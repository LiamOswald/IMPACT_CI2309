module 4byte_to_16byte_decoder(
		input [31:0] data_in,
                input [1:0] sel,
                output reg [127:0] data_out
);

always @(*) begin
   case (sel)
      2'b00: data_out[31:0] = data_in;
      2'b01: data_out[63:32] = data_in;
      2'b10: data_out[95:64] = data_in;
      2'b11: data_out[127:96] = data_in;
   endcase
end

endmodule
