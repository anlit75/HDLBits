module top_module ();

    reg clk;
    reg reset;
    reg t;
    wire q;
    
    tff dut (.clk(clk), .reset(reset), .t(t), .q(q));
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset = 1'b0;
        #5 reset = 1'b1;
        #5 reset = 1'b0;
        t = 1'b1;
    end
endmodule
