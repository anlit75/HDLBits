module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    parameter A=0, B=1, C=2, D=3;
    
    reg [1:0] state, next_state;
    
    always @(posedge clk) begin
        if (~resetn) state <= A;
        else state <= next_state;
    end
    
    always @(*) begin
        case (state)
            A: begin
                if (r[1]) next_state = B;
                else if (r[2]) next_state = C;
                else if (r[3]) next_state = D;
                else next_state = A;
            end
            B:  begin
                if (r[1]) next_state = B;
                else next_state = A;
            end
            C:  begin
                if (r[2]) next_state = C;
                else next_state = A;
            end
            D:  begin
                if (r[3]) next_state = D;
                else next_state = A;
            end
        endcase
    end
    
    assign g = {state==D, state==C, state==B};
endmodule
