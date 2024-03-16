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
