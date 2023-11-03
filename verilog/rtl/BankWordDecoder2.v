module BankWordDecoder(
    input clk,			//clock
    input [9:0] sel,   		//Word Line Select /*change 9 to 4 for 32x32*/
    input WL_enable,		//Word Line Enable
    output reg [1023:0] address //Word Line Address /*change 1023 to 31 for 32x32*/
    );
   
    integer i;
    integer k;
    reg [1023:0] address_tmp;    /*changed 1023 to 31 for 32x32*/
   
    always @(posedge clk) begin
        for(i=0; i<1024; i=i+1) begin  /*changed 1024 to 32 for 32x32*/
            address_tmp[i] <= (sel==i)?1'b1:1'b0;  
        end
    end
    
    always @(address_tmp, WL_enable) begin
        for(k=0; k<1024; k=k+1) begin   /*changed 1024 to 32 for 32x32*/
            address[k] <= address_tmp[k] & WL_enable;  
        end
    end

endmodule

`default_nettype wire
