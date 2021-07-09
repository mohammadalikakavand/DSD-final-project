`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:34 07/09/2021 
// Design Name: 
// Module Name:    AxA_adder 
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
module AxA_adder(
input_A11,
input_A12,
input_A21,
input_A22,
input_B11,
input_B12,
input_B21,
input_B22,

input_Clk,
input_Reset,
input_Start, // for starting the addition progress

input_C_Ack, //acknowledging "output read."

output_AB_Ack, // acknowledging "inputs read."
output_Stable, // acknowledging "the output is ready!"

output_C11,
output_C12,
output_C21,
output_C22,
 );

    input [31:0] input_A11, input_A12, input_A21, input_A22;
    input [31:0] input_B11, input_B12, input_B21, input_B22;
    output reg output_AB_Ack;

    output reg [31:0] output_C11, output_C12, output_C21, output_C22;
    output reg output_Stable;
    input input_C_Ack;

    input input_Clk;
    input input_Reset;
    input input_Start;

    reg [1:0] state;
    parameter waiting     = 2'd0;
              calculating = 2'd1;
              done        = 2'd2;

    adder(
    .clk(input_Clk),
    .reset(input_Reset), 
    .load(input_Start),
    .Number1(input_A11), 
    .Number2(input_B11), 
    .result_ack(input_C_Ack),
    .Result(output_C11),
    .result_ready(output_Stable));

    adder(
    .clk(input_Clk),
    .reset(input_Reset), 
    .load(input_Start),
    .Number1(input_A12), 
    .Number2(input_B12), 
    .result_ack(input_C_Ack),
    .Result(output_C11),
    .result_ready(output_Stable));

    adder(
    .clk(input_Clk),
    .reset(input_Reset), 
    .load(input_Start),
    .Number1(input_A21), 
    .Number2(input_B21), 
    .result_ack(input_C_Ack),
    .Result(output_C11),
    .result_ready(output_Stable));

    adder(
    .clk(input_Clk),
    .reset(input_Reset), 
    .load(input_Start),
    .Number1(input_A22), 
    .Number2(input_B22), 
    .result_ack(input_C_Ack),
    .Result(output_C11),
    .result_ready(output_Stable));          


endmodule
