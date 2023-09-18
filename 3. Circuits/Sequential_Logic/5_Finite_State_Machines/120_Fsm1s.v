module top_module(
    input clk,
    input reset,    // Synchronous reset to state B
    input in,
    output out
); 

    parameter A=0, B=1; 
    reg state, next_state;

	// This is a combinational always block
    always @(*) begin    
        // State transition logic
        case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
		endcase
    end

	 // This is a sequential always block
    always @(posedge clk) begin   
        // State flip-flops with synchronous reset
        if (reset) state <= B;
        else state <= next_state;
    end

    // Output logic
    assign out = (state == A) ? 0: 1;

endmodule