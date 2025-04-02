################################
## Layout scripts for Innovus 18.1
## Professor Matthew LaRue
## rev 1
## 3/28/2024
################################

###########################
## Initialize Design
###########################

set DESIGN "fir_filter"

# load verilog netlist from synthesis
set design_netlisttype verilog
set init_verilog [list ../../synthesis/netlists/${DESIGN}_syn.v]
set init_design_set_top 1
set init_top_cell ${DESIGN}

# init power net names
set init_pwr_net {VDD}
set init_gnd_net {GND}

# init MMMC
set init_mmmc_file ../scripts/mmmc_${DESIGN}.tcl

# read in LEF files
set init_lef_file {\
/apps/design_kits/ibm_kits/IBM_IP/ibm_cmos8hp/std_cell/sc/v.20110613/lef/cmos8hp_7AM_tech.lef \
/apps/design_kits/ibm_kits/IBM_IP/ibm_cmos8hp/std_cell/sc/v.20110613/lef/ibm_cmos8hp_sc.lef \
}

## Initialize Design
init_design \
    -setup {VIEW_ss_125} \
    -hold {VIEW_ff_-55}

## Save design
saveDesign saves/${DESIGN}_init_design.enc
#restoreDesign saves/${DESIGN}_init_design.enc.dat #{DESIGN}

###########################
## Floorplan
###########################

# Step 1: adjust the core size for the layout. Floorplan -> Specify Floorplan
#     use whatever W/H ration you would like, but set the Core Utilization to 0.25
#     Add margins of 15um to all sides of the core

# Step 2: add power rings to the design. Power -> Power Planning -> Add Ring
#     for nets, select VDD and GND
#     for configuration, place the rings on metal 4/5 depending on the orientation of the route (metal 5 is horizonatal, metal 4 is vertical)
#     set the width to 5um

# Step 3: add a vertical power stripe to the center of the design. Power -> Power Planning -> add Stripe
#     for nets, select VDD and GND
#     The stripe should be vertical and on layer 4
#     Set width to 5
#     Adjust the First/Last Strip values to the stripe is in the center of the core 

# Step 4: route power from the rings/stripes to the standard cell rows
#      Route -> Special Route
#      Nets are VDD and GND
#      Under Via Generation tab, select Make Via Connections to Core Ring and Stripe
#      Once you do sroute, zoom in on layout and make sure the vias were added

# Step 5: Place the pins
#      Edit -> Pin Editor
#      Select all the pins from the list in the lower left
#      Set pin later to M2, and Width/Depth to 0.5
#      For location, set "Spread" and then on the top of window, the Side/Edge field should become valid. Set value to "Top"
#      For Position, select a starting X point to 20um so the pins start to the right of the power rings


setEndCapMode \
    -cells NWSX \
    -leftEdge NWSX \
    -rightEdge NWSX

addEndCap -prefix ENDCAP

#deleteFiller -prefix ENDCAP

addWellTap \
    -cell NWSX \
    -prefix WELLTAP \
    -cellInterval 30.0 \
    -skipRow 1 \
    -inRowOffset 15

addWellTap \
    -cell NWSX \
    -prefix WELLTAP \
    -cellInterval 30.0 \
    -skipRow 1 \
    -startRowNum 2 \
    -inRowOffset 30.0

#deleteFiller -prefix WELLTAP

saveFPlan ../floorplan/${DESIGN}_floorplan.fp
#loadFPlan ../floorplan/${DESIGN}_floorplan.fp

saveDesign saves/${DESIGN}_floorplan.enc
#restoreDesign saves/${DESIGN}_floorplan.enc.dat #{DESIGN}

###########################
## Place Design
###########################

setDesignMode \
    -process 130

setPlaceMode \
    -congEffort auto \
    -timingDriven true \
    -ignoreScan true

placeDesign
setDrawView place

saveDesign saves/${DESIGN}_place.enc
#restoreDesign saves/${DESIGN}_place.enc.dat #{DESIGN}

##########################
## Pre-CTS Timing
##########################

setAnalysisMode \
    -analysisType onChipVariation \
    -skew true \
    -clockPropagation sdcControl

timeDesign \
    -preCTS \
    -idealClock \
    -numPaths 50 \
    -prefix preCTS \
    -outDIR ${DESIGN}_reports/preCTS

setOptMode \
    -yieldEffort none \
    -effort high \
    -maxDensity 0.95 \
    -fixDRC true \
    -fixFanoutLoad true \
    -optimizeFF true \
    -simplifyNetlist false \
    -holdTargetSlack 0.0 \
    -setupTargetSlack 0.0 \
    -usefulSkew false

optDesign \
    -preCTS \
    -drv \
    -outDir ${DESIGN}_reports/preCTS_opt_timing

####################
## Clock tree synthesis
####################

create_ccopt_clock_tree_spec -file ${DESIGN}.ctstch

set_ccopt_property buffer_cells {CLK_I CLK_K CLK_M CLK_O CLK_Q} 
set_ccopt_property inverter_cells {CLKI_I CLKI_K CLKI_M CLKI_O CLKI_Q}
    

#set_ccopt_mode 

## create clock tree
ccopt_design \
    -prefix CTS \
    -outDir ${DESIGN}_reports/CTS

## Step 6: Inspect clock tree
#          Clock -> Clock tree debugger
#          Does the clock tree look good?


##########################
## Post-CTS Timing
##########################

optDesign \
    -postCTS \
    -hold \
    -outDir ${DESIGN}_reports/postCTS_opt_timing

timeDesign \
    -postCTS \
    -numPaths 50 \
    -prefix postCTS \
    -outDIR ${DESIGN}_reports/postCTS

timeDesign \
    -postCTS \
    -hold \
    -numPaths 50 \
    -prefix postCTS_hold \
    -outDIR ${DESIGN}_reports/postCTS_hold

saveDesign saves/${DESIGN}_cts.enc
#restoreDesign saves/${DESIGN}_cts.enc.dat #{DESIGN}

#####################
## Route Design
#####################

routeDesign

optDesign \
    -postRoute \
    -outDir ${DESIGN}_reports/postRoute

optDesign \
    -postRoute \
    -hold \
    -outDir ${DESIGN}_reports/postRoute_hold

#timeDesign \
#    -postCTS \
#    -numPaths 50 \
#    -prefix postRoute \
#    -outDIR ${DESIGN}_reports/postRoute

#timeDesign \
#    -postCTS \
#    -hold \
#    -numPaths 50 \
#    -prefix postRoute_hold \
#    -outDIR ${DESIGN}_reports/postRoute_hold

set decapCells {DECAP_C}

addDeCapCellCandidates DECAP_C 7.775

addDeCap \
    -totCap 1000 \
    -addFixAttr \
    -prefix DECAP \
    -cells ${decapCells}


set fillerCells {FILL1 FILL2}

## filler
setFillerMode \
    -corePrefix FILLER \
    -core ${fillerCells}

addFiller \
    -cell ${fillerCells} \
    -prefix FILLER \
    -markFixed

## Step 7. Connect VDD/GND pins on cells
#        Power -> Connect Global Net
#        Under Connect, select Pin and set Pin Name to VDD
#        Under Scope, select Apply All
#        To Global Net -> VDD
#        Select Override prior connection and Verbose Output and then Add to List
#        Repeat above procedure but do it for net GND
#        Once done, hit apply. It should report connections in command window

verify_connectivity
verify_drc

## final timing report

timeDesign \
    -postRoute \
    -numPaths 50 \
    -prefix final \
    -outDIR ${DESIGN}_reports/final

timeDesign \
    -postRoute \
    -hold \
    -numPaths 50 \
    -prefix final_hold \
    -outDIR ${DESIGN}_reports/final

###############################
## design export
###############################

extractRC 
rcOut -spef ../netlists/${DESIGN}.spef
write_sdf   ../netlists/${DESIGN}.sdf
saveNetlist ../netlists/${DESIGN}_phys.v

saveDesign saves/${DESIGN}_final.enc
#restoreDesign saves/${DESIGN}_final.enc.dat #{DESIGN}





