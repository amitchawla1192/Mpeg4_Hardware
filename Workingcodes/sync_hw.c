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

uint32_t recv_size[15]={0};

/*char Buff1[512*1024];
char Buff2[512*1024];
char Buff3[512*1024];
char Buff4[512*1024];
char Buff5[512*1024];
char Buff6[512*1024];
char Buff7[512*1024];
char Buff8[512*1024];
char Buff9[512*1024];
*/





void read_buffer(uint32_t *recv_sizem,char *Buffer)
{
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

//x264_t *h_hw;
x264_t *x264_sw_sync_open(x264_t **ul,x264_t *h)
{char Buff0[512*1024];
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
//COPY_BUFFER(bfno,h->nal_buffer,1500068)
x264_t *reconfig_h;
////COPY_BUFFER(bfno,h->thread[0]->out.p_bitstream,1000000)
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

if(h_hw==NULL)
{
fprintf(stdout,"allocating data %p and %p\n",*ul,h_hw);
h_hw=(x264_t *)malloc(50432);
*ul = h_hw;
fprintf(stdout,"allocating data %p and %p\n",*ul,h_hw);
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
//COPY_BUFFER(bfno,h->nal_buffer,1500068)
////COPY_BUFFER(bfno,h->thread[0]->out.p_bitstream,1000000)
thread0_outnal=malloc(96);
mb_base=malloc(112896);
intra_border_backup00=malloc(208);
intra_border_backup01=malloc(208);
intra_border_backup10=malloc(208);
intra_border_backup11=malloc(208);
deblock_strength0=malloc(704);
scratch_buffer=malloc(512);
scratch_buffer2=malloc(384);
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
//COPY_BUFFER(bfno,h->nal_buffer,1500068)
reconfig_h = h_hw->reconfig_h;
////COPY_BUFFER(bfno,h->thread[0]->out.p_bitstream,1000000)
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
fprintf(stdout,"reached here %d\n",k);
//fprintf(stdout,"%d \n",COST_MV(k));
}
#undef COST_MV(i)

fprintf(stdout,"reached here \n");
//fprintf(stdout,"%p and %p are \n",h->mb.base,h->mb.base);

//COPY_BUFFER(bfno,h->nal_buffer,1500068)
COPY_DERIALISE(reconfig_h,50432) h_hw->reconfig_h = reconfig_h;
//COPY_BUFFER(bfno,h->thread[0]->out.p_bitstream,1000000)

COPY_DERIALISE(thread0_outnal,96)
h_hw->thread[0]->out.nal = thread0_outnal;

//fprintf(stdout,"%p and %p are \n",h->mb.base,h->mb.base);

//fprintf(stdout,"%d and %d are \n",h_hw->mb.i_qp,h->mb.i_qp);
COPY_DERIALISE(mb_base,1000) 
//fprintf(stdout,"fine here buddy \n");
//fprintf(stdout,"%p and %p are \n",h->mb.base,h->mb.base);

RELATIVE_ADDRESS(qp)
//fprintf(stdout,"%p and %p are \n",((intptr_t)h->mb.qp - (intptr_t)h->mb.base,h->mb.base);

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

//fprintf(stdout,"difference is %p and %p and %p",((intptr_t)h->mb.cbp -(intptr_t)h->mb.base),((intptr_t)h_hw->mb.cbp - (intptr_t)h_hw->mb.base),mb_base);

COPY_DERIALISE(intra_border_backup00,208) h_hw->intra_border_backup[0][0] = intra_border_backup00; 
COPY_DERIALISE(intra_border_backup01,208) h_hw->intra_border_backup[0][1] = intra_border_backup01;
COPY_DERIALISE(intra_border_backup10,208) h_hw->intra_border_backup[1][0] = intra_border_backup10;
COPY_DERIALISE(intra_border_backup11,208) h_hw->intra_border_backup[1][1] = intra_border_backup11;
COPY_DERIALISE(deblock_strength0,704) h_hw->deblock_strength[0] = deblock_strength0;
COPY_DERIALISE(scratch_buffer,512) h_hw->scratch_buffer = scratch_buffer;
COPY_DERIALISE(scratch_buffer2,384) h_hw->scratch_buffer2 = scratch_buffer2;
COPY_DERIALISE(rc,656) h_hw->rc = rc;
fprintf(stderr,"rc->b_abr is %d \n",rc->b_abr);
COPY_DERIALISE(rc_pred,100) h_hw->rc->pred = rc_pred;

COPY_DERIALISE(rc_pred_b_from_p,20) h_hw->rc->pred_b_from_p = rc_pred_b_from_p;


//if(h->mb.dist_scale_factor[1] == h_hw->mb.dist_scale_factor[1])
//fprintf(stderr,"copied succesfully \n");
//else 
//fprintf(stderr,"copied noise \n");
// for(int i=0;i <12;i++ )
//fprintf(stdout,"%p \n",h_hw->dequant4_mf[0][i]);
/*
for(int i=0;i<6;i++)
{
for(int j=0;j<16;j++)
{
if(h_hw->dequant4_mf[0][i][j] == h->dequant4_mf[0][i][j])
fprintf(stdout,"Data seems to be copied safe %p sizeof(int) is %p and %p  \n",&h_hw->dequant4_mf[0][i][j],&h->dequant4_mf[0][i][j],dequant4_mf0);
else
fprintf(stdout, " Data seems to be Noisy at address %p and %p\n ",&h_hw->dequant4_mf[0][i][j],&h->dequant4_mf[0][i][j]);
}
}
*/
//fprintf(stdout,"reached at exit point");

return ;
}


