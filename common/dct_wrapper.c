#include <stdio.h>
#include <iolib.h>
#include "common.h"
#if HIGH_BIT_DEPTH
    typedef uint16_t pixel;
    typedef uint64_t pixel4;
    typedef int32_t  dctcoef;
    typedef uint32_t udctcoef;

#else
    typedef uint8_t  pixel;
    typedef uint32_t pixel4;
    typedef int16_t  dctcoef;
    typedef uint16_t udctcoef;

#endif

enum func_id
{ 
DCT4x4DC,
IDCT4x4DC,
DCT2x4DC,
SUB4x4_DCT,
SUB8x8_DCT,
SUB16x16_DCT,
SUB4x4_DCT_DC,
SUB8x8_DCT_DC,
SUB8x16_DCT_DC,
ADD4x4_IDCT,
ADD8x8_IDCT,
ADD16x16_IDCT,
SUB8x8_DCT8,
SUB16x16_DCT8,
ADD8x8_IDCT8,
ADD16x16_IDCT8,
ADD4x4_IDCT_DC,
ADD8x8_IDCT_DC,
ADD16x16_IDCT_DC
};



void dct4x4dc_wrap( dctcoef d[16] )
{
fprintf(stderr,"going in dct_wrapper \n");
dct4x4dc(  d);
fprintf(stderr,"returning in dct_wrapper \n");
}

void idct4x4dc_wrap( dctcoef d[16] )
{
fprintf(stderr,"going in dct_wrapper \n");
idct4x4dc(  d );
fprintf(stderr,"returning in dct_wrapper \n");
}

void dct2x4dc_wrap( dctcoef dct[8], dctcoef dct4x4[8][16] )
{
fprintf(stderr,"going in dct_wrapper \n");
dct2x4dc(  dct, dct4x4 );
fprintf(stderr,"returning in dct_wrapper \n");
}

void sub4x4_dct_wrap( dctcoef dct[16], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper \n");


      int function_id,send_size1,send_size2,send_size3,recieve_size;
      function_id = SUB4x4_DCT;
      dctcoef temp[16];
      for(int i=0; i < 16; i++)
      {temp[i] = dct[i];
      fprintf(stderr,"copying %d %d \n",temp[i],dct[i]);
      }
            ///  Sending part ////
      send_size1 =(16 * sizeof(dctcoef))/4;
      send_size2 = (4 * FENC_STRIDE * sizeof(pixel))/4;
      send_size3 = (4 * FDEC_STRIDE * sizeof(pixel))/4;
      write_uint32("dct_in_data", function_id);
      write_uint32("dct_in_data", send_size1+send_size2 + send_size3);
      write_uint32_n("dct_in_data",temp,send_size1);
      write_uint32_n("dct_in_data",pix1,send_size2);
      write_uint32_n("dct_in_data",pix2,send_size3);
      fprintf(stderr,"sent data for sub4x4dct \n");
      ///  Recieving part ////
      function_id = read_uint32("dct_out_data");
      recieve_size = read_uint32("dct_out_data");
      
      fprintf(stderr,"recieving data in sub4x4dct %d %d %d \n",function_id,recieve_size,send_size1);
      read_uint32_n("dct_out_data",temp,(16 * sizeof(dctcoef))/4);
      for(int i=0; i < 16; i++)
	 fprintf(stderr,"recieved data at sw is %d \n",temp[i]);
      fprintf(stderr,"recieved data from sub4x4dct with function_id = %d \n",function_id);


sub4x4_dct(  dct, pix1, pix2 );
for(int i=0; i < 16 ; i++)
	if(temp[i] != dct[i])
	  fprintf(stderr,"Error in results of sub4x4_dct %d %d \n",temp[i],dct[i]);
fprintf(stderr,"returning in dct_wrapper \n");

}

void sub8x8_dct_wrap( dctcoef dct[4][16], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper \n");
sub8x8_dct(  dct, pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper \n");
}

void sub16x16_dct_wrap( dctcoef dct[16][16], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper \n");
sub16x16_dct(  dct, pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper \n");
}

int sub4x4_dct_dc_wrap( pixel *pix1, pixel *pix2 )
{int sum;
  fprintf(stderr,"going in dct_wrapper \n");
sum = sub4x4_dct_dc(  pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper \n");
return sum;
}

void sub8x8_dct_dc_wrap( dctcoef dct[4], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper \n");
sub8x8_dct_dc(  dct, pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper \n");
}

void sub8x16_dct_dc_wrap( dctcoef dct[8], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper \n");
sub8x16_dct_dc(  dct, pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper \n");
}

void add4x4_idct_wrap( pixel *p_dst, dctcoef dct[16] )
{
fprintf(stderr,"going in dct_wrapper \n");
add4x4_idct( p_dst,  dct );
fprintf(stderr,"returning in dct_wrapper \n");
}

void add8x8_idct_wrap( pixel *p_dst, dctcoef dct[4][16] )
{
fprintf(stderr,"going in dct_wrapper \n");
add8x8_idct( p_dst, dct );
fprintf(stderr,"returning in dct_wrapper \n");
}

void add16x16_idct_wrap( pixel *p_dst, dctcoef dct[16][16] )
{
fprintf(stderr,"going in dct_wrapper \n");
add16x16_idct(p_dst,  dct );
fprintf(stderr,"returning in dct_wrapper \n");
}


void sub8x8_dct8_wrap( dctcoef dct[64], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper \n");
sub8x8_dct8(  dct,pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper \n");
}

void sub16x16_dct8_wrap( dctcoef dct[4][64], pixel *pix1, pixel *pix2 )
{
fprintf(stderr,"going in dct_wrapper \n");
sub16x16_dct8(  dct,pix1, pix2 );
fprintf(stderr,"returning in dct_wrapper \n");
}

void add8x8_idct8_wrap( pixel *dst, dctcoef dct[64] )
{
fprintf(stderr,"going in dct_wrapper \n");
add8x8_idct8( dst,  dct );
fprintf(stderr,"returning in dct_wrapper \n");
}

void add16x16_idct8_wrap( pixel *dst, dctcoef dct[4][64] )
{
fprintf(stderr,"going in dct_wrapper \n");
add16x16_idct8( dst,  dct );
fprintf(stderr,"returning in dct_wrapper \n");
}

void inline add4x4_idct_dc_wrap( pixel *p_dst, dctcoef dc )
{
fprintf(stderr,"going in dct_wrapper \n");
add4x4_idct_dc( p_dst,  dc );
fprintf(stderr,"returning in dct_wrapper \n");
}

void add8x8_idct_dc_wrap( pixel *p_dst, dctcoef dct[4] )
{
fprintf(stderr,"going in dct_wrapper \n");
add8x8_idct_dc( p_dst, dct );
fprintf(stderr,"returning in dct_wrapper \n");
}

 void add16x16_idct_dc_wrap( pixel *p_dst, dctcoef dct[16] )
{
fprintf(stderr,"going in dct_wrapper \n");
add16x16_idct_dc( p_dst, dct );    
fprintf(stderr,"returning in dct_wrapper \n");
}

