module top_module (
    input [3:1] y,
    input w,
    output Y2);

    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;
    
    reg [2:0] next_state;
    
    always @(*) begin
        case (y)
            A: next_state = w ? A : B;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = w ? A : F;
            E: next_state = w ? D : E;
            F: next_state = w ? D : C;
        endcase
    end
    
    assign Y2 = next_state[1];
endmodule
