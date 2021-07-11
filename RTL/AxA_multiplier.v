`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:17:12 07/08/2021 
// Design Name: 
// Module Name:    AxA_multiplier 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module AxA_multiplier( 
input_Clk,
input_Reset,
input_Stable,
input_C_Ack,
input_A11,
input_A12,
input_A21,
input_A22,
input_B11,
input_B12,
input_B21,
input_B22,
output_AB_Ack,
output_Stable,
output_C11,
output_C12,
output_C21,
output_C22,
output_Free);
    input [31:0] input_A11,
                 input_A12, 
                 input_A21, 
                 input_A22;

    input [31:0] input_B11, 
                 input_B12, 
                 input_B21, 
                 input_B22;
                 
    input input_Stable;
    output reg output_AB_Ack;

    output reg [31:0] output_C11, 
                      output_C12, 
                      output_C21, 
                      output_C22;

    output reg output_Stable;
    output reg output_Free;
    input input_C_Ack;

    input input_Clk;
    input input_Reset;

    wire A11_B11_Stable,
         A12_B21_Stable,
         A11_B12_Stable,
         A12_B22_Stable,
         A21_B11_Stable,
         A22_B21_Stable,
         A21_B12_Stable,
         A22_B22_Stable;

    reg  A11_B11_Ack,
         A12_B21_Ack,
         A11_B12_Ack,
         A12_B22_Ack,
         A21_B11_Ack,
         A22_B21_Ack,
         A21_B12_Ack,
         A22_B22_Ack;

    reg  C11_Ack,
         C12_Ack,
         C21_Ack,
         C22_Ack;

    wire [31:0] A11_B11_Result,
                A12_B21_Result,
                A11_B12_Result,
                A12_B22_Result,
                A21_B11_Result,
                A22_B21_Result,
                A21_B12_Result,
                A22_B22_Result;
    
    wire [31:0] temp_C11,
                temp_C12,
                temp_C21,
                temp_C22;
    
    wire C11_Stable,
         C12_Stable,
         C21_Stable,
         C22_Stable;

    reg [1:0] state;
    parameter waiting = 2'b00,
              calculating = 2'b01,
              done = 2'b10;
    
    always @ (posedge input_Clk, negedge input_Reset) begin
      if (!input_Reset) begin
        output_C11 <= 0;
        output_C12 <= 0;
        output_C21 <= 0;
        output_C22 <= 0;
        output_AB_Ack <= 0;
        output_Stable <= 0;
        A11_B11_Ack <= 0;
        A12_B21_Ack <= 0;
        A11_B12_Ack <= 0;
        A12_B22_Ack <= 0;
        A21_B11_Ack <= 0;
        A22_B21_Ack <= 0;
        A21_B12_Ack <= 0;
        A22_B22_Ack <= 0;
        C11_Ack <= 0;
        C12_Ack <= 0;
        C21_Ack <= 0;
        C22_Ack <= 0;
        output_Free <= 1;
        state <= waiting;
      end
      else begin
        case(state)
            waiting: begin
                output_C11 <= 0;
                output_C12 <= 0;
                output_C21 <= 0;
                output_C22 <= 0;
                output_AB_Ack <= 0;
                output_Stable <= 0;
                if (input_Stable) begin
                    state <= calculating;
                    output_Free <= 0;
                    A11_B11_Ack <= 0;
                    A12_B21_Ack <= 0;
                    A11_B12_Ack <= 0;
                    A12_B22_Ack <= 0;
                    A21_B11_Ack <= 0;
                    A22_B21_Ack <= 0;
                    A21_B12_Ack <= 0;
                    A22_B22_Ack <= 0;
                    C11_Ack <= 0;
                    C12_Ack <= 0;
                    C21_Ack <= 0;
                    C22_Ack <= 0;
                end 
            end
            calculating: begin
              output_AB_Ack <= 1;
                if(C11_Stable && C12_Stable && C21_Stable && C22_Stable) begin
                  output_C11 <= temp_C11;
                  output_C12 <= temp_C12;
                  output_C21 <= temp_C21;
                  output_C22 <= temp_C22;
                  state <= done;
                end
            end
            done: begin
                output_Stable <= 1;
                if(input_C_Ack) begin
                    output_Free <= 1;
                    A11_B11_Ack <= 1;
                    A12_B21_Ack <= 1;
                    A11_B12_Ack <= 1;
                    A12_B22_Ack <= 1;
                    A21_B11_Ack <= 1;
                    A22_B21_Ack <= 1;
                    A21_B12_Ack <= 1;
                    A22_B22_Ack <= 1;
                    C11_Ack <= 1;
                    C12_Ack <= 1;
                    C21_Ack <= 1;
                    C22_Ack <= 1;
                    state <= waiting;
                end
                   
            end
        endcase
      end
    end
    single_multiplier mult_A11_B11 (
        .input_a(input_A11),
        .input_b(input_B11),
        .input_a_stb(input_Stable),
        .input_b_stb(input_Stable),
        .output_z_ack(A11_B11_Ack),
        .clk(input_Clk),
        .rst(input_Reset),
        .output_z(A11_B11_Result),
        .output_z_stb(A11_B11_Stable),
        .input_a_ack(),
        .input_b_ack());

    single_multiplier mult_A12_B21 (
        .input_a(input_A12),
        .input_b(input_B21),
        .input_a_stb(input_Stable),
        .input_b_stb(input_Stable),
        .output_z_ack(A12_B21_Ack),
        .clk(input_Clk),
        .rst(input_Reset),
        .output_z(A12_B21_Result),
        .output_z_stb(A12_B21_Stable),
        .input_a_ack(),
        .input_b_ack());

    single_multiplier mult_A11_B12 (
        .input_a(input_A11),
        .input_b(input_B12),
        .input_a_stb(input_Stable),
        .input_b_stb(input_Stable),
        .output_z_ack(A11_B12_Ack),
        .clk(input_Clk),
        .rst(input_Reset),
        .output_z(A11_B12_Result),
        .output_z_stb(A11_B12_Stable),
        .input_a_ack(),
        .input_b_ack());

    single_multiplier mult_A12_B22 (
        .input_a(input_A11),
        .input_b(input_B22),
        .input_a_stb(input_Stable),
        .input_b_stb(input_Stable),
        .output_z_ack(A12_B22_Ack),
        .clk(input_Clk),
        .rst(input_Reset),
        .output_z(A12_B22_Result),
        .output_z_stb(A12_B22_Stable),
        .input_a_ack(),
        .input_b_ack());

    single_multiplier mult_A21_B11 (
        .input_a(input_A21),
        .input_b(input_B11),
        .input_a_stb(input_Stable),
        .input_b_stb(input_Stable),
        .output_z_ack(A21_B11_Ack),
        .clk(input_Clk),
        .rst(input_Reset),
        .output_z(A21_B11_Result),
        .output_z_stb(A21_B11_Stable),
        .input_a_ack(),
        .input_b_ack());

    single_multiplier mult_A22_B21(
        .input_a(input_A22),
        .input_b(input_B21),
        .input_a_stb(input_Stable),
        .input_b_stb(input_Stable),
        .output_z_ack(A22_B21_Ack),
        .clk(input_Clk),
        .rst(input_Reset),
        .output_z(A22_B21_Result),
        .output_z_stb(A22_B21_Stable),
        .input_a_ack(),
        .input_b_ack());

    single_multiplier mult_A21_B12(
        .input_a(input_A21),
        .input_b(input_B12),
        .input_a_stb(input_Stable),
        .input_b_stb(input_Stable),
        .output_z_ack(A21_B12_Ack),
        .clk(input_Clk),
        .rst(input_Reset),
        .output_z(A21_B12_Result),
        .output_z_stb(A21_B12_Stable),
        .input_a_ack(),
        .input_b_ack());

    single_multiplier mult_A22_B22 (
        .input_a(input_A22),
        .input_b(input_B22),
        .input_a_stb(input_Stable),
        .input_b_stb(input_Stable),
        .output_z_ack(A22_B22_Ack),
        .clk(input_Clk),
        .rst(input_Reset),
        .output_z(A22_B22_Result),
        .output_z_stb(A22_B22_Stable),
        .input_a_ack(),
        .input_b_ack());

    adder add_C11 (
        .clk(input_Clk),
        .reset(input_Reset), 
        .load(A11_B11_Stable && A12_B21_Stable),
        .Number1(A11_B11_Result), 
        .Number2(A12_B21_Result), 
        .result_ack(C11_Ack),
        .Result(temp_C11),
        .result_ready(C11_Stable));

    adder add_C12 (
        .clk(input_Clk),
        .reset(input_Reset), 
        .load(A11_B12_Stable && A12_B22_Stable),
        .Number1(A11_B12_Result), 
        .Number2(A12_B22_Result), 
        .result_ack(C12_Ack),
        .Result(temp_C12),
        .result_ready(C12_Stable));

    adder add_C21 (
        .clk(input_Clk),
        .reset(input_Reset), 
        .load(A21_B11_Stable && A22_B21_Stable),
        .Number1(A21_B11_Result), 
        .Number2(A22_B21_Result), 
        .result_ack(C21_Ack),
        .Result(temp_C21),
        .result_ready(C21_Stable));

    adder add_C22 (
        .clk(input_Clk),
        .reset(input_Reset), 
        .load(A21_B12_Stable && A22_B22_Stable),
        .Number1(A21_B12_Result), 
        .Number2(A22_B22_Result), 
        .result_ack(C22_Ack),
        .Result(temp_C22),
        .result_ready(C22_Stable));

endmodule
