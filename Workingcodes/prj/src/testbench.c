#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

//
//// the next two inclusions are
//// to be used in the software version
////
#ifdef SW
#include <pipeHandler.h>
#include <Pipes.h>
#include "prog.h"
#else
#include "vhdlCStubs.h"
#endif
//
//


void *hardware1_(void* fargs)
{
   hardware1();
}

/*void *hardware2_(void* fargs)
{
hardware2();

}
*/
void *wstruct_pipe_(void* infile)
{uint32_t k;

//fprintf(stdout,"Sending datai\n");
fprintf(stdout,"Sending 1st data \n");
write_uint32("in_data",5);
write_uint32("in_data",10);
write_uint32("in_data",15);
write_uint32("in_data",20);
write_uint32("in_data",25);
write_uint32("in_data",30);
k=read_uint32("out_id");
fprintf(stdout,"Sending 2nd data %d\n ",k);
write_uint32("in_data",40);
write_uint32("in_data",50);
write_uint32("in_data",60);
write_uint32("in_data",70);
write_uint32("in_data",80);
write_uint32("in_data",90);
k=read_uint32("out_id");


fprintf(stdout,"sending 2nd id %d \n",k);
//write_uint32("in_id",0);
//fprintf(stdout,"sending 2nd id");
//write_uint32("in_id",1);

}

/*
void *rstruct_pipe_(void* fargs)
{int k=0,l=0;

//read_uint16("out_data");
//k=read_uint16("out_id");
//fprintf(stdout,"1st is %d \n",k);
//l=read_uint16("out_id");
//fprintf(stdout,"2nd is %d \n",l);


k=read_uint32("out_data");
fprintf(stdout,"1st is %d \n",k);

k=read_uint32("out_data");
fprintf(stdout,"1st is %d \n",k);

k=read_uint32("out_data");
fprintf(stdout,"1st is %d \n",k);

k=read_uint32("out_data");
fprintf(stdout,"1st is %d \n",k);

k=read_uint32("out_data");
fprintf(stdout,"1st is %d \n",k);

k=read_uint32("out_data");
fprintf(stdout,"1st is %d \n",k);


l=read_uint32("out_data");
fprintf(stdout,"1st is %d \n",l);

l=read_uint32("out_data");
fprintf(stdout,"1st is %d \n",l);

l=read_uint32("out_data");
fprintf(stdout,"1st is %d \n",l);

l=read_uint32("out_data");
fprintf(stdout,"1st is %d \n",l);

l=read_uint32("out_data");
fprintf(stdout,"1st is %d \n",l);

l=read_uint32("out_data");
fprintf(stdout,"1st is %d \n",l);

}

*/
void main()
{
 FILE* infile;
 FILE* outfile;
 char str[17];
pthread_t hard1_t, wstruct_t, rstruct_t;
//pthread_t hard2_t;

#ifdef SW

	init_pipe_handler();
	register_pipe("in_data",8,32,0);
  //      register_pipe("out_data",8,32,0);
//	register_pipe("in_id",8,32,0);
	register_pipe("out_id",8,32,0);        
//	pthread_create(&hard2_t,NULL,&hardware2_,NULL);
        pthread_create(&hard1_t,NULL,&hardware1_,NULL);
#endif


        pthread_create(&wstruct_t,NULL,&wstruct_pipe_,NULL);
  //      pthread_create(&rstruct_t,NULL,&rstruct_pipe_,NULL);


        pthread_join(wstruct_t,NULL);
    //    pthread_join(rstruct_t,NULL);



#ifdef SW
	pthread_cancel(hard1_t);
      //  pthread_cancel(hard2_t);
        close_pipe_handler();
#endif
}




