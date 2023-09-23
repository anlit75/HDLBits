module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting
);

    parameter SEARCH1=0, SEARCH2=1, SEARCH3=2, SEARCH4=3, START=4;
    
    reg [2:0] state, next_state;
    
    always @(posedge clk) begin
        if (reset) state <= SEARCH1;
        else state <= next_state;
    end
    
    always @(*) begin
        case (state)
            SEARCH1: next_state = data ? SEARCH2 : SEARCH1;
            SEARCH2: next_state = data ? SEARCH3 : SEARCH1;
            SEARCH3: next_state = data ? SEARCH3 : SEARCH4;
            SEARCH4: next_state = data ? START : SEARCH1;
            START: next_state = START;
        endcase
    end
    
    assign start_shifting = state == START;
endmodule
