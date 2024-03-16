module alu(
  input [31:0] in1_data,
  input [31:0] in2_data,
  input [3:0] alu_operation,
  output reg [31:0] out_data
);
  
  always @(in1_data, in2_data, alu_operation) begin
    case(alu_operation)
      // Addition
      4'b0001: out_data <= $signed(in1_data) + $signed(in2_data);
      
      // Subtraction
      4'b0010: out_data <= $signed(in1_data) - $signed(in2_data);
      
      // Logic left shift
      4'b0011:out_data <= $signed(in1_data) << $signed(in2_data);
      
      // Set less than
      4'b0100: out_data<= ($signed(in1_data) < $signed(in2_data)) ? 32'b1111_1111_1111_1111_1111_1111_1111_1111: 32'b0000_0000_0000_0000_0000_0000_0000_0000;
      
      // Set less than unsigned
      4'b0101: out_data <= (in1_data < in2_data) ? 32'b1111_1111_1111_1111_1111_1111_1111_1111: 32'b0000_0000_0000_0000_0000_0000_0000_0000;
      
      // XOR
      4'b0110: out_data <= $signed(in1_data) ^ $signed(in2_data);
      
      // Logic shift right
      4'b0111: out_data <= $signed(in1_data) >> $signed(in2_data);
      
      // Arithmetic shift right
      4'b1000: out_data <= $signed(in1_data) >>> $signed(in2_data);
      
      // OR
      4'b1001: out_data <= $signed(in1_data) | $signed(in2_data);
      
      // AND
      4'b1010: out_data <= $signed(in1_data) & $signed(in2_data);
      
      default: out_data <= 32'b0;
    endcase
  end
endmodule
