/* This file contains the list of pointers modified at software side before sending frame to hardware side.
1. The pointers which are malloced are already taken care of and rest are listed in this file and are to be modified now.

1.  We do not need to transfer nul_buffer to hardware as it is always written at software side from p_bitstream
2.  h->frames.refference are to be replaced from corresponding fdec at hardware side, h->fref[0] and are also to be replaced correspondingly. are also to be replaced from 
*/


static void modify_frame_pointers(x264_t *h_hw,x264_frame_t *frame,char *frame_base)
{
#define RELATIVE_ADDRESS_FRAME(frame,point) if(frame->point == NULL) \
				{/*fprintf(stderr,"New address of frame1 is NULL \n");*/}\
				else \
{			/* fprintf(stderr,"old address  %p   and old base %p ",frame->point,frame->base);*/ \
	frame->point = (intptr_t)frame->point - (intptr_t)frame->base + (intptr_t)frame##_base; \
/* fprintf(stderr,"New address  %p  new base %p  \n",frame->point,frame##_base); */\
}

	RELATIVE_ADDRESS_FRAME(frame,plane[0])
	RELATIVE_ADDRESS_FRAME(frame,plane[1])
	RELATIVE_ADDRESS_FRAME(frame,plane[2])
	RELATIVE_ADDRESS_FRAME(frame,plane_fld[0])
	RELATIVE_ADDRESS_FRAME(frame,plane_fld[1])
	RELATIVE_ADDRESS_FRAME(frame,plane_fld[2])
	RELATIVE_ADDRESS_FRAME(frame,filtered[0][0])
//	fprintf(stderr,"New address  %p  new base %p  \n",frame->filtered[0][0],frame_base);
	RELATIVE_ADDRESS_FRAME(frame,filtered[0][1])
//	fprintf(stderr,"New address  %p  new base %p  \n",frame->filtered[0][1],frame_base);
	RELATIVE_ADDRESS_FRAME(frame,filtered[0][2])
//	fprintf(stderr,"New address  %p  new base %p  \n",frame->filtered[0][2],frame_base);
	RELATIVE_ADDRESS_FRAME(frame,filtered[0][3])
//	fprintf(stderr,"New address  %p  new base %p  \n",frame->filtered[0][3],frame_base);
	RELATIVE_ADDRESS_FRAME(frame,filtered[1][0])
//	fprintf(stderr,"New address  %p  new base %p  \n",frame->filtered[1][0],frame_base);
	RELATIVE_ADDRESS_FRAME(frame,filtered[1][1])
//	fprintf(stderr,"New address  %p  new base %p  \n",frame->filtered[1][1],frame_base);
	RELATIVE_ADDRESS_FRAME(frame,filtered[1][2])
//	fprintf(stderr,"New address  %p  new base %p  \n",frame->filtered[1][2],frame_base);
	RELATIVE_ADDRESS_FRAME(frame,filtered[1][3])
//	fprintf(stderr,"New address  %p  new base %p  \n",frame->filtered[1][3],frame_base);
	RELATIVE_ADDRESS_FRAME(frame,filtered[2][0])
//	fprintf(stderr,"New address  %p  new base %p  \n",frame->filtered[2][0],frame_base);
	RELATIVE_ADDRESS_FRAME(frame,filtered[2][1])
//	fprintf(stderr,"New address  %p  new base %p  \n",frame->filtered[2][1],frame_base);
	RELATIVE_ADDRESS_FRAME(frame,filtered[2][2])
//	fprintf(stderr,"New address  %p  new base %p  \n",frame->filtered[2][2],frame_base);
	RELATIVE_ADDRESS_FRAME(frame,filtered[2][3])
//	fprintf(stderr,"New address  %p  new base %p  \n",frame->filtered[2][3],frame_base);
	RELATIVE_ADDRESS_FRAME(frame,filtered_fld[0][0])
	RELATIVE_ADDRESS_FRAME(frame,filtered_fld[0][1])
	RELATIVE_ADDRESS_FRAME(frame,filtered_fld[0][2])
	RELATIVE_ADDRESS_FRAME(frame,filtered_fld[0][3])
	RELATIVE_ADDRESS_FRAME(frame,filtered_fld[1][0])
	RELATIVE_ADDRESS_FRAME(frame,filtered_fld[1][1])
	RELATIVE_ADDRESS_FRAME(frame,filtered_fld[1][2])
	RELATIVE_ADDRESS_FRAME(frame,filtered_fld[1][3])
	RELATIVE_ADDRESS_FRAME(frame,filtered_fld[2][0])
	RELATIVE_ADDRESS_FRAME(frame,filtered_fld[2][1])
	RELATIVE_ADDRESS_FRAME(frame,filtered_fld[2][2])
	RELATIVE_ADDRESS_FRAME(frame,filtered_fld[2][3])
	for (int i=0 ; i < 4 ; i++)
	{	
	RELATIVE_ADDRESS_FRAME(frame,lowres[i])
	RELATIVE_ADDRESS_FRAME(frame,buffer[i])
	RELATIVE_ADDRESS_FRAME(frame,buffer_fld[i])
	RELATIVE_ADDRESS_FRAME(frame,buffer_lowres[i])
	}
	RELATIVE_ADDRESS_FRAME(frame,integral)
	// Weighted is not that straight forward 
	RELATIVE_ADDRESS_FRAME(frame,mb_type)
	RELATIVE_ADDRESS_FRAME(frame,mb_partition)
	RELATIVE_ADDRESS_FRAME(frame,mv[0])
	RELATIVE_ADDRESS_FRAME(frame,mv[1])
	RELATIVE_ADDRESS_FRAME(frame,mv16x16)
	for(int i = 0; i <= !!h_hw->param.i_bframe; i++ )
	        for(int j = 0; j <= h_hw->param.i_bframe ; j++ )
		{	RELATIVE_ADDRESS_FRAME(frame,lowres_mvs[i][j])
			RELATIVE_ADDRESS_FRAME(frame,lowres_mv_costs[i][j])
		}
	RELATIVE_ADDRESS_FRAME(frame,field)
	RELATIVE_ADDRESS_FRAME(frame,effective_qp)
	for( int i = 0; i <= h_hw->param.i_bframe+1; i++ )
	        for( int j = 0; j <= h_hw->param.i_bframe+1 ; j++ )
	        {       RELATIVE_ADDRESS_FRAME(frame,lowres_costs[i][j])
	        }
	RELATIVE_ADDRESS_FRAME(frame,ref[0])
	RELATIVE_ADDRESS_FRAME(frame,ref[1])
	for( int i = 0; i < h_hw->param.i_bframe+2; i++ )
		for( int j = 0; j < h_hw->param.i_bframe+2 ; j++ )
			RELATIVE_ADDRESS_FRAME(frame,i_row_satds[i][j])
	RELATIVE_ADDRESS_FRAME(frame,i_row_satd)
	RELATIVE_ADDRESS_FRAME(frame,i_row_bits)
	RELATIVE_ADDRESS_FRAME(frame,f_row_qp)
	RELATIVE_ADDRESS_FRAME(frame,f_row_qscale)
//	fprintf(stderr,"frame_f_qp_affset \n");
	RELATIVE_ADDRESS_FRAME(frame,f_qp_offset)
	RELATIVE_ADDRESS_FRAME(frame,f_qp_offset_aq)
	RELATIVE_ADDRESS_FRAME(frame,i_intra_cost)
	RELATIVE_ADDRESS_FRAME(frame,i_propagate_cost)
	RELATIVE_ADDRESS_FRAME(frame,i_inv_qscale_factor)
	RELATIVE_ADDRESS_FRAME(frame,base)
//	for (int k=0; k < X264_REF_MAX ; k++)
//		RELATIVE_ADDRESS_FRAME(pt.fenc,weighted[k])




#undef RELATIVE_ADDRESS_FRAME

}

static void modify_mb_pointers(x264_t *h_hw,uint8_t *mb_base)
{
#define RELATIVE_ADDRESS(point) if(h_hw->mb.point == NULL) \
                                h_hw->mb.point = NULL;\
                                else \
                                h_hw->mb.point = (intptr_t)h_hw->mb.point - (intptr_t)h_hw->mb.base + (intptr_t)mb_base; 

	RELATIVE_ADDRESS(qp)
	RELATIVE_ADDRESS(cbp)
	RELATIVE_ADDRESS(mb_transform_size)
	RELATIVE_ADDRESS(slice_table)
	RELATIVE_ADDRESS(intra4x4_pred_mode)
	RELATIVE_ADDRESS(non_zero_count)
	RELATIVE_ADDRESS(skipbp)
	RELATIVE_ADDRESS(chroma_pred_mode)
	RELATIVE_ADDRESS(mvd[0])
	RELATIVE_ADDRESS(mvd[1])
	RELATIVE_ADDRESS(mvr[0][1])
	RELATIVE_ADDRESS(mvr[0][2])
	RELATIVE_ADDRESS(mvr[0][3])
	RELATIVE_ADDRESS(mvr[0][4])
	RELATIVE_ADDRESS(mvr[1][0])
	RELATIVE_ADDRESS(mvr[1][1])
	RELATIVE_ADDRESS(mvr[1][2])
	RELATIVE_ADDRESS(mvr[1][3])
	RELATIVE_ADDRESS(p_weight_buf[0])
	RELATIVE_ADDRESS(p_weight_buf[1])
	h_hw->mb.base = mb_base;

}


static char *get_ref_base(x264_frame_t *ref)
{	for(int i=0; i<6; i++)
	{	if (ref->base == f_map[i].fdec_sw_base)
		{	f_map[i].frame_used = 1;
		//fprintf(stderr,"got frame %p \n",f_map[i].fdec_sw_base);
				return f_map[i].fdec_hw_base ;
		}
	}
	//fprintf(stderr,"---------------------ERROR----------------------- \n");
}

static void x264_hw_fdec_frame_reference(x264_t *h_hw)
{		//This part maps the hardware reference structure to software 
	for(int i=0; i < 2; i++)
		for(int j=0; j < h_hw->i_ref[i]; j++)
			h_hw->fref[i][j] = pt.fref_hw[i][j];
			
	for(int i=0; i < 2; i++ )
		for(int j =0; j < 6 ; j ++)
		{	if(pt.fref_sw[i][j] == h_hw->fref_nearest[i])
			{	h_hw->fref_nearest[i] = pt.fref_hw[i][j];
					break;
			}
		}
}

static void x264_hw_frame_push(int i)
{	//fprintf(stderr," pushed frame is %d \n",i);
	ref_num = ref_num + 1;
	ref_list[ref_num] = i;
	f_map[i].fdec_sw_base = NULL;
	f_map[i].fdec_hw_base = NULL;
	f_map[i].frame_valid = 0;
}

static void x264_hw_frame_pop(x264_frame_t *fdec)
{
	int a;
	a = ref_list[ref_num];
	f_map[a].fdec_sw_base = fdec->base;
	f_map[a].fdec_hw_base = pt.fdec_base[a];
	f_map[a].frame_valid = 1;
	pt.fdec_current_base = pt.fdec_base[a];
	//fprintf(stderr," popped frame is %d \n",a);
	ref_num = ref_num - 1;
}

static void x264_hw_frame_reference_update()
{
	for (int i=0 ; i < 6 ; i++)
	{	if (f_map[i].frame_valid)
			if(!f_map[i].frame_used)
		{
		x264_hw_frame_push(i);
		}
	}
}


static void reset_ref_validity()
{
	for(int i=0 ; i<6 ; i++)
	f_map[i].frame_used = 0;
}

 static already_alloted=0;
static char *allocate_space(int no_bytes)
{ char *ret;
  ret = &mem_space[already_alloted];
  //fprintf(stderr,"allocating %d spaceand %p",no_bytes,&mem_space[already_alloted]);
  already_alloted += no_bytes;
 // fprintf(stderr,"allocating %d \n",already_alloted);
  return ret;
}








