module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    wire [4:0] t_cout;

    genvar i;
    generate
        assign t_cout[0] = cin;
        for (i=0; i<4; i++) begin : BCD
            bcd_fadd B(
                .a(a[(i+1)*4-1:i*4]), 
                .b(b[(i+1)*4-1:i*4]), 
                .cin(t_cout[i]), 
                .cout(t_cout[i+1]), 
                .sum(sum[(i+1)*4-1:i*4])
            );
        end
    	assign cout = t_cout[4];
    endgenerate
endmodule
