`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:58:52 07/10/2021
// Design Name:   AxA_multiplier
// Module Name:   D:/University/4/DSD/final project/DSD_project/AxA_multiplier_test.v
// Project Name:  DSD_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: AxA_multiplier
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module AxA_multiplier_test;

	// Inputs
	reg input_Clk;
	reg input_Reset;
	reg input_Start;
	reg input_Stable;
	reg input_C_Ack;
	reg [31:0] input_A11;
	reg [31:0] input_A12;
	reg [31:0] input_A21;
	reg [31:0] input_A22;
	reg [31:0] input_B11;
	reg [31:0] input_B12;
	reg [31:0] input_B21;
	reg [31:0] input_B22;

	// Outputs
	wire output_AB_Ack;
	wire output_Stable;
	wire [31:0] output_C11;
	wire [31:0] output_C12;
	wire [31:0] output_C21;
	wire [31:0] output_C22;
	wire [31:0] A22_B22_Result;
	wire [31:0] temp_C22;

	// Instantiate the Unit Under Test (UUT)
	AxA_multiplier uut (
		.input_Clk(input_Clk), 
		.input_Reset(input_Reset), 
		.input_Start(input_Start), 
		.input_Stable(input_Stable), 
		.input_C_Ack(input_C_Ack), 
		.input_A11(input_A11), 
		.input_A12(input_A12), 
		.input_A21(input_A21), 
		.input_A22(input_A22), 
		.input_B11(input_B11), 
		.input_B12(input_B12), 
		.input_B21(input_B21), 
		.input_B22(input_B22), 
		.output_AB_Ack(output_AB_Ack), 
		.output_Stable(output_Stable), 
		.output_C11(output_C11), 
		.output_C12(output_C12), 
		.output_C21(output_C21), 
		.output_C22(output_C22), 
		.A22_B22_Result(A22_B22_Result), 
		.temp_C22(temp_C22)
	);

	initial begin
		// Initialize Inputs
		input_Clk = 0;
		input_Reset = 0;
		input_Start = 0;
		input_Stable = 0;
		input_C_Ack = 0;
		input_A11 = 0;
		input_A12 = 0;
		input_A21 = 0;
		input_A22 = 0;
		input_B11 = 0;
		input_B12 = 0;
		input_B21 = 0;
		input_B22 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

