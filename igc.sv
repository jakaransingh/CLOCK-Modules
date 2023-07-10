module igc(
   input  clk_i,
   input  en_i,
   input  tst_en_i,
   output clk_o
);

  logic clk_i;
  logic en_i;
  logic tst_en_i;
  logic clk_o;

  logic clk_en;

  assign en = tst_en ? 1'b1 : en_i;

  always_latch 
  begin
    if (clk_i == 1'b0) 
      clk_en <= en;
  end

  assign clk_o = clk_i & en;

endmodule
