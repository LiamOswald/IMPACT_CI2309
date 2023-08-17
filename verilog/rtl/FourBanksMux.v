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

/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */


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

`default_nettype wire
