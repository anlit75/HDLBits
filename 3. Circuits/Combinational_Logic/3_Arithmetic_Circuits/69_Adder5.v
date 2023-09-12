module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);

    reg [4:0] t_cout;

    always @(*) begin
        t_cout[0] = 1'b0;
        for (int i=0; i<4; i++) begin
            sum[i] = x[i] ^ y[i] ^ t_cout[i];
            t_cout[i+1] = (x[i] & y[i]) | (x[i] & t_cout[i]) | (y[i] & t_cout[i]);
        end
        sum[4] = t_cout[4];
    end
endmodule
