/*
This file is to be kept at software side and implements the serializing function.
This file includes ** functions
1) x264_sw_sync_open
	It implements serializing of data for first time transfer of required matrixes
	by hardware.
2) x264_sw_sync_t
	This implements serializing of x264_t structure for current frame, excluding
	matrixes transferred in x264_sw_sync_open.
3) x264_sw_sync_back_t
	This implements copying back of the x264_t structure from software to hardware.
4) x264_sw_sync_fenc
	This frame serializes all data in fenc frame
5) x264_sw_sync_fdec_back
	This implements copying back of fdec frame that is encoded frame.
*/

#define _ISOC99_SOURCE
#include <Pipes.h>
#include "common/common.h"
//#include "encoder/ratecontrol.c"



 /* This part is added by Amit Chawla */


#define COPY_BUFFER(bff,y,z)\
	serialize_pointer_old = serialize_pointer_new ;\
	serialize_pointer_new += z;\
	if(serialize_pointer_new < 9 * 1024 *1024)\
	{memcpy( bff + serialize_pointer_old , y, z); send_size = serialize_pointer_new;\
	}\
	else {fprintf(stdout,"Buffer Overflow"); }

static char COPY_BUFFER_0[9*1024*1024];

void x264_sw_sync_open(x264_t *h)
{
int send_size= 0;
int bfno=0,j=0;
uint32_t serialize_pointer_old = 0,serialize_pointer_new=0; // Number of bytes already copied to Buffer
 
int sendsize = 0;
//fprintf(stdout,"in sync \n");
//COPY_BUFFER(COPY_BUFFER_0,h,sizeof(x264_t))
COPY_BUFFER(COPY_BUFFER_0,h->quant4_mf[0],1664 )
COPY_BUFFER(COPY_BUFFER_0,h->dequant4_mf[0], 384 )
COPY_BUFFER(COPY_BUFFER_0,h->unquant4_mf[0], 3328 )
COPY_BUFFER(COPY_BUFFER_0,h->quant4_bias[0],1664) 
COPY_BUFFER(COPY_BUFFER_0,h->quant4_bias0[0] ,1664) 
COPY_BUFFER(COPY_BUFFER_0,h->quant4_bias[1],1664) 
COPY_BUFFER(COPY_BUFFER_0,h->quant4_bias0[1],1664)
COPY_BUFFER(COPY_BUFFER_0,h->quant8_mf[0],6656)
COPY_BUFFER(COPY_BUFFER_0,h->dequant8_mf[0],1536)
COPY_BUFFER(COPY_BUFFER_0,h->unquant8_mf[0],13312)
COPY_BUFFER(COPY_BUFFER_0,h->quant8_bias[0],6656)
COPY_BUFFER(COPY_BUFFER_0,h->quant8_bias0[0],6656)
COPY_BUFFER(COPY_BUFFER_0,h->quant8_bias[1],6656)
COPY_BUFFER(COPY_BUFFER_0,h->quant8_bias0[1],6656)
COPY_BUFFER(COPY_BUFFER_0,h->nr_offset_emergency,9216)
//COPY_BUFFER(COPY_BUFFER_0,h->frames.unused[0],172)
//COPY_BUFFER(COPY_BUFFER_0,h->frames.unused[1],84)
//COPY_BUFFER(COPY_BUFFER_0,h->frames.current,28)
//COPY_BUFFER(COPY_BUFFER_0,h->frames.blank_unused,16)
fprintf(stdout,"succesfull allotment of space again \n");
for(int i=0; i<70; i++)
{
COPY_BUFFER(COPY_BUFFER_0,h->cost_mv[i]-2*4*2048,65538)
}
fprintf(stdout,"copying something /n");
//COPY_BUFFER(bfno,h->nal_buffer,1500068)
//COPY_BUFFER(COPY_BUFFER_0,h->reconfig_h,50432)
//COPY_BUFFER(bfno,h->thread[0]->out.p_bitstream,1000000)
//COPY_BUFFER(COPY_BUFFER_0,h->thread[0]->out.nal,96)
//COPY_BUFFER(COPY_BUFFER_0,h->mb.base,112896)
//COPY_BUFFER(COPY_BUFFER_0,h->intra_border_backup[0][0],208)
//COPY_BUFFER(COPY_BUFFER_0,h->intra_border_backup[0][1],208)
//COPY_BUFFER(COPY_BUFFER_0,h->intra_border_backup[1][0],208)
//COPY_BUFFER(COPY_BUFFER_0,h->intra_border_backup[1][1],208)
//COPY_BUFFER(COPY_BUFFER_0,h->deblock_strength[0],704)
//COPY_BUFFER(COPY_BUFFER_0,h->scratch_buffer,512)
//COPY_BUFFER(COPY_BUFFER_0,h->scratch_buffer2,384)
//COPY_BUFFER(COPY_BUFFER_0,h->rc,656)
//COPY_BUFFER(COPY_BUFFER_0,h->rc->pred,100)
//COPY_BUFFER(COPY_BUFFER_0,h->rc->pred_b_from_p,20)

#define WRITE_BUFFER_X(siz) fprintf(stdout,"Writing buffer \n");\
if(siz != 0)\
{ write_uint32("in_data", siz);\
write_uint32_n("in_data",COPY_BUFFER_0,send_size/4); }

fprintf(stdout,"Now starting writing buffer %d \n",send_size);
  
WRITE_BUFFER_X(send_size)
//write_uint32("in_data", 0);
fprintf(stdout,"exiting sync sw open side %d ",send_size);
return ;
}



/*


/////////////////////////////    This code to copy from software to Hardware /////////////////////////



void x264_hw_sync(x264_t *h)
{//fprintf(stdout,"in sync \n");
int send_size[15]={0};
int bfno=0,j=0;
uint32_t serialize_pointer_old = 0,serialize_pointer_new=0; // Number of bytes already copied to Buffer
uint32_t size_buff = 512*1024;  /// initial size of buffer 
char Buffer0[size_buff]; //  write now starting with 2MB
//fprintf(stdout,"in sync \n");
char Buffer1[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer2[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer3[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer4[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer5[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer6[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer7[size_buff];
//fprintf(stdout,"in sync \n");
char Buffer8[size_buff];
//fprintf(stdout,"in sync \n");
char Buffer9[size_buff];
//fprintf(stdout,"in sync \n");
char Buffer10[size_buff];
//fprintf(stdout,"in sync \n");
char Buffer11[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer12[size_buff];
//fprintf(stdout,"in sync \n");
char Buffer13[size_buff];
//fprintf(stdout,"in sync \n");
char Buffer14[size_buff];
//fprintf(stdout,"in sync \n");

int sendsize=0;
//fprintf(stdout,"in sync \n");
COPY_BUFFER(bfno,h,sizeof(x264_t))
//COPY_BUFFER(bfno,h->quant4_mf[0],1664 )
//COPY_BUFFER(bfno,h->dequant4_mf[0], 384 )
//COPY_BUFFER(bfno,h->unquant4_mf[0], 3328 )
//COPY_BUFFER(bfno,h->quant4_bias[0],1664) 
//COPY_BUFFER(bfno,h->quant4_bias0[0] ,1664) 
//COPY_BUFFER(bfno,h->quant4_bias[1],1664) 
//COPY_BUFFER(bfno,h->quant4_bias0[1],1664)
//COPY_BUFFER(bfno,h->quant8_mf[0],6656)
//COPY_BUFFER(bfno,h->dequant8_mf[0],1536)
//COPY_BUFFER(bfno,h->unquant8_mf[0],13312)
//COPY_BUFFER(bfno,h->quant8_bias[0],6656)
//COPY_BUFFER(bfno,h->quant8_bias0[0],6656)
//COPY_BUFFER(bfno,h->quant8_bias[1],6656)
//COPY_BUFFER(bfno,h->quant8_bias0[1],6656)

COPY_BUFFER(bfno,h->nr_offset_emergency,9216)
COPY_BUFFER(bfno,h->frames.unused[0],172)
COPY_BUFFER(bfno,h->frames.unused[1],84)
COPY_BUFFER(bfno,h->frames.current,28)
COPY_BUFFER(bfno,h->frames.blank_unused,16)
fprintf(stdout,"succesfull allotment of space again \n");
//for(int i=0; i<70; i++)
//{
//COPY_BUFFER(bfno,h->cost_mv[i]-2*4*2048,65538)
//}
//COPY_BUFFER(bfno,h->nal_buffer,1500068)
COPY_BUFFER(bfno,h->reconfig_h,50432)
//COPY_BUFFER(bfno,h->thread[0]->out.p_bitstream,1000000)

COPY_BUFFER(bfno,h->thread[0]->out.nal,96)
COPY_BUFFER(bfno,h->mb.base,112896)
COPY_BUFFER(bfno,h->intra_border_backup[0][0],208)
COPY_BUFFER(bfno,h->intra_border_backup[0][1],208)
COPY_BUFFER(bfno,h->intra_border_backup[1][0],208)
COPY_BUFFER(bfno,h->intra_border_backup[1][1],208)
COPY_BUFFER(bfno,h->deblock_strength[0],704)
COPY_BUFFER(bfno,h->scratch_buffer,512)
COPY_BUFFER(bfno,h->scratch_buffer2,384)
COPY_BUFFER(bfno,h->rc,656)
COPY_BUFFER(bfno,h->rc->pred,100)
COPY_BUFFER(bfno,h->rc->pred_b_from_p,20)
COPY_BUFFER(bfno,h->fenc,sizeof(x264_frame_t))
COPY_BUFFER(bfno,h->fenc->base,177056)
COPY_BUFFER(bfno,h->fdec,sizeof(x264_frame_t))
fprintf(stdout,"allocated space for enc 177056 from %p to %p and for fdec from %p to %p",h->fenc->base,(intptr_t)h->fenc->base+177056,h->fdec->base,(intptr_t)h->fdec->base + 240608);
//COPY_BUFFER(bfno,h->fdec->base,240608)
#define WRITE_BUFFER_X(i,siz) fprintf(stdout,"Writing buffer \n");\
if(siz != 0)\
{ write_uint32("in_data", siz);\
write_uint32_n("in_data",Buffer##i,send_size[i]/4); }
for(int j=0;j<15;j++)
fprintf(stdout,"Now starting writing buffer %d \n",send_size[j]);
  
WRITE_BUFFER_X(0,send_size[0]) 
WRITE_BUFFER_X(1,send_size[1])
WRITE_BUFFER_X(2,send_size[2])
WRITE_BUFFER_X(3,send_size[3])
WRITE_BUFFER_X(4,send_size[4])
WRITE_BUFFER_X(5,send_size[5])
WRITE_BUFFER_X(6,send_size[6])
WRITE_BUFFER_X(7,send_size[7])
WRITE_BUFFER_X(8,send_size[8])
WRITE_BUFFER_X(9,send_size[9])
WRITE_BUFFER_X(10,send_size[10])
WRITE_BUFFER_X(11,send_size[11])
WRITE_BUFFER_X(12,send_size[12])
WRITE_BUFFER_X(13,send_size[13])
WRITE_BUFFER_X(14,send_size[14])
write_uint32("in_data", 0);
fprintf(stdout,"exiting sync sw side");
return ;
}



//////////////////// This code is to copy back to software  ///////////////

void x264_sw_sync_back(x264_t *h)
{//fprintf(stdout,"in sync \n");
static int prev_out_sw_bitstream=0;
int send_size[15]={0};
int bfno=0,j=0;
uint32_t serialize_pointer_old = 0,serialize_pointer_new=0; // Number of bytes already copied to Buffer
uint32_t size_buff =512*1024;  /// initial size of buffer 
char Buffer0[size_buff]; //  write now starting with 2MB
//fprintf(stdout,"in sync \n");
char Buffer1[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer2[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer3[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer4[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer5[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer6[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer7[size_buff];
//fprintf(stdout,"in sync \n");
char Buffer8[size_buff];
//fprintf(stdout,"in sync \n");
char Buffer9[size_buff];
//fprintf(stdout,"in sync \n");
char Buffer10[size_buff];
//fprintf(stdout,"in sync \n");
char Buffer11[size_buff]; 
//fprintf(stdout,"in sync \n");
char Buffer12[size_buff];
//fprintf(stdout,"in sync \n");
char Buffer13[size_buff];
//fprintf(stdout,"in sync \n");
char Buffer14[size_buff];
//fprintf(stdout,"in sync \n");

int sendsize=0;
//fprintf(stdout,"in sync \n");
COPY_BUFFER(bfno,h,sizeof(x264_t))
//COPY_BUFFER(bfno,h->quant4_mf[0],1664 )
//COPY_BUFFER(bfno,h->dequant4_mf[0], 384 )
//COPY_BUFFER(bfno,h->unquant4_mf[0], 3328 )
//COPY_BUFFER(bfno,h->quant4_bias[0],1664) 
//COPY_BUFFER(bfno,h->quant4_bias0[0] ,1664) 
//COPY_BUFFER(bfno,h->quant4_bias[1],1664) 
//COPY_BUFFER(bfno,h->quant4_bias0[1],1664)
//COPY_BUFFER(bfno,h->quant8_mf[0],6656)
//COPY_BUFFER(bfno,h->dequant8_mf[0],1536)
//COPY_BUFFER(bfno,h->unquant8_mf[0],13312)
//COPY_BUFFER(bfno,h->quant8_bias[0],6656)
//COPY_BUFFER(bfno,h->quant8_bias0[0],6656)
//COPY_BUFFER(bfno,h->quant8_bias[1],6656)
//COPY_BUFFER(bfno,h->quant8_bias0[1],6656)

COPY_BUFFER(bfno,h->nr_offset_emergency,9216)
COPY_BUFFER(bfno,h->frames.unused[0],172)
COPY_BUFFER(bfno,h->frames.unused[1],84)
COPY_BUFFER(bfno,h->frames.current,28)
COPY_BUFFER(bfno,h->frames.blank_unused,16)
fprintf(stdout,"succesfull allotment of space again \n");
//for(int i=0; i<70; i++)
//{
//COPY_BUFFER(bfno,h->cost_mv[i]-2*4*2048,65538)
//}
//COPY_BUFFER(bfno,h->nal_buffer,1500068)
COPY_BUFFER(bfno,h->reconfig_h,50432)
//COPY_BUFFER(bfno,(h->thread[0]->out.i_bitstream - prev_out_sw_bitstream), sizeof(int))
COPY_BUFFER(bfno,h->thread[0]->out.p_bitstream + prev_out_sw_bitstream,(h->thread[0]->out.i_bitstream - prev_out_sw_bitstream))
prev_out_sw_bitstream = h->thread[0]->out.i_bitstream ; 
COPY_BUFFER(bfno,h->thread[0]->out.nal,96)
COPY_BUFFER(bfno,h->mb.base,112896)
COPY_BUFFER(bfno,h->intra_border_backup[0][0],208)
COPY_BUFFER(bfno,h->intra_border_backup[0][1],208)
COPY_BUFFER(bfno,h->intra_border_backup[1][0],208)
COPY_BUFFER(bfno,h->intra_border_backup[1][1],208)
COPY_BUFFER(bfno,h->deblock_strength[0],704)
COPY_BUFFER(bfno,h->scratch_buffer,512)
COPY_BUFFER(bfno,h->scratch_buffer2,384)
COPY_BUFFER(bfno,h->rc,656)
COPY_BUFFER(bfno,h->rc->pred,100)
COPY_BUFFER(bfno,h->rc->pred_b_from_p,20)
COPY_BUFFER(bfno,h->fdec,sizeof(x264_frame_t))
COPY_BUFFER(bfno,h->fdec->base,240608)

#define WRITE_BUFFER_X(i,siz) fprintf(stdout,"Writing buffer\n");\
if(siz != 0)\
{ write_uint32("in_data", siz);\
write_uint32_n("in_data",Buffer##i,send_size[i]/4); }
for(int j=0;j<15;j++)
fprintf(stdout,"Now starting writing buffer %d \n",send_size[j]);
  
WRITE_BUFFER_X(0,send_size[0]) 
WRITE_BUFFER_X(1,send_size[1])
WRITE_BUFFER_X(2,send_size[2])
WRITE_BUFFER_X(3,send_size[3])
WRITE_BUFFER_X(4,send_size[4])
WRITE_BUFFER_X(5,send_size[5])
WRITE_BUFFER_X(6,send_size[6])
WRITE_BUFFER_X(7,send_size[7])
WRITE_BUFFER_X(8,send_size[8])
WRITE_BUFFER_X(9,send_size[9])
WRITE_BUFFER_X(10,send_size[10])
WRITE_BUFFER_X(11,send_size[11])
WRITE_BUFFER_X(12,send_size[12])
WRITE_BUFFER_X(13,send_size[13])
WRITE_BUFFER_X(14,send_size[14])
write_uint32("in_data", 0);
fprintf(stdout,"exiting sync sw side");
return ;
}


*/


