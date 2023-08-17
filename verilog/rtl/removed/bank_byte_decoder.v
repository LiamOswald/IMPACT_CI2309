//Will be left in the design for future use... maybe...

module bank_byte_mux (
    input [7:0] byte,
    input [1:0] select,
    output reg [31:0] byte
);

always @(*) begin
    case (select)
        2'b00: byte = 24'h000000', word[7:0]; 		// byte 0 = word
        2'b01: byte = 16'h0000', word[15:8], 8'h00'; // byte 1
        2'b10: byte = 8'h00', word[23:16], 16'h0000'; // byte 2
        2'b11: byte = word[31:24], 24'h000000'; // byte 3
    endcase
    end
endmodule

