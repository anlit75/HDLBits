module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done
); 
    
    reg [1:0] state, next_state;
    parameter CHECK=0, B1=1, B2=2, B3=3;
    
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) state <= CHECK;
        else state <= next_state;
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

endmodule
