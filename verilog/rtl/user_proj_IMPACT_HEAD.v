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
    inout [31:0] South

);

//wire [31:0] WL_Bank01;
//################################################
//Creates the Four Word Decoders Instences for the Four Memory Banks
//################################################





//Bank01 SRAM Block
(* blackbox *)
IMPACTSram bank01(
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif

.WL0(East [0]),
.WL1(East [1]),
.WL2(East [2]),
.WL3(East [3]),
.WL4(East [4]),
.WL5(East [5]),
.WL6(East [6]),
.WL7(East [7]),
.WL8(East [8]),
.WL9(East [9]),
.WL10(East [10]),
.WL11(East [11]),
.WL12(East [12]),
.WL13(East [13]),
.WL14(East [14]),
.WL15(East [15]),
.WL16(East [16]),
.WL17(East [17]),
.WL18(East [18]),
.WL19(East [19]),
.WL20(East [20]),
.WL21(East [21]),
.WL22(East [22]),
.WL23(East [23]),
.WL24(East [24]),
.WL25(East [25]),
.WL26(East [26]),
.WL27(East [27]),
.WL28(East [28]),
.WL29(East [29]),
.WL30(East [30]),
.WL31(East [31]),

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
`default_nettype wire


