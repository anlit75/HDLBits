module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output reg done
); //

    // Modify FSM and datapath from Fsm_serialdata
    parameter IDLE=0, START=1, PARITY=4, DONE=2, STOP=3;
    
    reg [2:0] state=IDLE, next_state;
    reg [3:0] counter=4'b0;
    reg [7:0] t_out;
    reg odd;
    
    always @(posedge clk) begin
        if (reset) state <= IDLE;
        else state <= next_state;
    end
    
    always @(posedge clk) begin
        if (reset) begin 
            counter <= '0;
            t_out <= '0;
        end
        else if (state == START) begin
            counter <= counter + 1'b1;
            t_out[counter] <= in;
        end
        else begin
            counter <= '0;
            t_out <= '0;
        end
        
        done <= in && state == DONE;
    end
    
    always @(*) begin
        case (state)
            IDLE: next_state = in ? IDLE : START;
            START: next_state = counter == 7 ? PARITY : START;
            PARITY: next_state = ~^t_out ? DONE : IDLE;
            DONE: next_state = in ? IDLE : STOP;
            STOP: next_state = in ? IDLE : STOP;
        endcase
    end

    // New: Datapath to latch input bits.
    assign out_byte = in && state == DONE ? t_out : 8'bz;

    // New: Add parity checking.
    /*parity p(
        .clk(clk),
        .reset(reset),
        .in(counter == 8 && in),
        .odd(odd)
    );*/

endmodule
