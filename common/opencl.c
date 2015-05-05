/*****************************************************************************
 * opencl.c: OpenCL initialization and kernel compilation
 *****************************************************************************
 * Copyright (C) 2012-2014 x264 project
 *
 * Authors: Steve Borho <sborho@multicorewareinc.com>
 *          Anton Mitrofanov <BugMaster@narod.ru>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111, USA.
 *
 * This program is also available under a commercial proprietary license.
 * For more information, contact us at licensing@x264.com.
 *****************************************************************************/

#include "common.h"

#ifdef _WIN32
#else
#include <dlfcn.h> //dlopen, dlsym, dlclose
#if SYS_MACOSX
#else
#define ocl_open dlopen( "libOpenCL.so", RTLD_NOW )
#endif
#define ocl_close dlclose
#define ocl_address dlsym
#endif



/* define from recent cl_ext.h, copied here in case headers are old */
#define CL_DEVICE_SIMD_INSTRUCTION_WIDTH_AMD        0x4042

/* Requires full include path in case of out-of-tree builds */
#include "common/oclobj.h"

static int x264_detect_switchable_graphics( void );

/* Try to load the cached compiled program binary, verify the device context is
 * still valid before reuse */

/* Save the compiled program binary to a file for later reuse.  Device context
 * is also saved in the cache file so we do not reuse stale binaries */
/* The OpenCL source under common/opencl will be merged into common/oclobj.h by
 * the Makefile. It defines a x264_opencl_source byte array which we will pass
 * to clCreateProgramWithSource().  We also attempt to use a cache file for the
 * compiled binary, stored in the current working folder. */





/* OpenCL misbehaves on hybrid laptops with Intel iGPU and AMD dGPU, so
 * we consult AMD's ADL interface to detect this situation and disable
 * OpenCL on these machines (Linux and Windows) */
#ifdef _WIN32
#define ADL_API_CALL
#define ADL_CALLBACK __stdcall
#define adl_close FreeLibrary
#define adl_address GetProcAddress
#else
#define ADL_API_CALL
#define ADL_CALLBACK
#define adl_close dlclose
#define adl_address dlsym
#endif

typedef void* ( ADL_CALLBACK *ADL_MAIN_MALLOC_CALLBACK )( int );
typedef int   ( ADL_API_CALL *ADL_MAIN_CONTROL_CREATE )( ADL_MAIN_MALLOC_CALLBACK, int );
typedef int   ( ADL_API_CALL *ADL_ADAPTER_NUMBEROFADAPTERS_GET )( int * );
typedef int   ( ADL_API_CALL *ADL_POWERXPRESS_SCHEME_GET )( int, int *, int *, int * );
typedef int   ( ADL_API_CALL *ADL_MAIN_CONTROL_DESTROY )( void );

#define ADL_OK 0
#define ADL_PX_SCHEME_DYNAMIC 2
/*
static void* ADL_CALLBACK adl_malloc_wrapper( int iSize )
{
    return x264_malloc( iSize );
}
*/

