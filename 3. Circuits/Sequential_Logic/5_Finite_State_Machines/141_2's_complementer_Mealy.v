module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter A = 2'b01;
    parameter B = 2'b10;
    
    reg [1:0] state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= next_state;
    end
    
    always @(*) begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = B;
        endcase
    end
    
    assign z = (state == A && x) | (state == B && ~x) ? 1'b1 : 1'b0;
endmodule
