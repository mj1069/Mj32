////////////////////////////////////////////////////////////////////////////////
// Project: MJ32 - Simple RISC V processor core
// File: data_memory.v
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

module data_memory
(
  input [31:0] Din,
  input re,
  input we,
  input [31:0] Ra,
  input [31:0] Wa,
  input C,
  output [31:0] Dout
);

  reg [31:0] memory[4500];

  assign Dout = (re)?memory[Ra]:32'bx;
  
    always @ (posedge C) begin
      if (we)
        memory[Wa] <= Din;
    end
endmodule
