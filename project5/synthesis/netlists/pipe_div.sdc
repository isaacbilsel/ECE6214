###################################################################

# Created by write_sdc on Fri Feb 28 18:03:01 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_max_capacitance 0.5 [current_design]
set_max_transition 1.5 [current_design]
set_load -pin_load 0.2 [get_ports {quotient[15]}]
set_load -pin_load 0.2 [get_ports {quotient[14]}]
set_load -pin_load 0.2 [get_ports {quotient[13]}]
set_load -pin_load 0.2 [get_ports {quotient[12]}]
set_load -pin_load 0.2 [get_ports {quotient[11]}]
set_load -pin_load 0.2 [get_ports {quotient[10]}]
set_load -pin_load 0.2 [get_ports {quotient[9]}]
set_load -pin_load 0.2 [get_ports {quotient[8]}]
set_load -pin_load 0.2 [get_ports {quotient[7]}]
set_load -pin_load 0.2 [get_ports {quotient[6]}]
set_load -pin_load 0.2 [get_ports {quotient[5]}]
set_load -pin_load 0.2 [get_ports {quotient[4]}]
set_load -pin_load 0.2 [get_ports {quotient[3]}]
set_load -pin_load 0.2 [get_ports {quotient[2]}]
set_load -pin_load 0.2 [get_ports {quotient[1]}]
set_load -pin_load 0.2 [get_ports {quotient[0]}]
set_load -pin_load 0.2 [get_ports {remainder[7]}]
set_load -pin_load 0.2 [get_ports {remainder[6]}]
set_load -pin_load 0.2 [get_ports {remainder[5]}]
set_load -pin_load 0.2 [get_ports {remainder[4]}]
set_load -pin_load 0.2 [get_ports {remainder[3]}]
set_load -pin_load 0.2 [get_ports {remainder[2]}]
set_load -pin_load 0.2 [get_ports {remainder[1]}]
set_load -pin_load 0.2 [get_ports {remainder[0]}]
set_load -pin_load 0.2 [get_ports ready]
set_load -pin_load 0.2 [get_ports error]
set_max_fanout 1 [get_ports clk]
set_max_fanout 1 [get_ports rst_n]
set_max_fanout 1 [get_ports {dividend[15]}]
set_max_fanout 1 [get_ports {dividend[14]}]
set_max_fanout 1 [get_ports {dividend[13]}]
set_max_fanout 1 [get_ports {dividend[12]}]
set_max_fanout 1 [get_ports {dividend[11]}]
set_max_fanout 1 [get_ports {dividend[10]}]
set_max_fanout 1 [get_ports {dividend[9]}]
set_max_fanout 1 [get_ports {dividend[8]}]
set_max_fanout 1 [get_ports {dividend[7]}]
set_max_fanout 1 [get_ports {dividend[6]}]
set_max_fanout 1 [get_ports {dividend[5]}]
set_max_fanout 1 [get_ports {dividend[4]}]
set_max_fanout 1 [get_ports {dividend[3]}]
set_max_fanout 1 [get_ports {dividend[2]}]
set_max_fanout 1 [get_ports {dividend[1]}]
set_max_fanout 1 [get_ports {dividend[0]}]
set_max_fanout 1 [get_ports {divisor[7]}]
set_max_fanout 1 [get_ports {divisor[6]}]
set_max_fanout 1 [get_ports {divisor[5]}]
set_max_fanout 1 [get_ports {divisor[4]}]
set_max_fanout 1 [get_ports {divisor[3]}]
set_max_fanout 1 [get_ports {divisor[2]}]
set_max_fanout 1 [get_ports {divisor[1]}]
set_max_fanout 1 [get_ports {divisor[0]}]
create_clock [get_ports clk]  -period 10  -waveform {0 5}
set_clock_latency 1  [get_clocks clk]
set_clock_uncertainty -setup 0.7  [get_clocks clk]
set_clock_uncertainty -hold 0.5  [get_clocks clk]
set_clock_transition -max -rise 0.1 [get_clocks clk]
set_clock_transition -min -rise 0.1 [get_clocks clk]
set_clock_transition -max -fall 0.12 [get_clocks clk]
set_clock_transition -min -fall 0.12 [get_clocks clk]
create_clock -name v_clk  -period 10  -waveform {0 5}
set_input_delay -clock v_clk  1  [get_ports rst_n]
set_input_delay -clock v_clk  1  [get_ports {dividend[15]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[14]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[13]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[12]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[11]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[10]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[9]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[8]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[7]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[6]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[5]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[4]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[3]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[2]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[1]}]
set_input_delay -clock v_clk  1  [get_ports {dividend[0]}]
set_input_delay -clock v_clk  1  [get_ports {divisor[7]}]
set_input_delay -clock v_clk  1  [get_ports {divisor[6]}]
set_input_delay -clock v_clk  1  [get_ports {divisor[5]}]
set_input_delay -clock v_clk  1  [get_ports {divisor[4]}]
set_input_delay -clock v_clk  1  [get_ports {divisor[3]}]
set_input_delay -clock v_clk  1  [get_ports {divisor[2]}]
set_input_delay -clock v_clk  1  [get_ports {divisor[1]}]
set_input_delay -clock v_clk  1  [get_ports {divisor[0]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[15]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[14]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[13]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[12]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[11]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[10]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[9]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[8]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[7]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[6]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[5]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[4]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[3]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[2]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[1]}]
set_output_delay -clock v_clk  1  [get_ports {quotient[0]}]
set_output_delay -clock v_clk  1  [get_ports {remainder[7]}]
set_output_delay -clock v_clk  1  [get_ports {remainder[6]}]
set_output_delay -clock v_clk  1  [get_ports {remainder[5]}]
set_output_delay -clock v_clk  1  [get_ports {remainder[4]}]
set_output_delay -clock v_clk  1  [get_ports {remainder[3]}]
set_output_delay -clock v_clk  1  [get_ports {remainder[2]}]
set_output_delay -clock v_clk  1  [get_ports {remainder[1]}]
set_output_delay -clock v_clk  1  [get_ports {remainder[0]}]
set_output_delay -clock v_clk  1  [get_ports ready]
set_output_delay -clock v_clk  1  [get_ports error]
set_input_transition -max -rise 0.1  [get_ports clk]
set_input_transition -max -fall 0.12  [get_ports clk]
set_input_transition -min -rise 0.1  [get_ports clk]
set_input_transition -min -fall 0.12  [get_ports clk]
set_input_transition -max -rise 0.1  [get_ports rst_n]
set_input_transition -max -fall 0.12  [get_ports rst_n]
set_input_transition -min -rise 0.1  [get_ports rst_n]
set_input_transition -min -fall 0.12  [get_ports rst_n]
set_input_transition -max -rise 0.1  [get_ports {dividend[15]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[15]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[15]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[15]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[14]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[14]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[14]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[14]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[13]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[13]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[13]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[13]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[12]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[12]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[12]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[12]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[11]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[11]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[11]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[11]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[10]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[10]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[10]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[10]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[9]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[9]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[9]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[9]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[8]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[8]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[8]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[8]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[7]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[7]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[7]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[7]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[6]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[6]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[6]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[6]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[5]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[5]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[5]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[5]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[4]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[4]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[4]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[4]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[3]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[3]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[3]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[3]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[2]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[2]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[2]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[2]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[1]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[1]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[1]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[1]}]
set_input_transition -max -rise 0.1  [get_ports {dividend[0]}]
set_input_transition -max -fall 0.12  [get_ports {dividend[0]}]
set_input_transition -min -rise 0.1  [get_ports {dividend[0]}]
set_input_transition -min -fall 0.12  [get_ports {dividend[0]}]
set_input_transition -max -rise 0.1  [get_ports {divisor[7]}]
set_input_transition -max -fall 0.12  [get_ports {divisor[7]}]
set_input_transition -min -rise 0.1  [get_ports {divisor[7]}]
set_input_transition -min -fall 0.12  [get_ports {divisor[7]}]
set_input_transition -max -rise 0.1  [get_ports {divisor[6]}]
set_input_transition -max -fall 0.12  [get_ports {divisor[6]}]
set_input_transition -min -rise 0.1  [get_ports {divisor[6]}]
set_input_transition -min -fall 0.12  [get_ports {divisor[6]}]
set_input_transition -max -rise 0.1  [get_ports {divisor[5]}]
set_input_transition -max -fall 0.12  [get_ports {divisor[5]}]
set_input_transition -min -rise 0.1  [get_ports {divisor[5]}]
set_input_transition -min -fall 0.12  [get_ports {divisor[5]}]
set_input_transition -max -rise 0.1  [get_ports {divisor[4]}]
set_input_transition -max -fall 0.12  [get_ports {divisor[4]}]
set_input_transition -min -rise 0.1  [get_ports {divisor[4]}]
set_input_transition -min -fall 0.12  [get_ports {divisor[4]}]
set_input_transition -max -rise 0.1  [get_ports {divisor[3]}]
set_input_transition -max -fall 0.12  [get_ports {divisor[3]}]
set_input_transition -min -rise 0.1  [get_ports {divisor[3]}]
set_input_transition -min -fall 0.12  [get_ports {divisor[3]}]
set_input_transition -max -rise 0.1  [get_ports {divisor[2]}]
set_input_transition -max -fall 0.12  [get_ports {divisor[2]}]
set_input_transition -min -rise 0.1  [get_ports {divisor[2]}]
set_input_transition -min -fall 0.12  [get_ports {divisor[2]}]
set_input_transition -max -rise 0.1  [get_ports {divisor[1]}]
set_input_transition -max -fall 0.12  [get_ports {divisor[1]}]
set_input_transition -min -rise 0.1  [get_ports {divisor[1]}]
set_input_transition -min -fall 0.12  [get_ports {divisor[1]}]
set_input_transition -max -rise 0.1  [get_ports {divisor[0]}]
set_input_transition -max -fall 0.12  [get_ports {divisor[0]}]
set_input_transition -min -rise 0.1  [get_ports {divisor[0]}]
set_input_transition -min -fall 0.12  [get_ports {divisor[0]}]
