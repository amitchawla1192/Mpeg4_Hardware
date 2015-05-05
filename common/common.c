// This file is completely checked for Hardware
/*****************************************************************************
 * common.c: misc common functions
 *****************************************************************************
 * Copyright (C) 2003-2014 x264 project
 *
 * Authors: Loren Merritt <lorenm@u.washington.edu>
 *          Laurent Aimar <fenrir@via.ecp.fr>
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

#include <stdarg.h>
#include <ctype.h>

#if HAVE_MALLOC_H
#include <malloc.h>
#endif
#if HAVE_THP
#include <sys/mman.h>
#endif

const int x264_bit_depth = BIT_DEPTH;

const int x264_chroma_format = X264_CHROMA_FORMAT;

static void x264_log_default( void *, int, const char *, va_list );





/****************************************************************************
 * x264_log:
 ****************************************************************************/
/*
void x264_log( x264_t *h, int i_level, const char *psz_fmt)// required by many in hardware
{
    if( !h || i_level <= h->param.i_log_level )
    {
        va_list arg;
        va_start( arg, psz_fmt );
        if( !h )
            x264_log_default( NULL, i_level, psz_fmt, arg );
        else
            h->param.pf_log( h->param.p_log_private, i_level, psz_fmt, arg );
        va_end( arg );
    }
}

static void x264_log_default( void *p_unused, int i_level, const char *psz_fmt va_list arg )// required by many places in hardware
{
    char *psz_prefix;
    switch( i_level )
    {
        case X264_LOG_ERROR:
            psz_prefix = "error";
            break;
        case X264_LOG_WARNING:
            psz_prefix = "warning";
            break;
        case X264_LOG_INFO:
            psz_prefix = "info";
            break;
        case X264_LOG_DEBUG:
            psz_prefix = "debug";
            break;
        default:
            psz_prefix = "unknown";
            break;
    }
   // fprintf( stderr, "x264 [%s]: ", psz_prefix );
   // x264_vfprintf( stderr, psz_fmt, arg );// it will be replaced by vfprintf from osdep.h
}
*/
/*
****************************************************************************
 * x264_malloc:
 ****************************************************************************/
/*
void *x264_malloc( int i_size )//// For now it is in encoder.c but to be removed
{
    uint8_t *align_buf = NULL;
#if HAVE_MALLOC_H
#if HAVE_THP
#define HUGE_PAGE_SIZE 2*1024*1024
#define HUGE_PAGE_THRESHOLD HUGE_PAGE_SIZE*7/8  FIXME: Is this optimal? 
     Attempt to allocate huge pages to reduce TLB misses. 
    if( i_size >= HUGE_PAGE_THRESHOLD )
    {
        align_buf = memalign( HUGE_PAGE_SIZE, i_size );
        if( align_buf )
        {
             Round up to the next huge page boundary if we are close enough. 
            size_t madv_size = (i_size + HUGE_PAGE_SIZE - HUGE_PAGE_THRESHOLD) & ~(HUGE_PAGE_SIZE-1);
            madvise( align_buf, madv_size, MADV_HUGEPAGE );
        }
    }
    else
#undef HUGE_PAGE_SIZE
#undef HUGE_PAGE_THRESHOLD
#endif
        align_buf = memalign( NATIVE_ALIGN, i_size );
#else
    uint8_t *buf = malloc( i_size + (NATIVE_ALIGN-1) + sizeof(void **) );
    if( buf )
    {
        align_buf = buf + (NATIVE_ALIGN-1) + sizeof(void **);
        align_buf -= (intptr_t) align_buf & (NATIVE_ALIGN-1);
        *( (void **) ( align_buf - sizeof(void **) ) ) = buf;
    }
#endif
    if( !align_buf )
        x264_log( NULL, X264_LOG_ERROR, "malloc of size %d failed\n", i_size );
    return align_buf;
}
*/
/****************************************************************************
 * x264_free:
 ****************************************************************************/
/*void x264_free( void *p )/// Needs to be taken care because malloc is not possible in Hardware
{
    if( p )
    {
#if HAVE_MALLOC_H
        free( p );
#else
        free( *( ( ( void **) p ) - 1 ) );
#endif
    }
}
*/
