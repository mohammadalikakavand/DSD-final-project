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
	wire output_Free;



	// Instantiate the Unit Under Test (UUT)
	AxA_multiplier uut (
		.input_Clk(input_Clk), 
		.input_Reset(input_Reset), 
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
		.output_Free(output_Free));

	initial begin
		// Initialize Inputs
		input_Clk = 0;
		input_Reset = 0;
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
		#100
		input_Reset = 1;
		input_Stable = 1;
		input_C_Ack = 0;
		input_A11 = 32'b01000000010000000000000000000000; //3
		input_A12 = 32'b01000000110000000000000000000000; //6
		input_A21 = 32'b01000000100000000000000000000000; //4
		input_A22 = 32'b01000000101000000000000000000000; //5
		input_B11 = 32'b01000000010000000000000000000000; //3
		input_B12 = 32'b01000000110000000000000000000000; //6
		input_B21 = 32'b01000000100000000000000000000000; //4
		input_B22 = 32'b01000000101000000000000000000000; //5
		// C11 = 33 , C12 = 33 , C21 = 32 , C22 = 49
		#1000
		input_C_Ack = 1;
		input_Stable = 0;
		//input_Reset = 0;
		#100
		input_C_Ack = 0;
		//input_Reset = 1;
		input_A11 = 32'b11000000010100000000000000000000; //-3.25
		input_A12 = 32'b10111111010000000000000000000000; //-0.75
		input_A21 = 32'b01000001100011100000000000000000; //17.75
		input_A22 = 32'b11000001101011100000000000000000; //-21.75

		input_B11 = 32'b01000000101011100000000000000000; //5.4375
		input_B12 = 32'b01000010001011000000000000000000; //43
		input_B21 = 32'b00111111111111000000000000000000; //1.96875
		input_B22 = 32'b00111111110000000000000000000000; //1.5
		// because of input_Stable = 0 ----> single_multipliers dont work

		#100
		input_C_Ack = 0;
		input_Stable = 1;
		input_A11 = 32'b11000000010100000000000000000000; //-3.25
		input_A12 = 32'b10111111010000000000000000000000; //-0.75
		input_A21 = 32'b01000001100011100000000000000000; //17.75
		input_A22 = 32'b11000001101011100000000000000000; //-21.75

		input_B11 = 32'b01000000101011100000000000000000; //5.4375
		input_B12 = 32'b01000010001011000000000000000000; //43
		input_B21 = 32'b00111111111111000000000000000000; //1.96875
		input_B22 = 32'b00111111110000000000000000000000; //1.5
		// C11 =-19.1484375 , C12 = -140.875 , C21 = 53.6953125 , C22 = 730.625

		#1000
		input_Reset = 0;
		input_C_Ack = 1;
		//asynchronous input_Reset with negedge will put our device in default mode
		#50
		input_C_Ack = 0;
		input_A11 = 32'b01000111101011000000000000000000; //88064
		input_A12 = 32'b01000110111011000000000000000000; //30208.0
		input_A21 = 32'b01001010101010100010000000000000; //5574656.0
		input_A22 = 32'b01001010011010100010110100000000; //3836736.0

		input_B11 = 32'b01001010110010000000010000000000; //6554112.0
		input_B12 = 32'b11001010100010000000010000000000; //-4456960.0
		input_B21 = 32'b11001000000101100000000000000000; //-153600.0
		input_B22 = 32'b01000111101011000000000000000000; //88064
		// input_Reset =0 ----. module dont leave default state and output will not be stable

		#50
		input_Reset = 1;
		input_A11 = 32'b01000111101011000000000000000000; //88064
		input_A12 = 32'b01000110111011000000000000000000; //30208.0
		input_A21 = 32'b01001010101010100010000000000000; //5574656.0
		input_A22 = 32'b01001010011010100010110100000000; //3836736.0

		input_B11 = 32'b01001010110010000000010000000000; //6554112.0
		input_B12 = 32'b11001010100010000000010000000000; //-4456960.0
		input_B21 = 32'b11001000000101100000000000000000; //-153600.0
		input_B22 = 32'b01000111101011000000000000000000; //88064
		// C11 = 572541370368 , C12 = -389837488128 , C21 = 35947597135872 , C22 = -24508140486656




	end
	always@ * repeat (500) #20 input_Clk = ~input_Clk;
   
endmodule

