// This file has been completely checked for Hardware..
/*****************************************************************************
 * frame.c: frame handling
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

#include "common.h"
static void ALWAYS_INLINE pixel_memset( pixel *dst, pixel *src, int len, int size )/// called by X264_SLICE_WRITE
{
    uint8_t *dstp = (uint8_t*)dst;
    uint32_t v1 = *src;
    uint32_t v2 = size == 1 ? v1 + (v1 <<  8) : M16( src );
    uint32_t v4 = size <= 2 ? v2 + (v2 << 16) : M32( src );
    int i = 0;
    len *= size;

    /* Align the input pointer if it isn't already */
    if( (intptr_t)dstp & (WORD_SIZE - 1) )
    {
        if( size <= 2 && ((intptr_t)dstp & 3) )
        {
            if( size == 1 && ((intptr_t)dstp & 1) )
                dstp[i++] = v1;
            if( (intptr_t)dstp & 2 )
            {
                M16( dstp+i ) = v2;
                i += 2;
            }
        }
        if( WORD_SIZE == 8 && (intptr_t)dstp & 4 )
        {
            M32( dstp+i ) = v4;
            i += 4;
        }
    }

    /* Main copy loop */
    if( WORD_SIZE == 8 )
    {
        uint64_t v8 = v4 + ((uint64_t)v4<<32);
        for( ; i < len - 7; i+=8 )
            M64( dstp+i ) = v8;
    }
    for( ; i < len - 3; i+=4 )
        M32( dstp+i ) = v4;

    /* Finish up the last few bytes */
    if( size <= 2 )
    {
        if( i < len - 1 )
        {
            M16( dstp+i ) = v2;
            i += 2;
        }
        if( size == 1 && i != len )
            dstp[i] = v1;
    }
}

static void ALWAYS_INLINE plane_expand_border( pixel *pix, int i_stride, int i_width, int i_height, int i_padh, int i_padv, int b_pad_top, int b_pad_bottom, int b_chroma )/// called by X264_SLICE_WRITE
{
#define PPIXEL(x, y) ( pix + (x) + (y)*i_stride )
    for( int y = 0; y < i_height; y++ )
    {
        /* left band */
        pixel_memset( PPIXEL(-i_padh, y), PPIXEL(0, y), i_padh>>b_chroma, sizeof(pixel)<<b_chroma );
        /* right band */
        pixel_memset( PPIXEL(i_width, y), PPIXEL(i_width-1-b_chroma, y), i_padh>>b_chroma, sizeof(pixel)<<b_chroma );
    }
    /* upper band */
    if( b_pad_top )
        for( int y = 0; y < i_padv; y++ )
            memcpy( PPIXEL(-i_padh, -y-1), PPIXEL(-i_padh, 0), (i_width+2*i_padh) * sizeof(pixel) );
    /* lower band */
    if( b_pad_bottom )
        for( int y = 0; y < i_padv; y++ )
            memcpy( PPIXEL(-i_padh, i_height+y), PPIXEL(-i_padh, i_height-1), (i_width+2*i_padh) * sizeof(pixel) );
#undef PPIXEL
}

void x264_frame_expand_border( x264_t *h, x264_frame_t *frame, int mb_y )/// called by X264_SLICE_WRITE
{
    int pad_top = mb_y == 0;
    int pad_bot = mb_y == h->mb.i_mb_height - (1 << SLICE_MBAFF);
    int b_start = mb_y == h->i_threadslice_start;
    int b_end   = mb_y == h->i_threadslice_end - (1 << SLICE_MBAFF);
    if( mb_y & SLICE_MBAFF )
        return;
    for( int i = 0; i < frame->i_plane; i++ )
    {
        int h_shift = i && CHROMA_H_SHIFT;
        int v_shift = i && CHROMA_V_SHIFT;
        int stride = frame->i_stride[i];
        int width = 16*h->mb.i_mb_width;
        int height = (pad_bot ? 16*(h->mb.i_mb_height - mb_y) >> SLICE_MBAFF : 16) >> v_shift;
        int padh = PADH;
        int padv = PADV >> v_shift;
        // buffer: 2 chroma, 3 luma (rounded to 4) because deblocking goes beyond the top of the mb
        if( b_end && !b_start )
            height += 4 >> (v_shift + SLICE_MBAFF);
        pixel *pix;
        int starty = 16*mb_y - 4*!b_start;
        if( SLICE_MBAFF )
        {
            // border samples for each field are extended separately
            pix = frame->plane_fld[i] + (starty*stride >> v_shift);
            plane_expand_border( pix, stride*2, width, height, padh, padv, pad_top, pad_bot, h_shift );
            plane_expand_border( pix+stride, stride*2, width, height, padh, padv, pad_top, pad_bot, h_shift );

            height = (pad_bot ? 16*(h->mb.i_mb_height - mb_y) : 32) >> v_shift;
            if( b_end && !b_start )
                height += 4 >> v_shift;
            pix = frame->plane[i] + (starty*stride >> v_shift);
            plane_expand_border( pix, stride, width, height, padh, padv, pad_top, pad_bot, h_shift );
        }
        else
        {
            pix = frame->plane[i] + (starty*stride >> v_shift);
            plane_expand_border( pix, stride, width, height, padh, padv, pad_top, pad_bot, h_shift );
        }
    }
}

void x264_frame_expand_border_filtered( x264_t *h, x264_frame_t *frame, int mb_y, int b_end )/// called in X264_SLICE_WRITE
{
    /* during filtering, 8 extra pixels were filtered on each edge,
     * but up to 3 of the horizontal ones may be wrong.
       we want to expand border from the last filtered pixel */
    int b_start = !mb_y;
    int width = 16*h->mb.i_mb_width + 8;
    int height = b_end ? (16*(h->mb.i_mb_height - mb_y) >> SLICE_MBAFF) + 16 : 16;
    int padh = PADH - 4;
    int padv = PADV - 8;
    for( int p = 0; p < (CHROMA444 ? 3 : 1); p++ )
        for( int i = 1; i < 4; i++ )
        {
            int stride = frame->i_stride[p];
            // buffer: 8 luma, to match the hpel filter
            pixel *pix;
            if( SLICE_MBAFF )
            {
                pix = frame->filtered_fld[p][i] + (16*mb_y - 16) * stride - 4;
                plane_expand_border( pix, stride*2, width, height, padh, padv, b_start, b_end, 0 );
                plane_expand_border( pix+stride, stride*2, width, height, padh, padv, b_start, b_end, 0 );
            }

            pix = frame->filtered[p][i] + (16*mb_y - 8) * stride - 4;
            plane_expand_border( pix, stride, width, height << SLICE_MBAFF, padh, padv, b_start, b_end, 0 );
        }
}



void x264_expand_border_mbpair( x264_t *h, int mb_x, int mb_y )/// false call in x264_slice_write can be removed.
{
    for( int i = 0; i < h->fenc->i_plane; i++ )
    {
        int v_shift = i && CHROMA_V_SHIFT;
        int stride = h->fenc->i_stride[i];
        int height = h->param.i_height >> v_shift;
        int pady = (h->mb.i_mb_height * 16 - h->param.i_height) >> v_shift;
        pixel *fenc = h->fenc->plane[i] + 16*mb_x;
        for( int y = height; y < height + pady; y++ )
            memcpy( fenc + y*stride, fenc + (height-1)*stride, 16*sizeof(pixel) );
    }
}

/* threading */
/* This part will not be called but still there , should be removed */
void x264_frame_cond_broadcast( x264_frame_t *frame, int i_lines_completed )
{
    x264_pthread_mutex_lock( &frame->mutex );
    frame->i_lines_completed = i_lines_completed;
    x264_pthread_cond_broadcast( &frame->cv );
    x264_pthread_mutex_unlock( &frame->mutex );
}

void x264_frame_cond_wait( x264_frame_t *frame, int i_lines_completed )
{
    x264_pthread_mutex_lock( &frame->mutex );
    while( frame->i_lines_completed < i_lines_completed )
        x264_pthread_cond_wait( &frame->cv, &frame->mutex );
    x264_pthread_mutex_unlock( &frame->mutex );
}

void x264_threadslice_cond_broadcast( x264_t *h, int pass )
{
    x264_pthread_mutex_lock( &h->mutex );
    h->i_threadslice_pass = pass;
    if( pass > 0 )
        x264_pthread_cond_broadcast( &h->cv );
    x264_pthread_mutex_unlock( &h->mutex );
}

void x264_threadslice_cond_wait( x264_t *h, int pass )
{
    x264_pthread_mutex_lock( &h->mutex );
    while( h->i_threadslice_pass < pass )
        x264_pthread_cond_wait( &h->cv, &h->mutex );
    x264_pthread_mutex_unlock( &h->mutex );
}



int x264_frame_new_slice( x264_t *h, x264_frame_t *frame )/// called by x264_SLICE_WRITE
{
    if( h->param.i_slice_count_max )
    {   
        int slice_count;
        if( h->param.b_sliced_threads )
            slice_count = x264_pthread_fetch_and_add( &frame->i_slice_count, 1, &frame->mutex );
        else
            slice_count = frame->i_slice_count++;
        if( slice_count >= h->param.i_slice_count_max )
            return -1;
    }
    return 0;
}




void x264_weight_scale_plane( x264_t *h, pixel *dst, intptr_t i_dst_stride, pixel *src, intptr_t i_src_stride,
                              int i_width, int i_height, x264_weight_t *w )
{	
    /* Weight horizontal strips of height 16. This was found to be the optimal height
     * in terms of the cache loads. */
	
    while( i_height > 0 )
    {	//fprintf(stderr,"------------------ WEIGHTED-------------- frame.c 2 \n");
        int x;
        for( x = 0; x < i_width-8; x += 16 )
	{
            mc_weight_w16( dst+x, i_dst_stride, src+x, i_src_stride, w, X264_MIN( i_height, 16 ) );
		//fprintf(stderr,"------------------ WEIGHTED-------------- frame.c 4 \n");
	}
        if( x < i_width )
            mc_weight_w8( dst+x, i_dst_stride, src+x, i_src_stride, w, X264_MIN( i_height, 16 ) );
        i_height -= 16;
        dst += 16 * i_dst_stride;
        src += 16 * i_src_stride;
	//fprintf(stderr,"------------------ WEIGHTED-------------- frame.c 3 \n");
    }
}


