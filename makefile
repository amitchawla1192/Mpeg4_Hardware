include config.mak

vpath %.c $(SRCPATH)
vpath %.h $(SRCPATH)
vpath %.S $(SRCPATH)
vpath %.asm $(SRCPATH)
vpath %.rc $(SRCPATH)

GENERATED =

all:SW HW
default:
CFLAGS=-Wshadow -O3 -ffast-math -m32  -Wall -I. -I$(SRCPATH) -I/home/amit/ahirgit/ahir/release/CtestBench/include/ -std=gnu99 -fomit-frame-pointer -fno-tree-vectorize
LDFLAGS=-m32  -L/home/amit/ahirgit/ahir/release/iolib/lib  -lio -lpthread -lm -ldl
CLFLAGS = -c -O3 -std=gnu99 -I. -I$(SRCPATH) -I/home/amit/ahirgit/ahir/release/CtestBench/include/ -emit-llvm
SRCS = x264_hw.c
#SRCCLI = 
#SRCSO =
OBJS =
OBJSO =
#OBJCLI =
#OBJCHK = 
CONFIG := $(shell cat config.h)

ifneq ($(findstring HAVE_AHIR 1, $(CONFIG)),)
#SRCS +=  ./encoder/encoder.c
#SRCS += Hardware/sync/sync_sw.c
SRCS += common/mc.c common/predict.c common/pixel.c common/macroblock.c \
       common/frame.c common/dct.c common/cabac.c \
       common/common.c common/rectangle.c \
       common/quant.c common/deblock.c  common/vlc.c \
       common/mvpred.c common/bitstream.c \
       encoder/analyse.c encoder/me.c encoder/ratecontrol.c \
       encoder/macroblock.c encoder/cabac.c encoder/cavlc.c \
       encoder/encoder.c sync/sync_hw.c 

endif

ifeq ($(HAVE_OPENCL),yes)
#common/oclobj.h: common/opencl/x264-cl.h $(wildcard $(SRCPATH)/common/opencl/*.cl)
#	cat $^ | $(SRCPATH)/tools/cltostr.sh $@
GENERATED += common/oclobj.h
SRCS += common/opencl.c
endif

OBJS   += $(SRCS:%.c=%.o)
#OBJCLI += $(SRCCLI:%.c=%.o)
#OBJSO  += $(SRCSO:%.c=%.o)



AHIR_RELEASE=/home/amit/ahirgit/ahir/release/
SOCKETLIB_INCLUDE=$(AHIR_RELEASE)/CtestBench/include
SOCKETLIB_LIB=$(AHIR_RELEASE)/CtestBench/lib
PIPEHANDLER_INCLUDE=$(AHIR_RELEASE)/pipeHandler/include
PIPEHANDLER_LIB=$(AHIR_RELEASE)/pipeHandler/lib
PTHREADUTILS_INCLUDE=$(AHIR_RELEASE)/pthreadUtils/include
VHDL_LIB=$(AHIR_RELEASE)/vhdl
VHDL_VHPI_LIB=$(AHIR_RELEASE)/CtestBench/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/
#SRC=./src

#all: SW HW 
#TOAA:c2llvmbc llvmbc2aa  aalink
#TOVC:c2llvmbc llvmbc2aa  aalink aa2vc 
#VC2VHDL: vc2vhdl  vhdlsim
#AA2VHDLSIM: aa2vc  vc2vhdl  vhdlsim
#TOVHDL:TOVC vc2vhdl

# llvm2aa opts: pipelined case, extract-do-while.
LLVM2AAOPTS=--storageinit=true
#LLVM2AAOPTS=-extract_do_while=true --storageinit=true -pipedepths=pipedepths.txt

#program defs: no unrolling
#PROGDEFS=-DPIPELINE 
#PROGDEFS=-DPIPELINE -DALT
#PROGDEFS=-DUNROLL

#TOPMODULES=-T main

.PHONY: SW HW
# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: default x264$(EXE)

x264$(EXE): $(GENERATED) .depend $(LIBX264)
	@echo "Going"
	$(LD) x264_hw $(OBJCLI) $(CLI_LIBX264) $(LDFLAGSCLI) $(LDFLAGS) 2> linking_errors.txt

.depend: config.mak
	@rm -f .depend
	@echo 'dependency file generation.'
	@$(foreach SRC, $(addprefix $(SRCPATH)/, $(SRCS) $(SRCCLI) $(SRCSO)), $(CC) $(CFLAGS) $(SRC) $(DEPMT) $(SRC:$(SRCPATH)/%.c=%.o) $(DEPMM) 1>> .depend;)


$(LIBX264): $(GENERATED) .depend $(OBJS) $(OBJASM)
	rm -f $(LIBX264)
	$(AR)$@ $(OBJS) $(OBJASM)
	$(if $(RANLIB), $(RANLIB) $@)
	
HW: default c2llvmbc llvmbc2aa

#AA2VHDL: aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.

c2llvmbc: $(SRCS) config.mak
	@$(foreach SRC, $(addprefix $(SRCPATH)/, $(SRCS)),$(CLANG) $(CLFLAGS) -o $(SRC:%.c=%.o) $(SRC);)
	llvm-ld -link-as-library $(addprefix $(SRCPATH)/, $(OBJS)) -b x264.linked.o
	llvm-dis x264.linked.o
	opt --indvars --loopsimplify x264.linked.o -o x264.linked.opt.o

llvmbc2aa:  x264.linked.opt.o 
	llvm2aa $(LLVM2AAOPTS)  x264.linked.opt.o | vcFormat >  x264.aa

# Aa to vC
#aalink: prog.aa 
#	AaLinkExtMem prog.aa $(FUNCTIONLIB)/Aa/fpu.aa | vcFormat > prog.linked.aa
#	AaOpt -B prog.linked.aa | vcFormat > prog.linked.opt.aa

#aa2vc: prog.linked.opt.aa
#	Aa2VC -O -C prog.linked.opt.aa | vcFormat > prog.vc

# vC to VHDL
#vc2vhdl: prog.vc
#	vc2vhdl -O -S 4 -I 2 -v -a -C -e ahir_system -w -s ghdl $(TOPMODULES) -f prog.vc -L $(FUNCTIONLIB)/fpu.list
#	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
#	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
#	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
# vhdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl $(SRC)/testbench.c vhdlCStubs.h vhdlCStubs.c
# 	gcc -c vhdlCStubs.c  -I$(SRC) -I./ -I$(SOCKETLIB_INCLUDE)
# 	gcc -c $(SRC)/testbench.c -I$(PTHREADUTILS_INCLUDE) -I$(SRC) -I./ -I$(SOCKETLIB_INCLUDE)
# 	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLib -lpthread
# 	ghdl --clean
# 	ghdl --remove
# 	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
# 	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
# 	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
# 	ghdl -i --work=work ahir_system_global_package.vhdl
# 	ghdl -i --work=work ahir_system.vhdl
# 	ghdl -i --work=work ahir_system_test_bench.vhdl
# 	ghdl -m --work=work -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 
# 
# # build testbench and ghdl executable for post-synth sim.
# UNISIM=/home/madhav/ahirgit/ahir/vhdl/unisims/
# postsynthvhdlsim: ahir_system_synth.vhdl ahir_system_test_bench.vhdl $(SRC)/testbench.c vhdlCStubs.h vhdlCStubs.c
# 	gcc -c vhdlCStubs.c -I./ -I$(SOCKETLIB_INCLUDE)
# 	gcc -c $(SRC)/testbench.c -I$(PTHREADUTILS_INCLUDE) -I$(SRC) -I./ -I$(SOCKETLIB_INCLUDE)
# 	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLib -lpthread
# 	ghdl --clean
# 	ghdl --remove
# 	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
# 	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
# 	ghdl -i --work=ahir_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
# 	ghdl -i --work=work --ieee=synopsys -fexplicit -P$(UNISIM) ahir_system_global_package.vhdl
# 	ghdl -i --work=work --ieee=synopsys -fexplicit -P$(UNISIM) ahir_system_synth.vhdl
# 	ghdl -i --work=work ahir_system_test_bench.vhdl
# 	ghdl -m --work=work --ieee=synopsys -fexplicit -P$(UNISIM) -Wc,-g -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 
# 
# 
# clean:
# 	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst *.ngc *_xmsgs *.xrpt pipeHandler.log *.srp *.ghw
# 
# PHONY: all clean	
clean: default
	rm $(SRCS:%.c=%.o) *.o *~
