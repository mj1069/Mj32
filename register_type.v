module register_type(
  input [9:0]funct10,
  output [3:0] operation
);
  
  assign operation = (funct10 == 10'b0000000000)?4'b0001:(funct10 == 10'b000100000)?4'b0010:(funct10 == 10'b001000000)?4'b0011:(funct10 == 10'b010000000)?4'b0100:(funct10 == 10'b011000000)?4'b0101:(funct10 == 10'b100000000)?4'b0110:(funct10 == 10'b101000000)?4'b0111:(funct10 == 10'b101100000)?4'b1000:(funct10 == 10'b110000000)?4'b1001:(funct10 == 10'b111000000)?4'b1010:4'b0000;

endmodule
