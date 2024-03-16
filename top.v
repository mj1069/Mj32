////////////////////////////////////////////////////////////////////////////////
// Project: MJ32 - Simple RISC V processor core
// File: top.v
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

`include "mj32.v"
`include "instruction_memory.v"
`include "data_memory.v"

module top();
  
  logic clk;
  logic reset;
  logic enable;
  logic [31:0] instruction;
  logic [31:0] mem_read_data;
  logic [31:0] pc;
  logic preset;
  logic [31:0] preset_address;
  logic mem_read;
  logic mem_write;
  logic [31:0] mem_read_address;
  logic [31:0] mem_write_address;
  logic [31:0] mem_write_data;
  
  MJ32 MJ32_instance (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .instruction(instruction),
    .mem_read_data(mem_read_data),
    .pc(pc),
    .preset(preset),
    .preset_address(preset_address),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_read_address(mem_read_address),
    .mem_write_address(mem_write_address),
    .mem_write_data(mem_write_data)
  );
  
  instruction_memory instruction_memory_inst (
    .addr(pc),
    .C(clk),
    .instruction(instruction)
  );
  
  data_memory data_memory_inst (
    .Din(mem_write_data),
    .re(mem_read),
    .we(mem_write),
    .Ra(mem_read_address),
    .Wa(mem_write_address),
    .C(clk),
    .Dout(mem_read_data)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0, top);
    
    clk <= 0;
    reset <= 1;
    enable <= 0;
    
    #5 reset <= 0;
    #5 enable <= 1;
    
    #250 $stop;
    
  end
  
  always #5 clk = ~clk;
  
endmodule
