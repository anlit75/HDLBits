module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    
    reg [2:0] next_state;
    
    always @(*) begin
        case (y)
            A: next_state = x ? B : A;
            B: next_state = x ? E : B;
            C: next_state = x ? B : C;
            D: next_state = x ? C : B;
            E: next_state = x ? E : D;
        endcase
    end
    
    assign z = (y == D) || (y == E);
    assign Y0 = next_state[0];
endmodule
