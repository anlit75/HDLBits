module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z 
); 

    parameter IN1 = 2'd0; 
    parameter IN2 = 2'd1;
    parameter IN3 = 2'd2;
    
    reg [1:0] state, next_state;
    
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) state <= IN1;
        else state <= next_state;
    end
    
    always @(*) begin
        case (state)
            IN1: next_state = x ? IN2 : IN1;
            IN2: next_state = x ? IN2 : IN3;
            IN3: next_state = x ? IN2 : IN1;
        endcase
    end
    
    assign z = x && state == IN3;
    
endmodule
