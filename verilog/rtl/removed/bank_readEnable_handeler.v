module bank_readEnable_handeler (
		input [1:0] bank_select,
                input read_enable,
                output reg Bank01_read_enabled,
                output reg Bank02_read_enabled,
                output reg Bank03_read_enabled,
                output reg Bank04_read_enabled
);

always @(*) begin
   case (bank_select)
      2'b00: Bank01_read_enabled = read_enable
      	     Bank02_read_enabled = not read_enable
      	     Bank03_read_enabled = not read_enable
      	     Bank04_read_enabled = not read_enable
      	     ;
      2'b01: Bank01_read_enabled = not read_enable
      	     Bank02_read_enabled = read_enable
      	     Bank03_read_enabled = not read_enable
      	     Bank04_read_enabled = not read_enable
      	     ;
      2'b10: Bank01_read_enabled = not read_enable
      	     Bank02_read_enabled = not read_enable
      	     Bank03_read_enabled = read_enable
      	     Bank04_read_enabled = not read_enable
      	     ;
      2'b11: Bank01_read_enabled = not read_enable
      	     Bank02_read_enabled = not read_enable
      	     Bank03_read_enabled = not read_enable
      	     Bank04_read_enabled = read_enable
      	     ;
   endcase
end

endmodule
