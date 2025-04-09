#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon Feb 17 22:24:53 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v18.10-p002_1 (64bit) 05/29/2018 19:19 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 18.10-p002_1 NR180522-1057/18_10-UB (database version 2.30, 418.7.1) {superthreading v1.46}
#@(#)CDS: AAE 18.10-p004 (64bit) 05/29/2018 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 18.10-p003_1 () May 15 2018 10:23:07 ( )
#@(#)CDS: SYNTECH 18.10-a012_1 () Apr 19 2018 01:27:21 ( )
#@(#)CDS: CPE v18.10-p005
#@(#)CDS: IQRC/TQRC 18.1.1-s118 (64bit) Fri Mar 23 17:23:45 PDT 2018 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
win
set init_verilog ../../synthesis/netlists/mult_ver.v
set init_top_cell mult_ver
set init_pwr_net VDD
set init_gnd_net GND
create_constraint_mode \
    -name syn_constraints \
    -sdc_files {../../synthesis/netlist/mult_ver.sdc}
set init_mmmc_file ../scripts/mmmc.tcl
set init_lef_file { /apps/design_kits/ibm_kits/IBM_IP/ibm_cmos8hp/std_cell/sc/v.20110613/lef/cmos8hp_7AM_tech.lef  /apps/design_kits/ibm_kits/IBM_IP/ibm_cmos8hp/std_cell/sc/v.20110613/lef/ibm_cmos8hp_sc.lef  }
init_design -setup VIEW_ss_125 -hold VIEW_ff_-55
set init_verilog ../../synthesis/netlist/mult_ver.v
set init_top_cell mult_ver
set init_pwr_net VDD
set init_gnd_net GND
create_constraint_mode \
    -name syn_constraints \
    -sdc_files {../../synthesis/netlist/mult_ver.sdc}
set init_mmmc_file ../scripts/mmmc.tcl
set init_lef_file { /apps/design_kits/ibm_kits/IBM_IP/ibm_cmos8hp/std_cell/sc/v.20110613/lef/cmos8hp_7AM_tech.lef  /apps/design_kits/ibm_kits/IBM_IP/ibm_cmos8hp/std_cell/sc/v.20110613/lef/ibm_cmos8hp_sc.lef  }
init_design -setup VIEW_ss_125 -hold VIEW_ff_-55
