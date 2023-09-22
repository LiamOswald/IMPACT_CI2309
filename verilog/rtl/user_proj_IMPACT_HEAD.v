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
 /// sta-blackbox
`include "user_defines.v" //why this?

module user_proj_IMPACT_HEAD (

`ifdef USE_POWER_PINS
    inout vccd1, // User area 1 1.8V supply
    inout vssd1, // User area 1 digital ground
`endif



//   inout vccd1, // User area 1 1.8V supply
//   inout vssd1, // User area 1 digital ground


    // Wishbone Slave ports (WB MI A)

    // Logic Analyzer Signals

    // IRQ
   
    input [31:0] East,
    inout [31:0] West,
    inout [31:0] South,
    input clk

);

//wire [31:0] WL_Bank01;
//################################################
//Creates the Four Word Decoders Instences for the Four Memory Banks
//################################################

wire [31:0] WL01;

BankWordDecoder decoder01 (
	`ifdef USE_POWER_PINS
		.vccd1(vccd1),	// User area 1 1.8V power
		.vssd1(vssd1),	// User area 1 digital ground
	`endif
	.clk(clk),
	.sel(East [4:0]),
	.address(WL01)
);




//Bank01 SRAM Block
(* blackbox *)
IMPACTSram bank01(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif

.WL0(WL01 [0]),
.WL1(WL01 [1]),
.WL2(WL01 [2]),
.WL3(WL01 [3]),
.WL4(WL01 [4]),
.WL5(WL01 [5]),
.WL6(WL01 [6]),
.WL7(WL01 [7]),
.WL8(WL01 [8]),
.WL9(WL01 [9]),
.WL10(WL01 [10]),
.WL11(WL01 [11]),
.WL12(WL01 [12]),
.WL13(WL01 [13]),
.WL14(WL01 [14]),
.WL15(WL01 [15]),
.WL16(WL01 [16]),
.WL17(WL01 [17]),
.WL18(WL01 [18]),
.WL19(WL01 [19]),
.WL20(WL01 [20]),
.WL21(WL01 [21]),
.WL22(WL01 [22]),
.WL23(WL01 [23]),
.WL24(WL01 [24]),
.WL25(WL01 [25]),
.WL26(WL01 [26]),
.WL27(WL01 [27]),
.WL28(WL01 [28]),
.WL29(WL01 [29]),
.WL30(WL01 [30]),
.WL31(WL01 [31]),

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
.BL16(West [16]),
.BL17(West [17]),
.BL18(West [18]),
.BL19(West [19]),
.BL20(West [20]),
.BL21(West [21]),
.BL22(West [22]),
.BL23(West [23]),
.BL24(West [24]),
.BL25(West [25]),
.BL26(West [26]),
.BL27(West [27]),
.BL28(West [28]),
.BL29(West [29]),
.BL30(West [30]),
.BL31(West [31]),


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
.BLb15(South [15]),
.BLb16(South [16]),
.BLb17(South [17]),
.BLb18(South [18]),
.BLb19(South [19]),
.BLb20(South [20]),
.BLb21(South [21]),
.BLb22(South [22]),
.BLb23(South [23]),
.BLb24(South [24]),
.BLb25(South [25]),
.BLb26(South [26]),
.BLb27(South [27]),
.BLb28(South [28]),
.BLb29(South [29]),
.BLb30(South [30]),
.BLb31(South [31])

);

endmodule

(* blackbox *)
module IMPACTSram (

`ifdef USE_POWER_PINS
	inout vccd1,	// User area 1 1.8V power
	inout vssd1,	// User area 1 digital ground
`endif

    input WL0, WL1, WL2, WL3, WL4, WL5, WL6, WL7, WL8, WL9, WL10, WL11, WL12, WL13, WL14, WL15,
    input WL16, WL17, WL18, WL19, WL20, WL21, WL22, WL23, WL24, WL25, WL26, WL27, WL28, WL29, WL30, WL31,
   
    inout BL0, BL1, BL2, BL3, BL4, BL5, BL6, BL7, BL8, BL9, BL10, BL11, BL12, BL13, BL14, BL15, 
    inout BL16, BL17, BL18, BL19, BL20, BL21, BL22, BL23, BL24, BL25, BL26, BL27, BL28, BL29, BL30, BL31,
   
    inout BLb0, BLb1, BLb2, BLb3, BLb4, BLb5, BLb6, BLb7, BLb8, BLb9, BLb10, BLb11, BLb12, BLb13, BLb14, BLb15,
    inout BLb16, BLb17, BLb18, BLb19, BLb20, BLb21, BLb22, BLb23, BLb24, BLb25, BLb26, BLb27, BLb28, BLb29, BLb30, BLb31
   
);
endmodule

module BankWordDecoder (
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif
	input clk,
	input [4:0] sel,
	output reg [31:0] address

);

    integer i;
    always@(posedge clk) begin
        for(i=0;i<32;i=i+1) begin
            address[i]=(sel==i)?1'b1:1'b0;
        end
    end

endmodule




`default_nettype wire


