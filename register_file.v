////////////////////////////////////////////////////////////////////////////////
// Project: MJ32 - Simple RISC V processor core
// File: register_file.v
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

module register_file
(
  input [31:0] Din,
  input we,
  input [4:0] Rw,
  input C,
  input [4:0] Ra,
  input [4:0] Rb,
  output [31:0] Da,
  output [31:0] Db
);

  reg [31:0] memory[32] = '{default:{32{1'b0}}};

  assign Da = memory[Ra];
  assign Db = memory[Rb];

  always @ (posedge C) begin
    if (we & Rw != 0)
      memory[Rw] <= Din;
  end

endmodule
