`default_nettype wire
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
`include "user_defines.v"

module user_proj_IMPACT_HEAD (




    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground


    // Wishbone Slave ports (WB MI A)

    // Logic Analyzer Signals

    // IRQ
    inout [31:0] East,
    inout [31:0] West,
    inout [31:0] South
);

wire [31:0] WL_Bank01;


//################################################
//Creates the Four Word Decoders Instences for the Four Memory Banks
//################################################

BankWordDecoder Decoder01(
	.vccd1(vccd1),
	.vssd1(vssd1),
	.sel(East[9:0]),
	.address(WL_Bank01 [31:0])
);


//Bank01 SRAM Block
IMPACT_Sram bank01(
	.vdd(vccd1),
	.gnd(vssd1),
	.WL0(WL_Bank01 [0]), 
	.WL1(WL_Bank01 [1]), 
	.WL2(WL_Bank01 [2]), 
	.WL3(WL_Bank01 [3]), 
	.WL4(WL_Bank01 [4]), 
	.WL5(WL_Bank01 [5]), 
	.WL6(WL_Bank01 [6]), 
	.WL7(WL_Bank01 [7]), 
	.WL8(WL_Bank01 [8]), 
	.WL9(WL_Bank01 [9]), 
	.WL10(WL_Bank01 [10]), 
	.WL11(WL_Bank01 [11]), 
	.WL12(WL_Bank01 [12]), 
	.WL13(WL_Bank01 [13]), 
	.WL14(WL_Bank01 [14]), 
	.WL15(WL_Bank01 [15]),
	.WL16(WL_Bank01 [16]), 
	.WL17(WL_Bank01 [17]),
	.WL18(WL_Bank01 [18]),
	.WL19(WL_Bank01 [19]),
	.WL20(WL_Bank01 [20]),
	.WL21(WL_Bank01 [21]),
	.WL22(WL_Bank01 [22]),
	.WL23(WL_Bank01 [23]),
	.WL24(WL_Bank01 [24]),
	.WL25(WL_Bank01 [25]),
	.WL26(WL_Bank01 [26]),
	.WL27(WL_Bank01 [27]),
	.WL28(WL_Bank01 [28]),
	.WL29(WL_Bank01 [29]),
	.WL30(WL_Bank01 [30]),
	.WL31(WL_Bank01 [31]),
	
	.BL0(West [0]), 
	.BL1(West [1]), 
	.BL2(West [2]), 
	.BL3(West [3]), 
	.BL4(West [4]), 
	.BL5(West [5]), 
	.BL6(West [6]), 
	.BL7(West [7]), 
	.BL8(West [8]), 
	.BL9(West [9]), 
	.BL10(West [10]), 
	.BL11(West [11]), 
	.BL12(West [12]), 
	.BL13(West [13]), 
	.BL14(West [14]), 
	.BL15(West [15]), 

	
	.BLb0(South [0]),
	.BLb1(South [1]),
	.BLb2(South [2]),
	.BLb3(South [3]),
	.BLb4(South [4]),
	.BLb5(South [5]),
	.BLb6(South [6]),
	.BLb7(South [7]),
	.BLb8(South [8]),
	.BLb9(South [9]),
	.BLb10(South [10]),
	.BLb11(South [11]),
	.BLb12(South [12]),
	.BLb13(South [13]),
	.BLb14(South [14]),
	.BLb15(South [15])

);

endmodule

module BankWordDecoder (

    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground

	input [9:0] sel,
	output reg [31:0] address

);

    integer i;

assign address[0] = ~sel[0] & ~sel[1] & ~sel[2] & ~sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[1] = sel[0] & ~sel[1] & ~sel[2] & ~sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[2] = ~sel[0] & sel[1] & ~sel[2] & ~sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[3] = sel[0] & sel[1] & ~sel[2] & ~sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[4] = ~sel[0] & ~sel[1] & sel[2] & ~sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[5] = sel[0] & ~sel[1] & sel[2] & ~sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[6] = ~sel[0] & sel[1] & sel[2] & ~sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[7] = sel[0] & sel[1] & sel[2] & ~sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[8] = ~sel[0] & ~sel[1] & ~sel[2] & sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[9] = sel[0] & ~sel[1] & ~sel[2] & sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[10] = ~sel[0] & sel[1] & ~sel[2] & sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[11] = sel[0] & sel[1] & ~sel[2] & sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[12] = ~sel[0] & ~sel[1] & sel[2] & sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[13] = sel[0] & ~sel[1] & sel[2] & sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[14] = ~sel[0] & sel[1] & sel[2] & sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[15] = sel[0] & sel[1] & sel[2] & sel[3] & ~sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[16] = ~sel[0] & ~sel[1] & ~sel[2] & ~sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[17] = sel[0] & ~sel[1] & ~sel[2] & ~sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[18] = ~sel[0] & sel[1] & ~sel[2] & ~sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[19] = sel[0] & sel[1] & ~sel[2] & ~sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[20] = ~sel[0] & ~sel[1] & sel[2] & ~sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[21] = sel[0] & ~sel[1] & sel[2] & ~sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[22] = ~sel[0] & sel[1] & sel[2] & ~sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[23] = sel[0] & sel[1] & sel[2] & ~sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[24] = ~sel[0] & ~sel[1] & ~sel[2] & sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[25] = sel[0] & ~sel[1] & ~sel[2] & sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[26] = ~sel[0] & sel[1] & ~sel[2] & sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[27] = sel[0] & sel[1] & ~sel[2] & sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[28] = ~sel[0] & ~sel[1] & sel[2] & sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[29] = sel[0] & ~sel[1] & sel[2] & sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[30] = ~sel[0] & sel[1] & sel[2] & sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];
assign address[31] = sel[0] & sel[1] & sel[2] & sel[3] & sel[4] & ~sel[5] & ~sel[6] & ~sel[7] & ~sel[8] & ~sel[9];    


endmodule


(* blackbox *)
module IMPACT_Sram (

    inout vdd,	// User area 1 1.8V supply
    inout gnd,	// User area 1 digital ground

    input WL0, WL1, WL2, WL3, WL4, WL5, WL6, WL7, WL8, WL9, WL10, WL11, WL12, WL13, WL14, WL15, 
    input WL16, WL17, WL18, WL19, WL20, WL21, WL22, WL23, WL24, WL25, WL26, WL27, WL28, WL29, WL30, WL31,
    
    inout BL0, BL1, BL2, BL3, BL4, BL5, BL6, BL7, BL8, BL9, BL10, BL11, BL12, BL13, BL14, BL15,
    
    inout BLb0, BLb1, BLb2, BLb3, BLb4, BLb5, BLb6, BLb7, BLb8, BLb9, BLb10, BLb11, BLb12, BLb13, BLb14, BLb15,
);
endmodule

