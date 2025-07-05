// Code your testbench here
// or browse Examples
module tb;
  parameter N = 4;
  logic clk, rst;
  
  logic [N-1:0] g3;
  
  initial begin
    clk = 0;
    forever begin
      #5 clk = ~clk;
    end
  end
  
  initial begin
    rst = 0;
    #10 rst  = 1;
    #10 rst = 0;
    
    #300;
    $finish;
  end
  
  initial begin
    $dumpvars(0);
    $dumpfile("dump.vcd");
  end
  
  gray_p #(.N(N)) g2 (clk, rst, g3);
endmodule
