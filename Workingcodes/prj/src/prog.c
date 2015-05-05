#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
//#include <fpu.h>
#include "prog.h"
//#include <pthread.h>
//#include <pthreadUtils.h>


typedef struct _Job
{
        uint32_t valid;
	uint32_t dimension;
        uint32_t row_id;
        uint32_t col_id;
        uint32_t a;
        uint32_t b;
        uint32_t result;
} Job;
Job job[20];

void hardware1()
{uint32_t i=0;
job[0].valid=0;
job[1].valid=0;
while(1)
{

job[i].dimension = read_uint32("in_data");
job[i].row_id = read_uint32("in_data");
job[i].col_id=read_uint32("in_data");
job[i].a = read_uint32("in_data");
job[i].b = read_uint32("in_data");
job[i].result = read_uint32("in_data");
job[i].valid = 1;
i++;
write_uint32("out_id",i);

}

}
/*
void hardware2()
{uint32_t i=0;
while(1)
{
i=read_uint32("in_id");
if(job[i].valid)
{

write_uint32("out_data",job[i].dimension);
write_uint32("out_data",job[i].row_id);
write_uint32("out_data",job[i].col_id);
write_uint32("out_data",job[i].a);
write_uint32("out_data",job[i].b);
write_uint32("out_data",job[i].result);
}

}

}

*/
//DEFINE_THREAD(hardware1);
//DEFINE_THREAD(hardware2);

//void hardware()
//{
//PTHREAD_DECL(hardware1);
//PTHREAD_DECL(hardware2);

//PTHREAD_CREATE(hardware1);
//PTHREAD_CREATE(hardwar:e2);

//PTHREAD_JOIN(hardware1);
//PTHREAD_JOIN(hardware2);
//PTHREAD_CANCEL(hardware1);
//PTHREAD_CANCEL(hardware2);
//}








