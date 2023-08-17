//This script is currently unused in the design
//rework this module to hex values for readability -LiamOswald

module 4_to_16_decoder (
    input [3:0] Data_in,
    output reg [15:0] Data_out
);

always @(Data_in) begin
    case (Data_in)
        4'b0000: Data_out = 16'b0000000000000001'; // output line 0
        4'b0001: Data_out = 16'b0000000000000010'; // output line 1
        4'b0010: Data_out = 16'b0000000000000100'; // output line 2
        4'b0011: Data_out = 16'b0000000000001000'; // output line 3
        4'b0100: Data_out = 16'b0000000000010000'; // output line 4
        4'b0101: Data_out = 16'b0000000000100000'; // output line 5
        4'b0110: Data_out = 16'b0000000001000000'; // output line 6
        4'b0111: Data_out = 16'b0000000010000000'; // output line 7
        4'b1000: Data_out = 16'b0000000100000000'; // output line 8
        4'b1001: Data_out = 16'b0000001000000000'; // output line 9
        4'b1010: Data_out = 16'b0000010000000000'; // output line 10
        4'b1011: Data_out = 16'b0000100000000000'; // output line 11
        4'b1100: Data_out = 16'b0001000000000000'; // output line 12
        4'b1101: Data_out = 16'b0010000000000000'; // output line 13
        4'b1110: Data_out = 16'b0100000000000000'; // output line 14
        4'b1111: Data_out = 16'b1000000000000000'; // output line 15

    endcase
    end
endmodule
