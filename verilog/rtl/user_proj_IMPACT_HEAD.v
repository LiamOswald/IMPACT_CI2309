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
//`include "BankWordDecoder.v"
//`include "data_in_decoder.v"
//`include "SramBank00.v"
//`include "FourBanksMux.v"
`include "user_defines.v"

module user_proj_IMPACT_HEAD (

`ifdef USE_POWER_PINS
    vccd1,	// User area 1 1.8V supply
    vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    wb_clk_i,
    wb_rst_i,
    wbs_stb_i,
    wbs_cyc_i,
    wbs_we_i,
    wbs_sel_i,
    wbs_dat_i,
    wbs_adr_i,
    wbs_ack_o,
    wbs_dat_o,

    // Logic Analyzer Signals
    la_data_in,
    la_data_out,
    la_oenb,

    // IOs
    io_in,
    io_out,
    io_oeb,

    // IRQ
    irq
);


`ifdef USE_POWER_PINS
    inout vccd1;	// User area 1 1.8V supply
    inout vssd1;	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i;
    input wb_rst_i;
    input wbs_stb_i;
    input wbs_cyc_i;
    input wbs_we_i;
    input [3:0] wbs_sel_i;
    input [31:0] wbs_dat_i;
    input [31:0] wbs_adr_i;
    output wbs_ack_o;
    output [31:0] wbs_dat_o;

    // Logic Analyzer Signals
    input  [127:0] la_data_in;
    output [127:0] la_data_out;
    input  [127:0] la_oenb;

    // IOs
    input  [37:0] io_in;
    output [37:0] io_out;
    output [37:0] io_oeb;

    // IRQ
    output [2:0] irq;

/*
reg [7:0] Data_In; 				//SRAM byte input		GPIO pins 0-7
output [7:0] Data_Out; 				//SRAM byte output		GPIO pins 8-15
input [9:0] Word_Select;			//Select word from SRAM bank	GPIO pins 16-25
input [1:0] Bank_Select; 			//Select SRAM Bank		GPIO pins 26 & 27
input [1:0] Byte_Select; 			//Select Byte from Word		GPIO pins 28 & 29
input WriteEnable;				//SRAM Write Enable signal	GPIO pin 30
input ReadEnable;				//SRAM Read Enable Signal	GPIO pin 31
input AnalogVCC;				//VCC control for Bank #4	GPIO pin 32
input [3:0] Truncation_Select;			//Truncation controller		GPIO Pins 33-36
input Project_Clock;				//User Project Clock 		GPIO Pin 37 				
*/


reg ready;	// ready signal for CPU
wire clk;	// cpu clock -  User project clock comes in on gpio pin #37
wire rst;	// cpu reset signal

reg [7:0] Data_In; 				//SRAM byte input		GPIO pins 0-7
reg [7:0] Data_Out; 				//SRAM byte output		GPIO pins 8-15
reg [9:0] Word_Select;				//Select word from SRAM bank	GPIO pins 16-25
reg [1:0] Bank_Select; 			//Select SRAM Bank		GPIO pins 26 & 27
reg [1:0] Byte_Select; 			//Select Byte from Word		GPIO pins 28 & 29
reg WriteEnable;				//SRAM Write Enable signal	GPIO pin 30
reg ReadEnable;				//SRAM Read Enable Signal	GPIO pin 31
reg AnalogVCC;					//VCC control for Bank #4	GPIO pin 32
reg [3:0] Truncation_Select;			//Truncation controller		GPIO Pins 33-36
reg Project_Clock;				//User Project Clock 		GPIO Pin 37 	


    // WB MI A
    //assign valid = wbs_cyc_i && wbs_stb_i; 
    // assign wstrb = wbs_sel_i & {4{wbs_we_i}};
    // assign wbs_dat_o = rdata;
    // assign wdata = wbs_dat_i[15:0];
    
    assign ready = wbs_ack_o; //cpu ready signal

    // IO	
    assign io_oeb = 38'b11111111111111111111110000000011111111; //only data out is 0s on data_out pins
    assign Data_In = io_in [7:0];
    assign Data_Out = io_out [15:8];
    assign Word_Select = io_in [25:16];
    assign Bank_Select = io_in [27:26];
    assign Byte_Select = io_in [29:28];
    assign WriteEnable = io_in [30];
    assign ReadEnable = io_in [31];
    assign AnalogVCC = io_in [32];
    assign Truncation_Select = io_in [36:33];
    assign Project_Clock = io_in [37];

    // IRQ
    assign irq = 3'b000;	// Unused

    // LA
    // assign la_data_out = {{(127-BITS){1'b0}}, count};
    // Assuming LA probes [63:32] are for controlling the count register  
    // assign la_write = ~la_oenb[63:32] & ~{BITS{valid}};
    // Assuming LA probes [65:64] are for controlling the count clk & reset  
    assign clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
    assign rst = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;


wire [31:0] Data_into_Bank;		//The byte ready to go into the SRAM bank.
					
wire [1023:0] WordDecoder_Bank01;
wire [1023:0] WordDecoder_Bank02; 
wire [1023:0] WordDecoder_Bank03; 
wire [1023:0] WordDecoder_Bank04; 

reg read_enable_Bank01;
reg read_enable_Bank02;
reg read_enable_Bank03;
reg read_enable_Bank04;

reg write_enable_Bank01;
reg write_enable_Bank02;
reg write_enable_Bank03;
reg write_enable_Bank04;

wire [31:0] Bank01_Output_ToMux;
wire [31:0] Bank02_Output_ToMux;
wire [31:0] Bank03_Output_ToMux;
wire [31:0] Bank04_Output_ToMux;


//Wait for Flash to finish configuring ports
always @(posedge clk) begin
        if (rst) begin
            Data_Out <= 8'h00;
            ready <= 0;
        end else begin
            ready <= 1'b0;
            
            //Assign Read_Enable Bank lines
	    read_enable_Bank01 <= ReadEnable && (Bank_Select == 2'b00);
	    read_enable_Bank02 <= ReadEnable && (Bank_Select == 2'b01);	
	    read_enable_Bank03 <= ReadEnable && (Bank_Select == 2'b10);	
	    read_enable_Bank04 <= ReadEnable && (Bank_Select == 2'b11);

	    //Assign Write_Enable_Bank lines.
	    write_enable_Bank01 <= WriteEnable && (Bank_Select == 2'b00);
	    write_enable_Bank02 <= WriteEnable && (Bank_Select == 2'b01);	
	    write_enable_Bank03 <= WriteEnable && (Bank_Select == 2'b10);	
	    write_enable_Bank04 <= WriteEnable && (Bank_Select == 2'b11);
        end
end



// BANK 01 WORDLINE Decoder
BankWordDecoder wordDecoder_Bank01 (
	.sel(Word_Select),
	.address(WordDecoder_Bank01)
);

// BANK 02 WORDLINE Decoder
BankWordDecoder wordDecoder_Bank02 (
	.sel(Word_Select),
	.address(WordDecoder_Bank02)
);
// BANK 03 WORDLINE Decoder
BankWordDecoder wordDecoder_Bank03(
	.sel(Word_Select),
	.address(WordDecoder_Bank03)
);
// BANK 04 WORDLINE Decoder
BankWordDecoder wordDecoder_Bank04(
	.sel(Word_Select),
	.address(WordDecoder_Bank04)
);


//****************************************
//CREATES INSTENCE OF data_in_Decoder
//*****************************************
data_in_decoder data_in_too_Data_into_Bank (
	.data_in(Data_In),
        .sel(Byte_Select),
        .data_out(Data_into_Bank)
);


//BANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANK
//BANKBANKBANKBANKBANKBA     bank                                       NKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANK
//BANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANKBANK

//Bank01 SRAM Block
SramBank00 bank01(
	.Address(WordDecoder_Bank01),
	.DataIn(Data_into_Bank),
	.DataOut(Bank01_Output_ToMux),
	.clk(Project_Clock),
	.WE(write_enable_Bank01), 
	.RE(read_enable_Bank01)
);


//Bank02 SRAM Block
SramBank00 bank02 (
	.Address(WordDecoder_Bank02),
	.DataIn(Data_into_Bank),
	.DataOut(Bank02_Output_ToMux),
	.clk(Project_Clock),
	.WE(write_enable_Bank02), 
	.RE(read_enable_Bank02)
);


//Bank03 SRAM Block
SramBank00 bank03 (
	.Address(WordDecoder_Bank03),
	.DataIn(Data_into_Bank),
	.DataOut(Bank03_Output_ToMux),
	.clk(Project_Clock),
	.WE(write_enable_Bank03), 
	.RE(read_enable_Bank03)
);


//Bank04 SRAM Block
SramBank00 bank04 (
	.Address(WordDecoder_Bank04),
	.DataIn(Data_into_Bank),
	.DataOut(Bank04_Output_ToMux),
	.clk(Project_Clock),
	.WE(write_enable_Bank04), 
	.RE(read_enable_Bank04)
);




//DATA OUT MUX! this mux takes 4 32bit values from the 4 memory banks, and mux's the output down to a single byte ready for the output pins
FourBanksMux Data_out_Mux(
		.Bank01_Reading(Bank01_Output_ToMux),
		.Bank02_Reading(Bank02_Output_ToMux),
		.Bank03_Reading(Bank03_Output_ToMux),
		.Bank04_Reading(Bank04_Output_ToMux),
		.bank_sel(Bank_Select),
		.byte_sel(Byte_Select),
                .data_out(Data_Out)
);

endmodule


module BankWordDecoder #(
    parameter BITS = 32
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif
	input [9:0] sel,
	output reg [1023:0] address

);

    integer i;
    always@(sel) begin
        for(i=0;i<1023;i=i+1) begin
            address[i]=(sel==i)?1'b1:1'b0;
        end
    end

endmodule

module data_in_decoder #(
    parameter BITS = 32
)(
		input [7:0] data_in,
                input [1:0] sel,
                output reg [31:0] data_out
);

always @(*) begin
   case (sel)
      2'b00: data_out[7:0] = data_in;
      2'b01: data_out[15:8] = data_in;
      2'b10: data_out[23:16] = data_in;
      2'b11: data_out[32:24] = data_in;
   endcase
end

endmodule

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


module FourBanksMux (Bank01_Reading, Bank02_Reading, Bank03_Reading, Bank04_Reading, bank_sel, byte_sel, data_out);
input [31:0] Bank01_Reading;
input [31:0] Bank02_Reading;
input [31:0] Bank03_Reading;
input [31:0] Bank04_Reading;
input [1:0] bank_sel;
input [1:0] byte_sel;
output reg [7:0] data_out;
                


reg [31:0] Bank_to_read;

always @(*) begin
   case (bank_sel)
      2'b00: Bank_to_read = Bank01_Reading;
      2'b01: Bank_to_read = Bank02_Reading;
      2'b10: Bank_to_read = Bank03_Reading;
      2'b11: Bank_to_read = Bank04_Reading;
   endcase
   
   case (byte_sel)
      2'b00: data_out = Bank_to_read[7:0];
      2'b01: data_out = Bank_to_read[15:8];
      2'b10: data_out = Bank_to_read[23:16];
      2'b11: data_out = Bank_to_read[32:24];
   endcase
end

endmodule

