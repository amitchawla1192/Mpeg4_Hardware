// This file is completely checked for Hardware
/*****************************************************************************
 * ratecontrol.c: ratecontrol
 *****************************************************************************
 * Copyright (C) 2005-2014 x264 project
 *
 * Authors: Loren Merritt <lorenm@u.washington.edu>
 *          Michael Niedermayer <michaelni@gmx.at>
 *          Gabriel Bouvigne <gabriel.bouvigne@joost.com>
 *          Fiona Glaser <fiona@x264.com>
 *          Måns Rullgård <mru@mru.ath.cx>
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

#define _ISOC99_SOURCE
#undef NDEBUG // always check asserts, the speed effect is far too small to disable them

#include "common/common.h"
#include "ratecontrol.h"
#include "me.h"



//static int parse_zones( x264_t *h );
//static float rate_estimate_qscale( x264_t *h );
//static int update_vbv( x264_t *h, int bits );
//static void update_vbv_plan( x264_t *h, int overhead );
static float predict_size( predictor_t *p, float q, float var );
static void update_predictor( predictor_t *p, float q, float var, float bits );



/* Terminology:
 * qp = h.264's quantizer
 * qscale = linearized quantizer = Lagrange multiplier
 */
static inline float qp2qscale( float qp )/// called by X264_SLICE_WRITE
{
    return 0.85f * powf( 2.0f, ( qp - 12.0f ) / 6.0f );
}

static float predict_row_size( x264_t *h, int y, float qscale )/// called by X264_SLICE_WRITE
{
    /* average between two predictors:
     * absolute SATD, and scaled bit cost of the colocated row in the previous frame */
    x264_ratecontrol_t *rc = h->rc;
    float pred_s = predict_size( &rc->row_pred[0], qscale, h->fdec->i_row_satd[y] );
    if( h->sh.i_type == SLICE_TYPE_I || qscale >= h->fref[0][0]->f_row_qscale[y] )
    {
        if( h->sh.i_type == SLICE_TYPE_P
            && h->fref[0][0]->i_type == h->fdec->i_type
            && h->fref[0][0]->f_row_qscale[y] > 0
            && h->fref[0][0]->i_row_satd[y] > 0
            && (abs(h->fref[0][0]->i_row_satd[y] - h->fdec->i_row_satd[y]) < h->fdec->i_row_satd[y]/2))
        {
            float pred_t = h->fref[0][0]->i_row_bits[y] * h->fdec->i_row_satd[y] / h->fref[0][0]->i_row_satd[y]
                         * h->fref[0][0]->f_row_qscale[y] / qscale;
            return (pred_s + pred_t) * 0.5f;
        }
        return pred_s;
    }
    /* Our QP is lower than the reference! */
    else
    {
        float pred_intra = predict_size( &rc->row_pred[1], qscale, h->fdec->i_row_satds[0][0][y] );
        /* Sum: better to overestimate than underestimate by using only one of the two predictors. */
        return pred_intra + pred_s;
    }
}

static int row_bits_so_far( x264_t *h, int y )/// called by X264_SLICE_WRITE
{
    int bits = 0;
    for( int i = h->i_threadslice_start; i <= y; i++ )
        bits += h->fdec->i_row_bits[i];
    return bits;
}

static float predict_row_size_sum( x264_t *h, int y, float qp )/// called by X264_SLICE_WRITE
{
    float qscale = qp2qscale( qp );
    float bits = row_bits_so_far( h, y );
    for( int i = y+1; i < h->i_threadslice_end; i++ )
        bits += predict_row_size( h, i, qscale );
    return bits;
}

/* TODO:
 *  eliminate all use of qp in row ratecontrol: make it entirely qscale-based.
 *  make this function stop being needlessly O(N^2)
 *  update more often than once per row? */
int x264_ratecontrol_mb( x264_t *h, int bits )/// called by X264_SLICE_WRITE
{
    x264_ratecontrol_t *rc = h->rc;
    const int y = h->mb.i_mb_y;

    h->fdec->i_row_bits[y] += bits;
    rc->qpa_aq += h->mb.i_qp;

    if( h->mb.i_mb_x != h->mb.i_mb_width - 1 )
        return 0;

    x264_emms();
    rc->qpa_rc += rc->qpm * h->mb.i_mb_width;

    if( !rc->b_vbv )
        return 0;

    float qscale = qp2qscale( rc->qpm );
    h->fdec->f_row_qp[y] = rc->qpm;
    h->fdec->f_row_qscale[y] = qscale;

    update_predictor( &rc->row_pred[0], qscale, h->fdec->i_row_satd[y], h->fdec->i_row_bits[y] );
    if( h->sh.i_type == SLICE_TYPE_P && rc->qpm < h->fref[0][0]->f_row_qp[y] )
        update_predictor( &rc->row_pred[1], qscale, h->fdec->i_row_satds[0][0][y], h->fdec->i_row_bits[y] );

    /* update ratecontrol per-mbpair in MBAFF */
    if( SLICE_MBAFF && !(y&1) )
        return 0;

    /* FIXME: We don't currently support the case where there's a slice
     * boundary in between. */
    int can_reencode_row = h->sh.i_first_mb <= ((h->mb.i_mb_y - SLICE_MBAFF) * h->mb.i_mb_stride);

    /* tweak quality based on difference from predicted size */
    float prev_row_qp = h->fdec->f_row_qp[y];
    float qp_absolute_max = h->param.rc.i_qp_max;
    if( rc->rate_factor_max_increment )
        qp_absolute_max = X264_MIN( qp_absolute_max, rc->qp_novbv + rc->rate_factor_max_increment );
    float qp_max = X264_MIN( prev_row_qp + h->param.rc.i_qp_step, qp_absolute_max );
    float qp_min = X264_MAX( prev_row_qp - h->param.rc.i_qp_step, h->param.rc.i_qp_min );
    float step_size = 0.5f;
    float buffer_left_planned = rc->buffer_fill - rc->frame_size_planned;
    float slice_size_planned = h->param.b_sliced_threads ? rc->slice_size_planned : rc->frame_size_planned;
    float max_frame_error = X264_MAX( 0.05f, 1.0f / h->mb.i_mb_height );
    float size_of_other_slices = 0;
    if( h->param.b_sliced_threads )
    {
        float size_of_other_slices_planned = 0;
        for( int i = 0; i < h->param.i_threads; i++ )
            if( h != h->thread[i] )
            {
                size_of_other_slices += h->thread[i]->rc->frame_size_estimated;
                size_of_other_slices_planned += h->thread[i]->rc->slice_size_planned;
            }
        float weight = rc->slice_size_planned / rc->frame_size_planned;
        size_of_other_slices = (size_of_other_slices - size_of_other_slices_planned) * weight + size_of_other_slices_planned;
    }
    if( y < h->i_threadslice_end-1 )
    {
        /* B-frames shouldn't use lower QP than their reference frames. */
        if( h->sh.i_type == SLICE_TYPE_B )
        {
            qp_min = X264_MAX( qp_min, X264_MAX( h->fref[0][0]->f_row_qp[y+1], h->fref[1][0]->f_row_qp[y+1] ) );
            rc->qpm = X264_MAX( rc->qpm, qp_min );
        }

        /* More threads means we have to be more cautious in letting ratecontrol use up extra bits. */
        float rc_tol = buffer_left_planned / h->param.i_threads * rc->rate_tolerance;
        float b1 = predict_row_size_sum( h, y, rc->qpm ) + size_of_other_slices;

        /* Don't increase the row QPs until a sufficent amount of the bits of the frame have been processed, in case a flat */
        /* area at the top of the frame was measured inaccurately. */
        if( row_bits_so_far( h, y ) < 0.05f * slice_size_planned )
            qp_max = qp_absolute_max = prev_row_qp;

        if( h->sh.i_type != SLICE_TYPE_I )
            rc_tol *= 0.5f;

        if( !rc->b_vbv_min_rate )
            qp_min = X264_MAX( qp_min, rc->qp_novbv );

        while( rc->qpm < qp_max
               && ((b1 > rc->frame_size_planned + rc_tol) ||
                   (rc->buffer_fill - b1 < buffer_left_planned * 0.5f) ||
                   (b1 > rc->frame_size_planned && rc->qpm < rc->qp_novbv)) )
        {
            rc->qpm += step_size;
            b1 = predict_row_size_sum( h, y, rc->qpm ) + size_of_other_slices;
        }

        while( rc->qpm > qp_min
               && (rc->qpm > h->fdec->f_row_qp[0] || rc->single_frame_vbv)
               && ((b1 < rc->frame_size_planned * 0.8f && rc->qpm <= prev_row_qp)
               || b1 < (rc->buffer_fill - rc->buffer_size + rc->buffer_rate) * 1.1f) )
        {
            rc->qpm -= step_size;
            b1 = predict_row_size_sum( h, y, rc->qpm ) + size_of_other_slices;
        }

        /* avoid VBV underflow or MinCR violation */
        while( (rc->qpm < qp_absolute_max)
               && ((rc->buffer_fill - b1 < rc->buffer_rate * max_frame_error) ||
                   (rc->frame_size_maximum - b1 < rc->frame_size_maximum * max_frame_error)))
        {
            rc->qpm += step_size;
            b1 = predict_row_size_sum( h, y, rc->qpm ) + size_of_other_slices;
        }

        h->rc->frame_size_estimated = b1 - size_of_other_slices;

        /* If the current row was large enough to cause a large QP jump, try re-encoding it. */
        if( rc->qpm > qp_max && prev_row_qp < qp_max && can_reencode_row )
        {
            /* Bump QP to halfway in between... close enough. */
            rc->qpm = x264_clip3f( (prev_row_qp + rc->qpm)*0.5f, prev_row_qp + 1.0f, qp_max );
            rc->qpa_rc = rc->qpa_rc_prev;
            rc->qpa_aq = rc->qpa_aq_prev;
            h->fdec->i_row_bits[y] = 0;
            h->fdec->i_row_bits[y-SLICE_MBAFF] = 0;
            return -1;
        }
    }
    else
    {
        h->rc->frame_size_estimated = predict_row_size_sum( h, y, rc->qpm );

        /* Last-ditch attempt: if the last row of the frame underflowed the VBV,
         * try again. */
        if( (h->rc->frame_size_estimated + size_of_other_slices) > (rc->buffer_fill - rc->buffer_rate * max_frame_error) &&
             rc->qpm < qp_max && can_reencode_row )
        {
            rc->qpm = qp_max;
            rc->qpa_rc = rc->qpa_rc_prev;
            rc->qpa_aq = rc->qpa_aq_prev;
            h->fdec->i_row_bits[y] = 0;
            h->fdec->i_row_bits[y-SLICE_MBAFF] = 0;
            return -1;
        }
    }

    rc->qpa_rc_prev = rc->qpa_rc;
    rc->qpa_aq_prev = rc->qpa_aq;

    return 0;
}


int x264_ratecontrol_mb_qp( x264_t *h )/// called by X264_MACROBLOCK_ANALYSE
{
    x264_emms();
    float qp = h->rc->qpm;
//	fprintf(stderr,"slice_ratecontrol 1\n");
    if( h->param.rc.i_aq_mode )
    {//fprintf(stderr,"slice_ratecontrol 2\n");
         /* MB-tree currently doesn't adjust quantizers in unreferenced frames. */
//	fprintf(stderr,"%d 1\n",h->fdec->b_kept_as_ref);
//	fprintf(stderr,"%d 2\n",h->mb.i_mb_xy);
//	fprintf(stderr,"%d 2\n",h->fenc->f_qp_offset[h->mb.i_mb_xy]);
//	fprintf(stderr,"%d 3\n",h->fenc->f_qp_offset_aq[h->mb.i_mb_xy]);
        float qp_offset = h->fdec->b_kept_as_ref ? h->fenc->f_qp_offset[h->mb.i_mb_xy] : h->fenc->f_qp_offset_aq[h->mb.i_mb_xy];
        /* Scale AQ's effect towards zero in emergency mode. */
        if( qp > QP_MAX_SPEC )
            qp_offset *= (QP_MAX - qp) / (QP_MAX - QP_MAX_SPEC);
        qp += qp_offset;
    }
//	fprintf(stderr,"slice_ratecontrol 3\n");
    return x264_clip3( qp + 0.5f, h->param.rc.i_qp_min, h->param.rc.i_qp_max );
}
static float predict_size( predictor_t *p, float q, float var )/// called by X264_SLICE_WRITE
{
    return (p->coeff*var + p->offset) / (q*p->count);
}

static void update_predictor( predictor_t *p, float q, float var, float bits )/// called by X264_SLICE_WRITE
{
    float range = 1.5;
    if( var < 10 )
        return;
    float old_coeff = p->coeff / p->count;
    float new_coeff = X264_MAX( bits*q / var, p->coeff_min );
    float new_coeff_clipped = x264_clip3f( new_coeff, old_coeff/range, old_coeff*range );
    float new_offset = bits*q - new_coeff_clipped * var;
    if( new_offset >= 0 )
        new_coeff = new_coeff_clipped;
    else
        new_offset = 0;
    p->count  *= p->decay;
    p->coeff  *= p->decay;
    p->offset *= p->decay;
    p->count  ++;
    p->coeff  += new_coeff;
    p->offset += new_offset;
}

