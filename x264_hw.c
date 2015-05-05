#include "common/common.h"
#include "sync/sync.h"
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

  x264_hardware();
  return 1;
}
