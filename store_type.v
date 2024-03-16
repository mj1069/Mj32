////////////////////////////////////////////////////////////////////////////////
// Project: MJ32 - Simple RISC V processor core
// File: store_type.v
// Author: Mohanraj K
// Email: mohanrajk1069@gmail.com
// Date: March 16, 2024
// Description: 
//   This project implements a simple CPU design in Verilog. It includes modules
//   for instruction fetching, decoding, executing, and memory access. The CPU
//   architecture supports basic arithmetic and logic operations, branching, and
//   memory operations. The top module integrates these modules to create the
//   complete CPU.
////////////////////////////////////////////////////////////////////////////////

module store_type(
  input [31:0]src1_data, src2_data,
  input [2:0]funct3,
  input [11:0]imm12,
  output [2:0] operation,
  output [31:0] address,
  output [31:0] data_out
);  
  assign address = src1_data + { {20{imm12[11]}}, imm12};
  assign data_out = src2_data;
  
  assign operation = (funct3 == 3'b000)?3'b001:(funct3 == 3'b001)?3'b010:(funct3 == 3'b010)?3'b011:3'b000;

endmodule
