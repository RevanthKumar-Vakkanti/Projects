
UART Packetizer RTL Design
==========================

Overview
--------
This project implements a complete UART packetizing system in Verilog. It accepts parallel data input, buffers it using a synchronous FIFO, and transmits it serially using a UART transmitter at a specified baud rate. The design is modular and includes clock division, FIFO buffering, FSM-based data control, baud rate generation, and UART transmission.

Modules
-------

1. clk_div_by_4
   - Purpose: Divides the input clock frequency by 4.
   - Assumption: Input clock is 200 MHz → Output clock is 50 MHz.

2. sync_fifo
   - Purpose: FIFO for buffering data before transmission.
   - Parameters: data width = 8, depth = 16.
   - Generates fifo_full, fifo_empty, data_out_valid.

3. packetizer_fsm
   - FSM to manage FIFO reads and UART transmission.
   - States: IDLE, READ, SEND, WAIT.
   - Uses binary state encoding (as verified by synthesis tool).

4. baud_gen
   - Purpose: Generates ticks at the baud rate.
   - Parameters: CLK_FREQ = 50 MHz, BAUD_RATE = 9600.

5. uart_tx
   - UART Transmitter: Outputs serial data.
   - Sends: Start bit, 8 data bits, stop bit.

6. uart_packetizer_top
   - Integrates all components into a complete system.
   - Interfaces: data_in, data_valid, tx_ready, serial_out, tx_busy, fifo_full.

7. tb_uart_packetizer_top
   - Testbench for simulation.
   - Sends sample bytes and checks serial transmission.

Simulation Instructions
-----------------------
1. Use a Verilog simulator like ModelSim, or Vivado XSim.
2. Compile all source files and the testbench.
3. Run the simulation and check outputs or waveform.
4. Testbench sends: 0xA5, 0x4A, 0x94, 0x56.

FSM Encoding Report
-------------------
- The FSM in `packetizer_fsm` uses binary encoding.
- Improvement: Consider using one-hot encoding to improve FPGA performance.


Assumptions
-----------
- Input clock = 200 MHz.
- UART format: 8N1 (start, 8 data, stop).
- Data width = 8 bits, FIFO depth = 16.
- No external UART RX module is assumed.

Author Notes
------------
- Clean, modular, and original RTL code.
- No open-source code used.
- Optimized for clarity and ease of integration.
