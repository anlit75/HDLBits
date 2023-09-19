module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    parameter IDLE=0, START=1, DONE=2, STOP=3;
    
    reg [1:0] state=IDLE, next_state;
    reg [3:0] counter=4'b0;
    
    always @(posedge clk) begin
        if (reset) state <= IDLE;
        else state <= next_state;
    end
    
    always @(posedge clk) begin
        if (reset) counter <= '0;
        else if (state == START) counter <= counter + 1'b1;
        else counter <= '0;
        
        done <= in && state == DONE;
    end
    
    always @(*) begin
        case (state)
            IDLE: next_state = in ? IDLE : START;
            START: next_state = counter == 7 ? DONE : START;
            DONE: next_state = in ? IDLE : STOP;
            STOP: next_state = in ? IDLE : STOP;
        endcase
    end
        
endmodule
