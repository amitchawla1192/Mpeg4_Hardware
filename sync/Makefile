# build software version of testbench (to check the "desired behaviour")


Release=$(HOME)/ahir-master/release
SOCKETLIB_INCLUDE=$(Release)/CtestBench/include
SOCKETLIB_LIB=$(Release)/CtestBench/lib
PIPEHANDLER_INCLUDE=$(Release)/pipeHandler/include
PIPEHANDLER_LIB=$(Release)/pipeHandler/lib
PTHREADUTILS_INCLUDE=$(Release)/pthreadUtils/include
VHDL_LIB=$(Release)/vhdl
VHDL_VHPI_LIB=$(Release)/CtestBench/vhdl
FUNCTIONLIB=$(Release)/functionLibrary/
SRC=./



all: SW HW 
TOAA:c2llvmbc llvmbc2aa  aalink
TOVC:c2llvmbc llvmbc2aa  aalink aa2vc 
VC2VHDL: vc2vhdl  vhdlsim
AA2VHDLSIM: aa2vc  vc2vhdl  vhdlsim
TOVHDL:TOVC vc2vhdl

LLVM2AAOPTS=-extract_do_while=true --storageinit=true -pipedepths=pipedepths.txt

PROGDEFS=


# the top-level module.
TOPMODULES = -T x264_sw_sync_open

# compile with SW defined.
SW: sync_hw.c 
	gcc -g -c -DSW $(PROGDEFS) -I$(PIPEHANDLER_INCLUDE)  -I$(PTHREADUTILS_INCLUDE) sync_hw.c
#        gcc -g -c -DSW $(PROGDEFS) -I$(FUNCTIONLIB)/include -I$(SRC) $(FUNCTIONLIB)/src/timer.c
#	gcc -g -c -DSW $(PROGDEFS) -I$(PIPEHANDLER_INCLUDE) -I$(PTHREADUTILS_INCLUDE) $(SRC)/testbench.c
#	gcc -g -o testbench_sw prog.o testbench.o -L$(PIPEHANDLER_LIB) -lPipeHandler -lpthread -lrt





# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa aalink  aa2vc  vc2vhdl  vhdlsim

AA2VHDL: aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.
CLANGOPTS=-O3

c2llvmbc: sync_hw.c 
	clang $(CLANGOPTS) -I/usr/include/i386-linux-gnu -std=gnu89 $(PROGDEFS) -I$(SRC) -I$(PIPEHANDLER_INCLUDE) -I$(PTHREADUTILS_INCLUDE)  -I$(SOCKETLIB_INCLUDE) -I$(HOME)/x264-devel-master/Hardware/common -emit-llvm -c sync_hw.c
	opt --indvars --loopsimplify sync_hw.o -o prog.opt.o
	llvm-dis prog.opt.o
#llvm byte-code to Aa..
llvmbc2aa:  prog.opt.o 
	llvm2aa $(LLVM2AAOPTS) prog.opt.o | vcFormat >  prog.aa
aalink: prog.aa
	AaLinkExtMem -I 1 -E mempool prog.aa| vcFormat > prog.linked.aa
	AaOpt -B prog.linked.aa | vcFormat > prog.linked.opt.aa

# Aa to vC
aa2vc: prog.linked.opt.aa
	Aa2VC -I mempool -O -C prog.linked.opt.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -O -S 4 -I 2 -v -a -C -e ahir_system -w -s ghdl $(TOPMODULES) -f prog.vc 
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl $(SRC)/testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c  -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -c $(SRC)/testbench.c -I$(PTHREADUTILS_INCLUDE) -I$(SRC) -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLib -lpthread
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst *.ngc *_xmsgs *.xrpt pipeHandler.log *.srp *.ghw *.dot

PHONY: all clean	
