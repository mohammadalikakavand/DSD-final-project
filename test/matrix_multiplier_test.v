`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:36:17 07/13/2021
// Design Name:   matrix_multiplier
// Module Name:   D:/University/4/DSD/final project/DSD_final/matrix_multiplier_test.v
// Project Name:  DSD_final
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: matrix_multiplier
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module matrix_multiplier_test;

	// Inputs
	reg [31:0] memory_data_in;
	reg [11:0] memory_address;
	reg write_enable;
	reg reset;
	reg clk;

	// Outputs
	wire [31:0] memory_data_out;
	wire result_ready;

	// Instantiate the Unit Under Test (UUT)
	matrix_multiplier uut (
		.memory_data_in(memory_data_in), 
		.memory_address(memory_address), 
		.write_enable(write_enable), 
		.reset(reset), 
		.clk(clk), 
		.memory_data_out(memory_data_out), 
		.result_ready(result_ready)
	);

	initial begin
		// Initialize Inputs
		memory_data_in = 0;
		memory_address = 0;
		write_enable = 0;
		reset = 1;
		clk = 0;

		#100;
        
		//ready for writing the test

	end
      
	always #10 clk = ~clk;

endmodule

