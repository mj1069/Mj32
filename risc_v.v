////////////////////////////////////////////////////////////////////////////////
// Project: MJ32 - Simple RISC V processor core
// File: MJ32.v
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

`include "fetch.v"
`include "decoder.v"
`include "register_type.v"
`include "immediate_type.v"
`include "load_type.v"
`include "call_type.v"
`include "jump_type.v"
`include "branch_type.v"
`include "store_type.v"
`include "alu.v"
`include "memory_control.v"
`include "register_file.v"

module MJ32(
  input clk,
  input reset,
  input enable,
  input [31:0] instruction,
  input [31:0] mem_read_data,
  output [31:0] pc,
  output preset,
  output [31:0] preset_address,
  output mem_read,
  output mem_write,
  output [31:0] mem_read_address,
  output [31:0] mem_write_address,
  output [31:0] mem_write_data
);
  
  // decoder wires
  logic register_type;
  logic immediate_type;
  logic load_type;
  logic store_type;
  logic branch_type;
  logic call_type;
  logic load_immediate_type;
  logic jump_type;
  logic [2:0] funct3;
  logic [9:0] funct10;
  logic [4:0] rs1_sel;
  logic [4:0] rs2_sel;
  logic [4:0] rd_sel;
  logic [11:0] imm12;
  logic [19:0] imm20;
  
  // register_type wires
  logic [3:0] reg_alu_operation;
  logic [9:0] is_reg_funct10;
  logic [3:0] is_reg_alu_operation;
  
  // immediate_type wires
  logic [3:0] imm_alu_operation;
  logic [9:0] is_imm_funct10;
  logic [3:0] is_imm_alu_operation;
  
  // load_type wires
  logic [2:0] load_operation;
  logic [31:0] load_address;
  logic [31:0] load_data_in;
  logic [2:0] is_load_operation;
  logic [31:0] is_load_address;
  logic [31:0] is_load_data_in;
  logic [31:0] is_load_data_out;
  logic [31:0] is_load_rs1_data;
  logic [2:0] is_load_funct3;
  logic [11:0] is_load_imm12;
  
  // store_type wires
  logic [31:0] is_store_rs1_data;
  logic [31:0] is_store_rs2_data;
  logic [2:0] store_operation;
  logic [31:0] store_address;
  logic [31:0] store_data;
  logic [2:0] is_store_operation;
  logic [31:0] is_store_address;
  logic [31:0] is_store_data;
  logic [2:0] is_store_funct3;
  logic [11:0] is_store_imm12;
  
  // jump type wires
  logic jump;
  logic [31:0] jump_address;
  logic [31:0] is_jump_address;
  logic [19:0] is_jump_imm20;
  logic [31:0] is_jump_rs1_data;
  logic [31:0] is_jump_rs2_data;
  
  // branch type wires
  logic branch;
  logic [31:0] branch_address;
  logic is_branch;
  logic [31:0] is_branch_rs1_data;
  logic [31:0] is_branch_rs2_data;
  logic [31:0] is_branch_address;
  logic [11:0] is_branch_imm12;
  logic [2:0] is_branch_funct3;
  
  // call type wires
  logic call;
  logic [31:0] call_address;
  logic [31:0] is_call_rs1_data;
  logic [11:0] is_call_imm12;
  logic [31:0] is_call_address;
  
  // alu wires
  logic [31:0] alu_in1_data;
  logic [31:0] alu_in2_data;
  logic [3:0] alu_operation;
  logic [31:0] alu_data_out;
  
  // register file wires
  logic [31:0] reg_rs1_data;
  logic [31:0] reg_rs2_data;
  logic [31:0] reg_rd_data;
  logic reg_rd_write;
  logic [4:0] reg_rs1_sel;
  logic [4:0] reg_rs2_sel;
  logic [4:0] reg_rd_sel;  
  
  // Fetch instantiation
  fetch fetch_inst (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .preset(preset),
    .preset_address(preset_address),
    .count(pc)
  );
  
  // Decoder instantiation
  decoder decoder_inst(
    .instruction(instruction),
    .register_type(register_type),
    .immediate_type(immediate_type),
    .load_type(load_type),
    .store_type(store_type),
    .branch_type(branch_type),
    .call_type(call_type),
    .load_immediate_type(load_immediate_type),
    .jump_type(jump_type),
    .funct3(funct3),
    .funct10(funct10),
    .src1(rs1_sel),
    .src2(rs2_sel),
    .des(rd_sel),
    .imm12(imm12),
    .imm20(imm20)
  );
  
  // Register type instantiation
  register_type register_type_inst (
    .funct10(is_reg_funct10),
    .operation(is_reg_alu_operation)
  );
  
  //Immediate type instantiation
  immediate_type immediate_type_inst (
    .funct10(is_imm_funct10),
    .operation(is_imm_alu_operation)
  );
  
  // Load type instantiation
  load_type load_type_inst (
    .src1_data(is_load_rs1_data),
    .funct3(is_load_funct3),
    .offset(is_load_imm12),
    .operation(is_load_operation),
    .address(is_load_address)
  );
  
  // Call type instantiation
  call_type call_type_inst (
    .imm12(is_call_imm12),
    .rs1_data(is_call_rs1_data),
    .call_address(is_call_address)
  );
  
  // Jump type instantiation
  jump_type jump_type_inst (
    .imm20(is_jump_imm20),
    .jump_address(is_jump_address)
  );
  
  // Branc type instantiation
  branch_type branch_type_inst (
    .src1_data(is_branch_rs1_data),
    .src2_data(is_branch_rs2_data),
    .funct3(is_branch_funct3),
    .imm12(is_branch_imm12),
    .branch(is_branch),
    .branch_address(is_branch_address)
  );
  
  // Store type instantiation
  store_type store_type_inst (
    .src1_data(is_store_rs1_data),
    .src2_data(is_store_rs2_data),
    .funct3(is_store_funct3),
    .imm12(is_store_imm12),
    .operation(is_store_operation),
    .address(is_store_address),
    .data_out(is_store_data)
  );
  
  // ALU instantiation
  alu alu_inst (
    .in1_data(alu_in1_data),
    .in2_data(alu_in2_data),
    .alu_operation(alu_operation),
    .out_data(alu_data_out)
  );
  
  // Memory control instantiation
  memory_control mem_ctrl_inst (
    .load_in(load_type),
    .store_in(store_type),
    .load_operation_in(load_operation),
    .load_address_in(load_address),
    .load_data_in(load_data_in),
    .store_operation_in(store_operation),
    .store_address_in(store_address),
    .store_data_in(store_data),
    .load_address_out(mem_read_address),
    .load_data_out(mem_read_data),
    .store_address_out(mem_write_address),
    .store_data_out(mem_write_data)
);
  
  // Register file instantiation
  register_file register_file_inst (
    .Din(reg_rd_data),
    .we(reg_rd_write),
    .Rw(reg_rd_sel),
    .C(clk),
    .Ra(reg_rs1_sel),
    .Rb(reg_rs2_sel),
    .Da(reg_rs1_data),
    .Db(reg_rs2_data)
  );
  
  assign is_reg_funct10 = (register_type)?funct10:10'b0;
  assign reg_alu_operation = (register_type)?is_reg_alu_operation:(immediate_type)?is_imm_alu_operation:4'b0;
  assign reg_rs1_sel = (register_type | immediate_type | load_type | store_type | branch_type)?rs1_sel:4'bz;
  assign reg_rs2_sel = (register_type | store_type | branch_type)?rs2_sel:4'bz;
  assign reg_rd_sel = (register_type | immediate_type | load_type | call_type | jump_type | load_immediate_type)?rd_sel:4'b0;
  assign reg_rd_write = (register_type | immediate_type | load_type)?1'b1:1'b0;
  assign reg_rd_data = (register_type | immediate_type)? alu_data_out:(load_type)?mem_read_data:32'b0;
  
  assign is_imm_funct10 = (immediate_type)?funct10:10'b0;
  
  assign is_branch_imm12 = (branch_type)?imm12:12'bz;
  assign is_branch_funct3 = (branch_type)?funct3:3'bz;
  assign branch = (branch_type)?is_branch:1'bz;
  assign branch_address = (branch_type)?is_branch_address:32'bz;
  assign is_branch_rs1_data = (branch_type)?reg_rs1_data:32'bz;
  assign is_branch_rs2_data = (branch_type)?reg_rs2_data:32'bz;
  
  assign is_call_imm12 = (call_type)?imm12:12'b0;
  assign call = (call_type)?1'b1:1'b0;
  assign is_call_rs1_data = (call_type)?reg_rs1_data:32'b0;
  assign call_address = (call_type)?is_call_address:32'b0;
  
  assign is_jump_imm20 = (jump_type)?imm20:20'b0;
  assign jump = (jump_type)?1'b1:1'b0;
  assign jump_address = (jump_type)?is_jump_address:32'b0;
  assign is_jump_rd_data = (jump_type)?reg_rd_data:32'b0;
  
  assign alu_in1_data = (register_type | immediate_type)?reg_rs1_data:32'b0;
  assign alu_in2_data = (register_type)?reg_rs2_data:(immediate_type)?{{20{1'b0}},imm12}:32'b0;
  assign alu_operation = (register_type)?is_reg_alu_operation:(immediate_type)?is_imm_alu_operation:32'b0;
  
  assign is_store_rs1_data = (store_type)?reg_rs1_data:32'b0;
  assign is_store_rs2_data = (store_type)?reg_rs2_data:32'b0;
  assign is_store_funct3 = (store_type)?funct3:3'b0;
  assign is_store_imm12 = (store_type)?imm12:12'b0;
  assign store_operation = (store_type)?is_store_operation:4'b0;
  assign store_data = (store_type)?is_store_data:32'b0;
  assign store_address = (store_type)?is_store_address:32'b0;
  assign mem_write = (store_type)?1'b1:1'b0;
  
  assign is_load_data = (load_type)?is_load_data_out:32'b0;
  assign mem_data_in = (store_type)?is_store_data:32'bz;
  assign load_data_in = (load_type)?mem_read_data:32'bz;
  assign is_load_rs1_data = (load_type)?reg_rs1_data:32'b0;
  assign is_load_funct3 = (load_type)?funct3:3'b0;
  assign is_load_imm12 = (load_type)?imm12:12'b0;
  assign load_operation = (load_type)?is_load_operation:4'b0;
  assign load_address = (load_type)?is_load_address:32'b0;
  assign mem_read = (load_type)?1'b1:1'b0;
  
  assign preset = (branch | call_type | jump_type)?1'b1:1'bz;
  assign preset_address = (is_branch)?is_branch_address:(call_type)?is_call_address:(jump_type)?jump_address:32'bz;
   
endmodule
