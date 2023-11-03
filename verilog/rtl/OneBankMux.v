module OneBankMux(
    input clk,				//clock
    input read_enable,			//SRAM Read Enable
    input [31:0] Bank01_Reading,	//SRAM output word
    input [1:0] byte_sel,		//Memory byte output
    output reg [7:0] data_out		//Memory byte output
);

    always@(posedge clk) begin
        if (read_enable) begin
            case (byte_sel)
                2'b00: data_out <= Bank01_Reading[7:0];
                2'b01: data_out <= Bank01_Reading[15:8];
                2'b10: data_out <= Bank01_Reading[23:16];
                2'b11: data_out <= Bank01_Reading[31:24];
            endcase
        end
    end

endmodule

`default_nettype wire
