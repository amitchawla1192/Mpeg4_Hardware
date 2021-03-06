#define _ISOC99_SOURCE
#include <Pipes.h>
#include "$(HOME)/x264-devel-master/common/common.h"
#define RELATIVE_ADDRESS(point) if(frame->point == NULL) \
				frame1->point = NULL;\
				else \
				frame1->point = (intptr_t)frame->point - (intptr_t)frame->base + (intptr_t)frame1->base; 
				


x264_frame_sw_sync(x264_frame_t *frame,void *Buffer)
{
x264_frame_t f1;
x264_frame_t *fenc=&f1;
void *fenc_hw;
char frame_buffer[177056];
f1.base = frame_buffer;
//frame1 = malloc(sizeof(x264_frame_t));
//frame1->base = malloc(177056);
memcpy(fenc, Buffer, sizeof(x264_frame_t));
//frame1->base = malloc(177056);
memcpy(fenc->base, Buffer + sizeof(x264_frame_t), 177056);
    for( int i = 0; i < X264_BFRAME_MAX+2; i++ )
        for( int j = 0; j < X264_BFRAME_MAX+2 ; j++ )
	{	RELATIVE_ADDRESS(i_row_satds[i][j])
	}
	RELATIVE_ADDRESS(buffer[0])
	RELATIVE_ADDRESS(buffer[1])
	RELATIVE_ADDRESS(buffer[2])
	RELATIVE_ADDRESS(buffer[3])
	RELATIVE_ADDRESS(buffer_fld[0])
	RELATIVE_ADDRESS(buffer_fld[1])
	RELATIVE_ADDRESS(buffer_fld[2])
	RELATIVE_ADDRESS(buffer_fld[3])
	RELATIVE_ADDRESS(mb_type)
	RELATIVE_ADDRESS(mb_partition)
	RELATIVE_ADDRESS(mv[0])
	RELATIVE_ADDRESS(mv16x16)
	RELATIVE_ADDRESS(ref[0])
	RELATIVE_ADDRESS(mv[1])
	RELATIVE_ADDRESS(ref[1])
	RELATIVE_ADDRESS(i_row_bits)
	RELATIVE_ADDRESS(f_row_qp)
	RELATIVE_ADDRESS(f_row_qscale)
	RELATIVE_ADDRESS(field)	
	RELATIVE_ADDRESS(effective_qp)
	RELATIVE_ADDRESS(buffer_lowres[0])
	for(int i = 0; i < 2; i++ )
        for(int j = 0; j < X264_BFRAME_MAX+1 ; j++ )
	{	RELATIVE_ADDRESS(lowres_mvs[i][j])
		RELATIVE_ADDRESS(lowres_mv_costs[i][j])
	}
	for( int i = 0; i < X264_BFRAME_MAX+2; i++ )
        for( int j = 0; j < X264_BFRAME_MAX+2 ; j++ )
        {       RELATIVE_ADDRESS(lowres_costs[i][j])
        }

	RELATIVE_ADDRESS(f_qp_offset)
	RELATIVE_ADDRESS(f_qp_offset_aq)
	RELATIVE_ADDRESS(i_inv_qscale_factor)
	

	if(*frame->plane[0] == *frame1->plane[0])
	fprintf(stdout, "frames i_type for frame-i_pts %lld  is found same %ld and %ld   \n", frame->i_pts,*frame->plane[0],*frame1->plane[0]);
	else 
	fprintf(stdout, "frame i_type for frame->i_pts %ld is found to be different and unexpected %lf and %lf \n", frame->i_pts, *frame->f_qp_offset,*frame1->f_qp_offset);

	return;
}

