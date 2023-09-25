module top_module ( );

    reg clk;
    
    dut dut (.clk(clk));
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
endmodule
