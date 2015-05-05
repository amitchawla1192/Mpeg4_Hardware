#define _ISOC99_SOURCE
#include <Pipes.h>
#include "common/common.h"
//#include "encoder/ratecontrol.c"
//typedef x264_ratecontrol_t x264_ratecontrol_t;
//typedef predictor_t predictor_t;

#define RELATIVE_ADDRESS(point) if(h_hw->mb.point == NULL) \
                                h_hw->mb.point = NULL;\
                                else \
                                h_hw->mb.point = (intptr_t)h_hw->mb.point - (intptr_t)h_hw->mb.base + (intptr_t)mb_base; 

#define RELATIVE_ADDRESS_FRAME(frame1,point) if(frame1->point == NULL) \
				{fprintf(stdout,"New address of frame1 is NULL \n");} \
				else \
{	\
				frame1->point = (intptr_t)frame1->point - (intptr_t)frame1->base + (intptr_t)frame1##_base; \
fprintf(stdout,"New address of frame1 is new address %p  new base %p old base %p \n",frame1->point,frame1##_base,frame1->base); \
}



#define COPY_DERIALISE(x,y) switch (bfno)\
			{case 0: memcpy(x , Buff0 + derialize_pointer ,y);fprintf(stdout,"copied data bytes %d and %d from address %p to %p \n",y,derialize_pointer,x,(intptr_t)x + y); \
/*			 case 1: memcpy(x , Buff1 + derialize_pointer ,y); \
			 case 2: memcpy(x , Buff2 + derialize_pointer ,y); \
			 case 3: memcpy(x , Buff3 + derialize_pointer ,y); \
			 case 4: memcpy(x , Buff4 + derialize_pointer ,y); \
			 case 5: memcpy(x , Buff5 + derialize_pointer ,y); \
			 case 6: memcpy(x , Buff6 + derialize_pointer ,y); \
			 case 7: memcpy(x , Buff7 + derialize_pointer ,y); \*/\
			 }		\
                        derialize_pointer += y;   \
			if(derialize_pointer == recv_size[bfno])\
			{ derialize_pointer =0;\
			  read_buffer(recv_size, Buff0 );\
			}







void read_buffer(uint32_t *recv_sizem,char *Buffer)
{
uint32_t recv_size[15]={0};
*recv_sizem = read_uint32("in_data");
uint32_t *gh;
gh = (uint32_t *)Buffer;
fprintf(stdout,"starting reading %d \n",*recv_sizem);
if(*recv_sizem)
{
/*{fprintf(stdout,"starting reading  inner \n");
for(int j=0;j< *recv_sizem/4; j++)
{fprintf(stdout,"starting reading  inner most %d\n",j);
*(gh+j) = read_uint32("in_data");
}
fprintf(stdout,"ending reading \n");
*/
read_uint32_n("in_data",Buffer,*recv_sizem/4); 

}
return;
}




/*********   SYNC WITH SOFTWARE  *******/
//////////////////////////////////////////////////   This function is called first time to create new structure at hardware side /////
//x264_t *h_hw;
x264_t *x264_sw_sync_open(x264_t **ul)
{uint32_t recv_size[15];
char Buff0[512*1024];
x264_t *h_hw=*ul;
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
uint16_t *quant8_bias01;
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
x264_frame_t *fdec;
char *fenc_base;
char *fdec_base;
if(h_hw==NULL)
{
fprintf(stdout,"allocating data\n",*ul,h_hw);
h_hw=(x264_t *)malloc(50432);
*ul = h_hw;
//fprintf(stdout,"allocating data %p and %p\n",*ul,h_hw);
rc = malloc(656);
reconfig_h = malloc(50432);
rc_pred = malloc(100);
rc_pred_b_from_p = malloc(20);
quant4_mf0 = malloc(1664);
dequant4_mf0 = malloc(384);
unquant4_mf0=malloc(3328);
quant4_bias0 = malloc(1664);
quant4_bias00 = malloc(1664);
quant4_bias1= malloc(1664);
quant4_bias01 = malloc(1664);
quant8_mf0 = malloc(6656);
dequant8_mf0=malloc(1536);
unquant8_mf0 = malloc(13312);
quant8_bias0=malloc(6656);
quant8_bias00 = malloc(6656);
quant8_bias1=malloc(6656);
quant8_bias01 = malloc(6656);
nr_offset_emergency=malloc(9216);
framesunused0 = malloc(172);
framesunused1=malloc(84);
framescurrent=malloc(28);
framesblank_unused=malloc(16);
for(int i=0;i<70;i++)
cost_mv[i]=malloc(65538);
nal_buffer = malloc(1500068);
p_bitstream = malloc(1000000);
thread0_outnal=malloc(96);
mb_base=malloc(112896);
intra_border_backup00=malloc(208);
intra_border_backup01=malloc(208);
intra_border_backup10=malloc(208);
intra_border_backup11=malloc(208);
deblock_strength0=malloc(704);
scratch_buffer=malloc(512);
scratch_buffer2=malloc(384);

fenc= malloc(sizeof(x264_frame_t));
fdec=malloc(sizeof(x264_frame_t));
fenc_base = malloc(177056);
fdec_base = malloc(240608);
fprintf(stdout,"allocated space for enc 177056 from %p to %p and for fdec from %p to %p",fenc_base,(intptr_t)fenc_base+177056,fdec_base,(intptr_t)fdec_base + 240608);

}
else 
{ fprintf(stdout," no need of allocating data \n");
quant4_mf0 = h_hw->quant4_mf[0];
dequant4_mf0 = h_hw->dequant4_mf[0];
unquant4_mf0= h_hw->unquant4_mf[0];
quant4_bias0 = h_hw->quant4_bias[0];
quant4_bias00 = h_hw->quant4_bias0[0];
quant4_bias1= h_hw->quant4_bias[1];
quant4_bias01 = h_hw->quant4_bias0[1];
quant8_mf0 = h_hw->quant8_mf[0];
dequant8_mf0= h_hw->dequant8_mf[0];
unquant8_mf0 = h_hw->unquant8_mf[0];
quant8_bias0= h_hw->quant8_bias[0];
quant8_bias00 = h_hw->quant8_bias0[0];
quant8_bias1= h_hw->quant8_bias[1] ;
quant8_bias01 = h_hw->quant8_bias0[1];
 
nr_offset_emergency = h_hw->nr_offset_emergency;
framesunused0 = h_hw->frames.unused[0];
framesunused1 = h_hw->frames.unused[1];
framescurrent = h_hw->frames.current ;
framesblank_unused = h_hw->frames.blank_unused;
for(int i=0;i<70;i++)
cost_mv[i]= h_hw->cost_mv[i] - 2*4*2048 ;
nal_buffer = h_hw->nal_buffer;
reconfig_h = h_hw->reconfig_h;
p_bitstream = h_hw->thread[0]->out.p_bitstream;
thread0_outnal= h_hw->thread[0]->out.nal; 
mb_base = h_hw->mb.base;
intra_border_backup00 = h_hw->intra_border_backup[0][0];
intra_border_backup01 = h_hw->intra_border_backup[0][1];
intra_border_backup10 = h_hw->intra_border_backup[1][0];
intra_border_backup11 = h_hw->intra_border_backup[1][1];
deblock_strength0 = h_hw->deblock_strength[0];
scratch_buffer = h_hw->scratch_buffer;
scratch_buffer2 = h_hw->scratch_buffer2;
rc = h_hw->rc;
rc_pred = h_hw->rc->pred;
rc_pred_b_from_p = h_hw->rc->pred_b_from_p;
fenc= h_hw->fenc;
fdec= h_hw->fdec;
fenc_base = h_hw->fenc->base;
fdec_base = h_hw->fdec->base;

}
int bfno=0;
uint32_t serialize_pointer=0,read_pointer=0;
unsigned int derialize_pointer=0;




/**********  READING BUFFERS ***********/

read_buffer(recv_size,Buff0);


h_hw->thread[0] =(x264_t *)h_hw ;

//fprintf(stdout," address %p and %p \n ",h_hw->thread[0],h_hw);

//fprintf(stdout,"%d and  %d \n",h_hw-i>dequant4_mf, h_hw->dequant4_mf[0]);
fprintf(stdout,"starting derialization \n");
COPY_DERIALISE(h_hw, sizeof(x264_t))
h_hw->thread[0] =(x264_t *)h_hw ;
//fprintf(stdout,"%d and %d are \n",h->param.i_width,h_hw->param.i_width);

COPY_DERIALISE(quant4_mf0,1664) h_hw->quant4_mf[0] = quant4_mf0;h_hw->quant4_mf[1] =quant4_mf0; h_hw->quant4_mf[2] =quant4_mf0;h_hw->quant4_mf[3] =quant4_mf0;
COPY_DERIALISE(dequant4_mf0,384) h_hw->dequant4_mf[0] = dequant4_mf0;h_hw->dequant4_mf[1] = dequant4_mf0;h_hw->dequant4_mf[2] = dequant4_mf0;h_hw->dequant4_mf[3] = dequant4_mf0;
COPY_DERIALISE(unquant4_mf0,3328) h_hw->unquant4_mf[0] = unquant4_mf0;h_hw->unquant4_mf[1] = unquant4_mf0;h_hw->unquant4_mf[2] = unquant4_mf0;h_hw->unquant4_mf[3] = unquant4_mf0;
COPY_DERIALISE(quant4_bias0,1664) h_hw->quant4_bias[0] = quant4_bias0;h_hw->quant4_bias[2] = quant4_bias0;
COPY_DERIALISE(quant4_bias00,1664) h_hw->quant4_bias0[0] = quant4_bias00;h_hw->quant4_bias0[2] = quant4_bias00;
COPY_DERIALISE(quant4_bias1,1664) h_hw->quant4_bias[1] = quant4_bias1;h_hw->quant4_bias[3] = quant4_bias1;
COPY_DERIALISE(quant4_bias01,1664) h_hw->quant4_bias0[1] = quant4_bias01;h_hw->quant4_bias0[3] = quant4_bias01;
COPY_DERIALISE(quant8_mf0,6656) h_hw->quant8_mf[0]= quant8_mf0;h_hw->quant8_mf[1]= quant8_mf0;
COPY_DERIALISE(dequant8_mf0,1536) h_hw->dequant8_mf[0] = dequant8_mf0;h_hw->dequant8_mf[1] = dequant8_mf0;
COPY_DERIALISE(unquant8_mf0,13312) h_hw->unquant8_mf[0] = unquant8_mf0;h_hw->unquant8_mf[1] = unquant8_mf0;
COPY_DERIALISE(quant8_bias0,6656) h_hw->quant8_bias[0] = quant8_bias0;
COPY_DERIALISE(quant8_bias00,6656) h_hw->quant8_bias0[0]= quant8_bias00;
COPY_DERIALISE(quant8_bias1,6656) h_hw->quant8_bias[1] = quant8_bias1;
COPY_DERIALISE(quant8_bias01,6656) h_hw->quant8_bias0[1] = quant8_bias01;

COPY_DERIALISE(nr_offset_emergency,9216) h_hw->nr_offset_emergency = nr_offset_emergency;
COPY_DERIALISE(framesunused0,172) h_hw->frames.unused[0]= framesunused0;
COPY_DERIALISE(framesunused1,84) h_hw->frames.unused[1]= framesunused1;
COPY_DERIALISE(framescurrent,28) h_hw->frames.current = framescurrent;

COPY_DERIALISE(framesblank_unused,16) h_hw->frames.blank_unused= framesblank_unused;
#define COST_MV(i) &cost_mv[k][0]
for(int k=0;k<70;k++)
{
COPY_DERIALISE(COST_MV(k),65538)
h_hw->cost_mv[k] = COST_MV(k)+ 2*4*2048 ;
//fprintf(stdout,"reached here %d\n",k);
//fprintf(stdout,"cost_mv copied correctly %d and %d",h->cost_mv[][])
//fprintf(stdout,"%d \n",COST_MV(k));
}
#undef COST_MV(i)

//fprintf(stdout,"reached here \n");
//fprintf(stdout,"%p and %p are \n",h->mb.base,h->mb.base);


//COPY_DERIALISE(nal_buffer,1500068) h_hw->nal_buffer = nal_buffer;
COPY_DERIALISE(reconfig_h,50432) h_hw->reconfig_h = reconfig_h;
//COPY_DERIALISE(p_bitstream,1000000) h_hw->thread[0]->out.p_bitstream = p_bitstream;

COPY_DERIALISE(thread0_outnal,96) h_hw->thread[0]->out.nal = thread0_outnal;
COPY_DERIALISE(mb_base,112896) 
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

COPY_DERIALISE(intra_border_backup00,208) h_hw->intra_border_backup[0][0] = intra_border_backup00; 
COPY_DERIALISE(intra_border_backup01,208) h_hw->intra_border_backup[0][1] = intra_border_backup01;
COPY_DERIALISE(intra_border_backup10,208) h_hw->intra_border_backup[1][0] = intra_border_backup10;
COPY_DERIALISE(intra_border_backup11,208) h_hw->intra_border_backup[1][1] = intra_border_backup11;
COPY_DERIALISE(deblock_strength0,704) h_hw->deblock_strength[0] = deblock_strength0;
COPY_DERIALISE(scratch_buffer,512) h_hw->scratch_buffer = scratch_buffer;
COPY_DERIALISE(scratch_buffer2,384) h_hw->scratch_buffer2 = scratch_buffer2;
COPY_DERIALISE(rc,656) h_hw->rc = rc;
COPY_DERIALISE(rc_pred,100) h_hw->rc->pred = rc_pred;
COPY_DERIALISE(rc_pred_b_from_p,20) h_hw->rc->pred_b_from_p = rc_pred_b_from_p;
h_hw->fenc = fenc;
h_hw->fdec = fdec;
h_hw->fenc->base = fenc_base;
h_hw->fdec->base = fdec_base;

//fprintf(stderr,"rc->b_abr is %d and h->rc->b_abr is %d\n",rc->b_abr,h->rc->b_abr);
//if(h->mb.dist_scale_factor[1] == h_hw->mb.dist_scale_factor[1])
//fprintf(stderr,"copied succesfully \n");
//else 
//fprintf(stderr,"copied noise \n");
// for(int i=0;i <12;i++ )
//fprintf(stdout,"%p \n",h_hw->dequant4_mf[0][i]);
/*
for(int i=0;i<70;i++)
{
for(int j=-2*4*2048;j<2*4*2048;j++)
{
if(h_hw->cost_mv[i][j] == h->cost_mv[i][j])
fprintf(stdout,"Data seems to be copied safe %d and %d  wher %d and %d \n",h_hw->cost_mv[i][j],h->cost_mv[i][j],i,j);
else
fprintf(stderr, " Data seems to be Noisy %d and %d\n ",h_hw->cost_mv[i][j],h->cost_mv[i][j]);
}
}
*/
//fprintf(stdout,"reached at exit point");

return ;
}






/////////////////////////////// This function is called at hardware side to read only per frame required material //////////






x264_t *x264_sw_sync(x264_t **ul)
{fprintf(stdout,"/////******************************************  Creating copy at hardware side *****************////////////////////////");

////////////////// DATA INITIALIZATION ////
uint32_t recv_size[15]={0};
char Buff0[512*1024];
x264_t *h_hw=*ul;
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
uint16_t *quant8_bias01;
uint16_t *nr_offset_emergency ;
x264_frame_t **framesunused0 ;
x264_frame_t **framesunused1;
x264_frame_t **framescurrent;
x264_frame_t **framesblank_unused;
uint16_t *cost_mv[70];
char *nal_buffer;
x264_t *reconfig_h;
char p_bitstream;
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
x264_frame_t *fdec;
char *fenc_base;
char *fdec_base;

///////// POINTER COPYING SESSION  /////////

quant4_mf0 = h_hw->quant4_mf[0];
dequant4_mf0 = h_hw->dequant4_mf[0];
unquant4_mf0= h_hw->unquant4_mf[0];
quant4_bias0 = h_hw->quant4_bias[0];
quant4_bias00 = h_hw->quant4_bias0[0];
quant4_bias1= h_hw->quant4_bias[1];
quant4_bias01 = h_hw->quant4_bias0[1];
quant8_mf0 = h_hw->quant8_mf[0];
dequant8_mf0= h_hw->dequant8_mf[0];
unquant8_mf0 = h_hw->unquant8_mf[0];
quant8_bias0= h_hw->quant8_bias[0];
quant8_bias00 = h_hw->quant8_bias0[0];
quant8_bias1= h_hw->quant8_bias[1] ;
quant8_bias01 = h_hw->quant8_bias0[1];
 
nr_offset_emergency = h_hw->nr_offset_emergency;
framesunused0 = h_hw->frames.unused[0];
framesunused1 = h_hw->frames.unused[1];
framescurrent = h_hw->frames.current ;
framesblank_unused = h_hw->frames.blank_unused;
for(int i=0;i<70;i++)
cost_mv[i]= h_hw->cost_mv[i] - 2*4*2048 ;
nal_buffer = h_hw->nal_buffer;
reconfig_h = h_hw->reconfig_h;
p_bitstream = h_hw->thread[0]->out.p_bitstream;
thread0_outnal= h_hw->thread[0]->out.nal; 
mb_base = h_hw->mb.base;
intra_border_backup00 = h_hw->intra_border_backup[0][0];
intra_border_backup01 = h_hw->intra_border_backup[0][1];
intra_border_backup10 = h_hw->intra_border_backup[1][0];
intra_border_backup11 = h_hw->intra_border_backup[1][1];
deblock_strength0 = h_hw->deblock_strength[0];
scratch_buffer = h_hw->scratch_buffer;
scratch_buffer2 = h_hw->scratch_buffer2;
rc = h_hw->rc;
rc_pred = h_hw->rc->pred;
rc_pred_b_from_p = h_hw->rc->pred_b_from_p;
fenc= h_hw->fenc;
fdec= h_hw->fdec;
fenc_base = h_hw->fenc->base;
fdec_base = h_hw->fdec->base;



/////// POINTER COPYING ENDS HERE ///////////
int bfno=0;
uint32_t serialize_pointer=0,read_pointer=0;
unsigned int derialize_pointer=0;




/**********  READING BUFFERS ***********/
read_buffer(recv_size,Buff0);
//h_hw->thread[0] =(x264_t *)h_hw ;


COPY_DERIALISE(h_hw, sizeof(x264_t))
h_hw->thread[0] =(x264_t *)h_hw ;


h_hw->quant4_mf[0] = quant4_mf0;h_hw->quant4_mf[1] =quant4_mf0; h_hw->quant4_mf[2] =quant4_mf0;h_hw->quant4_mf[3] =quant4_mf0;
h_hw->dequant4_mf[0] = dequant4_mf0;h_hw->dequant4_mf[1] = dequant4_mf0;h_hw->dequant4_mf[2] = dequant4_mf0;h_hw->dequant4_mf[3] = dequant4_mf0;
h_hw->unquant4_mf[0] = unquant4_mf0;h_hw->unquant4_mf[1] = unquant4_mf0;h_hw->unquant4_mf[2] = unquant4_mf0;h_hw->unquant4_mf[3] = unquant4_mf0;
h_hw->quant4_bias[0] = quant4_bias0;h_hw->quant4_bias[2] = quant4_bias0;
h_hw->quant4_bias0[0] = quant4_bias00;h_hw->quant4_bias0[2] = quant4_bias00;
h_hw->quant4_bias[1] = quant4_bias1;h_hw->quant4_bias[3] = quant4_bias1;
h_hw->quant4_bias0[1] = quant4_bias01;h_hw->quant4_bias0[3] = quant4_bias01;
h_hw->quant8_mf[0]= quant8_mf0;h_hw->quant8_mf[1]= quant8_mf0;
h_hw->dequant8_mf[0] = dequant8_mf0;h_hw->dequant8_mf[1] = dequant8_mf0;
h_hw->unquant8_mf[0] = unquant8_mf0;h_hw->unquant8_mf[1] = unquant8_mf0;
h_hw->quant8_bias[0] = quant8_bias0;
h_hw->quant8_bias0[0]= quant8_bias00;
h_hw->quant8_bias[1] = quant8_bias1;
h_hw->quant8_bias0[1] = quant8_bias01;

COPY_DERIALISE(nr_offset_emergency,9216) h_hw->nr_offset_emergency = nr_offset_emergency;
COPY_DERIALISE(framesunused0,172) h_hw->frames.unused[0]= framesunused0;
COPY_DERIALISE(framesunused1,84) h_hw->frames.unused[1]= framesunused1;
COPY_DERIALISE(framescurrent,28) h_hw->frames.current = framescurrent;
COPY_DERIALISE(framesblank_unused,16) h_hw->frames.blank_unused= framesblank_unused;
#define COST_MV(i) &cost_mv[k][0]
for(int k=0;k<70;k++)
{
h_hw->cost_mv[k] = COST_MV(k)+ 2*4*2048 ;
}
#undef COST_MV(i)

//COPY_DERIALISE(nal_buffer,1500068) h_hw->nal_buffer = nal_buffer;
COPY_DERIALISE(reconfig_h,50432) h_hw->reconfig_h = reconfig_h;
//COPY_DERIALISE(p_bitstream,1000000) h_hw->thread[0]->out.p_bitstream = p_bitstream;
  
COPY_DERIALISE(thread0_outnal,96) h_hw->thread[0]->out.nal = thread0_outnal;
COPY_DERIALISE(mb_base,112896) 
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

COPY_DERIALISE(intra_border_backup00,208) h_hw->intra_border_backup[0][0] = intra_border_backup00; 
COPY_DERIALISE(intra_border_backup01,208) h_hw->intra_border_backup[0][1] = intra_border_backup01;
COPY_DERIALISE(intra_border_backup10,208) h_hw->intra_border_backup[1][0] = intra_border_backup10;
COPY_DERIALISE(intra_border_backup11,208) h_hw->intra_border_backup[1][1] = intra_border_backup11;
COPY_DERIALISE(deblock_strength0,704) h_hw->deblock_strength[0] = deblock_strength0;
COPY_DERIALISE(scratch_buffer,512) h_hw->scratch_buffer = scratch_buffer;
COPY_DERIALISE(scratch_buffer2,384) h_hw->scratch_buffer2 = scratch_buffer2;
COPY_DERIALISE(rc,656) h_hw->rc = rc;
COPY_DERIALISE(rc_pred,100) h_hw->rc->pred = rc_pred;
COPY_DERIALISE(rc_pred_b_from_p,20) h_hw->rc->pred_b_from_p = rc_pred_b_from_p;

COPY_DERIALISE(fenc,sizeof(x264_frame_t)) 
for( int i = 0; i < X264_BFRAME_MAX+2; i++ )
        for( int j = 0; j < X264_BFRAME_MAX+2 ; j++ )
	{	RELATIVE_ADDRESS_FRAME(fenc,i_row_satds[i][j])
	}
	RELATIVE_ADDRESS_FRAME(fenc,buffer[0])
	RELATIVE_ADDRESS_FRAME(fenc,buffer[1])
	RELATIVE_ADDRESS_FRAME(fenc,buffer[2])
	RELATIVE_ADDRESS_FRAME(fenc,buffer[3])
	RELATIVE_ADDRESS_FRAME(fenc,buffer_fld[0])
	RELATIVE_ADDRESS_FRAME(fenc,buffer_fld[1])
	RELATIVE_ADDRESS_FRAME(fenc,buffer_fld[2])
	RELATIVE_ADDRESS_FRAME(fenc,buffer_fld[3])
	RELATIVE_ADDRESS_FRAME(fenc,mb_type)
	RELATIVE_ADDRESS_FRAME(fenc,mb_partition)
	RELATIVE_ADDRESS_FRAME(fenc,mv[0])
	RELATIVE_ADDRESS_FRAME(fenc,mv16x16)
	RELATIVE_ADDRESS_FRAME(fenc,ref[0])
	RELATIVE_ADDRESS_FRAME(fenc,mv[1])
	RELATIVE_ADDRESS_FRAME(fenc,ref[1])
	RELATIVE_ADDRESS_FRAME(fenc,i_row_bits)
	RELATIVE_ADDRESS_FRAME(fenc,f_row_qp)
	RELATIVE_ADDRESS_FRAME(fenc,f_row_qscale)
	RELATIVE_ADDRESS_FRAME(fenc,field)	
	RELATIVE_ADDRESS_FRAME(fenc,effective_qp)
	RELATIVE_ADDRESS_FRAME(fenc,buffer_lowres[0])
	for(int i = 0; i < 2; i++ )
        for(int j = 0; j < X264_BFRAME_MAX+1 ; j++ )
	{	RELATIVE_ADDRESS_FRAME(fenc,lowres_mvs[i][j])
		RELATIVE_ADDRESS_FRAME(fenc,lowres_mv_costs[i][j])
	}
	//RELATIVE_ADDRESS_FRAME(fenc,h_hw->fenc,i_propagate_cost)
	for( int i = 0; i < X264_BFRAME_MAX+2; i++ )
        for( int j = 0; j < X264_BFRAME_MAX+2 ; j++ )
        {       RELATIVE_ADDRESS_FRAME(fenc,lowres_costs[i][j])
        }

	RELATIVE_ADDRESS_FRAME(fenc,f_qp_offset)
	RELATIVE_ADDRESS_FRAME(fenc,f_qp_offset_aq)
	RELATIVE_ADDRESS_FRAME(fenc,i_inv_qscale_factor)
	RELATIVE_ADDRESS_FRAME(fenc,base)
COPY_DERIALISE(fenc_base,177056)
COPY_DERIALISE(fdec,sizeof(x264_frame_t))
//COPY_DERIALISE(fdec_base,240608)
for( int i = 0; i < X264_BFRAME_MAX+2; i++ )
        for( int j = 0; j < X264_BFRAME_MAX+2 ; j++ )
	{	RELATIVE_ADDRESS_FRAME(fdec,i_row_satds[i][j])
	}
	RELATIVE_ADDRESS_FRAME(fdec,buffer[0])
	RELATIVE_ADDRESS_FRAME(fdec,buffer[1])
	RELATIVE_ADDRESS_FRAME(fdec,buffer[2])
	RELATIVE_ADDRESS_FRAME(fdec,buffer[3])
	RELATIVE_ADDRESS_FRAME(fdec,buffer_fld[0])
	RELATIVE_ADDRESS_FRAME(fdec,buffer_fld[1])
	RELATIVE_ADDRESS_FRAME(fdec,buffer_fld[2])
	RELATIVE_ADDRESS_FRAME(fdec,buffer_fld[3])
	RELATIVE_ADDRESS_FRAME(fdec,mb_type)
	RELATIVE_ADDRESS_FRAME(fdec,mb_partition)
	RELATIVE_ADDRESS_FRAME(fdec,mv[0])
	RELATIVE_ADDRESS_FRAME(fdec,mv16x16)
	RELATIVE_ADDRESS_FRAME(fdec,ref[0])
	RELATIVE_ADDRESS_FRAME(fdec,mv[1])
	RELATIVE_ADDRESS_FRAME(fdec,ref[1])
	RELATIVE_ADDRESS_FRAME(fdec,i_row_bits)
	RELATIVE_ADDRESS_FRAME(fdec,f_row_qp)
	RELATIVE_ADDRESS_FRAME(fdec,f_row_qscale)
	RELATIVE_ADDRESS_FRAME(fdec,field)	
	RELATIVE_ADDRESS_FRAME(fdec,effective_qp)
	RELATIVE_ADDRESS_FRAME(fdec,buffer_lowres[0])
	for(int i = 0; i < 2; i++ )
        for(int j = 0; j < X264_BFRAME_MAX+1 ; j++ )
	{	RELATIVE_ADDRESS_FRAME(fdec,lowres_mvs[i][j])
		RELATIVE_ADDRESS_FRAME(fdec,lowres_mv_costs[i][j])
	}
	RELATIVE_ADDRESS_FRAME(fdec,i_propagate_cost)
	for( int i = 0; i < X264_BFRAME_MAX+2; i++ )
        for( int j = 0; j < X264_BFRAME_MAX+2 ; j++ )
        {       RELATIVE_ADDRESS_FRAME(fdec,lowres_costs[i][j])
        }

	RELATIVE_ADDRESS_FRAME(fdec,f_qp_offset)
	RELATIVE_ADDRESS_FRAME(fdec,f_qp_offset_aq)
	RELATIVE_ADDRESS_FRAME(fdec,i_inv_qscale_factor)
	RELATIVE_ADDRESS_FRAME(fdec,base)

h_hw->fenc = fenc;
//h_hw->fenc->base = fenc_base;
h_hw->fdec = fdec;
//h_hw->fdec->base=fdec_base;


return ;
}









////// This program is to copy back from hardware to software /////


x264_t *x264_hw_sync_back(x264_t **ul)
{
fprintf(stdout,"/////******************************************  Creating copy at software side *****************////////////////////////");
////////////////// DATA INITIALIZATION ////
uint32_t recv_size[15]={0};
char Buff0[512*1024];
x264_t *h_hw=*ul;
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
uint16_t *quant8_bias01;
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
x264_frame_t *fdec;
char *fenc_base;
char *fdec_base;

///////// POINTER COPYING SESSION  /////////

quant4_mf0 = h_hw->quant4_mf[0];
dequant4_mf0 = h_hw->dequant4_mf[0];
unquant4_mf0= h_hw->unquant4_mf[0];
quant4_bias0 = h_hw->quant4_bias[0];
quant4_bias00 = h_hw->quant4_bias0[0];
quant4_bias1= h_hw->quant4_bias[1];
quant4_bias01 = h_hw->quant4_bias0[1];
quant8_mf0 = h_hw->quant8_mf[0];
dequant8_mf0= h_hw->dequant8_mf[0];
unquant8_mf0 = h_hw->unquant8_mf[0];
quant8_bias0= h_hw->quant8_bias[0];
quant8_bias00 = h_hw->quant8_bias0[0];
quant8_bias1= h_hw->quant8_bias[1] ;
quant8_bias01 = h_hw->quant8_bias0[1];
 
nr_offset_emergency = h_hw->nr_offset_emergency;
framesunused0 = h_hw->frames.unused[0];
framesunused1 = h_hw->frames.unused[1];
framescurrent = h_hw->frames.current ;
framesblank_unused = h_hw->frames.blank_unused;
for(int i=0;i<70;i++)
cost_mv[i]= h_hw->cost_mv[i] - 2*4*2048 ;
nal_buffer = h_hw->nal_buffer;
reconfig_h = h_hw->reconfig_h;
p_bitstream = h_hw->thread[0]->out.p_bitstream;
thread0_outnal= h_hw->thread[0]->out.nal; 
mb_base = h_hw->mb.base;
intra_border_backup00 = h_hw->intra_border_backup[0][0];
intra_border_backup01 = h_hw->intra_border_backup[0][1];
intra_border_backup10 = h_hw->intra_border_backup[1][0];
intra_border_backup11 = h_hw->intra_border_backup[1][1];
deblock_strength0 = h_hw->deblock_strength[0];
scratch_buffer = h_hw->scratch_buffer;
scratch_buffer2 = h_hw->scratch_buffer2;
rc = h_hw->rc;
rc_pred = h_hw->rc->pred;
rc_pred_b_from_p = h_hw->rc->pred_b_from_p;
fenc= h_hw->fenc;
fdec= h_hw->fdec;
fenc_base = h_hw->fenc->base;
fdec_base = h_hw->fdec->base;
/////// POINTER COPYING ENDS HERE ///////////
int bfno=0;
uint32_t serialize_pointer=0,read_pointer=0;
unsigned int derialize_pointer=0;




/**********  READING BUFFERS ***********/
read_buffer(recv_size,Buff0);
//h_hw->thread[0] =(x264_t *)h_hw ;


COPY_DERIALISE(h_hw, sizeof(x264_t))
h_hw->thread[0] =(x264_t *)h_hw ;


h_hw->quant4_mf[0] = quant4_mf0;h_hw->quant4_mf[1] =quant4_mf0; h_hw->quant4_mf[2] =quant4_mf0;h_hw->quant4_mf[3] =quant4_mf0;
h_hw->dequant4_mf[0] = dequant4_mf0;h_hw->dequant4_mf[1] = dequant4_mf0;h_hw->dequant4_mf[2] = dequant4_mf0;h_hw->dequant4_mf[3] = dequant4_mf0;
h_hw->unquant4_mf[0] = unquant4_mf0;h_hw->unquant4_mf[1] = unquant4_mf0;h_hw->unquant4_mf[2] = unquant4_mf0;h_hw->unquant4_mf[3] = unquant4_mf0;
h_hw->quant4_bias[0] = quant4_bias0;h_hw->quant4_bias[2] = quant4_bias0;
h_hw->quant4_bias0[0] = quant4_bias00;h_hw->quant4_bias0[2] = quant4_bias00;
h_hw->quant4_bias[1] = quant4_bias1;h_hw->quant4_bias[3] = quant4_bias1;
h_hw->quant4_bias0[1] = quant4_bias01;h_hw->quant4_bias0[3] = quant4_bias01;
h_hw->quant8_mf[0]= quant8_mf0;h_hw->quant8_mf[1]= quant8_mf0;
h_hw->dequant8_mf[0] = dequant8_mf0;h_hw->dequant8_mf[1] = dequant8_mf0;
h_hw->unquant8_mf[0] = unquant8_mf0;h_hw->unquant8_mf[1] = unquant8_mf0;
h_hw->quant8_bias[0] = quant8_bias0;
h_hw->quant8_bias0[0]= quant8_bias00;
h_hw->quant8_bias[1] = quant8_bias1;
h_hw->quant8_bias0[1] = quant8_bias01;

COPY_DERIALISE(nr_offset_emergency,9216) h_hw->nr_offset_emergency = nr_offset_emergency;
COPY_DERIALISE(framesunused0,172) h_hw->frames.unused[0]= framesunused0;
COPY_DERIALISE(framesunused1,84) h_hw->frames.unused[1]= framesunused1;
COPY_DERIALISE(framescurrent,28) h_hw->frames.current = framescurrent;
COPY_DERIALISE(framesblank_unused,16) h_hw->frames.blank_unused= framesblank_unused;
#define COST_MV(i) &cost_mv[k][0]
for(int k=0;k<70;k++)
{
h_hw->cost_mv[k] = COST_MV(k)+ 2*4*2048 ;
}
#undef COST_MV(i)

//COPY_DERIALISE(nal_buffer,1500068) h_hw->nal_buffer = nal_buffer;
COPY_DERIALISE(reconfig_h,50432) h_hw->reconfig_h = reconfig_h;
//COPY_DERIALISE(p_bitstream,1000000) h_hw->thread[0]->out.p_bitstream = p_bitstream;

COPY_DERIALISE(thread0_outnal,96) h_hw->thread[0]->out.nal = thread0_outnal;
COPY_DERIALISE(mb_base,112896) 
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

COPY_DERIALISE(intra_border_backup00,208) h_hw->intra_border_backup[0][0] = intra_border_backup00; 
COPY_DERIALISE(intra_border_backup01,208) h_hw->intra_border_backup[0][1] = intra_border_backup01;
COPY_DERIALISE(intra_border_backup10,208) h_hw->intra_border_backup[1][0] = intra_border_backup10;
COPY_DERIALISE(intra_border_backup11,208) h_hw->intra_border_backup[1][1] = intra_border_backup11;
COPY_DERIALISE(deblock_strength0,704) h_hw->deblock_strength[0] = deblock_strength0;
COPY_DERIALISE(scratch_buffer,512) h_hw->scratch_buffer = scratch_buffer;
COPY_DERIALISE(scratch_buffer2,384) h_hw->scratch_buffer2 = scratch_buffer2;
COPY_DERIALISE(rc,656) h_hw->rc = rc;
COPY_DERIALISE(rc_pred,100) h_hw->rc->pred = rc_pred;
COPY_DERIALISE(rc_pred_b_from_p,20) h_hw->rc->pred_b_from_p = rc_pred_b_from_p;
h_hw->fenc = fenc;
h_hw->fenc->base=fenc_base;

COPY_DERIALISE(fdec,sizeof(x264_frame_t)) 
COPY_DERIALISE(fdec_base,240608) 

for( int i = 0; i < X264_BFRAME_MAX+2; i++ )
        for( int j = 0; j < X264_BFRAME_MAX+2 ; j++ )
	{	RELATIVE_ADDRESS_FRAME(fdec,i_row_satds[i][j])
	}
	RELATIVE_ADDRESS_FRAME(fdec,buffer[0])
	RELATIVE_ADDRESS_FRAME(fdec,buffer[1])
	RELATIVE_ADDRESS_FRAME(fdec,buffer[2])
	RELATIVE_ADDRESS_FRAME(fdec,buffer[3])
	RELATIVE_ADDRESS_FRAME(fdec,buffer_fld[0])
	RELATIVE_ADDRESS_FRAME(fdec,buffer_fld[1])
	RELATIVE_ADDRESS_FRAME(fdec,buffer_fld[2])
	RELATIVE_ADDRESS_FRAME(fdec,buffer_fld[3])
	RELATIVE_ADDRESS_FRAME(fdec,mb_type)
	RELATIVE_ADDRESS_FRAME(fdec,mb_partition)
	RELATIVE_ADDRESS_FRAME(fdec,mv[0])
	RELATIVE_ADDRESS_FRAME(fdec,mv16x16)
	RELATIVE_ADDRESS_FRAME(fdec,ref[0])
	RELATIVE_ADDRESS_FRAME(fdec,mv[1])
	RELATIVE_ADDRESS_FRAME(fdec,ref[1])
	RELATIVE_ADDRESS_FRAME(fdec,i_row_bits)
	RELATIVE_ADDRESS_FRAME(fdec,f_row_qp)
	RELATIVE_ADDRESS_FRAME(fdec,f_row_qscale)
	RELATIVE_ADDRESS_FRAME(fdec,field)	
	RELATIVE_ADDRESS_FRAME(fdec,effective_qp)
	RELATIVE_ADDRESS_FRAME(fdec,buffer_lowres[0])
	for(int i = 0; i < 2; i++ )
        for(int j = 0; j < X264_BFRAME_MAX+1 ; j++ )
	{	RELATIVE_ADDRESS_FRAME(fdec,lowres_mvs[i][j])
		RELATIVE_ADDRESS_FRAME(fdec,lowres_mv_costs[i][j])
	}
	RELATIVE_ADDRESS_FRAME(fdec,i_propagate_cost)
	for( int i = 0; i < X264_BFRAME_MAX+2; i++ )
        for( int j = 0; j < X264_BFRAME_MAX+2 ; j++ )
        {       RELATIVE_ADDRESS_FRAME(fdec,lowres_costs[i][j])
        }

	RELATIVE_ADDRESS_FRAME(fdec,f_qp_offset)
	RELATIVE_ADDRESS_FRAME(fdec,f_qp_offset_aq)
	RELATIVE_ADDRESS_FRAME(fdec,i_inv_qscale_factor)
	RELATIVE_ADDRESS_FRAME(fdec,base)

//h_hw->fenc = fenc;
//h_hw->fenc->base = fenc_base;
h_hw->fdec = fdec;
//h_hw->fdec->base=fdec_base;
return ;
}


