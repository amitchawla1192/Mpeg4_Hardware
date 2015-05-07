#include "common.h"
void dct4x4dc_wrap( dctcoef d[16] )
{
fprintf(stderr,"going in dct_wrapper");
dct4x4dc( d );
fprintf(stderr,"returning in dct_wrapper");
}

void idct4x4dc_wrap( dctcoef d[16] )
{
fprintf(stderr,"going in dct_wrapper");
idct4x4dc( d );
fprintf(stderr,"returning in dct_wrapper");
}

void dct2x4dc_wrap( dctcoef dct[8], dctcoef dct4x4[8][16] )
{
fprintf(stderr,"going in dct_wrapper");
dct2x4dc(  dct,  dct4x4 );
fprintf(stderr,"returning in dct_wrapper");
}

void sub4x4_dct_wrap( dctcoef dct[16], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper");
sub4x4_dct(  dct, pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper");
}

void sub8x8_dct_wrap( dctcoef dct[4][16], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper");
sub8x8_dct_wrap( dct, pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper");
}

void sub16x16_dct_wrap( dctcoef dct[16][16], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper");
sub16x16_dct( dct, pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper");
}

int sub4x4_dct_dc_wrap( pixel *pix1, pixel *pix2 )
{int sum ;
fprintf(stderr,"going in dct_wrapper");
sum = sub4x4_dct_dc( pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper");
return sum;
}

void sub8x8_dct_dc_wrap( dctcoef dct[4], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper");
sub8x8_dct_dc(  dct, pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper");
}

void sub8x16_dct_dc_wrap( dctcoef dct[8], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper");
sub8x16_dct_dc(  dct, pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper");
}

void add4x4_idct_wrap( pixel *p_dst, dctcoef dct[16] )
{
fprintf(stderr,"going in dct_wrapper");
add4x4_idct( p_dst,  dct );
fprintf(stderr,"returning in dct_wrapper");
}

void add8x8_idct_wrap( pixel *p_dst, dctcoef dct[4][16] )
{
fprintf(stderr,"going in dct_wrapper");
add8x8_idct( p_dst, dct );
fprintf(stderr,"returning in dct_wrapper");
}

void add16x16_idct_wrap( pixel *p_dst, dctcoef dct[16][16] )
{
fprintf(stderr,"going in dct_wrapper");
add16x16_idct(p_dst,  dct );
fprintf(stderr,"returning in dct_wrapper");
}


void sub8x8_dct8_wrap( dctcoef dct[64], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper");
sub8x8_dct8(  dct,pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper");
}

void sub16x16_dct8_wrap( dctcoef dct[4][64], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper");
sub16x16_dct8(  dct,pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper");
}

void add8x8_idct8_wrap( pixel *dst, dctcoef dct[64] )
{
fprintf(stderr,"going in dct_wrapper");
add8x8_idct8( dst,  dct );
fprintf(stderr,"returning in dct_wrapper");
}

void add16x16_idct8_wrap( pixel *dst, dctcoef dct[4][64] )
{
fprintf(stderr,"going in dct_wrapper");
add16x16_idct8( dst,  dct );
fprintf(stderr,"returning in dct_wrapper");
}

void inline add4x4_idct_dc_wrap( pixel *p_dst, dctcoef dc )
{
fprintf(stderr,"going in dct_wrapper");
add4x4_idct_dc( p_dst,  dc );
fprintf(stderr,"returning in dct_wrapper");
}

void add8x8_idct_dc_wrap( pixel *p_dst, dctcoef dct[4] )
{
fprintf(stderr,"going in dct_wrapper");
add8x8_idct_dc( p_dst, dct );
fprintf(stderr,"returning in dct_wrapper");
}

 void add16x16_idct_dc_wrap( pixel *p_dst, dctcoef dct[16] )
{
fprintf(stderr,"going in dct_wrapper");
add16x16_idct_dc( p_dst, dct );    
fprintf(stderr,"returning in dct_wrapper");
}

