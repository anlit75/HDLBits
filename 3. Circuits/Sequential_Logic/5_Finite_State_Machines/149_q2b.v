module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
	/*always @(*) begin
        case (state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
        endcase
    end*/
    
    assign Y1 = w && y[0];
    assign Y3 = ~w && (y[1] || y[2] || y[4] || y[5]);

endmodule
