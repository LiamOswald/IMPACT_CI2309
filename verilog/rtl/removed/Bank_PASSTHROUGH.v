module bank_passthrough (
		input [31:0] data_in,
                input [1023:0] word_sel,
                input write_enable
                input read_enable
                output reg [31:0] data_out);

always @(*) begin
   data_out = data_in
   endcase
end

endmodule
