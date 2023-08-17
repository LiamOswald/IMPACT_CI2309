//Will be left in the design for future use... maybe...

module bank_byte_mux (
    input [31:0] word,
    input [1:0] select,
    output reg [7:0] byte
);

always @(*) begin
    case (select)
        2'b00: byte = word[7:0]; // byte 0
        2'b01: byte = word[15:8]; // byte 1
        2'b10: byte = word[23:16]; // byte 3
        2'b11: byte = word[31:24]; // byte 4
    endcase
    end
endmodule

