////////////////////////////////////////////////////////////////////////////////
// Project: MJ32 - Simple RISC V processor core
// File: decoder.v
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

module decoder(
  input [31:0]instruction,
  output register_type,
  output immediate_type,
  output load_type,
  output store_type,
  output branch_type,
  output call_type,
  output load_immediate_type,
  output jump_type,
  output [2:0]funct3,
  output [9:0]funct10,
  output [4:0]src1, 
  output [4:0]src2,
  output [4:0]des,
  output [11:0]imm12,
  output [19:0]imm20
);
  
  assign  register_type = (instruction[6:0] == 7'b0110011)?1'b1:1'b0;
  assign  immediate_type = (instruction[6:0] == 7'b0010011)?1'b1:1'b0;
  assign  load_type = (instruction[6:0] == 7'b0000011)?1'b1:1'b0;
  assign  store_type = (instruction[6:0] == 7'b0100011)?1'b1:1'b0;
  assign  branch_type = (instruction[6:0] == 7'b1100011)?1'b1:1'b0;
  assign  call_type = (instruction[6:0] == 7'b1100111)?1'b1:1'b0; // Jump and link register
  assign  load_immediate_type = ((instruction[6:0] == 7'b0110111) | (instruction[6:0] == 7'b0010111))?1'b1:1'b0;
  assign  jump_type = (instruction[6:0] == 7'b1101111)?1'b1:1'b0; // Jump and unlink register
  
  assign  funct3 = ((instruction[6:0] == 7'b0110111) | (instruction[6:0] == 7'b0100011) | (instruction[6:0] == 7'b1100011) | (instruction[6:0] == 7'b1100111) | (instruction[6:0] == 7'b0000011))?instruction[14:12]:3'b0;
  assign  funct10 = ((instruction[6:0] == 7'b0110011) | (instruction[6:0] == 7'b0010011))?{instruction[31:25], instruction[14:12]}:10'b0;
  assign  src1 = ((instruction[6:0] == 7'b0110011) | (instruction[6:0] == 7'b0010011) | (instruction[6:0] == 7'b0100011) | (instruction[6:0] == 7'b1100011) | (instruction[6:0] == 7'b1100111) | (instruction[6:0] == 7'b0000011))?instruction[19:15]:5'b0;
  assign  src2 = ((instruction[6:0] == 7'b0110011) | (instruction[6:0] == 7'b0100011) | (instruction[6:0] == 7'b1100011) | (instruction[6:0] == 7'b0100011) | (instruction[6:0] == 7'b0000011))?instruction[24:20]:5'b0;
  assign  des = ((instruction[6:0] == 7'b0110011) | (instruction[6:0] == 7'b0010011) | (instruction[6:0] == 7'b0110111) | (instruction[6:0] == 7'b1100111) | (instruction[6:0] == 7'b0000011) | (instruction[6:0] == 7'b1101111))?instruction[11:7]:5'b0;
  assign  imm12 = ((instruction[6:0] == 7'b0010011) | (instruction[6:0] == 7'b1100111) | (instruction[6:0] == 7'b0000011))?instruction[31:20]:((instruction[6:0] == 7'b1100011) | (instruction[6:0] == 7'b0100011))?{instruction[31:25],instruction[11:7]}:12'b0;
  assign imm20 = ((instruction[6:0] == 7'b0110111) | (instruction[6:0] == 7'b0010111) | (instruction[6:0] == 7'b1101111))?instruction[31:12]:20'b0;
endmodule
