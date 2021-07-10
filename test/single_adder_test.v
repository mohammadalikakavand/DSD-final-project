`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:36:42 07/10/2021
// Design Name:   adder
// Module Name:   D:/University/4/DSD/final project/DSD_project/single_adder_test.v
// Project Name:  DSD_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module single_adder_test;

	// Inputs
	reg clk;
	reg reset;
	reg load;
	reg [31:0] Number1;
	reg [31:0] Number2;
	reg result_ack;

	// Outputs
	wire [31:0] Result;
	wire result_ready;

	// Instantiate the Unit Under Test (UUT)
	adder uut (
		.clk(clk), 
		.reset(reset), 
		.load(load), 
		.Number1(Number1), 
		.Number2(Number2), 
		.result_ack(result_ack), 
		.Result(Result), 
		.result_ready(result_ready)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		load = 0;
		Number1 = 0;
		Number2 = 0;
		result_ack = 0;

		#13
		load = 1;
		reset = 1;
		Number1 = 32'b01000001010001001100110011001101; //12.3
		Number2 = 32'b01000001011001011000010100011111; //14.345

	end
      
	always #10 clk = ~clk;

endmodule

