`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:18:19 07/08/2021 
// Design Name: 
// Module Name:    multiplier 
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
module multiplier
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=12)
(
    input [(DATA_WIDTH-1):0] data_a, data_b,
	output reg [(ADDR_WIDTH-1):0] addr_a, addr_b,
	output reg we_a, we_b, clk, result_ready,
    input reset,
	output reg [(DATA_WIDTH-1):0] q_a, q_b
);

    parameter MAX_LEN = 100;
    parameter MAX_LEN_LOG = 8;      ///// log(MAX_LEN)

    reg [(MAX_LEN_LOG-1):0] FIRST_ROWS, SECOND_COLUMNS, MIDDLE_LEN;

    reg [(MAX_LEN_LOG-1):0] calculating_row, calculating_column, calculating_index;

    reg [(DATA_WIDTH-1):0] data_a_upRight, data_a_upLeft, data_a_downRight, data_a_downLeft;
    reg [(DATA_WIDTH-1):0] data_b_upRight, data_b_upLeft, data_b_downRight, data_b_downLeft;

    reg [2:0] state;
   
    parameter S_RESET = 3'b000;
    parameter S_READY_NEW_ELEMENT = 3'b001;
    parameter S_GET_FROM_MEMORY = 3'b010;
    parameter S_SEND_TO_MUL = 3'b011;
    parameter S_WAIT_FOR_RESAULT = 3'b100;
    parameter S_WRITE_RESAULT = 3'b101;
    parameter S_FINISH = 3'b110;

    always @ (posedge clk, negedge reset)
    begin
        if (~reset) begin
            stage <= S_RESET;
            addr_a <= {(ADDR_WIDTH-1){1'b0}, 1'b1}; ///// get size of matrixes
        end
        else begin
            case (state)

            S_RESET: begin
                ///// find size of matrixes from data_a and set them
                calculating_row <= 0;
                calculating_column <= 0;
                calculating_index <= 0;
            end

            S_READY_NEW_ELEMENT: begin
                ////// ready adder to get new numbers
                calculating_index <= 0;
                addr_a <= //////
                addr_b <= //////
            end

            S_GET_FROM_MEMORY: begin
                
            end

            S_SEND_TO_MUL: begin

            end

            S_WAIT_FOR_RESAULT: begin

            end

            S_WRITE_RESAULT: begin

            end

            S_FINISH: begin

            end


            endcase
        end
    end


endmodule
