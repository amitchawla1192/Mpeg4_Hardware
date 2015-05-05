// This file is completely checked for hardware
/*****************************************************************************
 * mc.c: motion compensation
 *****************************************************************************
 * Copyright (C) 2003-2014 x264 project
 *
 * Authors: Laurent Aimar <fenrir@via.ecp.fr>
 *          Loren Merritt <lorenm@u.washington.edu>
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



 inline void pixel_avg( pixel *dst,  intptr_t i_dst_stride,
                              pixel *src1, intptr_t i_src1_stride,
                              pixel *src2, intptr_t i_src2_stride, int i_width, int i_height )// s/w also
{
    for( int y = 0; y < i_height; y++ )
    {
        for( int x = 0; x < i_width; x++ )
            dst[x] = ( src1[x] + src2[x] + 1 ) >> 1;
        dst  += i_dst_stride;
        src1 += i_src1_stride;
        src2 += i_src2_stride;
    }
}

static inline void pixel_avg_wxh( pixel *dst,  intptr_t i_dst,
                                  pixel *src1, intptr_t i_src1,
                                  pixel *src2, intptr_t i_src2, int width, int height )// s/w also
{
    for( int y = 0; y < height; y++ )
    {
        for( int x = 0; x < width; x++ )
            dst[x] = ( src1[x] + src2[x] + 1 ) >> 1;
        src1 += i_src1;
        src2 += i_src2;
        dst += i_dst;
    }
}

/* Implicit weighted bipred only:
 * assumes log2_denom = 5, offset = 0, weight1 + weight2 = 64 */
static inline void pixel_avg_weight_wxh( pixel *dst,  intptr_t i_dst,
                                         pixel *src1, intptr_t i_src1,
                                         pixel *src2, intptr_t i_src2, int width, int height, int i_weight1 )// s/w also
{
    int i_weight2 = 64 - i_weight1;
    for( int y = 0; y<height; y++, dst += i_dst, src1 += i_src1, src2 += i_src2 )
        for( int x = 0; x<width; x++ )
            dst[x] = x264_clip_pixel( (src1[x]*i_weight1 + src2[x]*i_weight2 + (1<<5)) >> 6 );
}
#undef op_scale2

#define PIXEL_AVG_C( name, width, height ) \
 void name( pixel *pix1, intptr_t i_stride_pix1, \
                  pixel *pix2, intptr_t i_stride_pix2, \
                  pixel *pix3, intptr_t i_stride_pix3, int weight ) \
{ \
    if( weight == 32 ) \
        pixel_avg_wxh( pix1, i_stride_pix1, pix2, i_stride_pix2, pix3, i_stride_pix3, width, height ); \
    else \
        pixel_avg_weight_wxh( pix1, i_stride_pix1, pix2, i_stride_pix2, pix3, i_stride_pix3, width, height, weight ); \
}
PIXEL_AVG_C( pixel_avg_16x16, 16, 16 ) // s/w also
PIXEL_AVG_C( pixel_avg_16x8,  16, 8 )
PIXEL_AVG_C( pixel_avg_8x16,  8, 16 )
PIXEL_AVG_C( pixel_avg_8x8,   8, 8 )
PIXEL_AVG_C( pixel_avg_8x4,   8, 4 )
PIXEL_AVG_C( pixel_avg_4x16,  4, 16 )
PIXEL_AVG_C( pixel_avg_4x8,   4, 8 )
PIXEL_AVG_C( pixel_avg_4x4,   4, 4 )
PIXEL_AVG_C( pixel_avg_4x2,   4, 2 )
PIXEL_AVG_C( pixel_avg_2x8,   2, 8 )
PIXEL_AVG_C( pixel_avg_2x4,   2, 4 )
PIXEL_AVG_C( pixel_avg_2x2,   2, 2 )

static void x264_weight_cache( x264_t *h, x264_weight_t *w )// s/w also
{
    w->weightfn = h->mc.weight;
}
#define opscale(x) dst[x] = x264_clip_pixel( ((src[x] * scale + (1<<(denom - 1))) >> denom) + offset )
#define opscale_noden(x) dst[x] = x264_clip_pixel( src[x] * scale + offset )
static void mc_weight( pixel *dst, intptr_t i_dst_stride, pixel *src, intptr_t i_src_stride,
                       const x264_weight_t *weight, int i_width, int i_height )
{	//fprintf(stderr,"------------------ WEIGHTED-------------- mc.c 1  \n");	
    int offset = weight->i_offset << (BIT_DEPTH-8);
    int scale = weight->i_scale;
    int denom = weight->i_denom;
	//fprintf(stderr,"------------------ WEIGHTED-------------- mc.c 1  \n");
    if( denom >= 1 )
    {
        for( int y = 0; y < i_height; y++, dst += i_dst_stride, src += i_src_stride )
            for( int x = 0; x < i_width; x++ )
                opscale( x );
	//fprintf(stderr,"------------------ WEIGHTED-------------- mc.c 2  \n");
    }
    else
    {
        for( int y = 0; y < i_height; y++, dst += i_dst_stride, src += i_src_stride )
            for( int x = 0; x < i_width; x++ )
                opscale_noden( x );
    }
}
#define MC_WEIGHT_C( name, width ) \
     void name( pixel *dst, intptr_t i_dst_stride, pixel *src, intptr_t i_src_stride, const x264_weight_t *weight, int height ) \
{ \
    mc_weight( dst, i_dst_stride, src, i_src_stride, weight, width, height );\
}

MC_WEIGHT_C( mc_weight_w20, 20 )
MC_WEIGHT_C( mc_weight_w16, 16 )
MC_WEIGHT_C( mc_weight_w12, 12 )
MC_WEIGHT_C( mc_weight_w8,   8 )
MC_WEIGHT_C( mc_weight_w4,   4 )
MC_WEIGHT_C( mc_weight_w2,   2 )
const x264_weight_t x264_weight_none[3] = { {{0}} };// s/w also
static void mc_copy( pixel *src, intptr_t i_src_stride, pixel *dst, intptr_t i_dst_stride, int i_width, int i_height )// s/w also
{//fprintf(stderr,"reading %d bytes from %p",i_width * sizeof(pixel),src);
    for( int y = 0; y < i_height; y++ )
    {	//fprintf(stderr,"reading %d bytes from %p",i_width * sizeof(pixel),src);
        memcpy( dst, src, i_width * sizeof(pixel) );

        src += i_src_stride;
        dst += i_dst_stride;
    }
}

#define TAPFILTER(pix, d) ((pix)[x-2*d] + (pix)[x+3*d] - 5*((pix)[x-d] + (pix)[x+2*d]) + 20*((pix)[x] + (pix)[x+d]))
void hpel_filter( pixel *dsth, pixel *dstv, pixel *dstc, pixel *src,
                         intptr_t stride, int width, int height, int16_t *buf )
{
    const int pad = (BIT_DEPTH > 9) ? (-10 * PIXEL_MAX) : 0;
    for( int y = 0; y < height; y++ )
    {
        for( int x = -2; x < width+3; x++ )
        {
            int v = TAPFILTER(src,stride);
            dstv[x] = x264_clip_pixel( (v + 16) >> 5 );
            /* transform v for storage in a 16-bit integer */
            buf[x+2] = v + pad;
        }
        for( int x = 0; x < width; x++ )
            dstc[x] = x264_clip_pixel( (TAPFILTER(buf+2,1) - 32*pad + 512) >> 10 );
        for( int x = 0; x < width; x++ )
            dsth[x] = x264_clip_pixel( (TAPFILTER(src,1) + 16) >> 5 );
        dsth += stride;
        dstv += stride;
        dstc += stride;
        src += stride;
    }
}

static const uint8_t hpel_ref0[16] = {0,1,1,1,0,1,1,1,2,3,3,3,0,1,1,1};
static const uint8_t hpel_ref1[16] = {0,0,0,0,2,2,3,2,2,2,3,2,2,2,3,2};

 void mc_luma( pixel *dst,    intptr_t i_dst_stride,
                     pixel *src[4], intptr_t i_src_stride,
                     int mvx, int mvy,
                     int i_width, int i_height, const x264_weight_t *weight )// s/w also
{
    int qpel_idx = ((mvy&3)<<2) + (mvx&3);
    int offset = (mvy>>2)*i_src_stride + (mvx>>2);
    pixel *src1 = src[hpel_ref0[qpel_idx]] + offset + ((mvy&3) == 3) * i_src_stride;

    if( qpel_idx & 5 ) /* qpel interpolation needed */
    {
        pixel *src2 = src[hpel_ref1[qpel_idx]] + offset + ((mvx&3) == 3);
        pixel_avg( dst, i_dst_stride, src1, i_src_stride,
                   src2, i_src_stride, i_width, i_height );
        if( weight->weightfn )
            mc_weight( dst, i_dst_stride, dst, i_dst_stride, weight, i_width, i_height );
    }
    else if( weight->weightfn )
        mc_weight( dst, i_dst_stride, src1, i_src_stride, weight, i_width, i_height );
    else
        mc_copy( src1, i_src_stride, dst, i_dst_stride, i_width, i_height );
}

 pixel *get_ref( pixel *dst,   intptr_t *i_dst_stride,
                       pixel *src[4], intptr_t i_src_stride,
                       int mvx, int mvy,
                       int i_width, int i_height, const x264_weight_t *weight )// s/w also
{
    int qpel_idx = ((mvy&3)<<2) + (mvx&3);
    int offset = (mvy>>2)*i_src_stride + (mvx>>2);
    pixel *src1 = src[hpel_ref0[qpel_idx]] + offset + ((mvy&3) == 3) * i_src_stride;

    if( qpel_idx & 5 ) /* qpel interpolation needed */
    {
        pixel *src2 = src[hpel_ref1[qpel_idx]] + offset + ((mvx&3) == 3);
        pixel_avg( dst, *i_dst_stride, src1, i_src_stride,
                   src2, i_src_stride, i_width, i_height );
        if( weight->weightfn )
            mc_weight( dst, *i_dst_stride, dst, *i_dst_stride, weight, i_width, i_height );
        return dst;
    }
    else if( weight->weightfn )
    {
        mc_weight( dst, *i_dst_stride, src1, i_src_stride, weight, i_width, i_height );
        return dst;
    }
    else
    {
        *i_dst_stride = i_src_stride;
        return src1;
    }
}

/* full chroma mc (ie until 1/8 pixel)*/
 void mc_chroma( pixel *dstu, pixel *dstv, intptr_t i_dst_stride,
                       pixel *src, intptr_t i_src_stride,
                       int mvx, int mvy,
                       int i_width, int i_height )// s/w also
{
    pixel *srcp;

    int d8x = mvx&0x07;
    int d8y = mvy&0x07;
    int cA = (8-d8x)*(8-d8y);
    int cB = d8x    *(8-d8y);
    int cC = (8-d8x)*d8y;
    int cD = d8x    *d8y;

    src += (mvy >> 3) * i_src_stride + (mvx >> 3)*2;
    srcp = &src[i_src_stride];

    for( int y = 0; y < i_height; y++ )
    {
        for( int x = 0; x < i_width; x++ )
        {
            dstu[x] = ( cA*src[2*x]  + cB*src[2*x+2] +
                        cC*srcp[2*x] + cD*srcp[2*x+2] + 32 ) >> 6;
            dstv[x] = ( cA*src[2*x+1]  + cB*src[2*x+3] +
                        cC*srcp[2*x+1] + cD*srcp[2*x+3] + 32 ) >> 6;
        }
        dstu += i_dst_stride;
        dstv += i_dst_stride;
        src   = srcp;
        srcp += i_src_stride;
    }
}

#define MC_COPY(W) \
 void mc_copy_w##W( pixel *dst, intptr_t i_dst, pixel *src, intptr_t i_src, int i_height ) \
{ \
    mc_copy( src, i_src, dst, i_dst, W, i_height ); \
}
MC_COPY( 16 )// s/w also
MC_COPY( 8 )
MC_COPY( 4 )



static void x264_plane_copy_deinterleave_c( pixel *dstu, intptr_t i_dstu,
                                            pixel *dstv, intptr_t i_dstv,
                                            pixel *src,  intptr_t i_src, int w, int h )// also S/w
{
    for( int y=0; y<h; y++, dstu+=i_dstu, dstv+=i_dstv, src+=i_src )
        for( int x=0; x<w; x++ )
        {
            dstu[x] = src[2*x];
            dstv[x] = src[2*x+1];
        }
}

 void store_interleave_chroma( pixel *dst, intptr_t i_dst, pixel *srcu, pixel *srcv, int height )
{
    for( int y=0; y<height; y++, dst+=i_dst, srcu+=FDEC_STRIDE, srcv+=FDEC_STRIDE )
        for( int x=0; x<8; x++ )
        {
            dst[2*x]   = srcu[x];
            dst[2*x+1] = srcv[x];
        }
}

void load_deinterleave_chroma_fenc( pixel *dst, pixel *src, intptr_t i_src, int height )// also S/W
{
    x264_plane_copy_deinterleave_c( dst, FENC_STRIDE, dst+FENC_STRIDE/2, FENC_STRIDE, src, i_src, 8, height );
}

 void load_deinterleave_chroma_fdec( pixel *dst, pixel *src, intptr_t i_src, int height )
{
    x264_plane_copy_deinterleave_c( dst, FDEC_STRIDE, dst+FDEC_STRIDE/2, FDEC_STRIDE, src, i_src, 8, height );
}

 void prefetch_fenc_null( pixel *pix_y,  intptr_t stride_y,
                                pixel *pix_uv, intptr_t stride_uv, int mb_x )
{}

 void prefetch_ref_null( pixel *pix, intptr_t stride, int parity )
{}

 void memzero_aligned( void * dst, size_t n )
{
    memset( dst, 0, n );
}

 void integral_init4h( uint16_t *sum, pixel *pix, intptr_t stride )
{
    int v = pix[0]+pix[1]+pix[2]+pix[3];
    for( int x = 0; x < stride-4; x++ )
    {
        sum[x] = v + sum[x-stride];
        v += pix[x+4] - pix[x];
    }
}

 void integral_init8h( uint16_t *sum, pixel *pix, intptr_t stride )
{
    int v = pix[0]+pix[1]+pix[2]+pix[3]+pix[4]+pix[5]+pix[6]+pix[7];
    for( int x = 0; x < stride-8; x++ )
    {
        sum[x] = v + sum[x-stride];
        v += pix[x+8] - pix[x];
    }
}

 void integral_init4v( uint16_t *sum8, uint16_t *sum4, intptr_t stride )
{
    for( int x = 0; x < stride-8; x++ )
        sum4[x] = sum8[x+4*stride] - sum8[x];
    for( int x = 0; x < stride-8; x++ )
        sum8[x] = sum8[x+8*stride] + sum8[x+8*stride+4] - sum8[x] - sum8[x+4];
}

 void integral_init8v( uint16_t *sum8, intptr_t stride )
{
    for( int x = 0; x < stride-8; x++ )
        sum8[x] = sum8[x+8*stride] - sum8[x];
}



#if !HAVE_AHIR
void x264_mc_init( int cpu, x264_mc_functions_t *pf, int cpu_independent )
{
    pf->mc_luma   = mc_luma;// S/W and H/W
    pf->get_ref   = get_ref;// S/W and H/W

    pf->mc_chroma = mc_chroma;// S/W and H/W

    pf->avg[PIXEL_16x16]= pixel_avg_16x16;// All in S/W and H/w
    pf->avg[PIXEL_16x8] = pixel_avg_16x8;
    pf->avg[PIXEL_8x16] = pixel_avg_8x16;
    pf->avg[PIXEL_8x8]  = pixel_avg_8x8;
    pf->avg[PIXEL_8x4]  = pixel_avg_8x4;
    pf->avg[PIXEL_4x16] = pixel_avg_4x16;
    pf->avg[PIXEL_4x8]  = pixel_avg_4x8;
    pf->avg[PIXEL_4x4]  = pixel_avg_4x4;
    pf->avg[PIXEL_4x2]  = pixel_avg_4x2;
    pf->avg[PIXEL_2x8]  = pixel_avg_2x8;
    pf->avg[PIXEL_2x4]  = pixel_avg_2x4;
    pf->avg[PIXEL_2x2]  = pixel_avg_2x2;

    pf->weight    = x264_mc_weight_wtab;// S/W slicetype.c 
    pf->offsetadd = x264_mc_weight_wtab;// s/w
    pf->offsetsub = x264_mc_weight_wtab;// s/w
    pf->weight_cache = x264_weight_cache;// S/W slicetype.c 

    pf->copy_16x16_unaligned = mc_copy_w16;// H/W and S/W
    pf->copy[PIXEL_16x16] = mc_copy_w16;// H/W and S/W
    pf->copy[PIXEL_8x8]   = mc_copy_w8;// H/W and S/W
    pf->copy[PIXEL_4x4]   = mc_copy_w4;// H/W and S/W

    pf->store_interleave_chroma       = store_interleave_chroma;// H/W macroblock.c
    pf->load_deinterleave_chroma_fenc = load_deinterleave_chroma_fenc;// H/W as well S/W
    pf->load_deinterleave_chroma_fdec = load_deinterleave_chroma_fdec;// H/W macroblock.c

    pf->plane_copy = x264_plane_copy_c;//S/W frame.c encoder.c and slicetype.c
    pf->plane_copy_interleave = x264_plane_copy_interleave_c;// S/W frame.c
    pf->plane_copy_deinterleave = x264_plane_copy_deinterleave_c;//S/W frame.c encoder.c and slicetype.c
    pf->plane_copy_deinterleave_rgb = x264_plane_copy_deinterleave_rgb_c;// S/W in common/frame.c
    pf->plane_copy_deinterleave_v210 = x264_plane_copy_deinterleave_v210_c;// S/W in common/frame.c

    pf->hpel_filter = hpel_filter;// H/W from downwards

    pf->prefetch_fenc_420 = prefetch_fenc_null;// H/W in common macroblock.c
    pf->prefetch_fenc_422 = prefetch_fenc_null;// H/W in common macroblock.c
    pf->prefetch_ref  = prefetch_ref_null;// H/W analyse.c
    pf->memcpy_aligned = memcpy;// H/W in analyse.c macroblock.c encoder.c and rdo.c
    pf->memzero_aligned = memzero_aligned;// H/W analyse.c and me.c
    pf->frame_init_lowres_core = frame_init_lowres_core;// S/W only

    pf->integral_init4h = integral_init4h;// H/W from downwards
    pf->integral_init8h = integral_init8h;// H/W from downwards
    pf->integral_init4v = integral_init4v;// H/W from downwards
    pf->integral_init8v = integral_init8v;// H/W from downwards

    pf->mbtree_propagate_cost = mbtree_propagate_cost;// S/W in slicetype.c
    pf->mbtree_propagate_list = mbtree_propagate_list;// S/W in slicetype.c


    if( cpu_independent )
    {
        pf->mbtree_propagate_cost = mbtree_propagate_cost;
        pf->mbtree_propagate_list = mbtree_propagate_list;
    }
}

#endif
void x264_frame_filter( x264_t *h, x264_frame_t *frame, int mb_y, int b_end )// H/W in encoder.c
{
    const int b_interlaced = PARAM_INTERLACED;
    int start = mb_y*16 - 8; // buffer = 4 for deblock + 3 for 6tap, rounded to 8
    int height = (b_end ? frame->i_lines[0] + 16*PARAM_INTERLACED : (mb_y+b_interlaced)*16) + 8;

    if( mb_y & b_interlaced )
        return;

    for( int p = 0; p < (CHROMA444 ? 3 : 1); p++ )
    {
        int stride = frame->i_stride[p];
        const int width = frame->i_width[p];
        int offs = start*stride - 8; // buffer = 3 for 6tap, aligned to 8 for simd

        if( !b_interlaced || h->mb.b_adaptive_mbaff )
            hpel_filter(
                frame->filtered[p][1] + offs,
                frame->filtered[p][2] + offs,
                frame->filtered[p][3] + offs,
                frame->plane[p] + offs,
                stride, width + 16, height - start,
                h->scratch_buffer );

        if( b_interlaced )
        {
            /* MC must happen between pixels in the same field. */
            stride = frame->i_stride[p] << 1;
            start = (mb_y*16 >> 1) - 8;
            int height_fld = ((b_end ? frame->i_lines[p] : mb_y*16) >> 1) + 8;
            offs = start*stride - 8;
            for( int i = 0; i < 2; i++, offs += frame->i_stride[p] )
            {	
               hpel_filter(
                    frame->filtered_fld[p][1] + offs,
                    frame->filtered_fld[p][2] + offs,
                    frame->filtered_fld[p][3] + offs,
                    frame->plane_fld[p] + offs,
                    stride, width + 16, height_fld - start,
                    h->scratch_buffer );
            }
        }
    }

    /* generate integral image:
     * frame->integral contains 2 planes. in the upper plane, each element is
     * the sum of an 8x8 pixel region with top-left corner on that point.
     * in the lower plane, 4x4 sums (needed only with --partitions p4x4). */

    if( frame->integral )
    {
        int stride = frame->i_stride[0];
        if( start < 0 )
        {
            memset( frame->integral - PADV * stride - PADH, 0, stride * sizeof(uint16_t) );
            start = -PADV;
        }
        if( b_end )
            height += PADV-9;
        for( int y = start; y < height; y++ )
        {
            pixel    *pix  = frame->plane[0] + y * stride - PADH;
            uint16_t *sum8 = frame->integral + (y+1) * stride - PADH;
            uint16_t *sum4;
            if( h->frames.b_have_sub8x8_esa )
            {
                integral_init4h( sum8, pix, stride );
                sum8 -= 8*stride;
                sum4 = sum8 + stride * (frame->i_lines[0] + PADV*2);
                if( y >= 8-PADV )
                    integral_init4v( sum8, sum4, stride );
            }
            else
            {
                integral_init8h( sum8, pix, stride );
                if( y >= 8-PADV )
                    integral_init8v( sum8-8*stride, stride );
            }
        }
    }
}
