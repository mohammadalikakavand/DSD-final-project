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
		rst = 0;
		
		#100
		rst = 1;
		input_a_stb = 1;
		input_b_stb = 1;
		input_a = 32'b01000001010001001100110011001101; //12.3
		input_b = 32'b01000001011001011000010100011111; //14.345
		// output_z = 176.44345 its ok

		#300
		rst = 0;
		input_a = 32'b01000001010001001100110011001101; //12.3
		input_b = 32'b01000001011001011000010100011111; //14.345
		// rst = 0 ----> module stay in default state its ok

		#300
		rst = 1;
		input_a = 32'b10111110000101100000000000000000; //-0.146484375
		input_b = 32'b00111100011000000000000000000000; // 0.013671875
		// output_z = -0.00200271606445 its ok 

		#300
		input_a_stb = 0;
		input_a = 32'b10111110000101100000000000000000; //-0.146484375
		input_b = 32'b00111100011000000000000000000000; // 0.013671875
		// first input is not stable so module dont calculate anything stay in first state (get_a) its ok

		#300
		input_a_stb = 1;
		input_a = 32'b11001111100100000000000000000000; //-4831838208.0
		input_b = 32'b11001101100111100000000000000000; //-331350016.0
		// output_z = 1.60102966753 * 10 ^ 18 its ok 

		#300
		input_b_stb = 0;
		input_a = 32'b11001111100100000000000000000000; //-4831838208.0
		input_b = 32'b11001101100111100000000000000000; //-331350016.0
		// second input is not stable so module dont start calculating and stay in second state (get_b) its ok

	end
      
	always #10 clk = ~clk;

endmodule

