module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out
);
    
    reg [2:0] Q = 3'b0;

    dff1 d1 (.clk(clk), .resetn(resetn), .in(in), .out(Q[0]));
    dff1 d2 (.clk(clk), .resetn(resetn), .in(Q[0]), .out(Q[1]));
    dff1 d3 (.clk(clk), .resetn(resetn), .in(Q[1]), .out(Q[2]));
    dff1 d4 (.clk(clk), .resetn(resetn), .in(Q[2]), .out(out));
endmodule

module dff1 (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out
);

    always @(posedge clk) begin
        if (!resetn) out <= 1'b0;
        else out <= in;
    end
endmodule
