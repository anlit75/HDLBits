module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    
    wire c1, c2;

    add16 a1 (.a(a[15: 0]), .b(b[15: 0]), .cin(1'b0), .sum(sum[15: 0]), .cout(c1));
    add16 a2 (.a(a[31:16]), .b(b[31:16]), .cin(c1),   .sum(sum[31:16]), .cout(c2));
endmodule
