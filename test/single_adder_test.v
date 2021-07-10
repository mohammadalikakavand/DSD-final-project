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

		#10
		load = 1;
		reset = 1;
		Number1 = 32'b01000001010001001100110011001101; //12.3
		Number2 = 32'b01000001011001011000010100011111; //14.345
		// Result = 26.6449985504 its ok
		#60
		result_ack =1;

		#10
		result_ack = 0;
		reset = 0;
		Number1 = 32'b01100101101100011100000000000000; //1.04925080291e+23
		Number2 = 32'b01011001101000000010000000000000; //5.63389758072e+15
		// reset = 0 ----> module doesnt do anything and output = 0 is not accepted its ok
		#60
		result_ack = 1;

		#10
		reset = 1;
		result_ack =0;
		Number1 = 32'b10110001101100000000000000000000; //-5.12227416039e-09
		Number2 = 32'b10111000001000000000000000000000; //-3.81469726562e-05
		// Result = -3.81520949304e-05 its ok

		#60
		result_ack = 1;

		#10
		result_ack =0;
		load = 0;
		Number1 = 32'b10110001101100000000000000000000; //-5.12227416039e-09
		Number2 = 32'b10111000001000000000000000000000; //-3.81469726562e-05
		// module doesnt work and stay in first state (get_input) its ok

		#60
		result_ack = 1;

		#10
		load = 1;
		result_ack = 0;
		Number1 = 32'b01100101101100011100000000000000; //1.04925080291e+23
		Number2 = 32'b01011001101000000010000000000000; //5.63389758072e+15
		// Result = 1.04925080291e+23  ** module stay in final state till result_ack  its ok

		#70
		Number1 = 32'b01000001010001001100110011001101; //12.3
		Number2 = 32'b01000001011001011000010100011111; //14.345
		// module doestnt work because stayed in final state  its ok







	end
      
	always #10 clk = ~clk;

endmodule

