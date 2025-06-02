`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2025 09:39:41
// Design Name: revanth kumar vakkanti
// Module Name: uart_packetizer
// Project Name: UART Packetizer with FSM and FIFO Integration
// Target Devices: Virtex 7 VC709 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



// frequency divided by 4 (200MHZ => 50MHz)
module clk_div_by_4 (
    input clk_in,       
    input rst,
    output reg clk_out 
);
    reg [1:0] count;

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            count <= 0;
            clk_out <= 0;
        end else begin
            count <= count + 1;
            if (count == 2) begin
                clk_out <= ~clk_out;
                count <= 0;
            end
        end
    end
endmodule


// Synchronous FIFO
module sync_fifo #(
    parameter data = 8,
    parameter addr = 4,
    parameter depth = 16
)(
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [data-1:0] din,
    output reg [data-1:0] dout = 0,
    output reg fifo_full = 0,
    output reg fifo_empty = 0,
    output reg data_out_valid = 0
);
    reg [data-1:0] mem [0:depth-1];
    reg [addr-1:0] wr_ptr = 0;
    reg [addr-1:0] rd_ptr = 0;

    always @(posedge clk) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            
            fifo_full <= 0;
            fifo_empty <= 1;
            data_out_valid <= 0;
            dout <= 0;
        end else begin
            data_out_valid <= 0;

            if (wr_en && !fifo_full) begin
                mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
            end

            if (rd_en && !fifo_empty) begin
                dout <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                data_out_valid <= 1;
                
            end
            
            fifo_full  <= (rd_ptr == (wr_ptr + 1));
            fifo_empty <= (rd_ptr == wr_ptr);
        end
    end
    
//      initial begin
//              $monitor("Time = %0t | RST = %b | WrEn =  %b | RdEn = %b | Din = %h | Dout = %h | Valid = %b | Full = %b | Empty = %b", $time, rst, wr_en, rd_en, din, dout, data_out_valid, fifo_full, fifo_empty);
//          end 

endmodule

// FSM
module packetizer_fsm(
    input clk,
    input rst,
    input fifo_empty,
    input fifo_data_valid,
    input [7:0] fifo_data_out,
    input tx_ready,
    input tx_busy,
    output reg fifo_rd_en,
    output reg start_tx,
    output reg [7:0] uart_data
);

    parameter IDLE = 2'b00,
              READ = 2'b01,
              SEND = 2'b10,
              WAIT = 2'b11;

    reg [1:0] state;
    

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            fifo_rd_en <= 0;
            start_tx <= 0;
            uart_data <= 0;
        end else begin
            fifo_rd_en <= 0;
            start_tx <= 0;

            case (state)
                IDLE: begin
                    if (!fifo_empty && tx_ready)
                        state <= READ;
                end

                READ: begin
                   #20 fifo_rd_en <= 1;
                    if (fifo_data_valid) begin
                        uart_data <= fifo_data_out;
                        state <= SEND;
                    end
                end

                SEND: begin
                    start_tx <= 1; 
                    state <= WAIT;
                end

                WAIT: begin
                    if (!tx_busy)
                        state <= IDLE;
                end
            endcase
        end
    end
    initial begin
        $monitor("time = %t | start_tx = %b ", $time, start_tx);
      end
endmodule


// BAUD RATE 
module baud_gen #(
    parameter CLK_FREQ = 50000000,
    parameter BAUD_RATE = 9600
)(
    input clk,
    input rst,
    output reg baud_tick
);
    localparam BAUD_TICK_CNT = CLK_FREQ / BAUD_RATE;
    reg [15:0] cnt;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt <= 0;
            baud_tick <= 0;
        end else begin
            if (cnt == BAUD_TICK_CNT - 1) begin
                cnt <= 0;
                baud_tick <= 1;
            end else begin
                cnt <= cnt + 1;
                baud_tick <= 0;
            end
        end
    end
   
endmodule


//UART TRANSMITTER
module uart_tx #(
    parameter DATA_WIDTH = 8
)(
    input clk,
    input rst,
    input start_tx,
    input baud_tick,
    input [DATA_WIDTH-1:0] data_in,
    output reg serial_out,
    output reg tx_busy
);

    localparam IDLE  = 2'b00,
               START = 2'b01,
               DATA  = 2'b10,
               STOP  = 2'b11;

    reg [1:0] state;
    reg [3:0] bit_cnt;
    reg [DATA_WIDTH-1:0] tx_data;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            serial_out <= 1;
            tx_busy <= 0;
            bit_cnt <= 0;
            tx_data <= 0;
        end else begin
            case (state)
                IDLE: begin
                    serial_out <= 1;
                    tx_busy <= 0;
                    if (start_tx) begin
                        tx_data <= data_in;
                        state <= START;
                        tx_busy <= 1;
                    end
                end

                START: if (baud_tick) begin
                    serial_out <= 0;
                    state <= DATA;
                    bit_cnt <= 0;
                end

                DATA: if (baud_tick) begin
                    serial_out <= tx_data[bit_cnt];
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == DATA_WIDTH - 1)
                        state <= STOP;
                end

                STOP: if (baud_tick) begin
                    serial_out <= 1;
                    state <= IDLE;
                    tx_busy <= 0;
                end
            endcase
        end
    end
endmodule



//TOP MODULE
module uart_packetizer_top #(
    parameter CLK_FREQ = 50000000,
    parameter BAUD_RATE = 9600
)(
    input clk,              
    input rst,
    input [7:0] data_in,
    input data_valid,
    input tx_ready,
    output serial_out,
    output fifo_full,
    output tx_busy
);

    wire clk_50mhz;

    clk_div_by_4 clk_div_inst (
        .clk_in(clk),       
        .rst(rst),
        .clk_out(clk_50mhz)
    );

    wire wr_en = data_valid && !fifo_full;
    wire fifo_empty, fifo_data_valid;
    wire [7:0] fifo_data_out;
    wire fifo_rd_en, start_tx;
    wire [7:0] uart_data;
    wire baud_tick;

    sync_fifo fifo_inst (
        .clk(clk_50mhz),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(fifo_rd_en),
        .din(data_in),
        .dout(fifo_data_out),
        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty),
        .data_out_valid(fifo_data_valid)
    );

    packetizer_fsm fsm_inst (
        .clk(clk_50mhz),
        .rst(rst),
        .fifo_empty(fifo_empty),
        .fifo_data_valid(fifo_data_valid),
        .fifo_data_out(fifo_data_out),
        .tx_ready(tx_ready),
        .tx_busy(tx_busy),
        .fifo_rd_en(fifo_rd_en),
        .start_tx(start_tx),
        .uart_data(uart_data)
    );

    baud_gen #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) baud_inst (
        .clk(clk_50mhz),
        .rst(rst),
        .baud_tick(baud_tick)
    );

    uart_tx uart_tx_inst (
        .clk(clk_50mhz),
        .rst(rst),
        .start_tx(start_tx),
        .baud_tick(baud_tick),
        .data_in(uart_data),
        .serial_out(serial_out),
        .tx_busy(tx_busy)
    );
    
endmodule

