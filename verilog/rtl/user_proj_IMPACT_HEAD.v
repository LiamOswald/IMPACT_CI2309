`default_nettype none //why wire? in proj_example it says none
/*
 *-------------------------------------------------------------
 *
 * user_proj_IMPACT_Head
 *
 * This head was built by LiamOswald for the University of South Alabama's SRAM research into various SRAM banks
 * If Liam isn't lazy, he will update this comment with real information at a later date... don't bet on it.
 * Email him: wdo1621@jagmail.southalabama.edu
 *
 *-------------------------------------------------------------
 */
`include "user_defines.v" //why this?
`include "BankWordDecoder.v"

module user_proj_IMPACT_HEAD (

`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif



//   inout vccd1, // User area 1 1.8V supply
//   inout vssd1, // User area 1 digital ground


    // Wishbone Slave ports (WB MI A)

    // Logic Analyzer Signals

    // IRQ
    input [31:0] North,
    input [31:0] East,
    output [31:0] South

);

//wire [31:0] WL_Bank01;
//################################################
//Creates the Four Word Decoders Instences for the Four Memory Banks
//################################################

wire [1023:0] Bank01WL;

BankWordDecoder Bank01_Decoder(
	.sel(North [9:0]),
	.address(Bank01WL)
);

//Bank01 SRAM Block
IMPACTSram testbank(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),
	.vccd2(vccd2),
	.vssd1(vssd1),	// User area 1 1.8V power
	.vssd2(vssd2),	// User area 1 digital ground
`endif
	
	.PRE(North[12]),
	.ReadEn(North[13]),
	.WriteEn(North[14]),
	.WL(Bank01WL),
	.DataIn(East),
	.DataOut(South)

);

endmodule

/*
module BankWordDecoder(
input [9:0]sel,
output [1023:0] address
);

    integer i;
    always@(sel) begin
        for(i=0;i<1024;i=i+1) begin
            address[i]=(sel==i)?1'b1:1'b0;
        end
    end

endmodule
*/



`default_nettype wire


