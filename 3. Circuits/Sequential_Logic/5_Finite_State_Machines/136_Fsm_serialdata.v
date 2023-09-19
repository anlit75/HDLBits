module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
);

    // Use FSM from Fsm_serial
    parameter IDLE=0, START=1, DONE=2, STOP=3;
    
    reg [1:0] state=IDLE, next_state;
    reg [3:0] counter=4'b0;
    reg [7:0] t_out;
    
    always @(posedge clk) begin
        if (reset) state <= IDLE;
        else state <= next_state;
    end
    
    always @(posedge clk) begin
        if (reset) counter <= '0;
        else if (state == START) counter <= counter + 1'b1;
        else counter <= '0;
        
        t_out[counter] = in;
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

    // New: Datapath to latch input bits.
    assign out_byte = in && state == DONE ? t_out : 8'bx;

endmodule
