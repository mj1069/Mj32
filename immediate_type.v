////////////////////////////////////////////////////////////////////////////////
// Project: MJ32 - Simple RISC V processor core
// File: immediate_type.v
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

module immediate_type(
  input [9:0]funct10,
  output [3:0]operation
);
  
  reg [2:0] funct3;
  reg [6:0] funct7;
  
  assign funct3 = funct10[2:0];
  assign funct7 = funct10[9:3];
  
  assign operation = (funct3 == 3'b000)?4'b0001:(funct3 == 3'b010)?4'b0011:(funct3 == 3'b011)?4'b0100:(funct3 == 3'b100)?4'b0101:(funct3 == 3'b110)?4'b1000:(funct3 == 3'b111)?4'b1001:((funct3 == 3'b001) & (funct7 == 7'b1000000))?4'b0010:((funct3 == 3'b101) & (funct7 == 7'b0000000))?4'b0110:((funct3 == 3'b101) & (funct7 == 7'b1000000))?4'b0111:4'b0000;

endmodule
