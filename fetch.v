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
