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
