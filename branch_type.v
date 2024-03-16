////////////////////////////////////////////////////////////////////////////////
// Project: MJ32 - Simple RISC V processor core
// File: branch_type.v
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

module branch_type(
  input [31:0]src1_data, src2_data,
  input [2:0]funct3,
  input [11:0]imm12,
  output reg branch,
  output reg [31:0] branch_address
);
  
  always @(src1_data, src2_data, funct3, imm12) begin
    case(funct3)
      
      // Branch if equal
      3'b000: begin
        if($signed(src1_data) == $signed(src2_data)) begin
          branch <= 1'b1;
          branch_address <= {{12{1'b0}}, imm12} >> 2;
        end
        else begin
          branch <= 1'b0;
        end
      end
      
      // Branch if not equal
      3'b001: begin
        if($signed(src1_data) != $signed(src2_data)) begin
          branch <= 1'b1;
          branch_address <= {{12{1'b0}}, imm12} >> 2;
        end
        else begin
          branch <= 1'b0;
        end
      end
      
      // Branch if less than
      3'b100: begin
        if($signed(src1_data) < $signed(src2_data)) begin
          branch <= 1'b1;
          branch_address <= {{12{1'b0}}, imm12} >> 2;
        end
        else begin
          branch <= 1'b0;
        end
      end
      
      // Branch if greater than
      3'b101: begin
        if($signed(src1_data) > $signed(src2_data)) begin
          branch <= 1'b1;
          branch_address <= {{12{1'b0}}, imm12} >> 2;
        end
        else begin
          branch <= 1'b0;
        end
      end
      
      // Branch if less than unsigned
      3'b110: begin
        if(src1_data < $signed(src2_data)) begin
          branch <= 1'b1;
          branch_address <= {{12{1'b0}}, imm12} >> 2;
        end
        else begin
          branch <= 1'b0;
        end
      end
      
      // Branch if greater than unsigned
      3'b111: begin
        if(src1_data > $signed(src2_data)) begin
          branch <= 1'b1;
          branch_address <= {{12{1'b0}}, imm12} >> 2;
        end
        else begin
          branch <= 1'b0;
        end
      end  
      
      // Default
      default: begin
        branch <= 1'b0;
        branch_address <= 32'b0;
      end
    endcase
  end
endmodule
