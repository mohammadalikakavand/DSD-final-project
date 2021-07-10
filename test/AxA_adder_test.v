`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:58:40 07/10/2021
// Design Name:   AxA_adder
// Module Name:   D:/University/4/DSD/final project/DSD_project/AxA_adder_test.v
// Project Name:  DSD_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: AxA_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module AxA_adder_test;

	// Inputs
	reg [31:0] input_A11;
	reg [31:0] input_A12;
	reg [31:0] input_A21;
	reg [31:0] input_A22;
	reg [31:0] input_B11;
	reg [31:0] input_B12;
	reg [31:0] input_B21;
	reg [31:0] input_B22;
	reg input_Clk;
	reg input_Reset;
	reg input_Start;
	reg input_C_Ack;

	// Outputs
	wire output_Stable;
	wire [31:0] output_C11;
	wire [31:0] output_C12;
	wire [31:0] output_C21;
	wire [31:0] output_C22;

	// Instantiate the Unit Under Test (UUT)
	AxA_adder uut (
		.input_A11(input_A11), 
		.input_A12(input_A12), 
		.input_A21(input_A21), 
		.input_A22(input_A22), 
		.input_B11(input_B11), 
		.input_B12(input_B12), 
		.input_B21(input_B21), 
		.input_B22(input_B22), 
		.input_Clk(input_Clk), 
		.input_Reset(input_Reset), 
		.input_Start(input_Start), 
		.input_C_Ack(input_C_Ack), 
		.output_Stable(output_Stable), 
		.output_C11(output_C11), 
		.output_C12(output_C12), 
		.output_C21(output_C21), 
		.output_C22(output_C22));

	initial begin
		// Initialize Inputs
		input_A11 = 0;
		input_A12 = 0;
		input_A21 = 0;
		input_A22 = 0;
		input_B11 = 0;
		input_B12 = 0;
		input_B21 = 0;
		input_B22 = 0;
		input_Clk = 0;
		input_Reset = 0;
		input_Start = 0;
		input_C_Ack = 0;

		#13
		input_Reset = 1;
		input_Start = 1;

		input_A11 = 32'b01000010111110100000000000000000; //125
		input_A12 = 32'b00111110111000000100000110001001; //0.438
		input_A21 = 32'b01000010000010100010100011110110; //34.54
		input_A22 = 32'b01000001010010001011110001101010; //12.546

		input_B11 = 32'b00111010011000110101101110000101; //0.0008673
		input_B12 = 32'b01000100100101100001110111000011; //1200.93
		input_B21 = 32'b01000001100110000000000000000000; //19
		input_B22 = 32'b00111111101010111000010100011111; //1.34

	end
      
	always #10 input_Clk = ~input_Clk;

endmodule

