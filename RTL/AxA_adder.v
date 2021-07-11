`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:34 07/09/2021 
// Design Name: 
// Module Name:    AxA_adder 
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
module AxA_adder
    #(parameter MAX_LEN = 100, // matrices maximum dimensions
      parameter MAX_LEN_LOG = 7)
(
    input_A11,
    input_A12,
    input_A21,
    input_A22,

    input_Clk,
    input_Reset,
    input_Start, // for starting the addition progress

    output_free, // the addre is ready for strarting addition
    output_Stable, // acknowledging "the output is ready!"

    output_C11_sum,
    output_C12_sum,
    output_C21_sum,
    output_C22_sum,
    sum_number); // number of sum operation needs to be done

    input [31:0] input_A11, input_A12, input_A21, input_A22;
    output reg [31:0] output_C11_sum, output_C12_sum, output_C21_sum, output_C22_sum;

    input input_Clk;
    input input_Reset;
    input input_Start;
    output reg output_free;
    output reg output_Stable;
    input [MAX_LEN_LOG - 1:0] sum_number;

    ////////////////////////////////////////////////////////////////////
    reg [MAX_LEN_LOG - 1:0] sum_number_reg;
    reg [MAX_LEN_LOG - 1:0] number_of_ops; 
    reg [1:0] state;
    reg [1:0] next_state;
    reg start_control;
    reg ack;
    wire [31:0] output_C11, output_C12, output_C21, output_C22;
    wire [3:0] stable;
    parameter WAITING       = 2'b00,
              CALCULATING   = 2'b01,
              DONE          = 2'b10;

    always @(posedge input_Clk or negedge input_Reset) begin
        if(!input_Reset) begin
        number_of_ops <= 0;
        state <= WAITING;
        output_C11_sum <= 0;
        output_C12_sum <= 0;
        output_C21_sum <= 0;
        output_C22_sum <= 0;
        sum_number_reg <= sum_number;
        end
        else begin
            state <= next_state;
            if (stable[0] & stable[1] & stable[2] & stable[3]) begin
                output_C11_sum <= output_C11_sum + output_C11;
                output_C12_sum <= output_C12_sum + output_C12;
                output_C21_sum <= output_C21_sum + output_C21;
                output_C22_sum <= output_C22_sum + output_C22;
                number_of_ops <= number_of_ops + 1;
            end
        end
    end

    always @(*) begin
        case(state)
        WAITING: begin
            output_free <= 1;
            output_Stable <= 0;
            if (input_Start) begin
                next_state <= CALCULATING;
                start_control <= 1;
            end
            else  begin
                next_state <= WAITING;
                start_control <= 0;
            end
        end

        CALCULATING: begin
             start_control <= 0;
             output_free <= 0;
             output_Stable <= 0;
             if (stable[0] & stable[1] & stable[2] & stable[3]) begin
                  ack <= 1;
                 if(number_of_ops == sum_number_reg - 1) begin
                  output_Stable <= 1;
                  next_state <= DONE;
                 end
                 else begin
                    next_state <= WAITING; 
                 end
             end
             else begin
               next_state <= CALCULATING;
               ack <= 0;
             end
        end

        DONE: begin
             start_control <= 0;
             output_free <= 0;
             output_Stable <= 1;
             next_state <= DONE;
        end

        endcase
    end


    adder adder_1(
    .clk(input_Clk),
    .reset(input_Reset), 
    .load(start_control),
    .Number1(input_A11), 
    .Number2(output_C11_sum), 
    .result_ack(ack),
    .Result(output_C11),
    .result_ready(stable[0]));

    adder adder_2(
    .clk(input_Clk),
    .reset(input_Reset), 
    .load(start_control),
    .Number1(input_A12), 
    .Number2(output_C12_sum), 
    .result_ack(ack),
    .Result(output_C12),
    .result_ready(stable[1]));

    adder adder_3(
    .clk(input_Clk),
    .reset(input_Reset), 
    .load(start_control),
    .Number1(input_A21), 
    .Number2(output_C21_sum), 
    .result_ack(ack),
    .Result(output_C21),
    .result_ready(stable[2]));

    adder adder_4(
    .clk(input_Clk),
    .reset(input_Reset), 
    .load(start_control),
    .Number1(input_A22), 
    .Number2(output_C22_sum), 
    .result_ack(ack),
    .Result(output_C22),
    .result_ready(stable[3]));          


endmodule
