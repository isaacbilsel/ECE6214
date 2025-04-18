###################################################################

# Created by write_sdc on Fri Apr  4 18:58:13 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_max_capacitance 0.5 [current_design]
set_max_transition 1.5 [current_design]
set_load -pin_load 0.2 [get_ports {data_out[11]}]
set_load -pin_load 0.2 [get_ports {data_out[10]}]
set_load -pin_load 0.2 [get_ports {data_out[9]}]
set_load -pin_load 0.2 [get_ports {data_out[8]}]
set_load -pin_load 0.2 [get_ports {data_out[7]}]
set_load -pin_load 0.2 [get_ports {data_out[6]}]
set_load -pin_load 0.2 [get_ports {data_out[5]}]
set_load -pin_load 0.2 [get_ports {data_out[4]}]
set_load -pin_load 0.2 [get_ports {data_out[3]}]
set_load -pin_load 0.2 [get_ports {data_out[2]}]
set_load -pin_load 0.2 [get_ports {data_out[1]}]
set_load -pin_load 0.2 [get_ports {data_out[0]}]
set_load -pin_load 0.2 [get_ports data_out_valid]
set_max_fanout 1 [get_ports clk]
set_max_fanout 1 [get_ports rst_n]
set_max_fanout 1 [get_ports {sample_rate[3]}]
set_max_fanout 1 [get_ports {sample_rate[2]}]
set_max_fanout 1 [get_ports {sample_rate[1]}]
set_max_fanout 1 [get_ports {sample_rate[0]}]
set_max_fanout 1 [get_ports {data_in[3]}]
set_max_fanout 1 [get_ports {data_in[2]}]
set_max_fanout 1 [get_ports {data_in[1]}]
set_max_fanout 1 [get_ports {data_in[0]}]
set_max_fanout 1 [get_ports coeff_write]
set_max_fanout 1 [get_ports {coeff_in[7]}]
set_max_fanout 1 [get_ports {coeff_in[6]}]
set_max_fanout 1 [get_ports {coeff_in[5]}]
set_max_fanout 1 [get_ports {coeff_in[4]}]
set_max_fanout 1 [get_ports {coeff_in[3]}]
set_max_fanout 1 [get_ports {coeff_in[2]}]
set_max_fanout 1 [get_ports {coeff_in[1]}]
set_max_fanout 1 [get_ports {coeff_in[0]}]
set_max_fanout 1 [get_ports {coeff_addr[6]}]
set_max_fanout 1 [get_ports {coeff_addr[5]}]
set_max_fanout 1 [get_ports {coeff_addr[4]}]
set_max_fanout 1 [get_ports {coeff_addr[3]}]
set_max_fanout 1 [get_ports {coeff_addr[2]}]
set_max_fanout 1 [get_ports {coeff_addr[1]}]
set_max_fanout 1 [get_ports {coeff_addr[0]}]
set_max_fanout 1 [get_ports new_symbol]
create_clock [get_ports clk]  -period 9  -waveform {0 4.5}
set_clock_latency 3  [get_clocks clk]
set_clock_uncertainty -setup 0.7  [get_clocks clk]
set_clock_uncertainty -hold 0.5  [get_clocks clk]
set_clock_transition -max -rise 0.1 [get_clocks clk]
set_clock_transition -min -rise 0.1 [get_clocks clk]
set_clock_transition -max -fall 0.12 [get_clocks clk]
set_clock_transition -min -fall 0.12 [get_clocks clk]
create_clock -name v_clk  -period 9  -waveform {0 4.5}
set_input_delay -clock v_clk  3.5  [get_ports rst_n]
set_input_delay -clock v_clk  3.5  [get_ports {sample_rate[3]}]
set_input_delay -clock v_clk  3.5  [get_ports {sample_rate[2]}]
set_input_delay -clock v_clk  3.5  [get_ports {sample_rate[1]}]
set_input_delay -clock v_clk  3.5  [get_ports {sample_rate[0]}]
set_input_delay -clock v_clk  3.5  [get_ports {data_in[3]}]
set_input_delay -clock v_clk  3.5  [get_ports {data_in[2]}]
set_input_delay -clock v_clk  3.5  [get_ports {data_in[1]}]
set_input_delay -clock v_clk  3.5  [get_ports {data_in[0]}]
set_input_delay -clock v_clk  3.5  [get_ports coeff_write]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_in[7]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_in[6]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_in[5]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_in[4]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_in[3]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_in[2]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_in[1]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_in[0]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_addr[6]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_addr[5]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_addr[4]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_addr[3]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_addr[2]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_addr[1]}]
set_input_delay -clock v_clk  3.5  [get_ports {coeff_addr[0]}]
set_input_delay -clock v_clk  3.5  [get_ports new_symbol]
set_output_delay -clock v_clk  1  [get_ports {data_out[11]}]
set_output_delay -clock v_clk  1  [get_ports {data_out[10]}]
set_output_delay -clock v_clk  1  [get_ports {data_out[9]}]
set_output_delay -clock v_clk  1  [get_ports {data_out[8]}]
set_output_delay -clock v_clk  1  [get_ports {data_out[7]}]
set_output_delay -clock v_clk  1  [get_ports {data_out[6]}]
set_output_delay -clock v_clk  1  [get_ports {data_out[5]}]
set_output_delay -clock v_clk  1  [get_ports {data_out[4]}]
set_output_delay -clock v_clk  1  [get_ports {data_out[3]}]
set_output_delay -clock v_clk  1  [get_ports {data_out[2]}]
set_output_delay -clock v_clk  1  [get_ports {data_out[1]}]
set_output_delay -clock v_clk  1  [get_ports {data_out[0]}]
set_output_delay -clock v_clk  1  [get_ports data_out_valid]
set_input_transition -max -rise 0.1  [get_ports clk]
set_input_transition -max -fall 0.12  [get_ports clk]
set_input_transition -min -rise 0.1  [get_ports clk]
set_input_transition -min -fall 0.12  [get_ports clk]
set_input_transition -max -rise 0.1  [get_ports rst_n]
set_input_transition -max -fall 0.12  [get_ports rst_n]
set_input_transition -min -rise 0.1  [get_ports rst_n]
set_input_transition -min -fall 0.12  [get_ports rst_n]
set_input_transition -max -rise 0.1  [get_ports {sample_rate[3]}]
set_input_transition -max -fall 0.12  [get_ports {sample_rate[3]}]
set_input_transition -min -rise 0.1  [get_ports {sample_rate[3]}]
set_input_transition -min -fall 0.12  [get_ports {sample_rate[3]}]
set_input_transition -max -rise 0.1  [get_ports {sample_rate[2]}]
set_input_transition -max -fall 0.12  [get_ports {sample_rate[2]}]
set_input_transition -min -rise 0.1  [get_ports {sample_rate[2]}]
set_input_transition -min -fall 0.12  [get_ports {sample_rate[2]}]
set_input_transition -max -rise 0.1  [get_ports {sample_rate[1]}]
set_input_transition -max -fall 0.12  [get_ports {sample_rate[1]}]
set_input_transition -min -rise 0.1  [get_ports {sample_rate[1]}]
set_input_transition -min -fall 0.12  [get_ports {sample_rate[1]}]
set_input_transition -max -rise 0.1  [get_ports {sample_rate[0]}]
set_input_transition -max -fall 0.12  [get_ports {sample_rate[0]}]
set_input_transition -min -rise 0.1  [get_ports {sample_rate[0]}]
set_input_transition -min -fall 0.12  [get_ports {sample_rate[0]}]
set_input_transition -max -rise 0.1  [get_ports {data_in[3]}]
set_input_transition -max -fall 0.12  [get_ports {data_in[3]}]
set_input_transition -min -rise 0.1  [get_ports {data_in[3]}]
set_input_transition -min -fall 0.12  [get_ports {data_in[3]}]
set_input_transition -max -rise 0.1  [get_ports {data_in[2]}]
set_input_transition -max -fall 0.12  [get_ports {data_in[2]}]
set_input_transition -min -rise 0.1  [get_ports {data_in[2]}]
set_input_transition -min -fall 0.12  [get_ports {data_in[2]}]
set_input_transition -max -rise 0.1  [get_ports {data_in[1]}]
set_input_transition -max -fall 0.12  [get_ports {data_in[1]}]
set_input_transition -min -rise 0.1  [get_ports {data_in[1]}]
set_input_transition -min -fall 0.12  [get_ports {data_in[1]}]
set_input_transition -max -rise 0.1  [get_ports {data_in[0]}]
set_input_transition -max -fall 0.12  [get_ports {data_in[0]}]
set_input_transition -min -rise 0.1  [get_ports {data_in[0]}]
set_input_transition -min -fall 0.12  [get_ports {data_in[0]}]
set_input_transition -max -rise 0.1  [get_ports coeff_write]
set_input_transition -max -fall 0.12  [get_ports coeff_write]
set_input_transition -min -rise 0.1  [get_ports coeff_write]
set_input_transition -min -fall 0.12  [get_ports coeff_write]
set_input_transition -max -rise 0.1  [get_ports {coeff_in[7]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_in[7]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_in[7]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_in[7]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_in[6]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_in[6]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_in[6]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_in[6]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_in[5]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_in[5]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_in[5]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_in[5]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_in[4]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_in[4]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_in[4]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_in[4]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_in[3]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_in[3]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_in[3]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_in[3]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_in[2]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_in[2]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_in[2]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_in[2]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_in[1]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_in[1]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_in[1]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_in[1]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_in[0]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_in[0]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_in[0]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_in[0]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_addr[6]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_addr[6]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_addr[6]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_addr[6]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_addr[5]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_addr[5]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_addr[5]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_addr[5]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_addr[4]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_addr[4]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_addr[4]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_addr[4]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_addr[3]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_addr[3]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_addr[3]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_addr[3]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_addr[2]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_addr[2]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_addr[2]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_addr[2]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_addr[1]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_addr[1]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_addr[1]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_addr[1]}]
set_input_transition -max -rise 0.1  [get_ports {coeff_addr[0]}]
set_input_transition -max -fall 0.12  [get_ports {coeff_addr[0]}]
set_input_transition -min -rise 0.1  [get_ports {coeff_addr[0]}]
set_input_transition -min -fall 0.12  [get_ports {coeff_addr[0]}]
set_input_transition -max -rise 0.1  [get_ports new_symbol]
set_input_transition -max -fall 0.12  [get_ports new_symbol]
set_input_transition -min -rise 0.1  [get_ports new_symbol]
set_input_transition -min -fall 0.12  [get_ports new_symbol]
