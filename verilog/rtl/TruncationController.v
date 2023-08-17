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


module TruncationController (
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif
input [3:0] sel,
output reg [31:0] TruncLines,

);

assign TruncLines = 32'h00000000

always @(*) begin

	case(sel)
		4'b0000: TruncLines = 32'h00000000;
		4'b0001: TruncLines = 32'h00000007;
		4'b0010: TruncLines = 32'h0000000F;
		4'b0011: TruncLines = 32'h0000007F;
		4'b0100: TruncLines = 32'h000000FF;
		4'b0101: TruncLines = 32'h000007FF;
		4'b0110: TruncLines = 32'h00000FFF;
		4'b0111: TruncLines = 32'h00007FFF;
		4'b1000: TruncLines = 32'h0000FFFF;
		4'b1001: TruncLines = 32'h0007FFFF;
		4'b1010: TruncLines = 32'h000FFFFF;
		4'b1011: TruncLines = 32'h007FFFFF;
		4'b1100: TruncLines = 32'h00FFFFFF;
		4'b1101: TruncLines = 32'h07FFFFFF;
		4'b1110: TruncLines = 32'h0FFFFFFF;
		4'b1111: TruncLines = 32'h7FFFFFFF;
		
		default: TruncLines = 32'h00000000;
	endcase

end
endmodule


`default_nettype wire
