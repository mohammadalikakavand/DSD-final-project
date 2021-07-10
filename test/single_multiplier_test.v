`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:15:09 07/10/2021
// Design Name:   single_multiplier
// Module Name:   D:/University/4/DSD/final project/DSD_project/single_multiplier_test.v
// Project Name:  DSD_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: single_multiplier
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module single_multiplier_test;

	// Inputs
	reg [31:0] input_a;
	reg [31:0] input_b;
	reg input_a_stb;
	reg input_b_stb;
	reg output_z_ack;
	reg clk;
	reg rst;

	// Outputs
	wire [31:0] output_z;
	wire output_z_stb;
	wire input_a_ack;
	wire input_b_ack;

	// Instantiate the Unit Under Test (UUT)
	single_multiplier uut (
		.input_a(input_a), 
		.input_b(input_b), 
		.input_a_stb(input_a_stb), 
		.input_b_stb(input_b_stb), 
		.output_z_ack(output_z_ack), 
		.clk(clk), 
		.rst(rst), 
		.output_z(output_z), 
		.output_z_stb(output_z_stb), 
		.input_a_ack(input_a_ack), 
		.input_b_ack(input_b_ack)
	);

	initial begin
		// Initialize Inputs
		input_a = 0;
		input_b = 0;
		input_a_stb = 0;
		input_b_stb = 0;
		output_z_ack = 0;
		clk = 0;
		rst = 1;
		
		#13
		rst = 0;
		input_a = 32'b01000001010001001100110011001101; //12.3
		input_b = 32'b01000001011001011000010100011111; //14.345
		input_a_stb = 1;
		input_b_stb = 1;

	end
      
	always #10 clk = ~clk;

endmodule

