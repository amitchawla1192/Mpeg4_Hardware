/*
This file is to be kept at Hardware side to sync with software side.
This file contains the following functions.
1) x264_hw_sync_open
	It implements serializing of data for first time transfer of required matrixes
	by hardware.
2) x264_hw_sync_t
	This implements serializing of x264_t structure for current frame, excluding
	matrixes transferred in x264_sw_sync_open.
3) x264_hw_sync_back_t
	This implements copying back of the x264_t structure from software to hardware.
4) x264_hw_sync_fenc
	This frame serializes all data in fenc frame
5) x264_hw_sync_fdec_back
	This implements copying back of fdec frame that is encoded frame.
*/



#define _ISOC99_SOURCE
//#include <Pipes.h>
#include <iolib.h>
#include "common/common.h"
#include "common/matrixes_hw.h"



static void read_buffer(uint32_t *recv_sizem,char *Buffer)
{
	*recv_sizem = read_uint32("in_data");
	//fprintf(stdout,"starting reading %d \n",*recv_sizem);
	if(*recv_sizem)
	{
		read_uint32_n("in_data",Buffer,*recv_sizem/4); 
	}
return;
}

static struct pointers_t
{
	uint16_t *quant4_mf0;
	int *dequant4_mf0 ;
	int *unquant4_mf0 ;
	uint16_t *quant4_bias0 ;
	uint16_t *quant4_bias00;
	uint16_t *quant4_bias1 ;
	uint16_t *quant4_bias01 ;
	uint16_t *quant8_mf0 ;
	int *dequant8_mf0 ; 
	int *unquant8_mf0 ;
	uint16_t *quant8_bias0 ;
	uint16_t *quant8_bias00 ;
	uint16_t *quant8_bias1 ;
	int16_t *quant8_bias01;
	uint16_t *nr_offset_emergency ;
	x264_frame_t **framesunused0 ;
	x264_frame_t **framesunused1;
	x264_frame_t **framescurrent;
	x264_frame_t **framesblank_unused;
	uint16_t *cost_mv[70];
	char *nal_buffer;
	x264_t *reconfig_h;
	char *p_bitstream;
	x264_nal_t *thread0_outnal;
	uint8_t *mb_base;
	uint8_t *intra_border_backup00;
	uint8_t *intra_border_backup01;
	uint8_t *intra_border_backup10;
	uint8_t *intra_border_backup11;
	uint8_t *deblock_strength0;
		char *scratch_buffer;
	char *scratch_buffer2;
	x264_ratecontrol_t *rc;
	predictor_t *rc_pred;
	predictor_t *rc_pred_b_from_p ;
	x264_frame_t *fenc;
	x264_frame_t *fdec_current;
	x264_frame_t *fref_hw[2][X264_REF_MAX+3];
	x264_frame_t *fref_sw[2][X264_REF_MAX+3];
	char *fenc_base;
	char *fdec_current_base;
	char *fdec_base[6];
	x264_frame_t *fref[2][X264_REF_MAX+3];
	x264_frame_t *fref_nearest[2];
} pt;

static int ref_list[6] = {0,1,2,3,4,5};
static int ref_num = 5;

static struct frame_map
{
	char *fdec_sw_base ;
	char *fdec_hw_base ;
	int frame_valid ;
	int frame_used ;
} f_map[6];
static char mem_space[10*1024*1024];
#include "modify_pointers.c"
//static int hw_ref_num;

#define COPY_DERIALISE(x,y) memcpy(x , Buff0 + derialize_pointer ,y); \
 /*fprintf(stderr,"copied data bytes %d and %d from address %p to %p \n",y,derialize_pointer,x,(intptr_t)x + y); */ \
derialize_pointer += y;   \
			if(derialize_pointer == recv_size)\
			{ /*fprintf(stderr,"derializing completed here \n");   */\
			}

static char Buff0[9 * 1024 *1024 ];
static x264_t *h_hw;

void x264_hw_sync_open(x264_t **ul)
{	uint32_t recv_size=0;
	for(int i=0;i<6;i++)
	{ f_map[i].frame_valid = 0;
	 f_map[i].frame_used = 0;
	}

	
	h_hw=(x264_t *)allocate_space(50432);
	*ul = h_hw;
	//fprintf(stderr,"m->param.i_height = %p \n",h_hw);
	pt.rc = allocate_space(656);
	pt.reconfig_h = allocate_space(50432);
	pt.rc_pred = allocate_space(100);
	pt.rc_pred_b_from_p = allocate_space(20);
	pt.quant4_mf0 = allocate_space(1664);
	pt.dequant4_mf0 = allocate_space(384);
	pt.unquant4_mf0=allocate_space(3328);
	pt.quant4_bias0 = allocate_space(1664);
	pt.quant4_bias00 = allocate_space(1664);
	pt.quant4_bias1= allocate_space(1664);
	pt.quant4_bias01 = allocate_space(1664);
	pt.quant8_mf0 = allocate_space(6656);
	pt.dequant8_mf0=allocate_space(1536);
	pt.unquant8_mf0 = allocate_space(13312);
	pt.quant8_bias0=allocate_space(6656);
	pt.quant8_bias00 = allocate_space(6656);
	pt.quant8_bias1=allocate_space(6656);
	pt.quant8_bias01 = allocate_space(6656);
	pt.nr_offset_emergency=allocate_space(9216);
	pt.framesunused0 = allocate_space(172);
	pt.framesunused1=allocate_space(84);
	pt.framescurrent=allocate_space(28);
	pt.framesblank_unused=allocate_space(16);
	for(int i=0;i<70;i++)
		pt.cost_mv[i]=allocate_space(65538);
	pt.nal_buffer = allocate_space(1500068);
	pt.p_bitstream = allocate_space(1000000);
	pt.thread0_outnal=allocate_space(sizeof(x264_nal_t));
	pt.mb_base=allocate_space(112896);
	pt.intra_border_backup00=allocate_space(208);
	pt.intra_border_backup01=allocate_space(208);
	pt.intra_border_backup10=allocate_space(208);
	pt.intra_border_backup11=allocate_space(208);
	pt.deblock_strength0=allocate_space(704);
	pt.scratch_buffer=allocate_space(512);
	pt.scratch_buffer2=allocate_space(384);
	pt.fenc= allocate_space(sizeof(x264_frame_t));
	pt.fdec_current=allocate_space(sizeof(x264_frame_t));
	for (int i =0 ; i < 2; i++)
		for (int j = 0; j < X264_REF_MAX +3 ;j++)
			pt.fref_hw[i][j]=allocate_space(sizeof(x264_frame_t));
	//pt.fdec_current_base = allocate_space(177056);
	pt.fenc_base = allocate_space(177056);
	pt.fdec_base[0] = allocate_space(240608);
	pt.fdec_base[1] = allocate_space(240608);
	pt.fdec_base[2] = allocate_space(240608);
	pt.fdec_base[3] = allocate_space(240608);
	pt.fdec_base[4] = allocate_space(240608);
	pt.fdec_base[5] = allocate_space(240608);
	pt.fdec_current_base= allocate_space(240608);
//	fprintf(stderr,"old address is %p",pt.p_bitstream);
	 int offset = ((intptr_t)pt.p_bitstream & 3);
	pt.p_bitstream = pt.p_bitstream + 4 - offset;
//	fprintf(stderr,"offset is %d and new address is %p \n ",offset,pt.p_bitstream);

	//fprintf(stdout,"allocated space for enc 177056 from %p to %p and for fdec from %p to %p",fenc_base,	(intptr_t)fenc_base177056,fdec_base,(intptr_t)fdec_base + 240608);
	
	//uint32_t serialize_pointer=0,read_pointer=0;
	unsigned int derialize_pointer=0;
				/**********  READING BUFFERS ***********/
	read_buffer(&recv_size,Buff0);
	COPY_DERIALISE(x264_cabac_contexts_hw,sizeof(x264_cabac_contexts_hw))
	COPY_DERIALISE(x264_cost_i4x4_mode_hw,sizeof(x264_cost_i4x4_mode_hw))
	COPY_DERIALISE(x264_cost_ref_hw,sizeof(x264_cost_ref_hw))
	//fprintf(stderr,"recieving %d \n",sizeof(x264_cost_ref_hw));
	//fprintf(stderr,"recieving %p \n",x264_cost_ref_hw);
	COPY_DERIALISE(x264_cabac_transition_unary_hw,sizeof(x264_cabac_transition_unary_hw))
	COPY_DERIALISE(x264_cabac_size_unary_hw,sizeof(x264_cabac_size_unary_hw))
	COPY_DERIALISE(cabac_transition_5ones_hw,sizeof(cabac_transition_5ones_hw))
	COPY_DERIALISE(cabac_size_5ones_hw,sizeof(cabac_size_5ones_hw) )
	//fprintf(stderr,"%d and %d and %d and %d and %d and %d and %d\n",sizeof(x264_cabac_contexts_hw),sizeof(x264_cost_i4x4_mode_hw),sizeof(x264_cost_ref_hw),sizeof(x264_cabac_transition_unary_hw),sizeof(x264_cabac_size_unary_hw),sizeof(cabac_transition_5ones_hw),sizeof(cabac_size_5ones_hw));
	h_hw->thread[0] =(x264_t *)h_hw ;
	COPY_DERIALISE(pt.quant4_mf0,1664)
	h_hw->quant4_mf[0] =pt.quant4_mf0;
	h_hw->quant4_mf[1] =pt.quant4_mf0;
	h_hw->quant4_mf[2] =pt.quant4_mf0;
	h_hw->quant4_mf[3] =pt.quant4_mf0;
	COPY_DERIALISE(pt.dequant4_mf0,384)
	h_hw->dequant4_mf[0] =pt.dequant4_mf0;
	h_hw->dequant4_mf[1] =pt.dequant4_mf0;
	h_hw->dequant4_mf[2] =pt.dequant4_mf0;
	h_hw->dequant4_mf[3] =pt.dequant4_mf0;
	COPY_DERIALISE(pt.unquant4_mf0,3328)
	h_hw->unquant4_mf[0] =pt.unquant4_mf0;
	h_hw->unquant4_mf[1] =pt.unquant4_mf0;
	h_hw->unquant4_mf[2] =pt.unquant4_mf0;
	h_hw->unquant4_mf[3] =pt.unquant4_mf0;
	COPY_DERIALISE(pt.quant4_bias0,1664)
	h_hw->quant4_bias[0] =pt.quant4_bias0;
	h_hw->quant4_bias[2] =pt.quant4_bias0;
	COPY_DERIALISE(pt.quant4_bias00,1664)
	h_hw->quant4_bias0[0] =pt.quant4_bias00;
	h_hw->quant4_bias0[2] =pt.quant4_bias00;
	COPY_DERIALISE(pt.quant4_bias1,1664)
	h_hw->quant4_bias[1] =pt.quant4_bias1;
	h_hw->quant4_bias[3] =pt.quant4_bias1;
	COPY_DERIALISE(pt.quant4_bias01,1664)
	h_hw->quant4_bias0[1] =pt.quant4_bias01;
	h_hw->quant4_bias0[3] =pt.quant4_bias01;
	COPY_DERIALISE(pt.quant8_mf0,6656)
	h_hw->quant8_mf[0]=pt.quant8_mf0;
	h_hw->quant8_mf[1]=pt.quant8_mf0;
	COPY_DERIALISE(pt.dequant8_mf0,1536)
	h_hw->dequant8_mf[0] =pt.dequant8_mf0;
	h_hw->dequant8_mf[1] =pt.dequant8_mf0;
	COPY_DERIALISE(pt.unquant8_mf0,13312)
	h_hw->unquant8_mf[0] =pt.unquant8_mf0;
	h_hw->unquant8_mf[1] =pt.unquant8_mf0;
	COPY_DERIALISE(pt.quant8_bias0,6656)
	h_hw->quant8_bias[0] =pt.quant8_bias0;
	COPY_DERIALISE(pt.quant8_bias00,6656)
	h_hw->quant8_bias0[0]=pt.quant8_bias00;
	COPY_DERIALISE(pt.quant8_bias1,6656)
	h_hw->quant8_bias[1] =pt.quant8_bias1;
	COPY_DERIALISE(pt.quant8_bias01,6656)
	h_hw->quant8_bias0[1] =pt.quant8_bias01;
	COPY_DERIALISE(pt.nr_offset_emergency,9216)
	h_hw->nr_offset_emergency =pt.nr_offset_emergency;
	#define COST_MV(i) &pt.cost_mv[k][0]
	for(int k=0;k<70;k++)
		{
			COPY_DERIALISE(COST_MV(k),65538)
			h_hw->cost_mv[k] = COST_MV(k)+ 2*4*2048 ;
		}
	#undef COST_MV(i)



}



		////////////////// This function is called at hardware side to read only per frame required material //////////
void x264_hw_sync_t(int *i_nal_type, int *i_global_qp, int *i_nal_ref_idc)
{
	unsigned int derialize_pointer=0, offset = 0;
	uint32_t recv_size=0;
	int b;
	char *base;
	read_buffer(&recv_size,Buff0);
	COPY_DERIALISE(&b, sizeof(int))
	//fprintf(stderr,"%d b is \n",b);
	COPY_DERIALISE(i_nal_type, sizeof(int))
	COPY_DERIALISE(i_global_qp, sizeof(int))
	COPY_DERIALISE(i_nal_ref_idc, sizeof(int))
	//fprintf(stderr,"int i_nal_type %d, int i_global_qp %d, int i_nal_ref_idc %d", *i_nal_type, *i_global_qp, *i_nal_ref_idc);
	COPY_DERIALISE(h_hw, sizeof(x264_t))
	
	for (int i=0; i < 2; i++ )
	{
	for (int j=0; j < h_hw->i_ref[i] ; j++)
	{	COPY_DERIALISE(pt.fref_hw[i][j], sizeof(x264_frame_t))
		pt.fref_sw[i][j] = h_hw->fref[i][j];
		if (pt.fref_hw[i][j]->orig == pt.fref_sw[i][j])
		pt.fref_hw[i][j]->orig = pt.fref_hw[i][j];
		else 
		for(int k=0; k < h_hw->i_ref[i] ; k++)
			if (pt.fref_hw[i][j]->orig == h_hw->fref[i][k])
			{	//fprintf(stderr,"---------DUPLICATE FRAME---------");
				pt.fref_hw[i][j]->orig = pt.fref_hw[i][k];
				break; 
			}
		base = get_ref_base(pt.fref_hw[i][j]);
		//fprintf(stderr,"got frame for j = %d as %p \n",j,base);
		modify_frame_pointers(h_hw,pt.fref_hw[i][j],base);
	}
	pt.fref_nearest[i] = h_hw->fref_nearest[i];
	}
	//fprintf(stderr,"copied %d and %d reference frames \n",h_hw->i_ref[0],h_hw->i_ref[1]);	
	x264_hw_fdec_frame_reference(h_hw);
	x264_hw_frame_reference_update();
	


	h_hw->sh.sps = &h_hw->sps;
	h_hw->sh.pps = &h_hw->pps;
	h_hw->thread[0] =(x264_t *)h_hw ;
	h_hw->quant4_mf[0] =pt.quant4_mf0;
	h_hw->quant4_mf[1] =pt.quant4_mf0;
	h_hw->quant4_mf[2] =pt.quant4_mf0;
	h_hw->quant4_mf[3] =pt.quant4_mf0;
	h_hw->dequant4_mf[0] =pt.dequant4_mf0;
	h_hw->dequant4_mf[1] =pt.dequant4_mf0;
	h_hw->dequant4_mf[2] =pt.dequant4_mf0;
	h_hw->dequant4_mf[3] =pt.dequant4_mf0;
	h_hw->unquant4_mf[0] =pt.unquant4_mf0;
	h_hw->unquant4_mf[1] =pt.unquant4_mf0;
	h_hw->unquant4_mf[2] =pt.unquant4_mf0;
	h_hw->unquant4_mf[3] =pt.unquant4_mf0;
	h_hw->quant4_bias[0] =pt.quant4_bias0;
	h_hw->quant4_bias[2] =pt.quant4_bias0;
	h_hw->quant4_bias0[0] =pt.quant4_bias00;
	h_hw->quant4_bias0[2] =pt.quant4_bias00;
	h_hw->quant4_bias[1] =pt.quant4_bias1;
	h_hw->quant4_bias[3] =pt.quant4_bias1;
	h_hw->quant4_bias0[1] =pt.quant4_bias01;
	h_hw->quant4_bias0[3] =pt.quant4_bias01;
	h_hw->quant8_mf[0]=pt.quant8_mf0;
	h_hw->quant8_mf[1]=pt.quant8_mf0;
	h_hw->dequant8_mf[0] =pt.dequant8_mf0;
	h_hw->dequant8_mf[1] =pt.dequant8_mf0;
	h_hw->unquant8_mf[0] =pt.unquant8_mf0;
	h_hw->unquant8_mf[1] =pt.unquant8_mf0;
	h_hw->quant8_bias[0] =pt.quant8_bias0;
	h_hw->quant8_bias0[0]=pt.quant8_bias00;
	h_hw->quant8_bias[1] =pt.quant8_bias1;
	h_hw->quant8_bias0[1] =pt.quant8_bias01;

		
	#define COST_MV(i) &pt.cost_mv[k][0]
	for(int k=0;k<70;k++)
		{
			h_hw->cost_mv[k] = COST_MV(k)+ 2*4*2048 ;
		}
	#undef COST_MV(i)

	COPY_DERIALISE(pt.nr_offset_emergency,9216)
	h_hw->nr_offset_emergency = pt.nr_offset_emergency;
	COPY_DERIALISE(pt.framesunused0,172)
	h_hw->frames.unused[0]= pt.framesunused0;
	COPY_DERIALISE(pt.framesunused1,84)
	h_hw->frames.unused[1]= pt.framesunused1;
	COPY_DERIALISE(pt.framescurrent,28)
	h_hw->frames.current = pt.framescurrent;
	COPY_DERIALISE(pt.framesblank_unused,16)
	h_hw->frames.blank_unused= pt.framesblank_unused;
	COPY_DERIALISE(pt.reconfig_h,50432)
	h_hw->reconfig_h = pt.reconfig_h;
	
	//COPY_DERIALISE(pt.thread0_outnal,h_hw->out.i_nal*sizeof(x264_nal_t))
	h_hw->thread[0]->out.i_nal = 0;
	h_hw->out.nal = pt.thread0_outnal;
	
	
	h_hw->out.bs.p_start = pt.p_bitstream;
	h_hw->out.p_bitstream = pt.p_bitstream;
	h_hw->out.bs.p = pt.p_bitstream;
	h_hw->out.bs.p_end   = (uint8_t*)pt.p_bitstream + 1000000;
	//COPY_DERIALISE(pt.p_bitstream,1000000)
	//h_hw->thread[0]->out.p_bitstream = pt.p_bitstream;  
	
	
	
	
	
	COPY_DERIALISE(pt.mb_base,112896) 
	modify_mb_pointers(h_hw,pt.mb_base);
	COPY_DERIALISE(pt.intra_border_backup00,208)
	h_hw->intra_border_backup[0][0] = pt.intra_border_backup00; // Sum +16 has to be done do check that
	//h_hw->intra_border_backup[0][0] += 16;
	COPY_DERIALISE(pt.intra_border_backup01,208)
	h_hw->intra_border_backup[0][1] = pt.intra_border_backup01; // Sum +16 has to be done do check that
	//h_hw->intra_border_backup[0][1] += 16;
	COPY_DERIALISE(pt.intra_border_backup10,208)
	h_hw->intra_border_backup[1][0] = pt.intra_border_backup10; // Sum +16 has to be done do check that
	//h_hw->intra_border_backup[1][0] += 16;
	COPY_DERIALISE(pt.intra_border_backup11,208)
	h_hw->intra_border_backup[1][1] = pt.intra_border_backup11; // Sum +16 has to be done do check that in common/macroblock.c
	//h_hw->intra_border_backup[1][1] += 16;
	COPY_DERIALISE(pt.deblock_strength0,704)
	//fprintf(stderr,"%p and %p deblock \n",h_hw->deblock_strength[0],h_hw->deblock_strength[1]);
	h_hw->deblock_strength[0] = pt.deblock_strength0;
	h_hw->deblock_strength[1] = pt.deblock_strength0;
	COPY_DERIALISE(pt.scratch_buffer,512)
	h_hw->scratch_buffer = pt.scratch_buffer;
	COPY_DERIALISE(pt.scratch_buffer2,384)
	h_hw->scratch_buffer2 = pt.scratch_buffer2;
	COPY_DERIALISE(pt.rc,656)
	h_hw->thread[0]->rc = pt.rc;
	COPY_DERIALISE(pt.rc_pred,100)
	h_hw->rc->pred = pt.rc_pred;
	COPY_DERIALISE(pt.rc_pred_b_from_p,20)
	h_hw->rc->pred_b_from_p = pt.rc_pred_b_from_p;
	/* this all has to be done at software side too */
	h_hw->rc->row_pred = h_hw->rc->row_preds[h_hw->sh.i_type];




	COPY_DERIALISE(pt.fenc,sizeof(x264_frame_t))
	pt.fenc->orig = pt.fenc; 
	modify_frame_pointers(h_hw,pt.fenc,pt.fenc_base);
	COPY_DERIALISE(pt.fenc_base,177056)
	h_hw->fenc = pt.fenc;
	//fprintf(stderr,"fdec_current is %p and address allowed up to %p \n",pt.fdec_current_base,(intptr_t)pt.fdec_current_base + 240608); 
	COPY_DERIALISE(pt.fdec_current,sizeof(x264_frame_t))
	pt.fdec_current->orig = pt.fdec_current;
	x264_hw_frame_pop(pt.fdec_current);
	modify_frame_pointers(h_hw,pt.fdec_current,pt.fdec_current_base);

	COPY_DERIALISE(pt.fdec_current_base,240608)
	h_hw->fdec = pt.fdec_current;
	//fprintf(stderr,"Derializing frame completed  \n");
	reset_ref_validity();
	
return ;
}

/* This code is to copy back to software  */
#define COPY_BUFFER(bff,y,z)\
	serialize_pointer_old = serialize_pointer_new ;\
	serialize_pointer_new += z;\
	if(serialize_pointer_new < 9 * 1024 *1024)\
	{memcpy( bff + serialize_pointer_old , y, z); send_size = serialize_pointer_new;\
	}\
	else {/*fprintf(stdout,"Buffer Overflow"); */ }

static char COPY_BUFFER_1[9*1024*1024];

void x264_hw_sync_back_t()
{	x264_t *h;
	h = h_hw;
	int j=0;
	uint32_t serialize_pointer_old = 0,serialize_pointer_new=0; // Number of bytes already copied to Buffer
	int send_size=0;
	static int prev_out_hw_bitstream=0;
	for (int i=0; i < 2; i++ )
	{for (int j=0; j < h->i_ref[i] ; j++)
		h->fref[i][j] = pt.fref_sw[i][j];	
	
		h->fref_nearest[i]= pt.fref_nearest[i];
	}
	
	COPY_BUFFER(COPY_BUFFER_1,h,sizeof(x264_t))
	COPY_BUFFER(COPY_BUFFER_1,h->nr_offset_emergency,9216)
	COPY_BUFFER(COPY_BUFFER_1,h->frames.unused[0],172) // make a copy of this which was transferred from software side and replace same here.
	COPY_BUFFER(COPY_BUFFER_1,h->frames.unused[1],84)  // make a copy of this which was transferred from software side and replace same here.
	COPY_BUFFER(COPY_BUFFER_1,h->frames.current,28) // make a copy of this which was transferred from software side and replace same here.
	COPY_BUFFER(COPY_BUFFER_1,h->frames.blank_unused,16)  // make a copy of this which was transferred from software side and replace same here.
	//COPY_BUFFER(COPY_BUFFER_1,h->nal_buffer,h->nal_buffer_size)
	COPY_BUFFER(COPY_BUFFER_1,h->reconfig_h,50432)
	COPY_BUFFER(COPY_BUFFER_1,h->thread[0]->out.nal,sizeof(x264_nal_t))
	COPY_BUFFER(COPY_BUFFER_1,h->thread[0]->out.p_bitstream, h->thread[0]->out.nal[h->out.i_nal-1].i_payload)
	//COPY_BUFFER(COPY_BUFFER_1,h->thread[0]->out.p_bitstream + prev_out_sw_bitstream,(h->thread[0]->out.i_bitstream - prev_out_sw_bitstream))
	

	COPY_BUFFER(COPY_BUFFER_1,h->mb.base,112896)
	COPY_BUFFER(COPY_BUFFER_1,h->intra_border_backup[0][0],208)
	COPY_BUFFER(COPY_BUFFER_1,h->intra_border_backup[0][1],208)
	COPY_BUFFER(COPY_BUFFER_1,h->intra_border_backup[1][0],208)
	COPY_BUFFER(COPY_BUFFER_1,h->intra_border_backup[1][1],208)
	COPY_BUFFER(COPY_BUFFER_1,h->deblock_strength[0],704)
	COPY_BUFFER(COPY_BUFFER_1,h->scratch_buffer,512)
	COPY_BUFFER(COPY_BUFFER_1,h->scratch_buffer2,384)
	COPY_BUFFER(COPY_BUFFER_1,h->rc,656)
	COPY_BUFFER(COPY_BUFFER_1,h->rc->pred,100)
	COPY_BUFFER(COPY_BUFFER_1,h->rc->pred_b_from_p,20)
	COPY_BUFFER(COPY_BUFFER_1,h->fenc,sizeof(x264_frame_t))	
	COPY_BUFFER(COPY_BUFFER_1,h->fenc->base,177056)
	COPY_BUFFER(COPY_BUFFER_1,h->fdec,sizeof(x264_frame_t))
	COPY_BUFFER(COPY_BUFFER_1,h->fdec->base,240608)
		
	#define WRITE_BUFFER_X(siz) /*fprintf(stderr,"Writing buffer %d \n",siz);*/\
	if(siz != 0)\
	{ write_uint32("out_data", siz);\
	write_uint32_n("out_data",COPY_BUFFER_1,send_size/4); }

	//fprintf(stderr,"Now starting writing buffer %d \n",send_size);
  	WRITE_BUFFER_X(send_size)




//write_uint32("in_data", 0);
//fprintf(stderr,"exiting sync hw side");
return ;
}
