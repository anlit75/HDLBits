module top_module (
    input clk,
    input reset,
    output [9:0] q
);
    
    always @(posedge clk) begin
        if (reset) q <= '0;
        else if (q != 999) q <= q + 1'b1;
        else q <= '0;
    end
    
endmodule
