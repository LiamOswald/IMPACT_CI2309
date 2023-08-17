module 4_to_1_byte_mux (
		input [31:0] data_in,
                input [1:0] sel,
                output reg [7:0] data_out
);

always @(*) begin
   case (sel)
      2'b00: data_out = data_in[7:0];
      2'b01: data_out = data_in[15:8];
      2'b10: data_out = data_in[23:16];
      2'b11: data_out = data_in[32:24];
   endcase
end

endmodule
