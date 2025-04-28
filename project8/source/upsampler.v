`timescale 1ns / 1ps

module upsampler(
    input wire        clk,
    input wire        rst_n,
    input wire        new_symbol,
    input wire [3:0]  input_data_1,
    input wire [3:0]  input_data_2,
    input wire [3:0]  sample_rate,
    output reg [3:0]  output_data_1,
    output reg [3:0]  output_data_2
);

    parameter S0_IDLE = 1'b0;
    parameter S1_SAMPLING = 1'b1;
    parameter ZERO_PAD = 4'b0000;

    // Internal states
    reg [3:0] sample_count_current;
    reg [3:0] sample_count_next;
    reg       state_current;
    reg       state_next;

    reg [3:0] sample_rate_q;
    reg [3:0] output_data_1_next;
    reg [3:0] output_data_2_next;

    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n) begin
            sample_count_current <= 4'd0;
            state_current <= S0_IDLE;
            output_data_1 <= 4'd0;
            output_data_2 <= 4'd0;
        end else begin
            sample_rate_q <= sample_rate;
            sample_count_current <= sample_count_next;
            state_current <= state_next;
            output_data_1 <= output_data_1_next;
            output_data_2 <= output_data_2_next;
        end
    end

    always @(*)
    begin
        // Default assignments
        sample_count_next = sample_count_current;
        state_next = state_current;
        output_data_1_next = output_data_1;
        output_data_2_next = output_data_2;

        case (state_current)
            S0_IDLE: begin
                if (new_symbol == 1'b1) begin
                    state_next = S1_SAMPLING;
                    sample_count_next = 4'd0;
                    output_data_1_next = input_data_1;
                    output_data_2_next = input_data_2;
                end
            end

            S1_SAMPLING: begin
                sample_count_next = sample_count_current + 1'b1;

                if (sample_count_current == sample_rate_q - 2) begin
                    state_next = S0_IDLE;
                    sample_count_next = 4'd0;
                    output_data_1_next = ZERO_PAD;
                    output_data_2_next = ZERO_PAD;
                end else begin
                    output_data_1_next = ZERO_PAD;
                    output_data_2_next = ZERO_PAD;
                end
            end
        endcase
    end

endmodule