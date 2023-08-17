module bank_writeEnable_handeler (
		input [1:0] bank_select,
                input write_enable,
                output reg Bank01_write_enabled,
                output reg Bank02_write_enabled,
                output reg Bank03_write_enabled,
                output reg Bank04_write_enabled
);

always @(*) begin
   case (bank_select)
      2'b00: Bank01_write_enabled = write_enable
      	     Bank02_write_enabled = not write_enable
      	     Bank03_write_enabled = not write_enable
      	     Bank04_write_enabled = not write_enable
      	     ;
      2'b01: Bank01_write_enabled = not write_enable
      	     Bank02_write_enabled = write_enable
      	     Bank03_write_enabled = not write_enable
      	     Bank04_write_enabled = not write_enable
      	     ;
      2'b10: Bank01_write_enabled = not write_enable
      	     Bank02_write_enabled = not write_enable
      	     Bank03_write_enabled = write_enable
      	     Bank04_write_enabled = not write_enable
      	     ;
      2'b11: Bank01_write_enabled = not write_enable
      	     Bank02_write_enabled = not write_enable
      	     Bank03_write_enabled = not write_enable
      	     Bank04_write_enabled = write_enable
      	     ;
   endcase
end

endmodule
