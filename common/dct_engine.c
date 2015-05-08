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
#include "dct.c"
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

void dct_engine()
{
	int func_id,size;
	char Buffer[];
	dctcoef d[16];
	while(1)
	{
		func_id = read_uint32("dct_in_data");
		size = read_uint32("dct_in_data");
		switch(func_id)
		{
			case DCT4x4DC: if (size == 16 * sizeof(dctcoef)/4 )
				{ read_uint32_n("dct_in_data",d,size);
					dct4x4dc(d);
				  write_uint32("dct_out_data",func_id);
				  write_uint32("dct_out_data",size);
		`		  write_uint32_n("dct_out_data",d,size/4);
				}
			break;





		}

	}
}
