module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire c1, c2, c3;
    wire [15:0] s0, s1;

    add16 a1 (.a(a[15: 0]), .b(b[15: 0]), .cin(1'b0), .sum(sum[15: 0]), .cout(c1));
    add16 a2 (.a(a[31:16]), .b(b[31:16]), .cin(1'b0), .sum(s0), .cout(c2));
    add16 a3 (.a(a[31:16]), .b(b[31:16]), .cin(1'b1), .sum(s1), .cout(c3));
    
    always @(*)
        case (c1)
            1'b0: sum[31:16] = s0;
            1'b1: sum[31:16] = s1;
        endcase
endmodule
