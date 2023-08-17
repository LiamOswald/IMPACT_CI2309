// +-----------------------------+
// SRAM Bank created from Registers
// Liam Oswald - wdo1621@jagmail.southalabama.edu

module SramBank00 (Address, DataIn, DataOut, clk, WE, RE);

parameter AddressSize = 1024;
parameter WordSize = 32;

input [AddressSize-1:0] Address;
input [WordSize-1:0] DataIn;
output [WordSize-1:0] DataOut;
input clk, WE, RE;

reg [WordSize-1:0] Mem [0:(1<<AddressSize)-1];

assign DataIn = (!clk && !RE) ? Mem[Address] : {WordSize{1'bz}};

always @(clk or WE)
  if (!clk && !WE)
    Mem[Address] = DataOut;

endmodule

`default_nettype wire
