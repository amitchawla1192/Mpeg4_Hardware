#if HAVE_DCT_WRAP
#define dct4x4dc dct4x4dc_wrap
#define idct4x4dc idct4x4dc_wrap
#define dct2x4dc dct2x4dc_wrap
#define sub4x4_dct sub4x4_dct_wrap
#define sub8x8_dct sub8x8_dct_wrap
#define sub16x16_dct sub16x16_dct_wrap
#define sub4x4_dct_dc sub4x4_dct_dc_wrap
#define sub8x8_dct_dc sub8x8_dct_dc_wrap
#define sub8x16_dct_dc sub8x16_dct_dc_wrap
#define add4x4_idct add4x4_idct_wrap
#define add8x8_idct add8x8_idct_wrap
#define add16x16_idct add16x16_idct_wrap
#define sub8x8_dct8 sub8x8_dct8_wrap
#define sub16x16_dct8 sub16x16_dct8_wrap
#define add8x8_idct8 add8x8_idct8_wrap
#define add16x16_idct8 add16x16_idct8_wrap
#define add4x4_idct_dc add4x4_idct_dc_wrap
#define add8x8_idct_dc add8x8_idct_dc_wrap
#define add16x16_idct_dc add16x16_idct_dc_wrap
#endif
