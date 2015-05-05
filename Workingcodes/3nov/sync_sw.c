#define _ISOC99_SOURCE
#include <Pipes.h>
#include "common/common.h"
//#include "encoder/ratecontrol.c"



 /* This part is added by Amit Chawla */
#define COPY_BUFFER(l,y,z)\
	serialize_pointer_old = serialize_pointer_new ;\
	serialize_pointer_new += z;\
	if(serialize_pointer_new > 512*1024)\
	{ if(l < 14)\
	{ \
	if(z < 512*1024)\
	{\
	send_size[l]= serialize_pointer_old;\
	fprintf(stdout,"Buffer complete \n ");\
	serialize_pointer_old=0;\
	serialize_pointer_new=z; \
	l++; \
	}\
	else{\
	fprintf(stdout,"this can not be sent in this buffer");\
	}} \
	else \
	{ \
	fprintf(stdout,"Buffer overflow at recieving side");\
	return; \
	} \
	}\
	switch (l) \
	{	\
	case 0 : fprintf(stdout,"reached in memcopy 0 %d and %d  \n",z,serialize_pointer_old);  memcpy(Buffer0 + serialize_pointer_old , y, z);send_size[0] = serialize_pointer_new;break; \
        case 1 : /*fprintf(stdout,"reached in memcopy 1  \n"); */ memcpy(Buffer1 + serialize_pointer_old , y, z);send_size[1] = serialize_pointer_new;break;  \
	case 2 : /*fprintf(stdout,"reached in memcopy 2  \n"); */ memcpy(Buffer2 + serialize_pointer_old , y, z);send_size[2] = serialize_pointer_new;break;  \
	case 3 :/* fprintf(stdout,"reached in memcopy 3  \n"); */ memcpy(Buffer3 + serialize_pointer_old , y, z);send_size[3] = serialize_pointer_new;break;  \
	case 4 : /*fprintf(stdout,"reached in memcopy 4  \n"); */ memcpy(Buffer4 + serialize_pointer_old , y, z);send_size[4] = serialize_pointer_new;break;  \
	case 5 : /*fprintf(stdout,"reached in memcopy 5  \n"); */ memcpy(Buffer5 + serialize_pointer_old , y, z);send_size[5] = serialize_pointer_new;break;  \
	case 6 : /*fprintf(stdout,"reached in memcopy 6  \n"); */ memcpy(Buffer6 + serialize_pointer_old , y, z);send_size[6] = serialize_pointer_new;break;  \
	case 7 : /*fprintf(stdout,"reached in memcopy 7  \n");  */memcpy(Buffer7 + serialize_pointer_old , y, z);send_size[7] = serialize_pointer_new;break;  \
	case 8 : /*fprintf(stdout,"reached in memcopy 8  \n");  */memcpy(Buffer8 + serialize_pointer_old , y, z);send_size[8] = serialize_pointer_new;break; \
        case 9 : /*fprintf(stdout,"reached in memcopy 9  \n");  */memcpy(Buffer9 + serialize_pointer_old , y, z);send_size[9] = serialize_pointer_new;break;  \
        case 10 : /*fprintf(stdout,"reached in memcopy 10  \n"); */ memcpy(Buffer10 + serialize_pointer_old , y, z);send_size[10] = serialize_pointer_new;break;  \
        case 11 : /*fprintf(stdout,"reached in memcopy 11  \n"); */ memcpy(Buffer11 + serialize_pointer_old , y, z);send_size[11] = serialize_pointer_new;break;  \
        case 12 : /*fprintf(stdout,"reached in memcopy 12  \n"); */ memcpy(Buffer12 + serialize_pointer_old , y, z);send_size[12] = serialize_pointer_new;break;  \
        case 13 : /*fprintf(stdout,"reached in memcopy 13 \n"); */ memcpy(Buffer13 + serialize_pointer_old , y, z);send_size[13] = serialize_pointer_new;break;  \
        case 14 : /*fprintf(stdout,"reached in memcopy 14  \n"); */ memcpy(Buffer14 + serialize_pointer_old , y, z);send_size[14] = serialize_pointer_new;break;  \ 	
	}
void x264_hw_sync_open(x264_t *h)
{//fprintf(stdout,"in sync \n");
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
COPY_BUFFER(bfno,h->quant4_mf[0],1664 )
COPY_BUFFER(bfno,h->dequant4_mf[0], 384 )
COPY_BUFFER(bfno,h->unquant4_mf[0], 3328 )
COPY_BUFFER(bfno,h->quant4_bias[0],1664) 
COPY_BUFFER(bfno,h->quant4_bias0[0] ,1664) 
COPY_BUFFER(bfno,h->quant4_bias[1],1664) 
COPY_BUFFER(bfno,h->quant4_bias0[1],1664)
COPY_BUFFER(bfno,h->quant8_mf[0],6656)
COPY_BUFFER(bfno,h->dequant8_mf[0],1536)
COPY_BUFFER(bfno,h->unquant8_mf[0],13312)
COPY_BUFFER(bfno,h->quant8_bias[0],6656)
COPY_BUFFER(bfno,h->quant8_bias0[0],6656)
COPY_BUFFER(bfno,h->quant8_bias[1],6656)
COPY_BUFFER(bfno,h->quant8_bias0[1],6656)

COPY_BUFFER(bfno,h->nr_offset_emergency,9216)
COPY_BUFFER(bfno,h->frames.unused[0],172)
COPY_BUFFER(bfno,h->frames.unused[1],84)
COPY_BUFFER(bfno,h->frames.current,28)
COPY_BUFFER(bfno,h->frames.blank_unused,16)
fprintf(stdout,"succesfull allotment of space again \n");
for(int i=0; i<70; i++)
{
COPY_BUFFER(bfno,h->cost_mv[i]-2*4*2048,65538)
}
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



//////////////////// This code is to copy bact to software  ///////////////

void x264_sw_sync_back(x264_t *h)
{//fprintf(stdout,"in sync \n");
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





