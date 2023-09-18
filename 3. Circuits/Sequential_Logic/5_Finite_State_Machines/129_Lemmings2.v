module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    reg [1:0] state, next_state, last_state;
    
    parameter LEFT=0, RIGHT=1, FALL=2;
    
    always @(posedge clk or posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) state <= LEFT;
        else begin 
            state <= next_state;
            if (state != FALL) last_state = state;
        end
    end
    
    always @(*) begin
        // State transition logic
        case (state)
            LEFT: begin
                if (ground) next_state = bump_left ? RIGHT : LEFT;
                else next_state = FALL;
            end
            RIGHT: begin
                if (ground) next_state = bump_right ? LEFT : RIGHT;
                else next_state = FALL;
            end
            FALL:  begin
                if (ground) next_state = last_state;
                else next_state = FALL;
            end
        endcase
    end
    
    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL);
endmodule
