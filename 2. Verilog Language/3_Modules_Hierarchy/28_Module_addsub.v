module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire c1, c2;
    wire [31:0] bxor;
    
    assign bxor = b ^ {32{sub}};

    add16 a1 (.a(a[15: 0]), .b(bxor[15: 0]), .cin(sub),  .sum(sum[15: 0]), .cout(c1));
    add16 a2 (.a(a[31:16]), .b(bxor[31:16]), .cin(c1),   .sum(sum[31:16]), .cout(c2));
endmodule
