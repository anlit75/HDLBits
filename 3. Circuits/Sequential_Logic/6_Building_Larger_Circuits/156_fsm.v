module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack 
);

    parameter SEARCH1=0, SEARCH2=1, SEARCH3=2, SEARCH4=3, SHIFT=4, COUNT=8, DONE=9;
    
    reg [3:0] state, next_state;
    
    always @(posedge clk) begin
        if (reset) state <= SEARCH1;
        else state <= next_state;
    end
    
    always @(*) begin
        case (state)
            SEARCH1: next_state = data ? SEARCH2 : SEARCH1;
            SEARCH2: next_state = data ? SEARCH3 : SEARCH1;
            SEARCH3: next_state = data ? SEARCH3 : SEARCH4;
            SEARCH4: next_state = data ? SHIFT : SEARCH1;
            COUNT: next_state = done_counting ? DONE : COUNT;
            DONE: next_state = ack ? SEARCH1 : DONE;
            default: next_state = state + 1;
        endcase
    end
    
    assign shift_ena = state >= SHIFT && state < COUNT;
    assign counting = state == COUNT;
    assign done = state == DONE;
endmodule
