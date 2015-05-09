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
#include "dct.h"
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
	dctcoef d[16];
	dctcoef dct[16];
	dctcoef dct1[16][16];
	dctcoef dct4x4[8][16];
	pixel pix1[16][FENC_STRIDE],pix2[16][FDEC_STRIDE];
	while(1)
	{
		func_id = read_uint32("dct_in_data");
		size = read_uint32("dct_in_data");
		switch(func_id)
		{
			case DCT4x4DC: if (size == (16 * sizeof(dctcoef))/4)
				{ read_uint32_n("dct_in_data",d,size);
					dct4x4dc(d);
				  write_uint32("dct_out_data",func_id);
				  write_uint32("dct_out_data",size);
				  write_uint32_n("dct_out_data",d,size);
				}
			break;
			case IDCT4x4DC: if (size == (16 * sizeof(dctcoef))/4 )
				{ read_uint32_n("dct_in_data",d,size);
					idct4x4dc(d);
				  write_uint32("dct_out_data",func_id);
				  write_uint32("dct_out_data",size);
				  write_uint32_n("dct_out_data",d,size);
				}
			break;
			case DCT2x4DC: if (size == (8 * sizeof(dctcoef))/4 + (8 * 16 * sizeof(dctcoef))/4)
				{ read_uint32_n("dct_in_data",dct,(8 * sizeof(dctcoef))/4);
				  read_uint32_n("dct_in_data",dct4x4,(8 * 16 * sizeof(dctcoef))/4);
					dct2x4dc_wrap( dct, dct4x4 );
				  write_uint32("dct_out_data",func_id);
				  write_uint32("dct_out_data",(8 * sizeof(dctcoef))/4);
				  write_uint32_n("dct_out_data",dct,(8 * sizeof(dctcoef))/4);
				}
			break;
			case SUB4x4_DCT: if (size == (16 * sizeof(dctcoef))/4 + (4 * FENC_STRIDE * sizeof(pixel))/4 + (4 * FDEC_STRIDE * sizeof(pixel))/4 )
				{ fprintf(stderr,"going in sub4x4_dct %d %d  \n",size,func_id);
				  read_uint32_n("dct_in_data",dct,(16 * sizeof(dctcoef))/4);
				  read_uint32_n("dct_in_data",pix1,(4 * FENC_STRIDE * sizeof(pixel))/4);
				  read_uint32_n("dct_in_data",pix2,(4 * FDEC_STRIDE * sizeof(pixel))/4);
				  for(int i=0; i < 16; i++)
				  fprintf(stderr,"copying data temp at HW is %d \n",dct[i]);
      					sub4x4_dct( dct, pix1, pix2 );
				  write_uint32("dct_out_data",func_id);
				  write_uint32("dct_out_data",(16 * sizeof(dctcoef))/4);
				  write_uint32_n("dct_out_data",dct,(16 * sizeof(dctcoef))/4);
				  for(int i=0; i < 16; i++)
				  fprintf(stderr,"sending data temp at HW is %d \n",dct[i]);
      				
				}
			break;
			case SUB8x8_DCT: if (size == (4 * 16 * sizeof(dctcoef))/4 + (8 * FENC_STRIDE * sizeof(pixel))/4 + (8 * FDEC_STRIDE * sizeof(pixel))/4)
				{ read_uint32_n("dct_in_data",dct1,(4 * 16 * sizeof(dctcoef))/4);
				  read_uint32_n("dct_in_data",pix1,(8 * FENC_STRIDE * sizeof(pixel))/4);
				  read_uint32_n("dct_in_data",pix2,(8 * FENC_STRIDE * sizeof(pixel))/4);
					sub8x8_dct(dct1,pix1,pix2);
				  write_uint32("dct_out_data",func_id);
				  write_uint32("dct_out_data",size);
				  write_uint32_n("dct_out_data",dct1,(4 * 16 * sizeof(dctcoef))/4);
				}
			break;
			case SUB16x16_DCT: if (size == (16 * 16 * sizeof(dctcoef))/4 + (16 * FENC_STRIDE * sizeof(pixel))/4 + (16 * FDEC_STRIDE * sizeof(pixel))/4)
				{ read_uint32_n("dct_in_data",dct1,(16 * 16 * sizeof(dctcoef))/4);
				  read_uint32_n("dct_in_data",pix1,(16 * FENC_STRIDE * sizeof(pixel))/4);
				  read_uint32_n("dct_in_data",pix2,(16 * FENC_STRIDE * sizeof(pixel))/4);
					sub16x16_dct(dct1,pix1,pix2);
				  write_uint32("dct_out_data",func_id);
				  write_uint32("dct_out_data",size);
				  write_uint32_n("dct_out_data",dct1,(16 * 16 * sizeof(dctcoef))/4);
				}
			break;
			case SUB4x4_DCT_dc: if (size == (4 * FENC_STRIDE * sizeof(pixel))/4 + (4 * FDEC_STRIDE * sizeof(pixel))/4)
				{ int sum;
				  read_uint32_n("dct_in_data",pix1,(4 * FENC_STRIDE * sizeof(pixel))/4);
				  read_uint32_n("dct_in_data",pix2,(4 * FENC_STRIDE * sizeof(pixel))/4);
					sum = sub4x4_dct_dc(pix1,pix2);
				  write_uint32("dct_out_data",func_id);
				  write_uint32("dct_out_data",size);
				  write_uint32("dct_out_data",sum);
				}
			break;




		}

	}
}
