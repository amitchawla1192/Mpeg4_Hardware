#define _ISOC99_SOURCE
#include <Pipes.h>
#include "common/frame.h"
char *x264_frame_hw_sync(x264_frame_t *frame)
{char *Buffer;
unsigned int size=0;

Buffer = malloc(sizeof(x264_frame_t)+ 177056);
memcpy(Buffer, frame, sizeof(x264_frame_t));
size+=sizeof(x264_frame_t);
memcpy(Buffer + size, frame->base, 177056);
return Buffer;
}

