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
    reg [(DATA_WIDTH-1):0] data_1_first_upRight, data_1_first_upLeft, data_1_first_downRight, data_1_first_downLeft;
    reg [(DATA_WIDTH-1):0] data_1_second_upRight, data_1_second_upLeft, data_1_second_downRight, data_1_second_downLeft;
    reg [(DATA_WIDTH-1):0] data_2_first_upRight, data_2_first_upLeft, data_2_first_downRight, data_2_first_downLeft;
    reg [(DATA_WIDTH-1):0] data_2_second_upRight, data_2_second_upLeft, data_2_second_downRight, data_2_second_downLeft;
    reg [(DATA_WIDTH-1):0] data_3_first_upRight, data_3_first_upLeft, data_3_first_downRight, data_3_first_downLeft;
    reg [(DATA_WIDTH-1):0] data_3_second_upRight, data_3_second_upLeft, data_3_second_downRight, data_3_second_downLeft;

    wire is_mul1_ready, is_mul2_ready, is_mul3_ready;

    reg [2:0] state;
   
    parameter S_RESET = 3'b000;
    parameter S_READY_NEW_ELEMENT = 3'b001;
    parameter S_GET_FROM_MEMORY = 3'b010;
    parameter S_SEND_TO_MUL = 3'b011;
    parameter S_WAIT_FOR_RESAULT = 3'b100;
    parameter S_WRITE_RESAULT = 3'b101;
    parameter S_FINISH = 3'b110;

    reg [1:0] item_index;

    reg [(ADDR_WIDTH-1):0] address_first_square, address_second_square, address_result_square, address_second_matrix;

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
                state <= S_READY_NEW_ELEMENT;
                we_b <= 1'b0;
                we_a <= 1'b0;
                address_first_square <= 2;
                //*
                address_second_square <= 
                address_result_square <=
                address_second_matrix <=
                *//
            end

            S_READY_NEW_ELEMENT: begin
                ////// ready adder to get new numbers
                calculating_index <= 0;
                addr_a <= address_first_square;
                address_first_square <= address_first_square + 1;
                addr_b <= address_second_square;
                address_second_square <= address_second_square + 1;
                item_index <= 2'b00;
                state <= S_GET_FROM_MEMORY;
                we_a <= 1'b0;
                we_b <= 1'b0;
            end

            S_GET_FROM_MEMORY: begin
                if (item_index == 2'b00) begin
                    data_a_upLeft <= data_a;
                    data_b_upLeft <= data_b;
                    addr_a <= address_first_square;
                    address_first_square <= address_first_square + MIDDLE_LEN - 1;
                    addr_b <= address_second_square;
                    address_second_square <= address_second_square + SECOND_COLUMNS - 1;
                    item_index <= 2'b01;
                    state <= S_GET_FROM_MEMORY;
                end
                else if (item_index == 2'b01) begin
                    data_a_upRight <= data_a;
                    data_b_upRight <= data_b;
                    addr_a <= address_first_square;
                    address_first_square <= address_first_square + 1;
                    addr_b <= address_second_square;
                    address_second_square <= address_second_square + 1;
                    item_index <= 2'b10;
                    state <= S_GET_FROM_MEMORY;

                end
                else if (item_index == 2'b10) begin
                    data_a_downLeft <= data_a;
                    data_b_downLeft <= data_b;
                    addr_a <= address_first_square;
                    addr_b <= address_second_square;
                    item_index <= 2'b11;
                    state <= S_GET_FROM_MEMORY;
                end
                else if (item_index == 2'b11) begin
                    data_a_downRight <= data_a;
                    data_b_downRight <= data_b;
                    item_index <= 2'b00;
                    state <= S_SEND_TO_MUL;
                end
            end

            S_SEND_TO_MUL: begin
                if (is_mul1_ready) begin
                    data_1_first_upLeft <= data_a_upLeft;
                    data_1_first_upRight <= data_a_upRight;
                    data_1_first_downLeft <= data_a_downLeft;
                    data_1_first_downRight <= data_a_downRight;
                    data_1_second_upLeft <= data_b_upLeft;
                    data_1_second_upRight <= data_b_upRight;
                    data_1_second_downLeft <= data_b_downLeft;
                    data_1_second_downRight <= data_b_downRight;
                    state <= S_WAIT_FOR_RESAULT;
                end
                else if (is_mul2_ready) begin
                    data_2_first_upLeft <= data_a_upLeft;
                    data_2_first_upRight <= data_a_upRight;
                    data_2_first_downLeft <= data_a_downLeft;
                    data_2_first_downRight <= data_a_downRight;
                    data_2_second_upLeft <= data_b_upLeft;
                    data_2_second_upRight <= data_b_upRight;
                    data_2_second_downLeft <= data_b_downLeft;
                    data_2_second_downRight <= data_b_downRight;
                    state <= S_WAIT_FOR_RESAULT;
                end
                else if (is_mul3_ready) begin
                    data_3_first_upLeft <= data_a_upLeft;
                    data_3_first_upRight <= data_a_upRight;
                    data_3_first_downLeft <= data_a_downLeft;
                    data_3_first_downRight <= data_a_downRight;
                    data_3_second_upLeft <= data_b_upLeft;
                    data_3_second_upRight <= data_b_upRight;
                    data_3_second_downLeft <= data_b_downLeft;
                    data_3_second_downRight <= data_b_downRight;
                    state <= S_WAIT_FOR_RESAULT;
                end
                else begin
                    state <=S_SEND_TO_MUL
                end
            end

            S_WAIT_FOR_RESAULT: begin
                if (calculating_index < (MIDDLE_LEN-2)) begin
                    calculating_index <= calculating_index + 2;
                    address_first_square <= address_first_square - MIDDLE_LEN + 2;
                    addr_a <= address_first_square - MIDDLE_LEN + 1;
                    address_second_square <= address_second_square + SECOND_COLUMNS;
                    addr_b <= address_second_square + SECOND_COLUMNS - 1;
                    state <= S_GET_FROM_MEMORY;
                end

                else begin
                    if () begin  //// result of adder is ready
                        state <= S_WRITE_RESAULT;
                        addr_a <= address_result_square;
                        addr_b <= address_result_square + 1;
                        address_result_square <= address_result_square + SECOND_COLUMNS;
                        we_a <= 1'b1;
                        we_b <= 1'b1;
                        q_a <= ///// up left of resault
                        q_b <= ///// up right of resault

                    end 
                    else
                        state <= S_WAIT_FOR_RESAULT;
                    end
                end
            end

            S_WRITE_RESAULT: begin
                addr_a <= address_result_square;
                addr_b <= address_result_square + 1;
                we_a <= 1'b1;
                we_b <= 1'b1;
                q_a <=  ///// down left of resault
                q_b <=  ///// down right of resault

                if (calculating_column < (SECOND_COLUMNS - 2)) begin
                    calculating_column <= calculating_column + 2;
                    address_first_square <= address_first_square - (MIDDLE_LEN + MIDDLE_LEN) + 1;
                    address_second_square <= address_second_matrix + calculating_column + 2;
                    address_result_square <= address_result_square - SECOND_COLUMNS + 2;
                    state <= S_READY_NEW_ELEMENT;
                end 
                else if(calculating_row < (FIRST_ROWS - 2)) begin
                    calculating_row <= calculating_row + 2;
                    address_first_square <= address_first_square + 1;
                    address_second_square <= address_second_matrix + calculating_column;
                    address_result_square <= address_result_square + 2;
                    state <= S_READY_NEW_ELEMENT;
                end

                else begin
                    state <= S_FINISH;
                end

            end

            S_FINISH: begin
                we_a <= 1'b0;
                we_b <= 1'b0;
                ///////
            end


            endcase
        end
    end


endmodule
