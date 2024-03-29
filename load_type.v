////////////////////////////////////////////////////////////////////////////////
// Project: MJ32 - Simple RISC V processor core
// File: load_type.v
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

module load_type(
  input [31:0]src1_data,
  input [2:0]funct3,
  input [11:0]offset,
  output [2:0] operation,
  output [31:0] address
); 
  
  assign address = src1_data + { {20{offset[11]}}, offset}; // Memory address from which to get the data
  
  assign operation = (funct3 == 3'b000)?3'b001:(funct3 == 3'b001)?3'b010:(funct3 == 3'b010)?3'b011:(funct3 == 3'b000)?3'b100:(funct3 == 3'b001)?3'b101:3'b000;

endmodule
