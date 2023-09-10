module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    reg [100:0] co;

    always @(*) begin
        co[0] = cin;
        for (int i=0; i<100; i++) begin
            sum[i] = a[i] ^ b[i] ^ co[i];
            co[i+1] = (a[i] & b[i]) | (b[i] & co[i]) | (a[i] & co[i]);
        end
        cout = co[100:1];
    end
endmodule
