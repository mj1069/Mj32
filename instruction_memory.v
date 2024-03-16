////////////////////////////////////////////////////////////////////////////////
// Project: MJ32 - Simple RISC V processor core
// File: instruction_memory.v
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

module instruction_memory
(
  input [31:0] addr,
  input C,
  output reg [31:0] instruction
);

  reg [31:0] memory[0:9] = {
    32'h00000013, 
	32'h00300093,
	32'h01400193,
  	32'h00208e63,
	32'h00320233,
	32'h00110113,
	32'h0000c06f,
	32'h00000013, 
  	32'h00302523,
	32'h00a02203
  };

    always @ (posedge C) begin
      instruction = memory[addr]; 
    end
endmodule
