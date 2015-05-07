// This file is completely checked for Hardware
/*****************************************************************************
 * quant.c: quantization and level-run
 *****************************************************************************
 * Copyright (C) 2005-2014 x264 project
 *
 * Authors: Loren Merritt <lorenm@u.washington.edu>
 *          Fiona Glaser <fiona@x264.com>
 *          Christian Heine <sennindemokrit@gmx.net>
 *          Henrik Gramner <henrik@gramner.com>
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

#define QUANT_ONE( coef, mf, f ) \
{ \
    if( (coef) > 0 ) \
        (coef) = (f + (coef)) * (mf) >> 16; \
    else \
        (coef) = - ((f - (coef)) * (mf) >> 16); \
    nz |= (coef); \
}
int modulo(int a, int b)
{int c;
while(a>=b)
{
a = a - b;

}
#ifdef SW
if(c%b != a)
fprintf(stderr,"error in modulo function in quant.c");
#endif
return a;
}


 int quant_8x8( dctcoef dct[64], udctcoef mf[64], udctcoef bias[64] )
{
    int nz = 0;
    for( int i = 0; i < 64; i++ )
        QUANT_ONE( dct[i], mf[i], bias[i] );
    return !!nz;
}

 int quant_4x4( dctcoef dct[16], udctcoef mf[16], udctcoef bias[16] )
{
    int nz = 0;
    for( int i = 0; i < 16; i++ )
        QUANT_ONE( dct[i], mf[i], bias[i] );
    return !!nz;
}

 int quant_4x4x4( dctcoef dct[4][16], udctcoef mf[16], udctcoef bias[16] )
{
    int nza = 0;
    for( int j = 0; j < 4; j++ )
    {
        int nz = 0;
        for( int i = 0; i < 16; i++ )
            QUANT_ONE( dct[j][i], mf[i], bias[i] );
        nza |= (!!nz)<<j;
    }
    return nza;
}

 int quant_4x4_dc( dctcoef dct[16], int mf, int bias )
{
    int nz = 0;
    for( int i = 0; i < 16; i++ )
        QUANT_ONE( dct[i], mf, bias );
    return !!nz;
}

 int quant_2x2_dc( dctcoef dct[4], int mf, int bias )
{
    int nz = 0;
    QUANT_ONE( dct[0], mf, bias );
    QUANT_ONE( dct[1], mf, bias );
    QUANT_ONE( dct[2], mf, bias );
    QUANT_ONE( dct[3], mf, bias );
    return !!nz;
}

#define DEQUANT_SHL( x ) \
    dct[x] = ( dct[x] * dequant_mf[i_mf][x] ) << i_qbits

#define DEQUANT_SHR( x ) \
    dct[x] = ( dct[x] * dequant_mf[i_mf][x] + f ) >> (-i_qbits)

 void dequant_4x4( dctcoef dct[16], int dequant_mf[6][16], int i_qp )
{
    const int i_mf = modulo(i_qp,6);
    const int i_qbits = i_qp/6 - 4;

    if( i_qbits >= 0 )
    {
        for( int i = 0; i < 16; i++ )
            DEQUANT_SHL( i );
    }
    else
    {
        const int f = 1 << (-i_qbits-1);
        for( int i = 0; i < 16; i++ )
            DEQUANT_SHR( i );
    }
}

 void dequant_8x8( dctcoef dct[64], int dequant_mf[6][64], int i_qp )
{
    const int i_mf = modulo(i_qp,6);
    const int i_qbits = i_qp/6 - 6;

    if( i_qbits >= 0 )
    {
        for( int i = 0; i < 64; i++ )
            DEQUANT_SHL( i );
    }
    else
    {
        const int f = 1 << (-i_qbits-1);
        for( int i = 0; i < 64; i++ )
            DEQUANT_SHR( i );
    }
}

 void dequant_4x4_dc( dctcoef dct[16], int dequant_mf[6][16], int i_qp )
{
    const int i_qbits = i_qp/6 - 6;
	int qp_mod = modulo(i_qp,6);
    if( i_qbits >= 0 )
    {
        const int i_dmf = dequant_mf[qp_mod][0] << i_qbits;
        for( int i = 0; i < 16; i++ )
            dct[i] *= i_dmf;
    }
    else
    {
        const int i_dmf = dequant_mf[qp_mod][0];
        const int f = 1 << (-i_qbits-1);
        for( int i = 0; i < 16; i++ )
            dct[i] = ( dct[i] * i_dmf + f ) >> (-i_qbits);
    }
}

#define IDCT_DEQUANT_2X4_START \
    int a0 = dct[0] + dct[1]; \
    int a1 = dct[2] + dct[3]; \
    int a2 = dct[4] + dct[5]; \
    int a3 = dct[6] + dct[7]; \
    int a4 = dct[0] - dct[1]; \
    int a5 = dct[2] - dct[3]; \
    int a6 = dct[4] - dct[5]; \
    int a7 = dct[6] - dct[7]; \
    int b0 = a0 + a1; \
    int b1 = a2 + a3; \
    int b2 = a4 + a5; \
    int b3 = a6 + a7; \
    int b4 = a0 - a1; \
    int b5 = a2 - a3; \
    int b6 = a4 - a5; \
    int b7 = a6 - a7;

 void idct_dequant_2x4_dc( dctcoef dct[8], dctcoef dct4x4[8][16], int dequant_mf[6][16], int i_qp )
{
    IDCT_DEQUANT_2X4_START
	int qp_mod = modulo(i_qp,6);
    int dmf = dequant_mf[qp_mod][0] << i_qp/6;
    dct4x4[0][0] = ((b0 + b1) * dmf + 32) >> 6;
    dct4x4[1][0] = ((b2 + b3) * dmf + 32) >> 6;
    dct4x4[2][0] = ((b0 - b1) * dmf + 32) >> 6;
    dct4x4[3][0] = ((b2 - b3) * dmf + 32) >> 6;
    dct4x4[4][0] = ((b4 - b5) * dmf + 32) >> 6;
    dct4x4[5][0] = ((b6 - b7) * dmf + 32) >> 6;
    dct4x4[6][0] = ((b4 + b5) * dmf + 32) >> 6;
    dct4x4[7][0] = ((b6 + b7) * dmf + 32) >> 6;
}

 void idct_dequant_2x4_dconly( dctcoef dct[8], int dequant_mf[6][16], int i_qp )
{
    IDCT_DEQUANT_2X4_START
	 int qp_mod = modulo(i_qp,6);
    int dmf = dequant_mf[qp_mod][0] << i_qp/6;
    dct[0] = ((b0 + b1) * dmf + 32) >> 6;
    dct[1] = ((b2 + b3) * dmf + 32) >> 6;
    dct[2] = ((b0 - b1) * dmf + 32) >> 6;
    dct[3] = ((b2 - b3) * dmf + 32) >> 6;
    dct[4] = ((b4 - b5) * dmf + 32) >> 6;
    dct[5] = ((b6 - b7) * dmf + 32) >> 6;
    dct[6] = ((b4 + b5) * dmf + 32) >> 6;
    dct[7] = ((b6 + b7) * dmf + 32) >> 6;
}

 ALWAYS_INLINE void optimize_chroma_idct_dequant_2x4( dctcoef out[8], dctcoef dct[8], int dmf )
{
    IDCT_DEQUANT_2X4_START
    out[0] = ((b0 + b1) * dmf + 2080) >> 6; /* 2080 = 32 + (32<<6) */
    out[1] = ((b2 + b3) * dmf + 2080) >> 6;
    out[2] = ((b0 - b1) * dmf + 2080) >> 6;
    out[3] = ((b2 - b3) * dmf + 2080) >> 6;
    out[4] = ((b4 - b5) * dmf + 2080) >> 6;
    out[5] = ((b6 - b7) * dmf + 2080) >> 6;
    out[6] = ((b4 + b5) * dmf + 2080) >> 6;
    out[7] = ((b6 + b7) * dmf + 2080) >> 6;
}
#undef IDCT_DEQUANT_2X4_START

 ALWAYS_INLINE void optimize_chroma_idct_dequant_2x2( dctcoef out[4], dctcoef dct[4], int dmf )
{
    int d0 = dct[0] + dct[1];
    int d1 = dct[2] + dct[3];
    int d2 = dct[0] - dct[1];
    int d3 = dct[2] - dct[3];
    out[0] = ((d0 + d1) * dmf >> 5) + 32;
    out[1] = ((d0 - d1) * dmf >> 5) + 32;
    out[2] = ((d2 + d3) * dmf >> 5) + 32;
    out[3] = ((d2 - d3) * dmf >> 5) + 32;
}

 ALWAYS_INLINE int optimize_chroma_round( dctcoef *ref, dctcoef *dct, int dequant_mf, int chroma422 )
{
    dctcoef out[8];

    if( chroma422 )
        optimize_chroma_idct_dequant_2x4( out, dct, dequant_mf );
    else
        optimize_chroma_idct_dequant_2x2( out, dct, dequant_mf );

    int sum = 0;
    for( int i = 0; i < (chroma422?8:4); i++ )
        sum |= ref[i] ^ out[i];
    return sum >> 6;
}

 ALWAYS_INLINE int optimize_chroma_dc_internal( dctcoef *dct, int dequant_mf, int chroma422 )
{
    /* dequant_mf = h->dequant4_mf[CQM_4IC + b_inter][i_qp%6][0] << i_qp/6, max 32*64 */
    dctcoef dct_orig[8];
    int coeff, nz;

    if( chroma422 )
        optimize_chroma_idct_dequant_2x4( dct_orig, dct, dequant_mf );
    else
        optimize_chroma_idct_dequant_2x2( dct_orig, dct, dequant_mf );

    /* If the DC coefficients already round to zero, terminate early. */
    int sum = 0;
    for( int i = 0; i < (chroma422?8:4); i++ )
        sum |= dct_orig[i];
    if( !(sum >> 6) )
        return 0;

    /* Start with the highest frequency coefficient... is this the best option? */
    for( nz = 0, coeff = (chroma422?7:3); coeff >= 0; coeff-- )
    {
        int level = dct[coeff];
        int sign = level>>31 | 1; /* dct[coeff] < 0 ? -1 : 1 */

        while( level )
        {
            dct[coeff] = level - sign;
            if( optimize_chroma_round( dct_orig, dct, dequant_mf, chroma422 ) )
            {
                nz = 1;
                dct[coeff] = level;
                break;
            }
            level -= sign;
        }
    }

    return nz;
}

 int optimize_chroma_2x2_dc( dctcoef dct[4], int dequant_mf )
{
    return optimize_chroma_dc_internal( dct, dequant_mf, 0 );
}

 int optimize_chroma_2x4_dc( dctcoef dct[8], int dequant_mf )
{
    return optimize_chroma_dc_internal( dct, dequant_mf, 1 );
}

 void x264_denoise_dct( dctcoef *dct, uint32_t *sum, udctcoef *offset, int size )
{
    for( int i = 0; i < size; i++ )
    {
        int level = dct[i];
        int sign = level>>31;
        level = (level+sign)^sign;
        sum[i] += level;
        level -= offset[i];
        dct[i] = level<0 ? 0 : (level^sign)-sign;
    }
}

/* (ref: JVT-B118)
 * x264_mb_decimate_score: given dct coeffs it returns a score to see if we could empty this dct coeffs
 * to 0 (low score means set it to null)
 * Used in inter macroblock (luma and chroma)
 *  luma: for a 8x8 block: if score < 4 -> null
 *        for the complete mb: if score < 6 -> null
 *  chroma: for the complete mb: if score < 7 -> null
 */

const uint8_t x264_decimate_table4[16] =
{
    3,2,2,1,1,1,0,0,0,0,0,0,0,0,0,0
};
const uint8_t x264_decimate_table8[64] =
{
    3,3,3,3,2,2,2,2,2,2,2,2,1,1,1,1,
    1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
};

 int ALWAYS_INLINE x264_decimate_score_internal( dctcoef *dct, int i_max )
{
    const uint8_t *ds_table = (i_max == 64) ? x264_decimate_table8 : x264_decimate_table4;
    int i_score = 0;
    int idx = i_max - 1;

    while( idx >= 0 && dct[idx] == 0 )
        idx--;
    while( idx >= 0 )
    {
        int i_run;

        if( (unsigned)(dct[idx--] + 1) > 2 )
            return 9;

        i_run = 0;
        while( idx >= 0 && dct[idx] == 0 )
        {
            idx--;
            i_run++;
        }
        i_score += ds_table[i_run];
    }

    return i_score;
}

 int x264_decimate_score15( dctcoef *dct )
{
    return x264_decimate_score_internal( dct+1, 15 );
}
 int x264_decimate_score16( dctcoef *dct )
{
    return x264_decimate_score_internal( dct, 16 );
}
int x264_decimate_score64( dctcoef *dct )
{
    return x264_decimate_score_internal( dct, 64 );
}

#define last(num)\
int x264_coeff_last##num( dctcoef *l )\
{\
    int i_last = num-1;\
    while( i_last >= 0 && l[i_last] == 0 )\
        i_last--;\
    return i_last;\
}

last(4)
last(8)
last(15)
last(16)
last(64)

#define level_run(num)\
int x264_coeff_level_run##num( dctcoef *dct, x264_run_level_t *runlevel )\
{\
    int i_last = runlevel->last = x264_coeff_last##num(dct);\
    int i_total = 0;\
    int mask = 0;\
    do\
    {\
        runlevel->level[i_total++] = dct[i_last];\
        mask |= 1 << (i_last);\
        while( --i_last >= 0 && dct[i_last] == 0 );\
    } while( i_last >= 0 );\
    runlevel->mask = mask;\
    return i_total;\
}

level_run(4)
level_run(8)
level_run(15)
level_run(16)

