module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    reg [3:0] t_cout;

    always @(*) begin
        t_cout[0] = cin;
        for (int i=0; i<3; i++) begin
            sum[i] = a[i] ^ b[i] ^ t_cout[i];
            t_cout[i+1] = (a[i] & b[i]) | (a[i] & t_cout[i]) | (b[i] & t_cout[i]);
        end
        cout = t_cout[3:1];
    end
endmodule
