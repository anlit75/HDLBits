module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z
);

    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;
    
    reg [2:0] state, next_state;
    
    always @(posedge clk) begin
        if (reset) state <= A;
        else state <= next_state;
    end
    
    always @(*) begin
        case (state)
            A: next_state = w ? A : B;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = w ? A : F;
            E: next_state = w ? D : E;
            F: next_state = w ? D : C;
        endcase
    end
    
    assign z = state == E || state == F;
endmodule
