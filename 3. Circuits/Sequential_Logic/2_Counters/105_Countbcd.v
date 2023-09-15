module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    reg re;

    always @(posedge clk) begin
        if (reset) ena <= 3'b0;
        else begin
            re     <= (q[ 3:0] == 8 && q[ 7:4] == 9 && q[11:8] == 9 && q[15:12] == 9);
            ena[3] <= (q[ 3:0] == 8 && q[ 7:4] == 9 && q[11:8] == 9);
            ena[2] <= (q[ 3:0] == 8 && q[ 7:4] == 9);
            ena[1] <= (q[ 3:0] == 8);
            
        end
    end
    
    always @(posedge clk) begin
        if (reset) q <= 16'b0;
        else begin
            q[3:0] <= q[3:0] + 1'b1;
            if (re & ena[3] & ena[2] & ena[1]) begin
                q <= '0;
            end
           else if (ena[3] & ena[2] & ena[1]) begin
                q[15:12] <= q[15:12] + 1'b1;
                q[11:0] <= '0;
            end
            else if (ena[2] & ena[1]) begin
                q[11:8] <= q[11:8] + 1'b1;
                q[7:0] <= '0;
            end
            else if (ena[1]) begin
                q[7:4] <= q[7:4] + 1'b1;
                q[3:0] <= '0;
            end
        end
    end
endmodule
