module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [100:0] t_cout;
    
    assign cout = t_cout[100];

    genvar i;
    generate
        assign t_cout[0] = cin;
        for (i=0; i<100; i++) begin : BCD
            bcd_fadd B(
                .a(a[(i+1)*4-1:i*4]), 
                .b(b[(i+1)*4-1:i*4]), 
                .cin(t_cout[i]), 
                .cout(t_cout[i+1]), 
                .sum(sum[(i+1)*4-1:i*4])
            );
        end
    endgenerate
endmodule
