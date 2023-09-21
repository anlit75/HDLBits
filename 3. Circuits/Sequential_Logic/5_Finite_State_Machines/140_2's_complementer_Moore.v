module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    /*parameter IDLE = 2'd0;
    parameter COMP = 2'd1;
    
    reg [1:0] state, next_state;
    reg cinout;
    
    always @(posedge clk or posedge areset) begin
        if (areset) state <= IDLE;
        else state <= next_state;
    end
    
    always @(*) begin
        case (state)
            IDLE: next_state = areset ? IDLE : COMP;
            COMP: next_state = areset ? IDLE : COMP;
        endcase
    end*/
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
            cinout <= 1'b1;
        end
        else if begin
           	z <= ~x ^ cinout; 
            cinout <= ~x & cinout;
        end
    end
endmodule
