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
