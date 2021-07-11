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
	reg input_Clk;
	reg input_Reset;
	reg input_Start;
	reg [6:0] sum_number;

	// Outputs
	wire output_free;
	wire output_Stable;
	wire [31:0] output_C11_sum;
	wire [31:0] output_C12_sum;
	wire [31:0] output_C21_sum;
	wire [31:0] output_C22_sum;

	// Instantiate the Unit Under Test (UUT)
	AxA_adder uut (
		.input_A11(input_A11), 
		.input_A12(input_A12), 
		.input_A21(input_A21), 
		.input_A22(input_A22), 
		.input_Clk(input_Clk), 
		.input_Reset(input_Reset), 
		.input_Start(input_Start), 
		.output_free(output_free), 
		.output_Stable(output_Stable), 
		.output_C11_sum(output_C11_sum), 
		.output_C12_sum(output_C12_sum), 
		.output_C21_sum(output_C21_sum), 
		.output_C22_sum(output_C22_sum), 
		.sum_number(sum_number)
	);

	initial begin
		// Initialize Inputs
		input_A11 = 0;
		input_A12 = 0;
		input_A21 = 0;
		input_A22 = 0;
		input_Clk = 0;
		input_Reset = 0;
		input_Start = 0;
		sum_number = 4; //number of add operation is 4

		#23

		input_Reset = 1;

		input_Start = 1;

		input_A11 = 32'b11000000010100000000000000000000; //-3.25
		input_A12 = 32'b10111111010000000000000000000000; //-0.75
		input_A21 = 32'b01000001100011100000000000000000; //17.75
		input_A22 = 32'b11000001101011100000000000000000; //-21.75
		#20
		input_Start = 0;
		#150
		input_Start = 1;
		input_A11 = 32'b01000000010000000000000000000000; //3
		input_A12 = 32'b01000000110000000000000000000000; //6
		input_A21 = 32'b01000000100000000000000000000000; //4
		input_A22 = 32'b01000000101000000000000000000000; //5
		#20
		input_Start = 0;
		#150
		input_Start = 1;
		input_A11 = 32'b11000000010100000000000000000000; //-3.25
		input_A12 = 32'b10111111010000000000000000000000; //-0.75
		input_A21 = 32'b01000001100011100000000000000000; //17.75
		input_A22 = 32'b11000001101011100000000000000000; //-21.75
		#20
		input_Start = 0;
		#150
		input_Start = 1;
		input_A11 = 32'b01000000101011100000000000000000; //5.4375
		input_A12 = 32'b01000010001011000000000000000000; //43
		input_A21 = 32'b00111111111111000000000000000000; //1.96875
		input_A22 = 32'b00111111110000000000000000000000; //1.5
		#20
		input_Start = 0;
		#250
		input_Start = 1;
		input_A11 = 32'b01000111101011000000000000000000; //88064
		input_A12 = 32'b01000110111011000000000000000000; //30208.0
		input_A21 = 32'b01001010101010100010000000000000; //5574656.0
		input_A22 = 32'b01001010011010100010110100000000; //3836736.0
		#20
		input_Start = 0;
		#150
		input_Start = 1;
		input_A11 = 32'b01001010110010000000010000000000; //6554112.0
		input_A12 = 32'b11001010100010000000010000000000; //-4456960.0
		input_A21 = 32'b11001000000101100000000000000000; //-153600.0
		input_A22 = 32'b01000111101011000000000000000000; //88064
		#20
		input_Reset = 0;
		input_Start = 1;
		#50
		input_Start = 1;
		input_Reset = 1;
		input_A11 = 32'b01000111101011000000000000000000; //88064
		input_A12 = 32'b01000110111011000000000000000000; //30208.0
		input_A21 = 32'b01001010101010100010000000000000; //5574656.0
		input_A22 = 32'b01001010011010100010110100000000; //3836736.0



	end
      
	always #10 input_Clk = ~input_Clk;

endmodule

