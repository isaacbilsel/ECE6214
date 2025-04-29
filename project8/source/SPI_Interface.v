`timescale 1ns / 1ps

module SPI_Interface(
    input wire        SCLK,
    input wire        MOSI,
    input wire        CSN,
    input wire        rst_n,
    input wire [7:0]  reg_read_data,
    output reg        MISO,
    output reg        MISO_enable,
    output reg [9:0]  reg_address,
    output reg [7:0]  reg_write_data,
    output reg        reg_write_enable,
    output reg        reg_read_enable
);

    // Internal registers
    reg [7:0]         spi_shiftreg_current;
    reg [2:0]         state_current;
    reg [5:0]         bit_count_current;
    reg               reg_readwrite_current;
    reg               MISO_positive_edge;
    reg               MISO_enable_positive_edge;
    reg [7:0]         MISO_buffer_current;

    // Internal combinational registers
    reg [7:0]         spi_shiftreg_next;
    reg [2:0]         state_next;
    reg [5:0]         bit_count_next;
    reg               reg_readwrite_next;
    reg               MISO_next;
    reg               MISO_enable_next;
    reg [10:0]        reg_address_next;
    reg [7:0]         reg_write_data_next;
    reg               reg_write_enable_next;
    reg               reg_read_enable_next;
    reg [7:0]         MISO_buffer_next;

    // FSM Definition
    parameter [2:0]   S0_IDLE = 3'b000;
    parameter [2:0]   S1_ReadWrite = 3'b001;
    parameter [2:0]   S2_REG_ADDRESS = 3'b010;
    parameter [2:0]   S3_READ = 3'b011;
    parameter [2:0]   S4_WRITE = 3'b100;

    // Sequential logic
    always @(posedge SCLK or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            state_current <= S0_IDLE;
            spi_shiftreg_current <= 8'd0;
            bit_count_current <= 6'd33;
            reg_readwrite_current <= 1'b0;
            reg_address <= 10'd0;
            MISO_positive_edge <= 1'b0;
            MISO_enable_positive_edge <= 1'b0;
            MISO_buffer_current <= 8'd0;
            reg_write_data <= 8'd0;
            reg_write_enable <= 1'b0;
            reg_read_enable <= 1'b0;
        end else begin
            state_current <= state_next;
            spi_shiftreg_current <= spi_shiftreg_next;
            bit_count_current <= bit_count_next;
            reg_readwrite_current <= reg_readwrite_next;
            reg_address <= reg_address_next;
            MISO_positive_edge <= MISO_next;
            MISO_enable_positive_edge <= MISO_enable_next;
            MISO_buffer_current <= MISO_buffer_next;
            reg_write_data <= reg_write_data_next;
            reg_write_enable <= reg_write_enable_next;
            reg_read_enable <= reg_read_enable_next;
        end
    end

    // Falling edge logic for MISO
    always @(negedge SCLK or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            MISO <= 1'b0;
            MISO_enable <= 1'b0;
        end else begin
            MISO <= MISO_positive_edge;
            MISO_enable <= MISO_enable_positive_edge;
        end
    end

    // Combinational logic for MOSI shift register
    always @(*) begin
        spi_shiftreg_next = {spi_shiftreg_current[6:0], MOSI};
    end

    // Combinational logic for state machine
    always @(*) begin
        state_next = state_current;
        bit_count_next = bit_count_current;
        reg_readwrite_next = reg_readwrite_current;
        reg_address_next = reg_address;
        reg_write_data_next = reg_write_data;
        reg_write_enable_next = reg_write_enable;
        reg_read_enable_next = reg_read_enable;
        MISO_enable_next = MISO_enable_positive_edge;
        MISO_buffer_next = MISO_buffer_current;
        MISO_next = MISO_positive_edge;

        case (state_current)
            S0_IDLE: begin
                if (CSN == 1'b0) begin
                    state_next = S1_ReadWrite;
                    bit_count_next = bit_count_current - 1'b1;
                end
            end

            S1_ReadWrite: begin
                state_next = S2_REG_ADDRESS;
                reg_readwrite_next = spi_shiftreg_current[0];
                bit_count_next = bit_count_current - 1'b1;
            end

            S2_REG_ADDRESS: begin
                bit_count_next = bit_count_current - 1'b1;
                if (bit_count_current == 6'd22) begin
                    if (reg_readwrite_current == 1'b0) begin
                        state_next = S3_READ;
                    end else begin
                        state_next = S4_WRITE;
                    end
                    reg_address_next = spi_shiftreg_current[7:0];
                end
            end

            S3_READ: begin
                reg_read_enable_next = 1'b1;
                MISO_buffer_next = reg_read_data;
                bit_count_next = bit_count_current - 1'b1;

                if (bit_count_current == 6'd15) begin
                    MISO_enable_next = 1'b1;
                end else if (bit_count_current <= 6'd7 && MISO_enable_positive_edge == 1'b1) begin
                    MISO_next = MISO_buffer_current[7];
                    MISO_buffer_next = {MISO_buffer_current[6:0], 1'b0};
                end else if (bit_count_current == 6'd0) begin
                    state_next = S0_IDLE;
                    bit_count_next = 6'd33;
                    MISO_enable_next = 1'b0;
                end
            end

            S4_WRITE: begin
                reg_write_enable_next = 1'b1;
                bit_count_next = bit_count_current - 1'b1;
                if (bit_count_current == 6'd5) begin
                    reg_write_data_next = spi_shiftreg_current;
                end else if (bit_count_current == 6'd0) begin
                    state_next = S0_IDLE;
                    bit_count_next = 6'd33;
                    reg_write_enable_next = 1'b0;
                end
            end

            default: begin
                if (CSN == 1'b0) begin
                    state_next = S1_ReadWrite;
                    bit_count_next = bit_count_current - 1'b1;
                end
            end
        endcase
    end
endmodule





/*
//original code

`timescale 1ns / 1ps
module SPI_Interface(
		     input wire	       SCLK,
		     input wire	       MOSI,
		     input wire	       CSN,
                     input wire        rst_n,
		     input wire [7:0] reg_read_data,
		     output reg	       MISO,
		     output reg	       MISO_enable,
		     output reg [9:0]  reg_address,
		     output reg [7:0] reg_write_data,
		     output reg	       reg_write_enable,
		     output reg	       reg_read_enable
		     );

   //internal registers
   reg [7:0]			       spi_shiftreg_current;
   reg [2:0]			       state_current;
   reg [5:0]			       bit_count_current;
   reg				       reg_readwrite_current;
   reg				       MISO_positive_edge;
   reg				       MISO_enable_positive_edge;
   reg [7:0]			       MISO_buffer_current;
   

   //internal combinational registers
   reg [7:0]			       spi_shiftreg_next;
   reg [2:0]			       state_next;
   reg [5:0]			       bit_count_next;
   reg				       reg_readwrite_next;
   reg				       MISO_next;
   reg				       MISO_enable_next;
   reg [10:0]			       reg_address_next;
   reg [7:0]			       reg_write_data_next;
   reg				       reg_write_enable_next;
   reg				       reg_read_enable_next;
   reg [7:0]			       MISO_buffer_next;

   //FSM Definition
   parameter [2:0]		       S0_IDLE = 3'b000;
   parameter [2:0]		       S1_ReadWrite  = 3'b001;
   parameter [2:0]		       S2_REG_ADDRESS = 3'b010;
   parameter [2:0]		       S3_READ = 3'b011;
   parameter [2:0]		       S4_WRITE = 3'b100;

   //sequential logic
   always @(posedge SCLK or negedge rst_n)
     begin
	if(rst_n == 1'b0) begin
	   state_current         <= S0_IDLE;
	   spi_shiftreg_current <= 8'd0;
	   bit_count_current     <= 6'd33;
	   reg_readwrite_current        <= 1'b0;
	   reg_address              <= 10'd0;
	   MISO_positive_edge         <= 1'b0;
	   MISO_enable_positive_edge  <= 1'b0;
	   MISO_buffer_current   <= 8'd0;
	   reg_write_data        <= 8'd0;
	   reg_write_enable      <= 1'b0;
	   reg_read_enable       <= 1'b0;
	  end else begin // if (rst_n == 1'b0)
	   state_current         <= state_next;
	   spi_shiftreg_current <= spi_shiftreg_next;
	   bit_count_current     <= bit_count_next;
	   reg_readwrite_current        <= reg_readwrite_next;
	   reg_address              <= reg_address_next;
	   MISO_positive_edge         <= MISO_next;
	   MISO_enable_positive_edge  <= MISO_enable_next;
	   MISO_buffer_current   <= MISO_buffer_next;
	   reg_write_data        <= reg_write_data_next;
	   reg_write_enable      <= reg_write_enable_next;
	   reg_read_enable       <= reg_read_enable_next;
	end // else: !if(rst_n == 1'b0)
              end // always @ (posedge SCLK or negedge rst_n)

   //falling edge logic for MISO
   always @(negedge SCLK or negedge rst_n)
     begin
	if(rst_n == 1'b0)begin
	   MISO <= 1'b0;
	   MISO_enable <= 1'b0;
	end else begin
	   MISO <= MISO_positive_edge;
	   MISO_enable <= MISO_enable_positive_edge;
	end
     end

   //combinational logic for MOSI shift register
   always @(*)
     begin
	spi_shiftreg_next = {spi_shiftreg_current[6:0], MOSI};
     end


   //combinational logic for state machine
   always @(*)
     begin
	state_next            = state_current;
	bit_count_next        = bit_count_current;
	reg_readwrite_next           = reg_readwrite_current;
	reg_address_next         = reg_address;
	reg_write_data_next   = reg_write_data;
	reg_write_enable_next = reg_write_enable;
	reg_read_enable_next  = reg_read_enable;
	MISO_enable_next      = MISO_enable_positive_edge;
	MISO_buffer_next      = MISO_buffer_current;
	MISO_next             = MISO_positive_edge;
	case(state_current)
	  S0_IDLE: begin
	     if(CSN == 1'b0)begin
		state_next = S1_ReadWrite ;
		bit_count_next = bit_count_current - 1'b1;
	     end
	  end

	  S1_ReadWrite : begin
	     state_next = S2_REG_ADDRESS;
	     reg_readwrite_next = spi_shiftreg_current[0];
	     bit_count_next = bit_count_current - 1'b1;
	  end

	  S2_REG_ADDRESS: begin
	     bit_count_next = bit_count_current - 1'b1;
	     if(bit_count_current == 6'd22)begin
		if(reg_readwrite_current == 1'b0)begin
		   state_next = S3_READ;
		end else begin
		   state_next = S4_WRITE;
		end
		reg_address_next = spi_shiftreg_current[7:0];
	     end
	  end // case: S2_REG_ADDRESS

	S3_READ: begin
    reg_read_enable_next = 1'b1;
    MISO_buffer_next = reg_read_data;
    bit_count_next = bit_count_current - 1'b1;
    
    if (bit_count_current == 6'd15) begin
        MISO_enable_next = 1'b1;
    end else if (bit_count_current <= 6'd7 && MISO_enable_positive_edge == 1'b1) begin
        MISO_next = MISO_buffer_current[7];
        MISO_buffer_next = {MISO_buffer_current[6:0], 1'b0};
    end else if (bit_count_current == 6'd0) begin
        state_next = S0_IDLE;
        bit_count_next = 6'd33;
        MISO_enable_next = 1'b0;
    end
end

	  S4_WRITE: begin
	     reg_write_enable_next = 1'b1;
	     bit_count_next = bit_count_current - 1'b1;
	     if(bit_count_current == 6'd5)begin
		reg_write_data_next = spi_shiftreg_current;
	     end else if(bit_count_current == 6'd0)begin
		state_next = S0_IDLE;
		bit_count_next = 6'd33;
		reg_write_enable_next = 1'b0;
	     end
	  end

	  default: begin
	     if(CSN == 1'b0)begin
		state_next = S1_ReadWrite ;
		bit_count_next = bit_count_current - 1'b1;
	     end
	  end
	endcase // case (state_current)
     end // always @ (*)
   endmodule // SPI_Interface


*/
