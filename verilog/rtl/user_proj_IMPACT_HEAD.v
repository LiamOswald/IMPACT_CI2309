`default_nettype none
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

`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

input reg [7:0] Data_In,				//SRAM byte input		GPIO pins 0-7
output reg [7:0] Data_Out, 				//SRAM byte output		GPIO pins 8-15
input reg [9:0] Word_Select,				//Select word from SRAM bank	GPIO pins 16-25
input reg [1:0] Bank_Select, 				//Select SRAM Bank		GPIO pins 26 & 27
input reg [1:0] Byte_Select, 				//Select Byte from Word		GPIO pins 28 & 29
input reg WriteEnable,					//SRAM Write Enable signal	GPIO pin 30
input reg ReadEnable,					//SRAM Read Enable Signal	GPIO pin 31
//input reg AnalogVCC;					//VCC control for Bank #4	GPIO pin 32
//input reg [3:0] Truncation_Select;			//Truncation controller		GPIO Pins 33-36
//input reg Project_Clock,				//User Project Clock 		GPIO Pin 37 

//input ready,         //ready = wbs_ack_o; //cpu ready signal
input clk,	//clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
input rst	//rst = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;    
);

reg [31:0] Data_Register;

wire [7:0] Data_into_Register;
			
wire [1023:0] WordDecoder_Bank01;
reg read_enable_Bank01;
reg write_enable_Bank01;
wire [31:0] Bank01_Output_ToMux;

wire Bank01_PRE;
assign Bank01_PRE = 1'b1;

/*
//this might be outdated? -Liam
//Wait for Flash to finish configuring ports
always @(posedge clk) begin
        if (rst) begin
            //Data_Out <= 8'h00;
           // ready <= 0;
        end else begin
            //ready <= 1'b0;
            
            //Assign Read_Enable Bank lines
	    read_enable_Bank01 <= ReadEnable && (Bank_Select == 2'b00);

	    //Assign Write_Enable_Bank lines.
	    write_enable_Bank01 <= WriteEnable && (Bank_Select == 2'b00);
        end
end
*/


//################################################
//Creates the Four Word Decoders Instences for the Four Memory Banks
//################################################

// BANK 01 WORDLINE Decoder
BankWordDecoder wordDecoder_Bank01 (
	.sel(Word_Select),
	.address(WordDecoder_Bank01)
);



//BANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANK
//BANKBANKBANKBANKBANKBA     bank                                       NKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANK
//BANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANK

//Bank01 SRAM Block
IMPACTSram bank01(
	
	.PRE(Bank01_PRE),
	.ReadEn(read_enable_Bank01),
	.WriteEn(write_enable_Bank01),
	.Address(WordDecoder_Bank01), //WL
	.DataOut(Bank01_Output_ToMux), //BL
	.DataIn(Data_Register)
 

);

//DATA OUT MUX! this mux takes 4 32bit values from the 4 memory banks, and mux's the output down to a single byte ready for the output pins
FourBanksMux Data_out_Mux(
		.Bank01_Reading(Bank01_Output_ToMux),
		.Bank02_Reading(Bank01_Output_ToMux),	//redundancy for now
		.Bank03_Reading(Bank01_Output_ToMux),	//redundancy for now
		.Bank04_Reading(Bank01_Output_ToMux),	//redundancy for now
		.bank_sel(Bank_Select),
		.byte_sel(Byte_Select),
                .data_out(Data_Out)
);

data_in_decoder DataIn_Decoder(
	.data_in(Data_In),
	.sel(Byte_Select),
	.data_out(Data_Register)
);

endmodule








