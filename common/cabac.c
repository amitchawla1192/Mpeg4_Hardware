// This file is completely checked for Hardware

/*****************************************************************************
 * cabac.c: arithmetic coder
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
#include "common/matrixes_hw.h"

const uint8_t x264_cabac_range_lps[64][4] =  /// Matrix called by X264_SLICE_WRITE
{
    {  2,   2,   2,   2}, {  6,   7,   8,   9}, {  6,   7,   9,  10}, {  6,   8,   9,  11},
    {  7,   8,  10,  11}, {  7,   9,  10,  12}, {  7,   9,  11,  12}, {  8,   9,  11,  13},
    {  8,  10,  12,  14}, {  9,  11,  12,  14}, {  9,  11,  13,  15}, { 10,  12,  14,  16},
    { 10,  12,  15,  17}, { 11,  13,  15,  18}, { 11,  14,  16,  19}, { 12,  14,  17,  20},
    { 12,  15,  18,  21}, { 13,  16,  19,  22}, { 14,  17,  20,  23}, { 14,  18,  21,  24},
    { 15,  19,  22,  25}, { 16,  20,  23,  27}, { 17,  21,  25,  28}, { 18,  22,  26,  30},
    { 19,  23,  27,  31}, { 20,  24,  29,  33}, { 21,  26,  30,  35}, { 22,  27,  32,  37},
    { 23,  28,  33,  39}, { 24,  30,  35,  41}, { 26,  31,  37,  43}, { 27,  33,  39,  45},
    { 29,  35,  41,  48}, { 30,  37,  43,  50}, { 32,  39,  46,  53}, { 33,  41,  48,  56},
    { 35,  43,  51,  59}, { 37,  45,  54,  62}, { 39,  48,  56,  65}, { 41,  50,  59,  69},
    { 43,  53,  63,  72}, { 46,  56,  66,  76}, { 48,  59,  69,  80}, { 51,  62,  73,  85},
    { 53,  65,  77,  89}, { 56,  69,  81,  94}, { 59,  72,  86,  99}, { 62,  76,  90, 104},
    { 66,  80,  95, 110}, { 69,  85, 100, 116}, { 73,  89, 105, 122}, { 77,  94, 111, 128},
    { 81,  99, 117, 135}, { 85, 104, 123, 142}, { 90, 110, 130, 150}, { 95, 116, 137, 158},
    {100, 122, 144, 166}, {105, 128, 152, 175}, {111, 135, 160, 185}, {116, 142, 169, 195},
    {123, 150, 178, 205}, {128, 158, 187, 216}, {128, 167, 197, 227}, {128, 176, 208, 240}
};

const uint8_t x264_cabac_transition[128][2] = /// Matrix called by X264_SLICE_WRITE
{
    {  0,   0}, {  1,   1}, {  2,  50}, { 51,   3}, {  2,  50}, { 51,   3}, {  4,  52}, { 53,   5},
    {  6,  52}, { 53,   7}, {  8,  52}, { 53,   9}, { 10,  54}, { 55,  11}, { 12,  54}, { 55,  13},
    { 14,  54}, { 55,  15}, { 16,  56}, { 57,  17}, { 18,  56}, { 57,  19}, { 20,  56}, { 57,  21},
    { 22,  58}, { 59,  23}, { 24,  58}, { 59,  25}, { 26,  60}, { 61,  27}, { 28,  60}, { 61,  29},
    { 30,  60}, { 61,  31}, { 32,  62}, { 63,  33}, { 34,  62}, { 63,  35}, { 36,  64}, { 65,  37},
    { 38,  66}, { 67,  39}, { 40,  66}, { 67,  41}, { 42,  66}, { 67,  43}, { 44,  68}, { 69,  45},
    { 46,  68}, { 69,  47}, { 48,  70}, { 71,  49}, { 50,  72}, { 73,  51}, { 52,  72}, { 73,  53},
    { 54,  74}, { 75,  55}, { 56,  74}, { 75,  57}, { 58,  76}, { 77,  59}, { 60,  78}, { 79,  61},
    { 62,  78}, { 79,  63}, { 64,  80}, { 81,  65}, { 66,  82}, { 83,  67}, { 68,  82}, { 83,  69},
    { 70,  84}, { 85,  71}, { 72,  84}, { 85,  73}, { 74,  88}, { 89,  75}, { 76,  88}, { 89,  77},
    { 78,  90}, { 91,  79}, { 80,  90}, { 91,  81}, { 82,  94}, { 95,  83}, { 84,  94}, { 95,  85},
    { 86,  96}, { 97,  87}, { 88,  96}, { 97,  89}, { 90, 100}, {101,  91}, { 92, 100}, {101,  93},
    { 94, 102}, {103,  95}, { 96, 104}, {105,  97}, { 98, 104}, {105,  99}, {100, 108}, {109, 101},
    {102, 108}, {109, 103}, {104, 110}, {111, 105}, {106, 112}, {113, 107}, {108, 114}, {115, 109},
    {110, 116}, {117, 111}, {112, 118}, {119, 113}, {114, 118}, {119, 115}, {116, 122}, {123, 117},
    {118, 122}, {123, 119}, {120, 124}, {125, 121}, {122, 126}, {127, 123}, {124, 127}, {126, 125}
};

const uint8_t x264_cabac_renorm_shift[64] =  /// Matrix called by X264_SLICE_WRITE
{
    6,5,4,4,3,3,3,3,2,2,2,2,2,2,2,2,
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
};

/* -ln2(probability) */
const uint16_t x264_cabac_entropy[128] =  /// Matrix called by X264_MACROBLOCK_ENCODE
{
    FIX8(0.0273), FIX8(5.7370), FIX8(0.0288), FIX8(5.6618),
    FIX8(0.0303), FIX8(5.5866), FIX8(0.0320), FIX8(5.5114),
    FIX8(0.0337), FIX8(5.4362), FIX8(0.0355), FIX8(5.3610),
    FIX8(0.0375), FIX8(5.2859), FIX8(0.0395), FIX8(5.2106),
    FIX8(0.0416), FIX8(5.1354), FIX8(0.0439), FIX8(5.0602),
    FIX8(0.0463), FIX8(4.9851), FIX8(0.0488), FIX8(4.9099),
    FIX8(0.0515), FIX8(4.8347), FIX8(0.0543), FIX8(4.7595),
    FIX8(0.0572), FIX8(4.6843), FIX8(0.0604), FIX8(4.6091),
    FIX8(0.0637), FIX8(4.5339), FIX8(0.0671), FIX8(4.4588),
    FIX8(0.0708), FIX8(4.3836), FIX8(0.0747), FIX8(4.3083),
    FIX8(0.0788), FIX8(4.2332), FIX8(0.0832), FIX8(4.1580),
    FIX8(0.0878), FIX8(4.0828), FIX8(0.0926), FIX8(4.0076),
    FIX8(0.0977), FIX8(3.9324), FIX8(0.1032), FIX8(3.8572),
    FIX8(0.1089), FIX8(3.7820), FIX8(0.1149), FIX8(3.7068),
    FIX8(0.1214), FIX8(3.6316), FIX8(0.1282), FIX8(3.5565),
    FIX8(0.1353), FIX8(3.4813), FIX8(0.1429), FIX8(3.4061),
    FIX8(0.1510), FIX8(3.3309), FIX8(0.1596), FIX8(3.2557),
    FIX8(0.1686), FIX8(3.1805), FIX8(0.1782), FIX8(3.1053),
    FIX8(0.1884), FIX8(3.0301), FIX8(0.1992), FIX8(2.9549),
    FIX8(0.2107), FIX8(2.8797), FIX8(0.2229), FIX8(2.8046),
    FIX8(0.2358), FIX8(2.7294), FIX8(0.2496), FIX8(2.6542),
    FIX8(0.2642), FIX8(2.5790), FIX8(0.2798), FIX8(2.5038),
    FIX8(0.2964), FIX8(2.4286), FIX8(0.3142), FIX8(2.3534),
    FIX8(0.3331), FIX8(2.2782), FIX8(0.3532), FIX8(2.2030),
    FIX8(0.3748), FIX8(2.1278), FIX8(0.3979), FIX8(2.0527),
    FIX8(0.4226), FIX8(1.9775), FIX8(0.4491), FIX8(1.9023),
    FIX8(0.4776), FIX8(1.8271), FIX8(0.5082), FIX8(1.7519),
    FIX8(0.5412), FIX8(1.6767), FIX8(0.5768), FIX8(1.6015),
    FIX8(0.6152), FIX8(1.5263), FIX8(0.6568), FIX8(1.4511),
    FIX8(0.7020), FIX8(1.3759), FIX8(0.7513), FIX8(1.3008),
    FIX8(0.8050), FIX8(1.2256), FIX8(0.8638), FIX8(1.1504),
    FIX8(0.9285), FIX8(1.0752), FIX8(1.0000), FIX8(1.0000)
};

//extern uint8_t x264_cabac_contexts[4][QP_MAX_SPEC+1][1024]; // Matrix to be copied from s/W to H/W
/*
void x264_cabac_init( x264_t *h )
{
    int ctx_count = CHROMA444 ? 1024 : 460;
    for( int i = 0; i < 4; i++ )
    {
        const int8_t (*cabac_context_init)[1024][2] = i == 0 ? &x264_cabac_context_init_I
                                                             : &x264_cabac_context_init_PB[i-1];
        for( int qp = 0; qp <= QP_MAX_SPEC; qp++ )
            for( int j = 0; j < ctx_count; j++ )
            {
                int state = x264_clip3( (((*cabac_context_init)[j][0] * qp) >> 4) + (*cabac_context_init)[j][1], 1, 126 );
                x264_cabac_contexts[i][qp][j] = (X264_MIN( state, 127-state ) << 1) | (state >> 6);
            }
    }
}
*/
/*****************************************************************************
 *
 *****************************************************************************/
void x264_cabac_context_init( x264_t *h, x264_cabac_t *cb, int i_slice_type, int i_qp, int i_model )  // called from X264_SLICE_WRITE
{
    memcpy( cb->state, x264_cabac_contexts_hw[i_slice_type == SLICE_TYPE_I ? 0 : i_model + 1][i_qp], CHROMA444 ? 1024 : 460 );
}

void x264_cabac_encode_init_core( x264_cabac_t *cb )	 // called from X264_SLICE_WRITE
{
    cb->i_low   = 0;
    cb->i_range = 0x01FE;
    cb->i_queue = -9; // the first bit will be shifted away and not written
    cb->i_bytes_outstanding = 0;
}

void x264_cabac_encode_init( x264_cabac_t *cb, uint8_t *p_data, uint8_t *p_end )	 // called from X264_SLICE_WRITE
{
    x264_cabac_encode_init_core( cb );
    cb->p_start = p_data;
    cb->p       = p_data;
    cb->p_end   = p_end;
}

static inline void x264_cabac_putbyte( x264_cabac_t *cb )/// called by X264_SLICE_WRITE
{
    if( cb->i_queue >= 0 )
    {
        int out = cb->i_low >> (cb->i_queue+10);
        cb->i_low &= (0x400<<cb->i_queue)-1;
        cb->i_queue -= 8;

        if( (out & 0xff) == 0xff )
            cb->i_bytes_outstanding++;
        else
        {
            int carry = out >> 8;
            int bytes_outstanding = cb->i_bytes_outstanding;
            // this can't modify before the beginning of the stream because
            // that would correspond to a probability > 1.
            // it will write before the beginning of the stream, which is ok
            // because a slice header always comes before cabac data.
            // this can't carry beyond the one byte, because any 0xff bytes
            // are in bytes_outstanding and thus not written yet.
            cb->p[-1] += carry;
            while( bytes_outstanding > 0 )
            {
                *(cb->p++) = carry-1;
                bytes_outstanding--;
            }
            *(cb->p++) = out;
            cb->i_bytes_outstanding = 0;
        }
    }
}

static inline void x264_cabac_encode_renorm( x264_cabac_t *cb )/// called by X264_SLICE_WRITE
{
    int shift = x264_cabac_renorm_shift[cb->i_range>>3];
    cb->i_range <<= shift;
    cb->i_low   <<= shift;
    cb->i_queue  += shift;
    x264_cabac_putbyte( cb );
}

/* Making custom versions of this function, even in asm, for the cases where
 * b is known to be 0 or 1, proved to be somewhat useful on x86_32 with GCC 3.4
 * but nearly useless with GCC 4.3 and worse than useless on x86_64. */
void x264_cabac_encode_decision_c( x264_cabac_t *cb, int i_ctx, int b )/// called by X264_SLICE_WRITE
{
    int i_state = cb->state[i_ctx];
    int i_range_lps = x264_cabac_range_lps[i_state>>1][(cb->i_range>>6)-4];
    cb->i_range -= i_range_lps;
    if( b != (i_state & 1) )
    {
        cb->i_low += cb->i_range;
        cb->i_range = i_range_lps;
    }
    cb->state[i_ctx] = x264_cabac_transition[i_state][b];
    x264_cabac_encode_renorm( cb );
}

/* Note: b is negated for this function */
void x264_cabac_encode_bypass_c( x264_cabac_t *cb, int b )/// This function is not called from any where still to be confirmed
{
    cb->i_low <<= 1;
    cb->i_low += b & cb->i_range;
    cb->i_queue += 1;
    x264_cabac_putbyte( cb );
}

static const int bypass_lut[16] =	// called by X264_SLICE_WRITE
{
    -1,      0x2,     0x14,     0x68,     0x1d0,     0x7a0,     0x1f40,     0x7e80,
    0x1fd00, 0x7fa00, 0x1ff400, 0x7fe800, 0x1ffd000, 0x7ffa000, 0x1fff4000, 0x7ffe8000
};

void x264_cabac_encode_ue_bypass( x264_cabac_t *cb, int exp_bits, int val )/// called by X264_SLICE_WRITE
{
    uint32_t v = val + (1<<exp_bits);
    int k = 31 - x264_clz( v );
    uint32_t x = (bypass_lut[k-exp_bits]<<exp_bits) + v;
    k = 2*k+1-exp_bits;
    int i = ((k-1)&7)+1;
    do {
        k -= i;
        cb->i_low <<= i;
        cb->i_low += ((x>>k)&0xff) * cb->i_range;
        cb->i_queue += i;
        x264_cabac_putbyte( cb );
        i = 8;
    } while( k > 0 );
}

void x264_cabac_encode_terminal_c( x264_cabac_t *cb )/// called by X264_SLICE_WRITE
{
    cb->i_range -= 2;
    x264_cabac_encode_renorm( cb );
}

void x264_cabac_encode_flush( x264_t *h, x264_cabac_t *cb )/// called by X264_SLICE_WRITE
{
    cb->i_low += cb->i_range - 2;
    cb->i_low |= 1;
    cb->i_low <<= 9;
    cb->i_queue += 9;
    x264_cabac_putbyte( cb );
    x264_cabac_putbyte( cb );
    cb->i_low <<= -cb->i_queue;
    cb->i_low |= (0x35a4e4f5 >> (h->i_frame & 31) & 1) << 10;
    cb->i_queue = 0;
    x264_cabac_putbyte( cb );

    while( cb->i_bytes_outstanding > 0 )
    {
        *(cb->p++) = 0xff;
        cb->i_bytes_outstanding--;
    }
}

