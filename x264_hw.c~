#include "common/common.h"
#include "sync/sync.h"
#include <pthread.h>
#include "common/dct_engine.c"
int main()
{
#if HAVE_AHIR
fprintf(stderr,"we have ahir yepp");
#else 
fprintf(stderr,"We dont have it");
#endif  
#if HAVE_THREAD
fprintf(stderr,"We have thread");
#endif
#if HAVE_DCT_WRAP
pthread_t dct_t;
fprintf(stderr,"we have dct_wrap \n");
pthread_create(&dct_t,NULL,dct_engine,NULL);
#endif
  x264_hardware();
#if HAVE_DCT_WRAP
pthread_join(dct_t,NULL);
#endif
  return 1;
}
