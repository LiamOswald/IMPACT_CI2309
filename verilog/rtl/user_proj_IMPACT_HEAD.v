
/*
// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0
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
 `default_nettype none
`include "user_defines.v"

module user_proj_IMPACT_HEAD (

`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
    inout vccd2,
    inout vssd2,
`endif

output [37:0] io_oeb,

input wire [7:0] Data_In,				//SRAM byte input		GPIO pins 0-7
output wire [7:0] Data_Out, 				//SRAM byte output		GPIO pins 8-15
input wire [9:0] Word_Select,				//Select word from SRAM bank	GPIO pins 16-25
input wire [1:0] Bank_Select, 				//Select SRAM Bank		GPIO pins 26 & 27
input wire [1:0] Byte_Select, 				//Select Byte from Word		GPIO pins 28 & 29
input wire WriteEnable,					//SRAM Write Enable signal	GPIO pin 30
input wire ReadEnable,					//SRAM Read Enable Signal	GPIO pin 31
input wire PreCharge,					//PreCharge	GPIO pin 32
//input reg [3:0] Truncation_Select;			//Truncation controller		GPIO Pins 33-36
input clk						//User Project Clock 		GPIO Pin 37 

 
);
//declare io direction
assign io_oeb = 38'b11111111_00000000_1111111111_11_11_1_1_0_11_10_1;

wire [31:0] Data_Register;
			
wire [1023:0] WordDecoder_Bank01;
wire [31:0] Bank01_Output_ToMux;




//################################################
//Creates the Four Word Decoders Instences for the Four Memory Banks
//################################################

// BANK 01 WORDLINE Decoder
BankWordDecoder wordDecoder_Bank01 (
	.clk(clk),
	.sel(Word_Select),
	.address(WordDecoder_Bank01)
);



//BANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANK
//BANKBANKBANKBANKBANKBA     bank                                       NKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANK
//BANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANK

//Bank01 SRAM Block
IMPACTSram bank01(
	
	`ifdef USE_POWER_PINS
    		.vccd1(vccd1),	// User area 1 1.8V supply
    		.vssd1(vssd1),	// User area 1 digital ground
	`endif
	
	.PRE(PreCharge),
	.ReadEn(ReadEnable),
	.WriteEn(WriteEnable),
	.Address(WordDecoder_Bank01), //WL
	.DataOut(Bank01_Output_ToMux), //BL
	.DataIn(Data_Register)
 

);

//DATA OUT MUX! this mux takes 4 32bit values from the 4 memory banks, and mux's the output down to a single byte ready for the output pins
FourBanksMux Data_out_Mux(
		.clk(clk),
		.Bank01_Reading(Bank01_Output_ToMux),
		.Bank02_Reading(Bank01_Output_ToMux),	//redundancy for now
		.Bank03_Reading(Bank01_Output_ToMux),	//redundancy for now
		.Bank04_Reading(Bank01_Output_ToMux),	//redundancy for now
		.bank_sel(Bank_Select),
		.byte_sel(Byte_Select),
                .data_out(Data_Out)
);

data_in_decoder DataIn_Decoder(
	.clk(clk),
	.data_in(Data_In),
	.sel(Byte_Select),
	.data_out(Data_Register)
);

	

endmodule








