////////////////////////////////////////////////////////////////////////////////
// Project: MJ32 - Simple RISC V processor core
// File: fetch.v
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

module fetch(
  input clk,
  input reset,
  input enable,
  input preset,
  input [31:0] preset_address,
  output reg [31:0] count
);
  
//   initial begin
//     count <= 32'b0;
//   end

  always @(reset or posedge clk) begin
    if (reset) begin
      count <= 32'b0;
    end else if (enable) begin
      if (preset) begin
        count <= preset_address;
      end else begin
        count <= count + 1'b1;
      end
    end
  end
  
endmodule
