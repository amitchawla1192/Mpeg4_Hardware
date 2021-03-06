SRCPATH=.
prefix=/usr/local
exec_prefix=${prefix}
bindir=${exec_prefix}/bin
libdir=${exec_prefix}/lib
includedir=${prefix}/include
ARCH=X86
SYS=LINUX
CC=gcc
COMPILER=GNU
COMPILER_STYLE=GNU
DEPMM=-MM -g0
DEPMT=-MT
LD=gcc -o 
LIBX264=libx264.a
AR=ar rc 
RANLIB=ranlib
STRIP=strip
INSTALL=install
AS=
ASFLAGS= -I. -I$(SRCPATH) -O2 -DARCH_X86_64=0 -I$(SRCPATH)/common/x86/ -f elf -DSTACK_ALIGNMENT=16 -DHIGH_BIT_DEPTH=0 -DBIT_DEPTH=8
RC=
RCFLAGS=
EXE=
HAVE_GETOPT_LONG=1
DEVNULL=/dev/null
PROF_GEN_CC=-fprofile-generate
PROF_GEN_LD=-fprofile-generate
PROF_USE_CC=-fprofile-use
PROF_USE_LD=-fprofile-use
HAVE_OPENCL=yes
default:
install:
LDFLAGSCLI = -ldl -lz 
CLI_LIBX264 = $(LIBX264)
CLANG = clang
