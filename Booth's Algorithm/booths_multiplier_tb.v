`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2024 19:35:23
// Design Name: 
// Module Name: booths_multiplier_tb
// Project Name: 
// Target Devices: 
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

// 4-bit booths_Algorithm
/*module booth_multiplier_4bit_tb;

    reg signed [3:0] multiplicand;
    reg signed [3:0] multiplier;
    wire signed [7:0] product;

    booth_multiplier_4bit uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );

    initial begin
        multiplicand = 4'b0000;
        multiplier = 4'b0000;

        #10;

        multiplicand = 4'b0011; multiplier = 4'b0101; #10; // 3 * 5
        $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        multiplicand = -4'b0011; multiplier = 4'b0101; #10; // -3 * 5
        $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        multiplicand = 4'b0011; multiplier = -4'b0101; #10; // 3 * -5
        $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        multiplicand = -4'b0011; multiplier = -4'b0101; #10; // -3 * -5
        $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        $stop;
    end

endmodule */


// 8-bit booths_Algorithm
/*module booth_multiplier_8bit_tb;

    reg signed [7:0] multiplicand;
    reg signed [7:0] multiplier;
    wire signed [15:0] product;

    booth_multiplier_8bit uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );

    initial begin
        multiplicand = 8'b00000000;
        multiplier = 8'b00000000;

        #10 multiplicand = 8'b00001100; // 12 in 8-bit signed
            multiplier = 8'b00000111;   // 7 in 8-bit signed
            $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        #10 multiplicand = -8'b00001010; // -10 in 8-bit signed
            multiplier = 8'b00000110;    // 6 in 8-bit signed
            $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        #10 multiplicand = 8'b00001111; // 15 in 8-bit signed
            multiplier = -8'b00001000;  // -8 in 8-bit signed
            $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        #10 multiplicand = -8'b00010100; // -20 in 8-bit signed
            multiplier = -8'b00001101;   // -13 in 8-bit signed
            $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        $stop;
    end

endmodule  */


// 16-bit booths_Algorithm
/*module booth_multiplier_16bit_tb;

    reg signed [15:0] multiplicand;
    reg signed [15:0] multiplier;
    wire signed [31:0] product;

    booth_multiplier_16bit uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );

    initial begin
        multiplicand = 16'b0000000000000000;
        multiplier = 16'b0000000000000000;

        #10 multiplicand = 16'b0000000100101100; // 300 in 16-bit signed
            multiplier = 16'b0000000011001000;   // 200 in 16-bit signed
            $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

       #10 multiplicand = -16'b0000000111110100; // -500 in 16-bit signed
           multiplier = 16'b0000000010010110;    // 150 in 16-bit signed
           $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

       #10 multiplicand = 16'b0000001111101000; // 1000 in 16-bit signed
           multiplier = -16'b0000001100100000;  // -400 in 16-bit signed
           $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

       #10 multiplicand = -16'b0000001010111100; // -700 in 16-bit signed
           multiplier = -16'b0000001001011000;   // -600 in 16-bit signed
           $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        $stop;
    end

endmodule */


// 32-bit booths_Algorithm
/*module booth_multiplier_32bit_tb;

    reg signed [31:0] multiplicand;
    reg signed [31:0] multiplier;
    wire signed [63:0] product;

    booth_multiplier_32bit uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );

    initial begin
        multiplicand = 32'b00000000000000000000000000000000;
        multiplier = 32'b00000000000000000000000000000000;

        #10 multiplicand = 32'b00000000000000011000011010100000; // 100000 in 32-bit signed
            multiplier = 32'b00000000000000001100001010000000;   // 49792 in 32-bit signed
            $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        #10 multiplicand = -32'b00000000000000111100100100000000; // -248064 in 32-bit signed
            multiplier = 32'b00000000000000010010011000111000;    // 75320 in 32-bit signed
            $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        #10 multiplicand = 32'b00000000000000011110000101000000; // 123200 in 32-bit signed
            multiplier = -32'b00000000000010011111110101000001;  // -654657 in 32-bit signed
            $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        #10 multiplicand = -32'b00000000000011110100001011111111; // -1000191 in 32-bit signed
            multiplier = -32'b00000000000011011000101011110000;   // -887536 in 32-bit signed
           $display("Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand, multiplier, product);

        $stop;
    end

endmodule */


// N-bit booths_Algorithm
module booth_multiplier_Nbit_tb;

    parameter N0 = 4;    
    parameter N1 = 8;
    parameter N2 = 16;
    parameter N3 = 32;
    
    reg signed [N0-1:0] multiplicand4;
    reg signed [N0-1:0] multiplier4;
    wire signed [2*N0-1:0] product4;
    

    reg signed [N1-1:0] multiplicand8;
    reg signed [N1-1:0] multiplier8;
    wire signed [2*N1-1:0] product8;

    reg signed [N2-1:0] multiplicand16;
    reg signed [N2-1:0] multiplier16;
    wire signed [2*N2-1:0] product16;

    reg signed [N3-1:0] multiplicand32;
    reg signed [N3-1:0] multiplier32;
    wire signed [2*N3-1:0] product32;
    
    
    booth_multiplier_Nbit #(.N(N0)) uut4 (
        .multiplicand(multiplicand4),
        .multiplier(multiplier4),
        .product(product4)
    );
    
    booth_multiplier_Nbit #(.N(N1)) uut8 (
        .multiplicand(multiplicand8),
        .multiplier(multiplier8),
        .product(product8)
    );

    booth_multiplier_Nbit #(.N(N2)) uut16 (
        .multiplicand(multiplicand16),
        .multiplier(multiplier16),
        .product(product16)
    );

    booth_multiplier_Nbit #(.N(N3)) uut32 (
        .multiplicand(multiplicand32),
        .multiplier(multiplier32),
        .product(product32)
    );

    initial begin

            multiplicand4 = 4'd0; multiplier4 = 4'd0;    
            multiplicand8 = 8'd0; multiplier8 = 8'd0;
            multiplicand16 = 16'd0; multiplier16 = 16'd0;
            multiplicand32 = 32'd0; multiplier32 = 32'd0;
            
        #10 multiplicand4 = -4'd3;
            multiplier4 = 4'd5;
            $display("4-bit Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand4, multiplier4, product4);           
    
        #10 multiplicand8 = 8'd12;
            multiplier8 = -8'd5;
            $display("8-bit Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand8, multiplier8, product8);

        #10 multiplicand16 = -16'd300;
            multiplier16 = 16'd250;
            $display("16-bit Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand16, multiplier16, product16);

        #10 multiplicand32 = 32'd100000;
            multiplier32 = -32'd200000;
            $display("32-bit Multiplicand: %d, Multiplier: %d, Product: %d", multiplicand32, multiplier32, product32);

        #50 $stop;
    end
endmodule

