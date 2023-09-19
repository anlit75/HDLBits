module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done
); 

    // FSM from fsm_ps2
    reg [1:0] state, next_state;
    reg [23:0] t_out;
    
    parameter CHECK=0, B1=1, B2=2, B3=3;
    
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) state <= CHECK;
        else begin
            state <= next_state;
            if (next_state == B1) t_out[23:16] = in;
            else if (next_state == B2) t_out[15:8] = in;
            else if (next_state == B3) t_out[7:0] = in;
        end
    end

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            CHECK: next_state = in[3] ? B1 : CHECK;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = in[3] ? B1 : CHECK;
        endcase
    end
 
    // Output logic
    assign done = state == B3;

    // New: Datapath to store incoming bytes.
    assign out_bytes = (state == B3) ? t_out : 24'bx;

endmodule
