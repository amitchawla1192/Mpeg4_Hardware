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
SUB4x4_DCT_dc,
SUB8x8_DCT_dc,
SUB8x16_DCT_dc,
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

char Buffer[32];

void dct4x4dc_wrap( dctcoef d[16] )
{
int function_id,send_size,recieve_size;
function_id = dct4x4dc;
sendsize = 16 * sizeof(dctcoef)/4
write_uint32("dct_in_data", function_id);
write_uint32("dct_in_data", send_size);
write_uint32_n("dct_in_data",d,send_size);
fprintf(stderr,"send data for dct4x4");

function_id = read_uint32("dct_out_data");
recieve_size = read_uint32("dct_out_data");
if(recieve_size != send_size)
fprintf(stderr,"Error in recieving data in dct4x4dc");
read_uint32_n("dct_out_data",d,recieve_size);
fprintf(stderr,"recieved data from dct4x4dc with function_id = %d",function_id);

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
sub8x8_dct( dct, pix1, pix2 );
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
