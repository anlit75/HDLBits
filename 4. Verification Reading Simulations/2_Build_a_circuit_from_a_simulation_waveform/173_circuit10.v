module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  
);

    always @(posedge clk) begin
        case (state)
            0: state <= a & b ? ~state : state;
            1: state <= ~a & ~b ? ~state : state;
        endcase
    end
    
    always @(*) begin
        case (state)
            0: q = a ^ b;
            1: q = ~(a ^ b);
        endcase
    end
endmodule
