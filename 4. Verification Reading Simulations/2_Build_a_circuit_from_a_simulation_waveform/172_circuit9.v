module top_module (
    input clk,
    input a,
    output [3:0] q 
);

    always @(posedge clk) begin
        if (a) q <= 4'd4;
        else if (q < 6) q <= q + 1'b1;
        else q <= '0;
    end
endmodule
