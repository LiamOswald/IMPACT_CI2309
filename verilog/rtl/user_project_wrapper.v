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

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

//IMPACT defined I/O via the GPIO pins, pin layout follows LiamOswalds design 03/22/2023

// IOs
//input [7:0] Data_In //SRAM byte input			GPIO pins 0-7
//output [7:0] Data_Out //SRAM byte output		GPIO pins 8-15
//input [9:0] Word_Select	//Select word from SRAM bank	GPIO pins 16-25
//input [1:0] Bank_Select //Select SRAM Bank		GPIO pins 26 & 27
//input [1:0] Byte_Select //Select Byte from Word		GPIO pins 28 & 29
//input WriteEnable	//SRAM Write Enable signal	GPIO pin 30
//input ReadEnable	//SRAM Read Enable Signal	GPIO pin 31
//input AnalogVCC		//VCC control for Bank #4	GPIO pin 32
//input [3:0] Truncation_Select	//Truncation controller	GPIO Pins 33-36
//input Project_Clock	//User Project Clock 		GPIO Pin 37

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,


	input [`MPRJ_IO_PADS-1:0] io_in,
	output [`MPRJ_IO_PADS-1:0] io_out,
	output [`MPRJ_IO_PADS-1:0] io_oeb,


//assign pin 31 to be analog input
//inout [`MPRJ_IO_PADS-6:`MPRJ_IO_PADS-6] analog_io,




//WishBone Unused for IMPACT design -LiamOswald 03/22/2023
 
//Logic Analyzer Unused for IMPACT design -LiamOswald 03/22/2023

);

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/


//create dummy signal to ensure GPIO is working
assign io_out[36] = ~ io_in[35];

//declare io direction
assign io_oeb = 38'b11111111_00000000_1111111111_11_11_1_1_0_11_10_1;


//fill unused io_out with neat pattern, this should never reach gpio
assign io_out [0:7] = 8'b01010101;
assign io_out [16:35] = 20'b10101010101010101010;
assign io_out [37] = 1'b1;

user_proj_IMPACT_HEAD mprj (
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif

    // IO Pads
    
   
    .Data_In(io_in[7:0]),			//SRAM byte input		GPIO pins 0-7
    .Data_Out(io_out[15:8]), 			//SRAM byte output		GPIO pins 8-15
    .Word_Select(io_in[25:16]), 		//Select word from SRAM bank	GPIO pins 16-25
    .Bank_Select(io_in[27:26]),			//Select SRAM Bank		GPIO pins 26 & 27
    .Byte_Select(io_in[29:28]),			//Select Byte from Word		GPIO pins 28 & 29
    .WriteEnable(io_in[30]),			//SRAM Write Enable signal	GPIO pin 30
    .ReadEnable(io_in[31]),			//SRAM Read Enable Signal	GPIO pin 31
    //.AnalogVCC(analog_io),			//VCC control for Bank #4	GPIO pin 32
    //.Truncation_Select(io_in[36:33]),		//Truncation controller		GPIO Pins 33-36
    .clk(io_in[37])			//User Project Clock 		GPIO Pin 37	


);

endmodule	// user_project_wrapper
