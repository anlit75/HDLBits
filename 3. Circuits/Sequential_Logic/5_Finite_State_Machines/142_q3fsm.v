module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    parameter A=0, B1=1, B2=2, B3=3;
    
    reg [1:0] state, next_state;
    reg [2:0] check;
    
    always @(posedge clk) begin
        if (reset) state <= A;
        else state <= next_state;
    end
    
    always @(*) begin
        case (state)
            A: next_state = s ? B1 : A;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = B1;
        endcase

        case (state)
            B1: check[0] = w;
            B2: check[1] = w;
            B3: check[2] = w;
            default: check = '0;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) z <= 1'b0;
        else if (state == B3) z <= (check[0] + check[1] + check[2]) == 2;
        else z <= 1'b0;
    end
    
endmodule
