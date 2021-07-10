`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:16:33 07/10/2021
// Design Name:   memory
// Module Name:   D:/University/4/DSD/final project/DSD_project/memory_test.v
// Project Name:  DSD_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module memory_test;

	// Inputs
	reg [31:0] data_a;
	reg [31:0] data_b;
	reg [11:0] addr_a;
	reg [11:0] addr_b;
	reg we_a;
	reg we_b;
	reg clk;

	// Outputs
	wire [31:0] q_a;
	wire [31:0] q_b;

	// Instantiate the Unit Under Test (UUT)
	memory uut (
		.data_a(data_a), 
		.data_b(data_b), 
		.addr_a(addr_a), 
		.addr_b(addr_b), 
		.we_a(we_a), 
		.we_b(we_b), 
		.clk(clk), 
		.q_a(q_a), 
		.q_b(q_b)
	);

	initial begin
		// Initialize Inputs
		data_a = 0;
		data_b = 0;
		addr_a = 0;
		addr_b = 0;
		we_a = 0;
		we_b = 0;
		clk = 0;

		#13
		we_a = 1;
		we_b = 1;
		data_a = 32'd1234;
		data_b = 32'd720;
		addr_a = 0;
		addr_b = 1;

		#20
		we_a = 0;
		we_b = 0;
		addr_a = 1;
		addr_b = 0;


	end
      
	always #10 clk = ~clk;

endmodule

