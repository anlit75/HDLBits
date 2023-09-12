module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); 

    reg [8:0] t_cout = 0;
    
    always @(*) begin
        for (int i=0; i<8; i++) begin
            s[i] = a[i] ^ b[i] ^ t_cout[i];
            t_cout[i+1] = (a[i] & b[i]) | (b[i] & t_cout[i]) | (a[i] & t_cout[i]);
        end
        // http://www.c-jump.com/CIS77/CPU/Overflow/lecture.html#O01_0090_signed_overflow
        overflow = t_cout[8] ^ t_cout[7];
    end
endmodule
