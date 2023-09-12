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

// +-----------------------------+
// SRAM Bank created from Registers
// Liam Oswald - wdo1621@jagmail.southalabama.edu

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

`default_nettype wire
