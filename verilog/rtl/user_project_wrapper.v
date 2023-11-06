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
    
    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,
    
    // User maskable interrupt signals
    output [2:0] user_irq,
    
    input user_clock2,


	input [`MPRJ_IO_PADS-1:0] io_in,
	output [`MPRJ_IO_PADS-1:0] io_out,
	output [`MPRJ_IO_PADS-1:0] io_oeb,


//WishBone Unused for IMPACT design -LiamOswald 03/22/2023
 
//Logic Analyzer Unused for IMPACT design -LiamOswald 03/22/2023

);

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/


user_proj_IMPACT_HEAD mprj (
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif

    // IO Pads
    .io_oeb(io_oeb [37:5]),
    .user_irq(user_irq), 
    .Data_In(io_in[12:5]),			//SRAM byte input		GPIO pins 5-12
    .Data_Out(io_out[20:13]), 			//SRAM byte output		GPIO pins 13-20
    .Word_Select(io_in[21:30]), 		//Select word from SRAM bank	GPIO pins 21-30
    .Byte_Select(io_in[31:32]),			//Select Byte from Word		GPIO pins 31 & 32
    .WriteEnable(io_in[33]),			//SRAM Write Enable signal	GPIO pin 33
    .ReadEnable(io_in[34]),			//SRAM Read Enable Signal	GPIO pin 34
    .WL_enable(io_in[35]),			//SRAM world line enable 	GPIO pin 35
    .PreCharge(io_in[36]),			//SRAM precharge enable bar	GPIO pin 36
    .clk(io_in[37]),				//User Project Clock 		GPIO Pin 37	

);

endmodule	// user_project_wrapper
