module data_in_decoder(
    input clk,				//Clock
    input write_enable,			//SRAM Write Enable signal
    input [7:0] data_in,		//Memory byte input
    input [1:0] sel,			//Select Byte from Word
    output reg [31:0] data_out		//SRAM input
);

    always @(posedge clk) begin
        if(write_enable) begin
            case (sel)
                2'b00: data_out[7:0] <= data_in;
                2'b01: data_out[15:8] <= data_in;
                2'b10: data_out[23:16] <= data_in;
                2'b11: data_out[31:24] <= data_in;
            endcase
        end
    end

endmodule
