create_clock -name clk -period 5.000 [get_ports clk]
set_property PACKAGE_PIN H19 [get_ports clk]
set_property IOSTANDARD DIFF_SSTL15_DCI [get_ports clk]


set_property PACKAGE_PIN AV35 [get_ports rst]
set_property IOSTANDARD LVCMOS18 [get_ports rst]

set_property PACKAGE_PIN AU36 [get_ports serial_out]
set_property IOSTANDARD LVCMOS18 [get_ports serial_out]

set_property PACKAGE_PIN AV30  [get_ports {data_in[0]}]
set_property PACKAGE_PIN AY33  [get_ports {data_in[1]}]
set_property PACKAGE_PIN BA31  [get_ports {data_in[2]}]
set_property PACKAGE_PIN BA32  [get_ports {data_in[3]}]
set_property PACKAGE_PIN AW30  [get_ports {data_in[4]}]
set_property PACKAGE_PIN AY30  [get_ports {data_in[5]}]
set_property PACKAGE_PIN BA30  [get_ports {data_in[6]}]
set_property PACKAGE_PIN BB31  [get_ports {data_in[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {data_in[*]}]

set_property PACKAGE_PIN AR40 [get_ports data_valid]
set_property IOSTANDARD LVCMOS18 [get_ports data_valid]

set_property PACKAGE_PIN AU38 [get_ports tx_ready]
set_property IOSTANDARD LVCMOS18 [get_ports tx_ready]

set_property PACKAGE_PIN AM39 [get_ports fifo_full]
set_property IOSTANDARD LVCMOS18 [get_ports fifo_full]

set_property PACKAGE_PIN AN39 [get_ports tx_busy]
set_property IOSTANDARD LVCMOS18 [get_ports tx_busy]

set_false_path -from [get_ports rst] -to [all_registers]

set_input_delay 2.0 -clock [get_clocks clk] [get_ports data_in*]
set_input_delay 2.0 -clock [get_clocks clk] [get_ports data_valid]
set_output_delay 2.0 -clock [get_clocks clk] [get_ports serial_out]


set_property CONFIG_MODE BPI16 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]