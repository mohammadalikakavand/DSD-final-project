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
		write_enable   = 0;
		reset = 0;
		clk = 0;

		#105;
        reset = 1;
		write_enable   = 1;

		//set status >> DONT START
		memory_data_in = 32'b0;
		memory_address = 12'd0;

		#20
		//set confing
		memory_data_in = 32'h04040404;
		memory_address = 12'd1;

						/* first matrix is
							1		14.5	320		180.4
							735.2	1.4		0.564	34
							23.3	988		0.846	0.365
							11.9755	3999	635		11.23
						*/
		#20
		//set first matrix index 1,1
		memory_data_in = 32'b00111111100000000000000000000000; //1
		memory_address = 12'd2;

		#20
		//set first matrix index 1,2
		memory_data_in = 32'b01000001011010000000000000000000; //14.5
		memory_address = 12'd3;

		#20
		//set first matrix index 1,3
		memory_data_in = 32'b01000011101000000000000000000000; //320
		memory_address = 12'd4;

		#20
		//set first matrix index 1,4
		memory_data_in = 32'b01000011001101000110011001100110; //180.4
		memory_address = 12'd5;

		#20
		//set first matrix index 2,1
		memory_data_in = 32'b01000100001101111100110010111001; //735.2
		memory_address = 12'd6;

		#20
		//set first matrix index 2,2
		memory_data_in = 32'b00111111101100110011001100110011; //1.4
		memory_address = 12'd7;

		#20
		//set first matrix index 2,3
		memory_data_in = 32'b00111111000100000110001001001110; //0.564
		memory_address = 12'd8;

		#20
		//set first matrix index 2,4
		memory_data_in = 32'b01000010000010000000000000000000; //34
		memory_address = 12'd9;

		#20
		//set first matrix index 3,1
		memory_data_in = 32'b01000001101110100110011001100110; //23.3
		memory_address = 12'd10;

		#20
		//set first matrix index 3,2
		memory_data_in = 32'b01000100011101110000000000000000; //988
		memory_address = 12'd11;

		#20
		//set first matrix index 3,3
		memory_data_in = 32'b00111111111011000100100110111010; //1.846
		memory_address = 12'd12;

		#20
		//set first matrix index 3,4
		memory_data_in = 32'b00111110101110101110000101001000; //0.365
		memory_address = 12'd13;

		#20
		//set first matrix index 4,1
		memory_data_in = 32'b01000001001111111001101110100110; //11.97.55
		memory_address = 12'd14;

		#20
		//set first matrix index 4,2
		memory_data_in = 32'b01000101011110011111000000000000; //3999
		memory_address = 12'd15;

		#20
		//set first matrix index 4,3
		memory_data_in = 32'b01000100000111101100000000000000; //635
		memory_address = 12'd16;

		#20
		//set first matrix index 4,4
		memory_data_in = 32'b01000001001100111010111000010100; //11.23
		memory_address = 12'd17;

		//////////////////////////////////////////////////////////////

						/* second matrix is
							64.358	29.158	3445	44.18
							107.3	16.4	31.162	46.21
							29.6	4.772	50.575	30.636
							59.46	94.5	109.013	12.4
						*/
		#20
		//set first matrix index 1,1
		memory_data_in = 32'b01000010100000001011011101001100; //64.358
		memory_address = 12'd1026;

		#20
		//set first matrix index 1,2
		memory_data_in = 32'b01000001111010010100001110010110; //29.158
		memory_address = 12'd1027;

		#20
		//set first matrix index 1,3
		memory_data_in = 32'b01000101010101110101000000000000; //3445
		memory_address = 12'd1028;

		#20
		//set first matrix index 1,4
		memory_data_in = 32'b01000010001100001011100001010010; //44.18
		memory_address = 12'd1029;

		#20
		//set first matrix index 2,1
		memory_data_in = 32'b01000010110101101001100110011010; //107.3
		memory_address = 12'd1030;

		#20
		//set first matrix index 2,2
		memory_data_in = 32'b01000001100000110011001100110011; //16.4
		memory_address = 12'd1031;

		#20
		//set first matrix index 2,3
		memory_data_in = 32'b01000001111110010100101111000111; //31.162
		memory_address = 12'd1032;

		#20
		//set first matrix index 2,4
		memory_data_in = 32'b01000010001110001101011100001010; //46.21
		memory_address = 12'd1033;

		#20
		//set first matrix index 3,1
		memory_data_in = 32'b01000001111011001100110011001101; //29.6
		memory_address = 12'd1034;

		#20
		//set first matrix index 3,2
		memory_data_in = 32'b01000000100110001011010000111001; //4.772
		memory_address = 12'd1035;

		#20
		//set first matrix index 3,3
		memory_data_in = 32'b01000010010010100100110011001101; //50.575
		memory_address = 12'd1036;

		#20
		//set first matrix index 3,4
		memory_data_in = 32'b01000001111101010001011010000111; //30.636
		memory_address = 12'd1037;

		#20
		//set first matrix index 4,1
		memory_data_in = 32'b01000010011011011101011100001010; //59.46
		memory_address = 12'd1038;

		#20
		//set first matrix index 4,2
		memory_data_in = 32'b01000010101111010000000000000000; //94.5
		memory_address = 12'd1039;

		#20
		//set first matrix index 4,3
		memory_data_in = 32'b01000010110110100000011010101000; //109.013
		memory_address = 12'd1040;

		#20
		//set first matrix index 4,4
		memory_data_in = 32'b01000001010001100110011001100110; //12.4
		memory_address = 12'd1041;

		#20
		//set status >> START
		memory_data_in = 32'b10000000000000000000000000000000;
		memory_address = 12'd0;

		#20
		//set status >> START
		write_enable   = 0;

		#10000

		#20
		// get result matrix. index 1,1
		memory_address = 12'd2050

		#20
		// get result matrix. index 1,2
		memory_address = 12'd2051

		#20
		// get result matrix. index 1,3
		memory_address = 12'd2052

		#20
		// get result matrix. index 1,4
		memory_address = 12'd2053

		#20
		// get result matrix. index 2,1
		memory_address = 12'd2054

		#20
		// get result matrix. index 2,2
		memory_address = 12'd2055

		#20
		// get result matrix. index 2,3
		memory_address = 12'd2056

		#20
		// get result matrix. index 2,4
		memory_address = 12'd2057

		#20
		// get result matrix. index 3,1
		memory_address = 12'd2058

		#20
		// get result matrix. index 3,2
		memory_address = 12'd2059

		#20
		// get result matrix. index 3,3
		memory_address = 12'd2060

		#20
		// get result matrix. index 3,4
		memory_address = 12'd2061

		#20
		// get result matrix. index 4,1
		memory_address = 12'd2062

		#20
		// get result matrix. index 4,2
		memory_address = 12'd2063

		#20
		// get result matrix. index 4,3
		memory_address = 12'd2064

		#20
		// get result matrix. index 4,4
		memory_address = 12'd2065

		#100;
	


	end
      
	always #10 clk = ~clk;

endmodule

