`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2025 09:42:12
// Design Name: revanth kumar Vakkanti
// Module Name: uart_packetizer_tb
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



//module tb_sync_fifo;

//    reg clk, rst;
//    reg wr_en, rd_en;
//    reg [7:0] din;
//    wire [7:0] dout;
//    wire fifo_full, fifo_empty, data_out_valid;

//    
//    sync_fifo uut (
//        .clk(clk),
//        .rst(rst),
//        .wr_en(wr_en),
//        .rd_en(rd_en),
//        .din(din),
//        .dout(dout),
//        .fifo_full(fifo_full),
//        .fifo_empty(fifo_empty),
//        .data_out_valid(data_out_valid)
//    );

//    always #5 clk = ~clk;

//    initial begin
//        $monitor("Time = %0t | WrEn =  %b | RdEn = %b | Din = %h | Dout = %h | Valid = %b | Full = %b | Empty = %b", $time, wr_en, rd_en, din, dout, data_out_valid, fifo_full, fifo_empty);

//        clk = 0;
//        rst = 1;
//        wr_en = 0;
//        rd_en = 0;
//        din = 8'h00;

//        #10 rst = 0;

//      
//        repeat (4) begin
//            @(posedge clk);
//            wr_en = 1;
//            din = din + 8'h11;
//        end

//        @(posedge clk);
//        wr_en = 0;

//      
//        @(posedge clk);

//        // Read 4 bytes from FIFO
//        repeat (4) begin
//            @(posedge clk);
//            rd_en = 1;
//        end

//        @(posedge clk);
//        rd_en = 0;

//        #20 $finish;
//    end

//endmodule





module tb_uart_packetizer_top;

    reg clk, rst;
    reg [7:0] data_in;
    reg data_valid;
    reg tx_ready;
    wire serial_out;
    wire fifo_full;
    wire tx_busy;

    uart_packetizer_top #(
        .CLK_FREQ(50000000),   
        .BAUD_RATE(9600)
    ) dut (
        .clk(clk),             
        .rst(rst),
        .data_in(data_in),
        .data_valid(data_valid),
        .tx_ready(tx_ready),
        .serial_out(serial_out),
        .fifo_full(fifo_full),
        .tx_busy(tx_busy)
    );

    always #2.5 clk = ~clk;

    initial begin
        $monitor("Time = %0t | RST = %b | DataIn = %h | DataValid = %b | TxReady = %b | SerialOut = %b | TxBusy = %b | FIFO_Full = %b", 
                 $time, rst, data_in, data_valid, tx_ready, serial_out, tx_busy, fifo_full);

        clk = 0;
        rst = 1;
        data_in = 0;
        data_valid = 0;
        tx_ready = 0;

       #30 rst = 0;
                tx_ready = 1;
         
                #40 data_in = 8'hA5;
                data_valid = 1;
               #20 data_valid = 0;
                
                #40 data_in = 8'h4A;
                data_valid = 1;
                #20 data_valid = 0;  
                
                #40 data_in = 8'h94;
                data_valid = 1;
                #20 data_valid = 0;              

                #40 data_in = 8'h56;
                data_valid = 1;
               #20 data_valid = 0;
                          
        
                wait (!tx_busy);
                #130;
                $finish;
    end
endmodule



