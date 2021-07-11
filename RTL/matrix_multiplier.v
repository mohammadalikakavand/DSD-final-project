`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:08 07/11/2021 
// Design Name: 
// Module Name:    matrix_multiplier 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module matrix_multiplier
    #(parameter DATA_WIDTH=32,
      parameter ADDR_WIDTH=12, // memory address length
      parameter MAX_LEN = 100; // matrices maximum dimensions
      parameter MAX_LEN_LOG = 7)

   (input [(DATA_WIDTH-1):0] memory_data_in,
	input [(ADDR_WIDTH-1):0] memory_address
	input we_a,
    input clk,
	output [(DATA_WIDTH-1):0] memory_data_out
    
    );


    memory my_memory(
        .data_a(),
        .data_b(),
        .addr_a(),
        .addr_b(),
        .we_a(),
        .we_b(),
        .clk(),
        .q_a(),
        .q_b());
        defparam my_memory.DATA_WIDTH = DATA_WIDTH;
        defparam my_memory.ADDR_WIDTH = ADDR_WIDTH;


    multiplier my_multiplier(
        .data_a(),
        .data_b(),
        .addr_a(),
        .addr_b(),
        .we_a(),
        .we_b(),
        .clk(),
        .result_ready(),
        .reset(),
        .q_a(),
        .q_b());
        defparam my_multiplier.DATA_WIDTH = DATA_WIDTH;
        defparam my_multiplier.ADDR_WIDTH = ADDR_WIDTH;
        defparam my_multiplier.MAX_LEN = MAX_LEN;
        defparam my_multiplier.MAX_LEN_LOG = MAX_LEN_LOG;


endmodule
