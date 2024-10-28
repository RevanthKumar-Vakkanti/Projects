`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2024 19:31:13
// Design Name: 
// Module Name: booths_multiplier
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
/*module booth_multiplier_4bit(
    input signed [3:0] multiplicand,
    input signed [3:0] multiplier,
    output reg signed [7:0] product
);
    reg [3:0] A, Q, M;
    reg Q_1;
    integer i;

    always @(*) begin

        A = 4'b0000;
        Q = multiplier;
        M = multiplicand;
        Q_1 = 1'b0;
        product = 8'b0;


        for (i = 0; i < 4; i = i + 1) begin
            case ({Q[0], Q_1})
                2'b01: A = A + M; 
                2'b10: A = A - M;
                default: ; 
            endcase

            
            {A, Q, Q_1} = {A[3], A, Q}; 
        end
        product = {A, Q};
    end
endmodule */


// 8-bit booths_Algorithm
/*module booth_multiplier_8bit(
    input signed [7:0] multiplicand,
    input signed [7:0] multiplier,
    output reg signed [15:0] product
);
    reg [7:0] A, Q, M;
    reg Q_1;
    integer i;

    always @(*) begin
        A = 8'b00000000;
        Q = multiplier;
        M = multiplicand;
        Q_1 = 1'b0;
        product = 16'b0;

        for (i = 0; i < 8; i = i + 1) begin
            case ({Q[0], Q_1})
                2'b01: A = A + M; 
                2'b10: A = A - M; 
                default: ;
            endcase

            {A, Q, Q_1} = {A[7], A, Q};
        end
        product = {A, Q};
    end
endmodule */

// 16-bit booths_Algorithm
/*module booth_multiplier_16bit(
    input signed [15:0] multiplicand,
    input signed [15:0] multiplier,
    output reg signed [31:0] product
);
    reg [15:0] A, Q, M;
    reg Q_1;
    integer i;

    always @(*) begin
        A = 16'b0000000000000000;
        Q = multiplier;
        M = multiplicand;
        Q_1 = 1'b0;
        product = 32'b0;

        for (i = 0; i < 16; i = i + 1) begin
            case ({Q[0], Q_1})
                2'b01: A = A + M; 
                2'b10: A = A - M; 
                default: ;
            endcase

            {A, Q, Q_1} = {A[15], A, Q};
        end

        product = {A, Q};
    end
endmodule  */


// 32-bit booths_Algorithm
/* module booth_multiplier_32bit(
    input signed [31:0] multiplicand,
    input signed [31:0] multiplier,
    output reg signed [63:0] product
);
    reg [31:0] A, Q, M;
    reg Q_1;
    integer i;

    always @(*) begin
        A = 32'b00000000000000000000000000000000;
        Q = multiplier;
        M = multiplicand;
        Q_1 = 1'b0;
        product = 64'b0;

        for (i = 0; i < 32; i = i + 1) begin

            case ({Q[0], Q_1})
                2'b01: A = A + M; 
                2'b10: A = A - M; 
                default: ; 
            endcase

            {A, Q, Q_1} = {A[31], A, Q};  
        end

        product = {A, Q};
    end
endmodule  */


// N-bit booths_Algorithm
module booth_multiplier_Nbit #(parameter N = 8)(
    input signed [N-1:0] multiplicand,
    input signed [N-1:0] multiplier,
    output reg signed [2*N-1:0] product
);
    reg [N-1:0] A, Q, M;
    reg Q_1;
    integer i;

    always @(*) begin
    
        A = {N{1'b0}}; 
        Q = multiplier;
        M = multiplicand;
        Q_1 = 1'b0;
        product = {2*N{1'b0}}; 

        for (i = 0; i < N; i = i + 1) begin
            case ({Q[0], Q_1})
                2'b01: A = A + M; 
                2'b10: A = A - M; 
                default: ; 
            endcase

  
            {A, Q, Q_1} = {A[N-1], A, Q}; 
        end

        product = {A, Q};
    end
endmodule




