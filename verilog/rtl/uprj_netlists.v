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

// Include caravel global defines for the number of the user project IO pads 
`include "defines.v"
`define USE_POWER_PINS

`ifdef GL
    // Assume default net type to be wire because GL netlists don't have the wire definitions
    //these functions were changed by LiamOswald
    `default_nettype wire
    `include "gl/user_project_wrapper.v"
    `include "gl/user_proj_IMPACT_HEAD.v"
    `include "gl/BankWordDecoder.v"
    `include "gl/data_in_decoder.v"
    `include "gl/SramBank00.v"
    `include "gl/FourBanksMux.v"
    `include "gl/user_defines.v"
    
`else
    `include "user_proj_IMPACT_wrapper.v"
    `include "user_proj_IMPACT_HEAD.v"
    `include "BankWordDecoder.v"
    `include "data_in_decoder.v"
    `include "SramBank00.v"
    `include "FourBanksMux.v"
    `include "user_defines.v"
   
`endif
