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
    #(parameter DATA_WIDTH=32,
      parameter ADDR_WIDTH=12, // memory address length
      parameter MAX_LEN = 100; // matrices maximum dimensions
      parameter MAX_LEN_LOG = 7)
(
    input [(DATA_WIDTH-1):0] data_a, data_b,        // connected to memory ports
	output reg [(ADDR_WIDTH-1):0] addr_a, addr_b,   // connected to memory ports
	output reg we_a, we_b, clk, result_ready, is_working,
    input reset,
	output reg [(DATA_WIDTH-1):0] q_a, q_b          // write data in memory
);

    reg [(MAX_LEN_LOG-1):0] FIRST_ROWS, SECOND_COLUMNS, MIDDLE_LEN; //matrices dimentions

    reg [(MAX_LEN_LOG-1):0] calculating_row, calculating_column, calculating_index; //first index of target product


    reg [(MAX_LEN_LOG-1):0] sum_number_calculating_element;
    reg [(DATA_WIDTH-1):0] adder_in_upRight, adder_in_upLeft, adder_in_downRight, adder_in_downLeft;
    wire [(DATA_WIDTH-1):0] adder_out_upRight, adder_out_upLeft, adder_out_downRight, adder_out_downLeft;
    wire is_adder_free, is_adder_out_ready;
    reg add_mul_state, start_add, reset_adder;

    wire [(DATA_WIDTH-1):0] data_1_result_upRight, data_1_result_upLeft, data_1_result_downRight, data_1_result_downLeft;
    wire [(DATA_WIDTH-1):0] data_2_result_upRight, data_2_result_upLeft, data_2_result_downRight, data_2_result_downLeft;
    wire [(DATA_WIDTH-1):0] data_3_result_upRight, data_3_result_upLeft, data_3_result_downRight, data_3_result_downLeft;

    reg mul1_start, mul2_start, mul3_start;
    reg mul1_C_Ack, mul2_C_Ack, mul3_C_Ack;

    wire mul1_finish, mul2_finish, mul3_finish;
    wire mul1_AB_Ack, mul2_AB_Ack, mul3_AB_Ack;

    // first 2x2 matrix values
    reg [(DATA_WIDTH-1):0] data_a_upRight, data_a_upLeft, data_a_downRight, data_a_downLeft;
    // second 2x2 marix values
    reg [(DATA_WIDTH-1):0] data_b_upRight, data_b_upLeft, data_b_downRight, data_b_downLeft;
    // first multiplier first operand
    reg [(DATA_WIDTH-1):0] data_1_first_upRight, data_1_first_upLeft, data_1_first_downRight, data_1_first_downLeft;
    //first multiplier second operand
    reg [(DATA_WIDTH-1):0] data_1_second_upRight, data_1_second_upLeft, data_1_second_downRight, data_1_second_downLeft;
    // second multiplier first operand
    reg [(DATA_WIDTH-1):0] data_2_first_upRight, data_2_first_upLeft, data_2_first_downRight, data_2_first_downLeft;
    // second multiplier second operand
    reg [(DATA_WIDTH-1):0] data_2_second_upRight, data_2_second_upLeft, data_2_second_downRight, data_2_second_downLeft;
   // third multiplier first operand
    reg [(DATA_WIDTH-1):0] data_3_first_upRight, data_3_first_upLeft, data_3_first_downRight, data_3_first_downLeft;
    // third multiplier second operand
    reg [(DATA_WIDTH-1):0] data_3_second_upRight, data_3_second_upLeft, data_3_second_downRight, data_3_second_downLeft;

    wire is_mul1_ready, is_mul2_ready, is_mul3_ready;

    reg [2:0] state;
    reg [2:0] next_state;
   
    parameter S_RESET = 3'b000;
    parameter S_READY_NEW_ELEMENT = 3'b001;
    parameter S_GET_FROM_MEMORY = 3'b010;
    parameter S_SEND_TO_MUL = 3'b011;
    parameter S_WAIT_FOR_RESULT = 3'b100;
    parameter S_WRITE_RESULT = 3'b101;
    parameter S_FINISH = 3'b110;
    parameter S_WAITING = 3'b111;

    parameter ADDRESS_SECOND_MATRIX = 1026;
    parameter ADDRESS_RESULT_MATRIX = 2050;

    reg [2:0] item_index;

    reg [(ADDR_WIDTH-1):0] address_first_square, address_second_square, address_result_square, address_second_matrix;

    always @ (posedge clk, negedge reset)
    begin
        if (~reset) begin
            state <= S_WAITING;
            next_state <= S_RESET;
            is_working <= 1'b0;
            result_ready <= 1'b0;
            add_mul_state <= 1'b0;
            addr_a <= 0;
            reset_adder <= 1'b0;
        end
        else begin
            case (state)

            S_WAITING: begin
                state <= next_state;
                we_a <= 1'b0;
                we_b <= 1'b0;
            end

            S_RESET: begin
                if (~is_working) begin
                    if (data_a[31] == 1'b1) begin
                        addr_a <= 1;
                        result_ready <= 1'b0;
                        is_working <= 1'b1;
                        state <= S_WAITING;
                        next_state <= S_RESET;
                    end
                    else begin
                        state <= S_RESET;
                        addr_a <= 0;
                    end
                end
                else begin
                    FIRST_ROWS <= q_a[31:24];
                    MIDDLE_LEN <= q_a[23:16];
                    SECOND_COLUMNS <= q_a[7:0];
                    sum_number_calculating_element <= ((q_a[23:16] + 1'b1) >> 1);
                    calculating_row <= 0;
                    calculating_column <= 0;
                    calculating_index <= 0;
                    state <= S_READY_NEW_ELEMENT;
                    we_b <= 1'b0;
                    we_a <= 1'b0;
                    address_first_square <= 2;
                    address_second_square <= ADDRESS_SECOND_MATRIX;
                    address_result_square <= ADDRESS_RESULT_MATRIX;
                    address_second_matrix <= ADDRESS_SECOND_MATRIX;
                end

            end

            S_READY_NEW_ELEMENT: begin
                reset_adder <= 1'b0;
                calculating_index <= 0;
                addr_a <= address_first_square;
                address_first_square <= address_first_square + 1;
                addr_b <= address_second_square;
                address_second_square <= address_second_square + 1;
                item_index <= 3'b000;
                state <= S_GET_FROM_MEMORY;
                we_a <= 1'b0;
                we_b <= 1'b0;
            end

            S_GET_FROM_MEMORY: begin
                reset_adder <= 1'b1;
                if (item_index == 3'b000) begin
                    addr_a <= address_first_square;
                    address_first_square <= address_first_square + MIDDLE_LEN - 1;
                    addr_b <= address_second_square;
                    address_second_square <= address_second_square + SECOND_COLUMNS - 1;
                    item_index <= 3'b001;
                    state <= S_GET_FROM_MEMORY;
                end
                else if (item_index == 3'b001) begin
                    data_a_upLeft <= data_a;
                    data_b_upLeft <= data_b;
                    addr_a <= address_first_square;
                    address_first_square <= address_first_square + 1;
                    addr_b <= address_second_square;
                    address_second_square <= address_second_square + 1;
                    item_index <= 3'b010;
                    state <= S_GET_FROM_MEMORY;

                end
                else if (item_index == 3'b010) begin
                    if(calculating_index == (MIDDLE_LEN - 1)) begin
                        data_a_upRight <= 0;
                    end
                    else begin
                        data_a_upRight <= data_a;
                    end
                    if(calculating_column == (SECOND_COLUMNS - 1)) begin
                        data_b_upRight <= 0;
                    end
                    else begin
                        data_b_upRight <= data_b;
                    end
                    addr_a <= address_first_square;
                    addr_b <= address_second_square;
                    item_index <= 3'b011;
                    state <= S_GET_FROM_MEMORY;
                end
                else if (item_index == 3'b011) begin
                    if(calculating_row == (FIRST_ROWS-1)) begin
                        data_a_downLeft <= 0;
                    end
                    else begin
                        data_a_downLeft <= data_a;
                    end
                    if(calculating_index == (MIDDLE_LEN - 1)) begin
                        data_b_downLeft <= 0;
                    end
                    else begin
                        data_b_downLeft <= data_b;
                    end
                    item_index <= 3'b100;
                    state <= S_GET_FROM_MEMORY;
                end
                else begin
                    if((calculating_row == (FIRST_ROWS-1)) || (calculating_index == (MIDDLE_LEN - 1))) begin
                        data_a_downRight <= 0;
                    end
                    else begin
                        data_a_downRight <= data_a;
                    end
                    if((calculating_index == (MIDDLE_LEN - 1)) || (calculating_column == (SECOND_COLUMNS - 1)) ) begin
                        data_b_downRight <= 0;
                    end
                    else begin
                        data_b_downRight <= data_b;
                    end
                    item_index <= 3'b000;
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
                    mul1_start <= 1'b1;
                    state <= S_WAIT_FOR_RESULT;
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
                    mul2_start <= 1'b1;
                    state <= S_WAIT_FOR_RESULT;
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
                    mul3_start <= 1'b1;
                    state <= S_WAIT_FOR_RESULT;
                end
                else begin
                    state <=S_SEND_TO_MUL
                end
            end

            S_WAIT_FOR_RESULT: begin
                mul1_start <= 1'b0;
                mul2_start <= 1'b0;
                mul3_start <= 1'b0;

                if (calculating_index < (MIDDLE_LEN-2)) begin
                    calculating_index <= calculating_index + 2;
                    address_first_square <= address_first_square - MIDDLE_LEN + 2;
                    addr_a <= address_first_square - MIDDLE_LEN + 1;
                    address_second_square <= address_second_square + SECOND_COLUMNS;
                    addr_b <= address_second_square + SECOND_COLUMNS - 1;
                    state <= S_GET_FROM_MEMORY;
                end

                else begin
                    if (is_adder_out_ready) begin  //// result of adder is ready
                        state <= S_WRITE_RESULT;
                        addr_a <= address_result_square;
                        addr_b <= address_result_square + 1;
                        address_result_square <= address_result_square + SECOND_COLUMNS;
                        we_a <= 1'b1;
                        we_b <= 1'b1;
                        q_a <= adder_out_upLeft
                        q_b <= adder_out_upRight

                    end 
                    else
                        state <= S_WAIT_FOR_RESULT;
                    end
                end
            end

            S_WRITE_RESULT: begin
                addr_a <= address_result_square;
                addr_b <= address_result_square + 1;
                we_a <= 1'b1;
                we_b <= 1'b1;
                q_a <= adder_out_downLeft
                q_b <= adder_out_downRight

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
                we_a <= 1'b1;
                we_b <= 1'b1;
                addr_a <= 0;
                q_a <= 1;
                result_ready <= 1'b1;
                is_working <= 1'b0;
                next_state <= S_RESET;
                state <= S_WAITING;
            end

            endcase
        end
    end

    AxA_multiplier first_AxA_multiplier (
        .input_Clk(clk),
        .input_Reset(reset),
        .input_Stable(mul1_start),
        .input_C_Ack(mul1_C_Ack),
        .input_A11(data_1_first_upLeft),
        .input_A12(data_1_first_upRight),
        .input_A21(data_1_first_downLeft),
        .input_A22(data_1_first_downRight),
        .input_B11(data_1_second_upLeft),
        .input_B12(data_1_second_upRight),
        .input_B21(data_1_second_downLeft),
        .input_B22(data_1_second_downRight),
        .output_AB_Ack(mul1_AB_Ack),
        .output_Stable(mul1_finish),
        .output_C11(data_1_result_upLeft),
        .output_C12(data_1_result_upRight),
        .output_C21(data_1_result_downLeft),
        .output_C22(data_1_result_downRight),
        .output_Free(is_mul1_ready)
    );

    AxA_multiplier second_AxA_multiplier (
        .input_Clk(clk),
        .input_Reset(reset),
        .input_Stable(mul2_start),
        .input_C_Ack(mul2_C_Ack),
        .input_A11(data_2_first_upLeft),
        .input_A12(data_2_first_upRight),
        .input_A21(data_2_first_downLeft),
        .input_A22(data_2_first_downRight),
        .input_B11(data_2_second_upLeft),
        .input_B12(data_2_second_upRight),
        .input_B21(data_2_second_downLeft),
        .input_B22(data_2_second_downRight),
        .output_AB_Ack(mul2_AB_Ack),
        .output_Stable(mul2_finish),
        .output_C11(data_2_result_upLeft),
        .output_C12(data_2_result_upRight),
        .output_C21(data_2_result_downLeft),
        .output_C22(data_2_result_downRight),
        .output_Free(is_mul2_ready)
    );
    
    AxA_multiplier third_AxA_multiplier (
        .input_Clk(clk),
        .input_Reset(reset),
        .input_Stable(mul3_start),
        .input_C_Ack(mul3_C_Ack),
        .input_A11(data_3_first_upLeft),
        .input_A12(data_3_first_upRight),
        .input_A21(data_3_first_downLeft),
        .input_A22(data_3_first_downRight),
        .input_B11(data_3_second_upLeft),
        .input_B12(data_3_second_upRight),
        .input_B21(data_3_second_downLeft),
        .input_B22(data_3_second_downRight),
        .output_AB_Ack(mul3_AB_Ack),
        .output_Stable(mul3_finish),
        .output_C11(data_3_result_upLeft),
        .output_C12(data_3_result_upRight),
        .output_C21(data_3_result_downLeft),
        .output_C22(data_3_result_downRight),
        .output_Free(is_mul3_ready)
    );

    AxA_adder adder (
        .input_A11(adder_in_upLeft),
        .input_A12(adder_in_upRight),
        .input_A21(adder_in_downLeft),
        .input_A22(adder_in_downRight),
        .input_Clk(clk),
        .input_Reset(reset_adder),
        .input_Start(start_add),
        .output_free(is_adder_free),
        .output_Stable(is_adder_out_ready),
        .output_C11_sum(adder_out_upLeft),
        .output_C12_sum(adder_out_upRight),
        .output_C21_sum(adder_out_downLeft),
        .output_C22_sum(adder_out_downRight)
        .sum_number(sum_number_calculating_element)
    );

    always @(posedge clk)
    begin
        if (add_mul_state == 1'b0) begin
            mul1_C_Ack <= 1'b0;
            mul2_C_Ack <= 1'b0;
            mul3_C_Ack <= 1'b0;
            add_mul_state <= 1'b1;
            start_add <= 1'b0;
        end
        else if (is_adder_free) begin
            if (mul1_finish) begin
                adder_in_upLeft <= data_1_result_upLeft;
                adder_in_upRight <= data_1_result_upRight;
                adder_in_downLeft <= data_1_result_downLeft;
                adder_in_downRight <= data_1_result_downRight;
                add_mul_state <= 1'b0;
                start_add <= 1'b1;
                mul1_C_Ack <= 1'b1;
            end
            else if (mul2_finish) begin
                adder_in_upLeft <= data_2_result_upLeft;
                adder_in_upRight <= data_2_result_upRight;
                adder_in_downLeft <= data_2_result_downLeft;
                adder_in_downRight <= data_2_result_downRight;
                add_mul_state <= 1'b0;
                start_add <= 1'b1;
                mul2_C_Ack <= 1'b1;
            end
            else if (mul3_finish) begin
                adder_in_upLeft <= data_3_result_upLeft;
                adder_in_upRight <= data_3_result_upRight;
                adder_in_downLeft <= data_3_result_downLeft;
                adder_in_downRight <= data_3_result_downRight;
                add_mul_state <= 1'b0;
                start_add <= 1'b1;
                mul3_C_Ack <= 1'b1;
            end
        end
    end
    

endmodule
