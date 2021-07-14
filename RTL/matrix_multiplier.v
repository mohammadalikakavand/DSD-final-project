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
      parameter MAX_LEN = 100, // matrices maximum dimensions
      parameter MAX_LEN_LOG = 7)

   (input [(DATA_WIDTH-1):0] memory_data_in,
	input [(ADDR_WIDTH-1):0] memory_address,
	input write_enable,
    input reset,
    input clk,

	output [(DATA_WIDTH-1):0] memory_data_out,
    output wire result_ready
    );


    wire  [(DATA_WIDTH-1):0] data_a, data_b, data_b_inner, q_b_inner, q_a, q_b;
    wire  [(ADDR_WIDTH-1):0] addr_a, addr_b, addr_b_inner;
    wire  we_a, we_b, is_working, we_b_inner;

    assign data_b = is_working? data_b_inner : memory_data_in;
    assign addr_b = is_working? addr_b_inner : memory_address;
    assign we_b = is_working? we_b_inner : write_enable;
    assign memory_data_out = is_working? {DATA_WIDTH{1'bz}} : q_b;
    assign q_b_inner = is_working? q_b : {DATA_WIDTH{1'bz}};

    memory my_memory(
        .data_a(data_a),
        .data_b(data_b),
        .addr_a(addr_a),
        .addr_b(addr_b),
        .we_a(we_a),
        .we_b(we_b),
        .clk(clk),
        .q_a(q_a),
        .q_b(q_b));
        defparam my_memory.DATA_WIDTH = DATA_WIDTH;
        defparam my_memory.ADDR_WIDTH = ADDR_WIDTH;


    multiplier my_multiplier(
        .data_a(q_a),
        .data_b(q_b_inner),
        .addr_a(addr_a),
        .addr_b(addr_b_inner),
        .we_a(we_a),
        .we_b(we_b_inner),
        .clk(clk),
        .result_ready(result_ready),
        .is_working(is_working),
        .reset(reset),
        .q_a(data_a),
        .q_b(data_b_inner));
        defparam my_multiplier.DATA_WIDTH = DATA_WIDTH;
        defparam my_multiplier.ADDR_WIDTH = ADDR_WIDTH;
        defparam my_multiplier.MAX_LEN = MAX_LEN;
        defparam my_multiplier.MAX_LEN_LOG = MAX_LEN_LOG;


endmodule
