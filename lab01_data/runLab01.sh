#!/bin/bash

# clean terminal
clear

# load Synopsys VCS Compiler
load_vcs_vS-2021.09-SP2

# remove logs, bin files from previous simulation
echo -e "\t Deleting previous sim dump"
rm -rf csrc simv.daidir *.log simv *.h *.key
echo -e "\t Deleted previous sim dump \n\n"

# compile UVM testbench
vcs \
+define+VCS +libext+.v+.sv -debug_access+all \
-full64 -timescale=1ns/100fs -sverilog \
-error=noMPD -l compilation.log -ntb_opts uvm-1.2 \
+incdir+./sv +incdir+./tb \
./sv/yapp_pkg.sv \
./tb/top.sv

# simulate UVM testbench
./simv


