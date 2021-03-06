// This file is completely checked for Hardware
/*****************************************************************************
 * encoder.c: top-level encoder functions
 *****************************************************************************
 * Copyright (C) 2003-2014 x264 project
 *
 * Authors: Laurent Aimar <fenrir@via.ecp.fr>
 *          Loren Merritt <lorenm@u.washington.edu>
 *          Fiona Glaser <fiona@x264.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111, USA.
 *
 * This program is also available under a commercial proprietary license.
 * For more information, contact us at licensing@x264.com.
 *****************************************************************************/

#include "common/common.h"
#include "set.h"
#include "analyse.h"
#include "ratecontrol.h"
#include "macroblock.h"
#include "me.h"
#if !HAVE_AHIR
#include "sync.h"
#include <pthread.h>
//#include <pipeHandler.h>
//#include <Pipes.h>
#include <iolib.h>
#endif
//x264_t *kop=NULL;
//int slice_counter=0,look_counter;
//#define DEBUG_MB_TYPE

#define bs_write_ue bs_write_ue_big


/****************************************************************************
 *
 ******************************* x264 libs **********************************
 *
 ****************************************************************************/




static void x264_slice_header_init( x264_t *h, x264_slice_header_t *sh,
                                    x264_sps_t *sps, x264_pps_t *pps,
                                    int i_idr_pic_id, int i_frame, int i_qp )
{
    x264_param_t *param = &h->param;

    /* First we fill all fields */
    sh->sps = sps;
    sh->pps = pps;

    sh->i_first_mb  = 0;
    sh->i_last_mb   = h->mb.i_mb_count - 1;
    sh->i_pps_id    = pps->i_id;

    sh->i_frame_num = i_frame;

    sh->b_mbaff = PARAM_INTERLACED;
    sh->b_field_pic = 0;    /* no field support for now */
    sh->b_bottom_field = 0; /* not yet used */

    sh->i_idr_pic_id = i_idr_pic_id;

    /* poc stuff, fixed later */
    sh->i_poc = 0;
    sh->i_delta_poc_bottom = 0;
    sh->i_delta_poc[0] = 0;
    sh->i_delta_poc[1] = 0;

    sh->i_redundant_pic_cnt = 0;

    h->mb.b_direct_auto_write = h->param.analyse.i_direct_mv_pred == X264_DIRECT_PRED_AUTO
                                && h->param.i_bframe
                                && ( h->param.rc.b_stat_write || !h->param.rc.b_stat_read );

    if( !h->mb.b_direct_auto_read && sh->i_type == SLICE_TYPE_B )
    {
        if( h->fref[1][0]->i_poc_l0ref0 == h->fref[0][0]->i_poc )
        {
            if( h->mb.b_direct_auto_write )
                sh->b_direct_spatial_mv_pred = ( h->stat.i_direct_score[1] > h->stat.i_direct_score[0] );
            else
                sh->b_direct_spatial_mv_pred = ( param->analyse.i_direct_mv_pred == X264_DIRECT_PRED_SPATIAL );
        }
        else
        {
            h->mb.b_direct_auto_write = 0;
            sh->b_direct_spatial_mv_pred = 1;
        }
    }
    /* else b_direct_spatial_mv_pred was read from the 2pass statsfile */

    sh->b_num_ref_idx_override = 0;
    sh->i_num_ref_idx_l0_active = 1;
    sh->i_num_ref_idx_l1_active = 1;

    sh->b_ref_pic_list_reordering[0] = h->b_ref_reorder[0];
    sh->b_ref_pic_list_reordering[1] = h->b_ref_reorder[1];

    /* If the ref list isn't in the default order, construct reordering header */
    for( int list = 0; list < 2; list++ )
    {
        if( sh->b_ref_pic_list_reordering[list] )
        {
            int pred_frame_num = i_frame;
            for( int i = 0; i < h->i_ref[list]; i++ )
            {
                int diff = h->fref[list][i]->i_frame_num - pred_frame_num;
                sh->ref_pic_list_order[list][i].idc = ( diff > 0 );
                sh->ref_pic_list_order[list][i].arg = (abs(diff) - 1) & ((1 << sps->i_log2_max_frame_num) - 1);
                pred_frame_num = h->fref[list][i]->i_frame_num;
            }
        }
    }

    sh->i_cabac_init_idc = param->i_cabac_init_idc;

    sh->i_qp = SPEC_QP(i_qp);
    sh->i_qp_delta = sh->i_qp - pps->i_pic_init_qp;
    sh->b_sp_for_swidth = 0;
    sh->i_qs_delta = 0;

    int deblock_thresh = i_qp + 2 * X264_MIN(param->i_deblocking_filter_alphac0, param->i_deblocking_filter_beta);
    /* If effective qp <= 15, deblocking would have no effect anyway */
    if( param->b_deblocking_filter && (h->mb.b_variable_qp || 15 < deblock_thresh ) )
        sh->i_disable_deblocking_filter_idc = param->b_sliced_threads ? 2 : 0;
    else
        sh->i_disable_deblocking_filter_idc = 1;
    sh->i_alpha_c0_offset = param->i_deblocking_filter_alphac0 << 1;
    sh->i_beta_offset = param->i_deblocking_filter_beta << 1;
}

static void x264_slice_header_write( bs_t *s, x264_slice_header_t *sh, int i_nal_ref_idc ) /// CALLED BY X264_SLICE_WRITE
{
    if( sh->b_mbaff )
    {
        int first_x = sh->i_first_mb % sh->sps->i_mb_width;
        int first_y = sh->i_first_mb / sh->sps->i_mb_width;
        assert( (first_y&1) == 0 );
        bs_write_ue( s, (2*first_x + sh->sps->i_mb_width*(first_y&~1) + (first_y&1)) >> 1 );
    }
    else
        bs_write_ue( s, sh->i_first_mb );

    bs_write_ue( s, sh->i_type + 5 );   /* same type things */
    bs_write_ue( s, sh->i_pps_id );
    bs_write( s, sh->sps->i_log2_max_frame_num, sh->i_frame_num & ((1<<sh->sps->i_log2_max_frame_num)-1) );

    if( !sh->sps->b_frame_mbs_only )
    {
        bs_write1( s, sh->b_field_pic );
        if( sh->b_field_pic )
            bs_write1( s, sh->b_bottom_field );
    }

    if( sh->i_idr_pic_id >= 0 ) /* NAL IDR */
        bs_write_ue( s, sh->i_idr_pic_id );

    if( sh->sps->i_poc_type == 0 )
    {
        bs_write( s, sh->sps->i_log2_max_poc_lsb, sh->i_poc & ((1<<sh->sps->i_log2_max_poc_lsb)-1) );
        if( sh->pps->b_pic_order && !sh->b_field_pic )
            bs_write_se( s, sh->i_delta_poc_bottom );
    }

    if( sh->pps->b_redundant_pic_cnt )
        bs_write_ue( s, sh->i_redundant_pic_cnt );

    if( sh->i_type == SLICE_TYPE_B )
        bs_write1( s, sh->b_direct_spatial_mv_pred );

    if( sh->i_type == SLICE_TYPE_P || sh->i_type == SLICE_TYPE_B )
    {
        bs_write1( s, sh->b_num_ref_idx_override );
        if( sh->b_num_ref_idx_override )
        {
            bs_write_ue( s, sh->i_num_ref_idx_l0_active - 1 );
            if( sh->i_type == SLICE_TYPE_B )
                bs_write_ue( s, sh->i_num_ref_idx_l1_active - 1 );
        }
    }

    /* ref pic list reordering */
    if( sh->i_type != SLICE_TYPE_I )
    {
        bs_write1( s, sh->b_ref_pic_list_reordering[0] );
        if( sh->b_ref_pic_list_reordering[0] )
        {
            for( int i = 0; i < sh->i_num_ref_idx_l0_active; i++ )
            {
                bs_write_ue( s, sh->ref_pic_list_order[0][i].idc );
                bs_write_ue( s, sh->ref_pic_list_order[0][i].arg );
            }
            bs_write_ue( s, 3 );
        }
    }
    if( sh->i_type == SLICE_TYPE_B )
    {
        bs_write1( s, sh->b_ref_pic_list_reordering[1] );
        if( sh->b_ref_pic_list_reordering[1] )
        {
            for( int i = 0; i < sh->i_num_ref_idx_l1_active; i++ )
            {
                bs_write_ue( s, sh->ref_pic_list_order[1][i].idc );
                bs_write_ue( s, sh->ref_pic_list_order[1][i].arg );
            }
            bs_write_ue( s, 3 );
        }
    }

    sh->b_weighted_pred = 0;
    if( sh->pps->b_weighted_pred && sh->i_type == SLICE_TYPE_P )
    {
        sh->b_weighted_pred = sh->weight[0][0].weightfn || sh->weight[0][1].weightfn || sh->weight[0][2].weightfn;
        /* pred_weight_table() */
        bs_write_ue( s, sh->weight[0][0].i_denom );
        bs_write_ue( s, sh->weight[0][1].i_denom );
        for( int i = 0; i < sh->i_num_ref_idx_l0_active; i++ )
        {
            int luma_weight_l0_flag = !!sh->weight[i][0].weightfn;
            int chroma_weight_l0_flag = !!sh->weight[i][1].weightfn || !!sh->weight[i][2].weightfn;
            bs_write1( s, luma_weight_l0_flag );
            if( luma_weight_l0_flag )
            {
                bs_write_se( s, sh->weight[i][0].i_scale );
                bs_write_se( s, sh->weight[i][0].i_offset );
            }
            bs_write1( s, chroma_weight_l0_flag );
            if( chroma_weight_l0_flag )
            {
                for( int j = 1; j < 3; j++ )
                {
                    bs_write_se( s, sh->weight[i][j].i_scale );
                    bs_write_se( s, sh->weight[i][j].i_offset );
                }
            }
        }
    }
    else if( sh->pps->b_weighted_bipred == 1 && sh->i_type == SLICE_TYPE_B )
    {
      /* TODO */
    }

    if( i_nal_ref_idc != 0 )
    {
        if( sh->i_idr_pic_id >= 0 )
        {
            bs_write1( s, 0 );  /* no output of prior pics flag */
            bs_write1( s, 0 );  /* long term reference flag */
        }
        else
        {
            bs_write1( s, sh->i_mmco_command_count > 0 ); /* adaptive_ref_pic_marking_mode_flag */
            if( sh->i_mmco_command_count > 0 )
            {
                for( int i = 0; i < sh->i_mmco_command_count; i++ )
                {
                    bs_write_ue( s, 1 ); /* mark short term ref as unused */
                    bs_write_ue( s, sh->mmco[i].i_difference_of_pic_nums - 1 );
                }
                bs_write_ue( s, 0 ); /* end command list */
            }
        }
    }

    if( sh->pps->b_cabac && sh->i_type != SLICE_TYPE_I )
        bs_write_ue( s, sh->i_cabac_init_idc );

    bs_write_se( s, sh->i_qp_delta );      /* slice qp delta */

    if( sh->pps->b_deblocking_filter_control )
    {
        bs_write_ue( s, sh->i_disable_deblocking_filter_idc );
        if( sh->i_disable_deblocking_filter_idc != 1 )
        {
            bs_write_se( s, sh->i_alpha_c0_offset >> 1 );
            bs_write_se( s, sh->i_beta_offset >> 1 );
        }
    }
}

/* If we are within a reasonable distance of the end of the memory allocated for the bitstream, */
/* reallocate, adding an arbitrary amount of space. */
static int x264_bitstream_check_buffer_internal( x264_t *h, int size, int b_cabac, int i_nal ) /// called by x264_check_buffer
{
    if( (b_cabac && (h->cabac.p_end - h->cabac.p < size)) ||
        (h->out.bs.p_end - h->out.bs.p < size) )
    {/*
        int buf_size = h->out.i_bitstream + size;
        uint8_t *buf = x264_malloc( buf_size );
        if( !buf )
            return -1;
        int aligned_size = h->out.i_bitstream & ~15;
        memcpy( buf, h->out.p_bitstream, aligned_size );
        memcpy( buf + aligned_size, h->out.p_bitstream + aligned_size, h->out.i_bitstream - aligned_size );

        intptr_t delta = buf - h->out.p_bitstream;

        h->out.bs.p_start += delta;
        h->out.bs.p += delta;
        h->out.bs.p_end = buf + buf_size;

        h->cabac.p_start += delta;
        h->cabac.p += delta;
        h->cabac.p_end = buf + buf_size;

        for( int i = 0; i <= i_nal; i++ )
            h->out.nal[i].p_payload += delta;

        x264_free( h->out.p_bitstream );
        h->out.p_bitstream = buf;
        h->out.i_bitstream = buf_size;
	*/
    }
    return 0;
}

static int x264_bitstream_check_buffer( x264_t *h )
{
    int max_row_size = (2500 << SLICE_MBAFF) * h->mb.i_mb_width;
    return x264_bitstream_check_buffer_internal( h, max_row_size, h->param.b_cabac, h->out.i_nal );
}





/****************************************************************************/
/*

*/
/*
*/
/****************************************************************************
 * x264_encoder_reconfig:
 ****************************************************************************/

/****************************************************************************
 * x264_encoder_parameters:
 ****************************************************************************/

/* internal usage */
static void x264_nal_start( x264_t *h, int i_type, int i_ref_idc )
{
    x264_nal_t *nal = &h->out.nal[h->out.i_nal];

    nal->i_ref_idc        = i_ref_idc;
    nal->i_type           = i_type;
    nal->b_long_startcode = 1;

    nal->i_payload= 0;
    nal->p_payload= &h->out.p_bitstream[bs_pos( &h->out.bs ) / 8];
    nal->i_padding= 0;
}

/* if number of allocated nals is not enough, re-allocate a larger one. */
static int x264_nal_check_buffer( x264_t *h )
{
    if( h->out.i_nal >= h->out.i_nals_allocated )
    {/*
        x264_nal_t *new_out = x264_malloc( sizeof(x264_nal_t) * (h->out.i_nals_allocated*2) );
        if( !new_out )
            return -1;
        memcpy( new_out, h->out.nal, sizeof(x264_nal_t) * (h->out.i_nals_allocated) );
//	fprintf(stderr,"out nals allocated again at %p",new_out);
        x264_free( h->out.nal );
        h->out.nal = new_out;
        h->out.i_nals_allocated *= 2;
	*/
    }
    return 0;
}

static int x264_nal_end( x264_t *h )
{
    x264_nal_t *nal = &h->out.nal[h->out.i_nal];
    uint8_t *end = &h->out.p_bitstream[bs_pos( &h->out.bs ) / 8];
    nal->i_payload = end - nal->p_payload;
    /* Assembly implementation of nal_escape reads past the end of the input.
     * While undefined padding wouldn't actually affect the output, it makes valgrind unhappy. */
    memset( end, 0xff, 64 );
    if( h->param.nalu_process )
        h->param.nalu_process( h, nal, h->fenc->opaque );
    h->out.i_nal++;

    return x264_nal_check_buffer( h );
}
static void x264_weighted_pred_init( x264_t *h )
{	//fprintf(stderr,"weighted 1 \n");
    /* for now no analysis and set all weights to nothing */
    for( int i_ref = 0; i_ref < h->i_ref[0]; i_ref++ )
        h->fenc->weighted[i_ref] = h->fref[0][i_ref]->filtered[0][0];
	//fprintf(stderr,"------------------ WEIGHTED-------------- encoder.c 1 \n");
    // FIXME: This only supports weighting of one reference frame
    // and duplicates of that frame.
    h->fenc->i_lines_weighted = 0;
//   fprintf(stderr,"weighted 2 \n");
    for( int i_ref = 0; i_ref < (h->i_ref[0] << SLICE_MBAFF); i_ref++ )
        for( int i = 0; i < 3; i++ )
            h->sh.weight[i_ref][i].weightfn = NULL;
// fprintf(stderr,"weighted 3 \n");

    if( h->sh.i_type != SLICE_TYPE_P || h->param.analyse.i_weighted_pred <= 0 )
        return;
// fprintf(stderr,"weighted 4 \n");	
    int i_padv = PADV << PARAM_INTERLACED;
    int denom = -1;
    int weightplane[2] = { 0, 0 };
    int buffer_next = 0;
    for( int i = 0; i < 3; i++ )
    {
        for( int j = 0; j < h->i_ref[0]; j++ )
         {//fprintf(stderr,"weighted 5 \n");
            if( h->fenc->weight[j][i].weightfn )
            {	
                h->sh.weight[j][i] = h->fenc->weight[j][i];
                // if weight is useless, don't write it to stream
                if( h->sh.weight[j][i].i_scale == 1<<h->sh.weight[j][i].i_denom && h->sh.weight[j][i].i_offset == 0 )
                    h->sh.weight[j][i].weightfn = NULL;
                else
                {
                    if( !weightplane[!!i] )
                    {
                        weightplane[!!i] = 1;
                        h->sh.weight[0][!!i].i_denom = denom = h->sh.weight[j][i].i_denom;
                        assert( x264_clip3( denom, 0, 7 ) == denom );
                    }
// 		    fprintf(stderr,"weighted 5 \n");
                    assert( h->sh.weight[j][i].i_denom == denom );
                    if( !i )
                    {
                        h->fenc->weighted[j] = h->mb.p_weight_buf[buffer_next++] + h->fenc->i_stride[0] * i_padv + PADH;
                        //scale full resolution frame
                        if( h->param.i_threads == 1 )
                        {	//fprintf(stderr,"from pred_init \n");
//                         fprintf(stderr,"weighted 6 \n");
                            pixel *src = h->fref[0][j]->filtered[0][0] - h->fref[0][j]->i_stride[0]*i_padv - PADH;
                            pixel *dst = h->fenc->weighted[j] - h->fenc->i_stride[0]*i_padv - PADH;
				//fprintf(stderr,"------------------ WEIGHTED-------------- encoder.c 2 \n");
                            int stride = h->fenc->i_stride[0];
                            int width = h->fenc->i_width[0] + PADH*2;
                            int height = h->fenc->i_lines[0] + i_padv*2;
// 			    fprintf(stderr,"weighted 7 %d %d \n",i,j);
	//fprintf(stderr,"------------------ WEIGHTED-------------- encoder.c 3 %d  \n",src[0]);
	//fprintf(stderr,"------------------ WEIGHTED-------------- encoder.c 4 %p  \n",h->sh.weight[j][0].weightfn);
	//fprintf(stderr,"------------------ WEIGHTED-------------- encoder.c 5 %d  \n",dst[10]);
                            x264_weight_scale_plane( h, dst, stride, src, stride, width, height, &h->sh.weight[j][0] );
//fprintf(stderr,"------------------ WEIGHTED-------------- encoder.c 4 \n");
// 			    fprintf(stderr,"weighted 8 \n");
                            h->fenc->i_lines_weighted = height;
                        }
                    }
                }
            }
        }
    }
		//fprintf(stderr,"------------------ WEIGHTED-------------- encoder.c 5 \n");
// 		fprintf(stderr,"weighted 9 \n");
    if( weightplane[1] )
        for( int i = 0; i < h->i_ref[0]; i++ )
        {
            if( h->sh.weight[i][1].weightfn && !h->sh.weight[i][2].weightfn )
            {
                h->sh.weight[i][2].i_scale = 1 << h->sh.weight[0][1].i_denom;
                h->sh.weight[i][2].i_offset = 0;
            }
            else if( h->sh.weight[i][2].weightfn && !h->sh.weight[i][1].weightfn )
            {
                h->sh.weight[i][1].i_scale = 1 << h->sh.weight[0][1].i_denom;
                h->sh.weight[i][1].i_offset = 0;
            }
        }
// fprintf(stderr,"weighted 10 \n");
    if( !weightplane[0] )
        h->sh.weight[0][0].i_denom = 0;
    if( !weightplane[1] )
        h->sh.weight[0][1].i_denom = 0;
    h->sh.weight[0][2].i_denom = h->sh.weight[0][1].i_denom;
//     fprintf(stderr,"weighted 11 \n");
//fprintf(stderr,"------------------ WEIGHTED-------------- encoder.c exiting \n");
}

static void x264_fdec_filter_row( x264_t *h, int mb_y, int pass )			// in x264_slice_write
{
    /* mb_y is the mb to be encoded next, not the mb to be filtered here */
    int b_hpel = h->fdec->b_kept_as_ref;
    int b_deblock = h->sh.i_disable_deblocking_filter_idc != 1;
    int b_end = mb_y == h->i_threadslice_end;
    int b_measure_quality = 1;
    int min_y = mb_y - (1 << SLICE_MBAFF);
    int b_start = min_y == h->i_threadslice_start;
    /* Even in interlaced mode, deblocking never modifies more than 4 pixels
     * above each MB, as bS=4 doesn't happen for the top of interlaced mbpairs. */
    int minpix_y = min_y*16 - 4 * !b_start;
    int maxpix_y = mb_y*16 - 4 * !b_end;
    b_deblock &= b_hpel || h->param.b_full_recon || h->param.psz_dump_yuv;
    if( h->param.b_sliced_threads )
    {
        switch( pass )
        {
            /* During encode: only do deblock if asked for */
            default:
            case 0:
                b_deblock &= h->param.b_full_recon;
                b_hpel = 0;
                break;
            /* During post-encode pass: do deblock if not done yet, do hpel for all
             * rows except those between slices. */
            case 1:
                b_deblock &= !h->param.b_full_recon;
                b_hpel &= !(b_start && min_y > 0);
                b_measure_quality = 0;
                break;
            /* Final pass: do the rows between slices in sequence. */
            case 2:
                b_deblock = 0;
                b_measure_quality = 0;
                break;
        }
    }
    if( mb_y & SLICE_MBAFF )
        return;
    if( min_y < h->i_threadslice_start )
        return;

    if( b_deblock )
        for( int y = min_y; y < mb_y; y += (1 << SLICE_MBAFF) )
            x264_frame_deblock_row( h, y );

    /* FIXME: Prediction requires different borders for interlaced/progressive mc,
     * but the actual image data is equivalent. For now, maintain this
     * consistency by copying deblocked pixels between planes. */
    if( PARAM_INTERLACED && (!h->param.b_sliced_threads || pass == 1) )
        for( int p = 0; p < h->fdec->i_plane; p++ )
            for( int i = minpix_y>>(CHROMA_V_SHIFT && p); i < maxpix_y>>(CHROMA_V_SHIFT && p); i++ )
                memcpy( h->fdec->plane_fld[p] + i*h->fdec->i_stride[p],
                        h->fdec->plane[p]     + i*h->fdec->i_stride[p],
                        h->mb.i_mb_width*16*sizeof(pixel) );

    if( h->fdec->b_kept_as_ref && (!h->param.b_sliced_threads || pass == 1) )
        x264_frame_expand_border( h, h->fdec, min_y );
    if( b_hpel )
    {
        int end = mb_y == h->mb.i_mb_height;
        /* Can't do hpel until the previous slice is done encoding. */
        if( h->param.analyse.i_subpel_refine )
        {
            x264_frame_filter( h, h->fdec, min_y, end );
            x264_frame_expand_border_filtered( h, h->fdec, min_y, end );
        }
    }

    if( SLICE_MBAFF && pass == 0 )
        for( int i = 0; i < 3; i++ )
        {
            XCHG( pixel *, h->intra_border_backup[0][i], h->intra_border_backup[3][i] );
            XCHG( pixel *, h->intra_border_backup[1][i], h->intra_border_backup[4][i] );
        }

    if( h->i_thread_frames > 1 && h->fdec->b_kept_as_ref )//// This will not run
        x264_frame_cond_broadcast( h->fdec, mb_y*16 + (b_end ? 10000 : -(X264_THREAD_HEIGHT << SLICE_MBAFF)) );

    if( b_measure_quality )
    {
        maxpix_y = X264_MIN( maxpix_y, h->param.i_height );
        if( h->param.analyse.b_psnr )
        {
            for( int p = 0; p < (CHROMA444 ? 3 : 1); p++ )
                h->stat.frame.i_ssd[p] += x264_pixel_ssd_wxh( &h->pixf,
                    h->fdec->plane[p] + minpix_y * h->fdec->i_stride[p], h->fdec->i_stride[p],
                    h->fenc->plane[p] + minpix_y * h->fenc->i_stride[p], h->fenc->i_stride[p],
                    h->param.i_width, maxpix_y-minpix_y );
            if( !CHROMA444 )
            {
                uint64_t ssd_u, ssd_v;
                int v_shift = CHROMA_V_SHIFT;
                x264_pixel_ssd_nv12( &h->pixf,
                    h->fdec->plane[1] + (minpix_y>>v_shift) * h->fdec->i_stride[1], h->fdec->i_stride[1],
                    h->fenc->plane[1] + (minpix_y>>v_shift) * h->fenc->i_stride[1], h->fenc->i_stride[1],
                    h->param.i_width>>1, (maxpix_y-minpix_y)>>v_shift, &ssd_u, &ssd_v );
                h->stat.frame.i_ssd[1] += ssd_u;
                h->stat.frame.i_ssd[2] += ssd_v;
            }
        }

        if( h->param.analyse.b_ssim )
        {
            int ssim_cnt;
            x264_emms();
            /* offset by 2 pixels to avoid alignment of ssim blocks with dct blocks,
             * and overlap by 4 */
            minpix_y += b_start ? 2 : -6;
            h->stat.frame.f_ssim +=
                x264_pixel_ssim_wxh( &h->pixf,
                    h->fdec->plane[0] + 2+minpix_y*h->fdec->i_stride[0], h->fdec->i_stride[0],
                    h->fenc->plane[0] + 2+minpix_y*h->fenc->i_stride[0], h->fenc->i_stride[0],
                    h->param.i_width-2, maxpix_y-minpix_y, h->scratch_buffer, &ssim_cnt );
            h->stat.frame.i_ssim_cnt += ssim_cnt;
        }
    }
}
void x264_slice_init( x264_t *h, int i_nal_type, int i_global_qp )
{
    /* ------------------------ Create slice header  ----------------------- */
    if( i_nal_type == NAL_SLICE_IDR )
    {
        x264_slice_header_init( h, &h->sh, h->sps, h->pps, h->i_idr_pic_id, h->i_frame_num, i_global_qp );

        /* alternate id */
        if( h->param.i_avcintra_class )
        {
            switch( h->i_idr_pic_id )
            {
                case 5:
                    h->i_idr_pic_id = 3;
                    break;
                case 3:
                    h->i_idr_pic_id = 4;
                    break;
                case 4:
                default:
                    h->i_idr_pic_id = 5;
                    break;
            }
        }
        else
            h->i_idr_pic_id ^= 1;
    }
    else
    {
        x264_slice_header_init( h, &h->sh, h->sps, h->pps, -1, h->i_frame_num, i_global_qp );

        h->sh.i_num_ref_idx_l0_active = h->i_ref[0] <= 0 ? 1 : h->i_ref[0];
        h->sh.i_num_ref_idx_l1_active = h->i_ref[1] <= 0 ? 1 : h->i_ref[1];
        if( h->sh.i_num_ref_idx_l0_active != h->pps->i_num_ref_idx_l0_default_active ||
            (h->sh.i_type == SLICE_TYPE_B && h->sh.i_num_ref_idx_l1_active != h->pps->i_num_ref_idx_l1_default_active) )
        {
            h->sh.b_num_ref_idx_override = 1;
        }
    }

    if( h->fenc->i_type == X264_TYPE_BREF && h->param.b_bluray_compat && h->sh.i_mmco_command_count )
    {
        h->b_sh_backup = 1;
        h->sh_backup = h->sh;
    }

    h->fdec->i_frame_num = h->sh.i_frame_num;

    if( h->sps->i_poc_type == 0 )
    {
        h->sh.i_poc = h->fdec->i_poc;
        if( PARAM_INTERLACED )
        {
            h->sh.i_delta_poc_bottom = h->param.b_tff ? 1 : -1;
            h->sh.i_poc += h->sh.i_delta_poc_bottom == -1;
        }
        else
            h->sh.i_delta_poc_bottom = 0;
        h->fdec->i_delta_poc[0] = h->sh.i_delta_poc_bottom == -1;
        h->fdec->i_delta_poc[1] = h->sh.i_delta_poc_bottom ==  1;
    }
    else
    {
        /* Nothing to do ? */
    }

    x264_macroblock_slice_init( h );
}
typedef struct
{
    int skip;
    uint8_t cabac_prevbyte;
    bs_t bs;
    x264_cabac_t cabac;
    x264_frame_stat_t stat;
    int last_qp;
    int last_dqp;
    int field_decoding_flag;
} x264_bs_bak_t;

static ALWAYS_INLINE void x264_bitstream_backup( x264_t *h, x264_bs_bak_t *bak, int i_skip, int full )    /// called from x264_slice_write
{
    if( full )
    {
        bak->stat = h->stat.frame;
        bak->last_qp = h->mb.i_last_qp;
        bak->last_dqp = h->mb.i_last_dqp;
        bak->field_decoding_flag = h->mb.field_decoding_flag;
    }
    else
    {
        bak->stat.i_mv_bits = h->stat.frame.i_mv_bits;
        bak->stat.i_tex_bits = h->stat.frame.i_tex_bits;
    }
    /* In the per-MB backup, we don't need the contexts because flushing the CABAC
     * encoder has no context dependency and in this case, a slice is ended (and
     * thus the content of all contexts are thrown away). */
    if( h->param.b_cabac )
    {
        if( full )
            memcpy( &bak->cabac, &h->cabac, sizeof(x264_cabac_t) );
        else
            memcpy( &bak->cabac, &h->cabac, offsetof(x264_cabac_t, f8_bits_encoded) );
        /* x264's CABAC writer modifies the previous byte during carry, so it has to be
         * backed up. */
        bak->cabac_prevbyte = h->cabac.p[-1];
    }
    else
    {
        bak->bs = h->out.bs;
        bak->skip = i_skip;
    }
}

static ALWAYS_INLINE void x264_bitstream_restore( x264_t *h, x264_bs_bak_t *bak, int *skip, int full ) // called from x264_slice_write
{
    if( full )
    {
        h->stat.frame = bak->stat;
        h->mb.i_last_qp = bak->last_qp;
        h->mb.i_last_dqp = bak->last_dqp;
        h->mb.field_decoding_flag = bak->field_decoding_flag;
    }
    else
    {
        h->stat.frame.i_mv_bits = bak->stat.i_mv_bits;
        h->stat.frame.i_tex_bits = bak->stat.i_tex_bits;
    }
    if( h->param.b_cabac )
    {
        if( full )
            memcpy( &h->cabac, &bak->cabac, sizeof(x264_cabac_t) );
        else
            memcpy( &h->cabac, &bak->cabac, offsetof(x264_cabac_t, f8_bits_encoded) );
        h->cabac.p[-1] = bak->cabac_prevbyte;
    }
    else
    {
        h->out.bs = bak->bs;
        *skip = bak->skip;
    }
}

static intptr_t x264_slice_write( x264_t *h )
{
    int i_skip;
    int mb_xy, i_mb_x, i_mb_y;
    /* NALUs other than the first use a 3-byte startcode.
     * Add one extra byte for the rbsp, and one more for the final CABAC putbyte.
     * Then add an extra 5 bytes just in case, to account for random NAL escapes and
     * other inaccuracies. */
    int overhead_guess = (NALU_OVERHEAD - (h->param.b_annexb && h->out.i_nal)) + 1 + h->param.b_cabac + 5;
    int slice_max_size = h->param.i_slice_max_size > 0 ? (h->param.i_slice_max_size-overhead_guess)*8 : 0;
    int back_up_bitstream_cavlc = !h->param.b_cabac && h->sps->i_profile_idc < PROFILE_HIGH;
    int back_up_bitstream = slice_max_size || back_up_bitstream_cavlc;
    int starting_bits = bs_pos(&h->out.bs);
    int b_deblock = h->sh.i_disable_deblocking_filter_idc != 1;
    int b_hpel = h->fdec->b_kept_as_ref;
    int orig_last_mb = h->sh.i_last_mb;
    int thread_last_mb = h->i_threadslice_end * h->mb.i_mb_width - 1;
    uint8_t *last_emu_check;
#define BS_BAK_SLICE_MAX_SIZE 0
#define BS_BAK_CAVLC_OVERFLOW 1
#define BS_BAK_SLICE_MIN_MBS  2
#define BS_BAK_ROW_VBV        3
    x264_bs_bak_t bs_bak[4];
    b_deblock &= b_hpel || h->param.b_full_recon || h->param.psz_dump_yuv;
    bs_realign( &h->out.bs );
//	 fprintf(stderr,"Hardwareslices_slice 1 \n");
    /* Slice */
    x264_nal_start( h, h->i_nal_type, h->i_nal_ref_idc );	// HW/encoder/encoder.c
    h->out.nal[h->out.i_nal].i_first_mb = h->sh.i_first_mb;
//	fprintf(stderr,"Hardwareslices_slice 2 \n");
    /* Slice header */
    x264_macroblock_thread_init( h );    // HW/common/macroblock.c
//	fprintf(stderr,"Hardwareslices_slice 3 \n");
    /* Set the QP equal to the first QP in the slice for more accurate CABAC initialization. */
    h->mb.i_mb_xy = h->sh.i_first_mb;
    h->sh.i_qp = x264_ratecontrol_mb_qp( h );
    h->sh.i_qp = SPEC_QP( h->sh.i_qp );
    h->sh.i_qp_delta = h->sh.i_qp - h->pps->i_pic_init_qp;
//	fprintf(stderr,"Hardwareslices_slice 4 \n");
    x264_slice_header_write( &h->out.bs, &h->sh, h->i_nal_ref_idc );   // HW/encoder/encoder.c
    if( h->param.b_cabac )
    {
        /* alignment needed */
        bs_align_1( &h->out.bs );

        /* init cabac */
        x264_cabac_context_init( h, &h->cabac, h->sh.i_type, x264_clip3( h->sh.i_qp-QP_BD_OFFSET, 0, 51 ), h->sh.i_cabac_init_idc );  // HW/common/cabac.c
        x264_cabac_encode_init ( &h->cabac, h->out.bs.p, h->out.bs.p_end );   // HW/common/cabac.c
        last_emu_check = h->cabac.p;
    }
    else
        last_emu_check = h->out.bs.p;
    h->mb.i_last_qp = h->sh.i_qp;
    h->mb.i_last_dqp = 0;
    h->mb.field_decoding_flag = 0;
//	fprintf(stderr,"Hardwareslices_slice 5 \n");
    i_mb_y = h->sh.i_first_mb / h->mb.i_mb_width;
    i_mb_x = h->sh.i_first_mb % h->mb.i_mb_width;
    i_skip = 0;

    while( 1 )
    {//	fprintf(stderr,"Hardwareslices_slice 1 \n");
        mb_xy = i_mb_x + i_mb_y * h->mb.i_mb_width;
        int mb_spos = bs_pos(&h->out.bs) + x264_cabac_pos(&h->cabac);  // HW/common/cabac.h and bitstream.h

        if( i_mb_x == 0 )
        {
            if( x264_bitstream_check_buffer( h ) )   // in same file
                return -1;
            if( !(i_mb_y & SLICE_MBAFF) && h->param.rc.i_vbv_buffer_size )
                x264_bitstream_backup( h, &bs_bak[BS_BAK_ROW_VBV], i_skip, 1 );   // in same file
            if( !h->mb.b_reencode_mb )
                x264_fdec_filter_row( h, i_mb_y, 0 );
        }
	//fprintf(stderr,"Hardwareslices_slice 2 \n");
        if( back_up_bitstream )
        {
            if( back_up_bitstream_cavlc )
                x264_bitstream_backup( h, &bs_bak[BS_BAK_CAVLC_OVERFLOW], i_skip, 0 );  // in same file
            if( slice_max_size && !(i_mb_y & SLICE_MBAFF) )
            {
                x264_bitstream_backup( h, &bs_bak[BS_BAK_SLICE_MAX_SIZE], i_skip, 0 );  // in same file
                if( (thread_last_mb+1-mb_xy) == h->param.i_slice_min_mbs )
                    x264_bitstream_backup( h, &bs_bak[BS_BAK_SLICE_MIN_MBS], i_skip, 0 );  // in same file
            }
        }
	//fprintf(stderr,"Hardwareslices_slice 3 \n");
        if( PARAM_INTERLACED )  // false statement no worry
        {
            if( h->mb.b_adaptive_mbaff )
            {
                if( !(i_mb_y&1) )
                {
                    /* FIXME: VSAD is fast but fairly poor at choosing the best interlace type. */
                    h->mb.b_interlaced = x264_field_vsad( h, i_mb_x, i_mb_y );
                    memcpy( &h->zigzagf, MB_INTERLACED ? &h->zigzagf_interlaced : &h->zigzagf_progressive, sizeof(h->zigzagf) );
                    if( !MB_INTERLACED && (i_mb_y+2) == h->mb.i_mb_height )
                        x264_expand_border_mbpair( h, i_mb_x, i_mb_y );
                }
            }
            h->mb.field[mb_xy] = MB_INTERLACED;
        }
	
        /* load cache */
        if( SLICE_MBAFF )
            x264_macroblock_cache_load_interlaced( h, i_mb_x, i_mb_y );
        else
            x264_macroblock_cache_load_progressive( h, i_mb_x, i_mb_y );     //// goes to hardware
	
	//fprintf(stderr,"Hardwareslices_slice 4 \n");
        x264_macroblock_analyse( h );   /// HW/encoder/analyse.c
	//fprintf(stderr,"coming outside macroblock analyse \n");
        /* encode this macroblock -> be careful it can change the mb type to P_SKIP if needed */
reencode:
	// fprintf(stderr,"going in  macroblock encode \n");
        x264_macroblock_encode( h );
	// fprintf(stderr,"Hardwareslices_slice 5 \n");
        if( h->param.b_cabac )
        {	//fprintf(stderr,"encoder/cabac 1 \n");
            if( mb_xy > h->sh.i_first_mb && !(SLICE_MBAFF && (i_mb_y&1)) )
                x264_cabac_encode_terminal( &h->cabac );
		//fprintf(stderr,"encoder/cabac 2 \n");
            if( IS_SKIP( h->mb.i_type ) )
                x264_cabac_mb_skip( h, 1 );
            else
            {
                if( h->sh.i_type != SLICE_TYPE_I )
                    x264_cabac_mb_skip( h, 0 );
                x264_macroblock_write_cabac( h, &h->cabac );
            }
		//fprintf(stderr,"encoder/cabac 3 \n");
        }
        else
        {
            if( IS_SKIP( h->mb.i_type ) )
                i_skip++;
            else
            {
                if( h->sh.i_type != SLICE_TYPE_I )
                {
                    bs_write_ue( &h->out.bs, i_skip );  /* skip run */
                    i_skip = 0;
                }
                x264_macroblock_write_cavlc( h );
                /* If there was a CAVLC level code overflow, try again at a higher QP. */
                if( h->mb.b_overflow )
                {
                    h->mb.i_chroma_qp = h->chroma_qp_table[++h->mb.i_qp];
                    h->mb.i_skip_intra = 0;
                    h->mb.b_skip_mc = 0;
                    h->mb.b_overflow = 0;
                    x264_bitstream_restore( h, &bs_bak[BS_BAK_CAVLC_OVERFLOW], &i_skip, 0 );
                    goto reencode;
                }
            }
        }
	// fprintf(stderr,"Hardwareslices_slice 6 \n");
        int total_bits = bs_pos(&h->out.bs) + x264_cabac_pos(&h->cabac);
        int mb_size = total_bits - mb_spos;

        if( slice_max_size && (!SLICE_MBAFF || (i_mb_y&1)) )
        {
            /* Count the skip run, just in case. */
            if( !h->param.b_cabac )
                total_bits += bs_size_ue_big( i_skip );
            /* Check for escape bytes. */
            uint8_t *end = h->param.b_cabac ? h->cabac.p : h->out.bs.p;
            for( ; last_emu_check < end - 2; last_emu_check++ )
                if( last_emu_check[0] == 0 && last_emu_check[1] == 0 && last_emu_check[2] <= 3 )
                {
                    slice_max_size -= 8;
                    last_emu_check++;
                }
            /* We'll just re-encode this last macroblock if we go over the max slice size. */
            if( total_bits - starting_bits > slice_max_size && !h->mb.b_reencode_mb )
            {
                if( !x264_frame_new_slice( h, h->fdec ) )
                {
                    /* Handle the most obnoxious slice-min-mbs edge case: we need to end the slice
                     * because it's gone over the maximum size, but doing so would violate slice-min-mbs.
                     * If possible, roll back to the last checkpoint and try again.
                     * We could try raising QP, but that would break in the case where a slice spans multiple
                     * rows, which the re-encoding infrastructure can't currently handle. */
                    if( mb_xy <= thread_last_mb && (thread_last_mb+1-mb_xy) < h->param.i_slice_min_mbs )
                    {
                        if( thread_last_mb-h->param.i_slice_min_mbs < h->sh.i_first_mb+h->param.i_slice_min_mbs )
                        {
                          //  x264_log( h, X264_LOG_WARNING, "slice-max-size violated (frame %d, cause: slice-min-mbs)\n", h->i_frame );
                            slice_max_size = 0;
                            goto cont;
                        }
                        x264_bitstream_restore( h, &bs_bak[BS_BAK_SLICE_MIN_MBS], &i_skip, 0 );
                        h->mb.b_reencode_mb = 1;
                        h->sh.i_last_mb = thread_last_mb-h->param.i_slice_min_mbs;
                        break;
                    }
                    if( mb_xy-SLICE_MBAFF*h->mb.i_mb_stride != h->sh.i_first_mb )
                    {
                        x264_bitstream_restore( h, &bs_bak[BS_BAK_SLICE_MAX_SIZE], &i_skip, 0 );
                        h->mb.b_reencode_mb = 1;
                        if( SLICE_MBAFF )
                        {
                            // set to bottom of previous mbpair
                            if( i_mb_x )
                                h->sh.i_last_mb = mb_xy-1+h->mb.i_mb_stride*(!(i_mb_y&1));
                            else
                                h->sh.i_last_mb = (i_mb_y-2+!(i_mb_y&1))*h->mb.i_mb_stride + h->mb.i_mb_width - 1;
                        }
                        else
                            h->sh.i_last_mb = mb_xy-1;
                        break;
                    }
                    else
                        h->sh.i_last_mb = mb_xy;
                }
                else
                    slice_max_size = 0;
            }
        }
cont:
        h->mb.b_reencode_mb = 0;
	// fprintf(stderr,"Hardwareslices_slice 7 \n");
        /* save cache */
        x264_macroblock_cache_save( h );

        if( x264_ratecontrol_mb( h, mb_size ) < 0 )
        {
            x264_bitstream_restore( h, &bs_bak[BS_BAK_ROW_VBV], &i_skip, 1 );
            h->mb.b_reencode_mb = 1;
            i_mb_x = 0;
            i_mb_y = i_mb_y - SLICE_MBAFF;
            h->mb.i_mb_prev_xy = i_mb_y * h->mb.i_mb_stride - 1;
            h->sh.i_last_mb = orig_last_mb;
            continue;
        }
	 //fprintf(stderr,"Hardwareslices_slice 8 \n");
        /* accumulate mb stats */
        h->stat.frame.i_mb_count[h->mb.i_type]++;

        int b_intra = IS_INTRA( h->mb.i_type );
        int b_skip = IS_SKIP( h->mb.i_type );
        if( h->param.i_log_level >= X264_LOG_INFO || h->param.rc.b_stat_write )
        {
            if( !b_intra && !b_skip && !IS_DIRECT( h->mb.i_type ) )
            {
                if( h->mb.i_partition != D_8x8 )
                        h->stat.frame.i_mb_partition[h->mb.i_partition] += 4;
                    else
                        for( int i = 0; i < 4; i++ )
                            h->stat.frame.i_mb_partition[h->mb.i_sub_partition[i]] ++;
                if( h->param.i_frame_reference > 1 )
                    for( int i_list = 0; i_list <= (h->sh.i_type == SLICE_TYPE_B); i_list++ )
                        for( int i = 0; i < 4; i++ )
                        {
                            int i_ref = h->mb.cache.ref[i_list][ x264_scan8[4*i] ];
                            if( i_ref >= 0 )
                                h->stat.frame.i_mb_count_ref[i_list][i_ref] ++;
                        }
            }
        }
	// fprintf(stderr,"Hardwareslices_slice 9 \n");
        if( h->param.i_log_level >= X264_LOG_INFO )
        {
            if( h->mb.i_cbp_luma | h->mb.i_cbp_chroma )
            {
                if( CHROMA444 )
                {
                    for( int i = 0; i < 4; i++ )
                        if( h->mb.i_cbp_luma & (1 << i) )
                            for( int p = 0; p < 3; p++ )
                            {
                                int s8 = i*4+p*16;
                                int nnz8x8 = M16( &h->mb.cache.non_zero_count[x264_scan8[s8]+0] )
                                           | M16( &h->mb.cache.non_zero_count[x264_scan8[s8]+8] );
                                h->stat.frame.i_mb_cbp[!b_intra + p*2] += !!nnz8x8;
                            }
                }
                else
                {
                    int cbpsum = (h->mb.i_cbp_luma&1) + ((h->mb.i_cbp_luma>>1)&1)
                               + ((h->mb.i_cbp_luma>>2)&1) + (h->mb.i_cbp_luma>>3);
                    h->stat.frame.i_mb_cbp[!b_intra + 0] += cbpsum;
                    h->stat.frame.i_mb_cbp[!b_intra + 2] += !!h->mb.i_cbp_chroma;
                    h->stat.frame.i_mb_cbp[!b_intra + 4] += h->mb.i_cbp_chroma >> 1;
                }
            }
            if( h->mb.i_cbp_luma && !b_intra )
            {
                h->stat.frame.i_mb_count_8x8dct[0] ++;
                h->stat.frame.i_mb_count_8x8dct[1] += h->mb.b_transform_8x8;
            }
            if( b_intra && h->mb.i_type != I_PCM )
            {
                if( h->mb.i_type == I_16x16 )
                    h->stat.frame.i_mb_pred_mode[0][h->mb.i_intra16x16_pred_mode]++;
                else if( h->mb.i_type == I_8x8 )
                    for( int i = 0; i < 16; i += 4 )
                        h->stat.frame.i_mb_pred_mode[1][h->mb.cache.intra4x4_pred_mode[x264_scan8[i]]]++;
                else //if( h->mb.i_type == I_4x4 )
                    for( int i = 0; i < 16; i++ )
                        h->stat.frame.i_mb_pred_mode[2][h->mb.cache.intra4x4_pred_mode[x264_scan8[i]]]++;
                h->stat.frame.i_mb_pred_mode[3][x264_mb_chroma_pred_mode_fix[h->mb.i_chroma_pred_mode]]++;
            }
            h->stat.frame.i_mb_field[b_intra?0:b_skip?2:1] += MB_INTERLACED;
        }
	// fprintf(stderr,"Hardwareslices_slice 10 \n");
        /* calculate deblock strength values (actual deblocking is done per-row along with hpel) */
        if( b_deblock )
	{	//fprintf(stderr,"deblock 1 \n");
            x264_macroblock_deblock_strength( h );
		//fprintf(stderr,"deblock 2 \n");
	}
	//fprintf(stderr,"%d is mb_xy \n",mb_xy);
        if( mb_xy == h->sh.i_last_mb )
 	{// fprintf(stderr,"breaking loop %d and %d  \n",mb_xy,h->sh.i_last_mb);
	  break;
	}
	//fprintf(stderr,"Hardwareslices_slice 11 \n");
        if( SLICE_MBAFF )
        {
            i_mb_x += i_mb_y & 1;
            i_mb_y ^= i_mb_x < h->mb.i_mb_width;
        }
        else
            i_mb_x++;
        if( i_mb_x == h->mb.i_mb_width )
        {
            i_mb_y++;
            i_mb_x = 0;
        }
	//fprintf(stderr,"Hardwareslices_slice 12 \n");
    }
    if( h->sh.i_last_mb < h->sh.i_first_mb )
        return 0;
	// fprintf(stderr,"Hardwareslices_slice 13 \n");
    h->out.nal[h->out.i_nal].i_last_mb = h->sh.i_last_mb;

    if( h->param.b_cabac )
    {
        x264_cabac_encode_flush( h, &h->cabac );
        h->out.bs.p = h->cabac.p;
    }
    else
    {
        if( i_skip > 0 )
            bs_write_ue( &h->out.bs, i_skip );  /* last skip run */
        /* rbsp_slice_trailing_bits */
        bs_rbsp_trailing( &h->out.bs );
        bs_flush( &h->out.bs );
    }
    if( x264_nal_end( h ) )
        return -1;
	// fprintf(stderr,"Hardwareslices_slice 14 \n");
    if( h->sh.i_last_mb == (h->i_threadslice_end * h->mb.i_mb_width - 1) )
    {
        h->stat.frame.i_misc_bits = bs_pos( &h->out.bs )
                                  + (h->out.i_nal*NALU_OVERHEAD * 8)
                                  - h->stat.frame.i_tex_bits
                                  - h->stat.frame.i_mv_bits;
        x264_fdec_filter_row( h, h->i_threadslice_end, 0 );

        if( h->param.b_sliced_threads )
        {
            /* Tell the main thread we're done. */
            x264_threadslice_cond_broadcast( h, 1 );
            /* Do hpel now */
            for( int mb_y = h->i_threadslice_start; mb_y <= h->i_threadslice_end; mb_y++ )
                x264_fdec_filter_row( h, mb_y, 1 );
            x264_threadslice_cond_broadcast( h, 2 );
            /* Do the first row of hpel, now that the previous slice is done */
            if( h->i_thread_idx > 0 )
            {
                x264_threadslice_cond_wait( h->thread[h->i_thread_idx-1], 2 );
                x264_fdec_filter_row( h, h->i_threadslice_start + (1 << SLICE_MBAFF), 2 );
            }
        }

        /* Free mb info after the last thread's done using it */
        if( h->fdec->mb_info_free && (!h->param.b_sliced_threads || h->i_thread_idx == (h->param.i_threads-1)) )
        {
            h->fdec->mb_info_free( h->fdec->mb_info );
            h->fdec->mb_info = NULL;
            h->fdec->mb_info_free = NULL;
        }
    }

    return 0;
}

void *x264_hw_slices_write( x264_t *h )
{	
	
    int i_slice_num = 0;
    int last_thread_mb = h->sh.i_last_mb;

    /* init stats */
    memset( &h->stat.frame, 0, sizeof(h->stat.frame) );
    h->mb.b_reencode_mb = 0;	//fprintf(stderr,"Going inside slice_hardware\n" );
	//fprintf(stderr,"Hardwareslices 1 \n");
    while( h->sh.i_first_mb + SLICE_MBAFF*h->mb.i_mb_stride <= last_thread_mb )
    {
        h->sh.i_last_mb = last_thread_mb;
	// fprintf(stderr,"Hardwareslices 2 \n");
        if( !i_slice_num || !x264_frame_new_slice( h, h->fdec ) )      // to get the new fdec frame
        {
            if( h->param.i_slice_max_mbs )
            {
                if( SLICE_MBAFF )
                {
                    // convert first to mbaff form, add slice-max-mbs, then convert back to normal form
                    int last_mbaff = 2*(h->sh.i_first_mb % h->mb.i_mb_width)
                        + h->mb.i_mb_width*(h->sh.i_first_mb / h->mb.i_mb_width)
                        + h->param.i_slice_max_mbs - 1;
                    int last_x = (last_mbaff % (2*h->mb.i_mb_width))/2;
                    int last_y = (last_mbaff / (2*h->mb.i_mb_width))*2 + 1;
                    h->sh.i_last_mb = last_x + h->mb.i_mb_stride*last_y;
                }
                else
                {
                    h->sh.i_last_mb = h->sh.i_first_mb + h->param.i_slice_max_mbs - 1;
                    if( h->sh.i_last_mb < last_thread_mb && last_thread_mb - h->sh.i_last_mb < h->param.i_slice_min_mbs )
                        h->sh.i_last_mb = last_thread_mb - h->param.i_slice_min_mbs;
                }
                i_slice_num++;
            }
            else if( h->param.i_slice_count && !h->param.b_sliced_threads )
            {
                int height = h->mb.i_mb_height >> PARAM_INTERLACED;
                int width = h->mb.i_mb_width << PARAM_INTERLACED;
                i_slice_num++;
                h->sh.i_last_mb = (height * i_slice_num + h->param.i_slice_count/2) / h->param.i_slice_count * width - 1;
            }
        }
        h->sh.i_last_mb = X264_MIN( h->sh.i_last_mb, last_thread_mb );
	// fprintf(stderr,"Hardwareslices 3 \n");
	//fprintf(stderr,"Going inside slice_hardware\n" );
        if( x264_stack_align( x264_slice_write, h ) )   /// this is the main part here in hardware
            goto fail;
	// fprintf(stderr,"Hardwareslices 4 \n");

	//fprintf(stderr,"Going inside slice_hardware\n" );
        h->sh.i_first_mb = h->sh.i_last_mb + 1;
        // if i_first_mb is not the last mb in a row then go to the next mb in MBAFF order
        if( SLICE_MBAFF && h->sh.i_first_mb % h->mb.i_mb_width )
            h->sh.i_first_mb -= h->mb.i_mb_stride;
    }
     
    return (void *)0;

fail:
    /* Tell other threads we're done, so they wouldn't wait for it */
    if( h->param.b_sliced_threads )
        x264_threadslice_cond_broadcast( h, 2 );
    return (void *)-1;
}



/* This function is the main thread at hardware side */
void x264_hardware()
{ x264_t *h_hw = NULL;
  x264_hw_sync_open(&h_hw);  // This function is to initialize hardware
  int count = 300;
//	fprintf(stderr," sizeof x264_t is %d and sizeof x264_frame_t is %d \n",sizeof(x264_t),sizeof(x264_frame_t));
  char *check;
  
  for(int i = 0; i < count ; i++)
  {int i_nal_type,i_global_qp,i_nal_ref_idc;
  
    x264_hw_sync_t(&i_nal_type,&i_global_qp,&i_nal_ref_idc);
  //  check = h_hw->chroma_qp_table  ;
    h_hw->chroma_qp_table = i_chroma_qp_table + 12 + h_hw->pps->i_chroma_qp_index_offset;
  //   if(h_hw->chroma_qp_table != check)
//	 fprintf(stderr,"chroma_qp_table_hw %p and %p \n",h_hw->chroma_qp_table,check);
  // fprintf(stderr,"Hardware 1 \n"); 
   x264_slice_init( h_hw, i_nal_type, i_global_qp );
//	fprintf(stderr,"Hardware 2 \n");
   //------------------------- Weights -------------------------------------
    if( h_hw->sh.i_type == SLICE_TYPE_B )
        x264_macroblock_bipred_init( h_hw );
	//fprintf(stderr,"Hardware 3 \n");
    x264_weighted_pred_init( h_hw );
	//fprintf(stderr,"Hardware 4 \n");
    if( i_nal_ref_idc != NAL_PRIORITY_DISPOSABLE )
        h_hw->i_frame_num++;

//     Write frame *
    h_hw->i_threadslice_start = 0;
    h_hw->i_threadslice_end = h_hw->mb.i_mb_height;

	
	//fprintf(stderr,"going frame is %d with number of reference frames %d \n",h_hw->i_frame, h_hw->i_ref[0] + h_hw->i_ref[1],h_hw->fref[0][0]);
	if( (intptr_t)x264_hw_slices_write( h_hw ) )
            return;
	//fprintf(stderr,"Hardware 5 \n");
	
    	x264_hw_sync_back_t();
	//fprintf(stderr,"encoded frame in hardware %d \n",i);
    }
  
 
  return;
  
  
}


//*************************** IMPORTANT NOTES *************
//We have to transfer x264_cabac_contexts matrix from common/cabac.c to hardware or we can initialize it in hardware itself.

