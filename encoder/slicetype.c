/*****************************************************************************
 * slicetype.c: lookahead analysis
 *****************************************************************************
 * Copyright (C) 2005-2014 x264 project
 *
 * Authors: Fiona Glaser <fiona@x264.com>
 *          Loren Merritt <lorenm@u.washington.edu>
 *          Dylan Yudaken <dyudaken@gmail.com>
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

#include "Hardware/common/common.h"
#include "macroblock.h"
#include "me.h"

// Indexed by pic_struct values
static const uint8_t delta_tfi_divisor[10] = { 0, 2, 1, 1, 2, 2, 3, 3, 4, 6 };

static int x264_slicetype_frame_cost( x264_t *h, x264_mb_analysis_t *a,
                                      x264_frame_t **frames, int p0, int p1, int b,
                                      int b_intra_penalty );

void x264_weights_analyse( x264_t *h, x264_frame_t *fenc, x264_frame_t *ref, int b_lookahead );

#if HAVE_OPENCL
int x264_opencl_lowres_init( x264_t *h, x264_frame_t *fenc, int lambda );
int x264_opencl_motionsearch( x264_t *h, x264_frame_t **frames, int b, int ref, int b_islist1, int lambda, const x264_weight_t *w );
int x264_opencl_finalize_cost( x264_t *h, int lambda, x264_frame_t **frames, int p0, int p1, int b, int dist_scale_factor );
int x264_opencl_precalculate_frame_cost( x264_t *h, x264_frame_t **frames, int lambda, int p0, int p1, int b );
void x264_opencl_flush( x264_t *h );
void x264_opencl_slicetype_prep( x264_t *h, x264_frame_t **frames, int num_frames, int lambda );
void x264_opencl_slicetype_end( x264_t *h );
#endif



/* How data is organized for 4:2:0/4:2:2 chroma weightp:
 * [U: ref] [U: fenc]
 * [V: ref] [V: fenc]
 * fenc = ref + offset
 * v = u + stride * chroma height */


/* Output buffers are separated by 128 bytes to avoid false sharing of cachelines
 * in multithreaded lookahead. */
#define PAD_SIZE 32
/* cost_est, cost_est_aq, intra_mbs, num rows */
#define NUM_INTS 4
#define COST_EST 0
#define COST_EST_AQ 1
#define INTRA_MBS 2
#define NUM_ROWS 3
#define ROW_SATD (NUM_INTS + (h->mb.i_mb_y - h->i_threadslice_start))

#undef TRY_BIDIR

#define NUM_MBS\
   (h->mb.i_mb_width > 2 && h->mb.i_mb_height > 2 ?\
   (h->mb.i_mb_width - 2) * (h->mb.i_mb_height - 2) :\
    h->mb.i_mb_width * h->mb.i_mb_height)

