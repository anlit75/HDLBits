module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging 
); 

    reg [2:0] state, next_state, last_state;
    reg [4:0] counter='0;
    
    parameter LEFT=0, RIGHT=1, FALL=2, DIG=3, SPLATTER=4;
    
    always @(posedge clk or posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin 
            state <= LEFT;
            counter <= '0;
        end
        else begin 
            state <= next_state;
            counter <= (state == FALL) ? counter + 1'b1 : '0; 
            
            if (state == LEFT || state == RIGHT) last_state <= state;
            else last_state <= last_state;
        end
    end
    
    always @(*) begin
        // State transition logic
        case (state)
            LEFT: begin
                if (ground) next_state = dig ? DIG : (bump_left ? RIGHT : LEFT);
                else next_state = FALL;
            end
            RIGHT: begin
                if (ground) next_state = dig ? DIG : (bump_right ? LEFT : RIGHT);
                else next_state = FALL;
            end
            FALL:  begin
                if (ground) next_state = (counter > 21) ? SPLATTER : last_state;
                else next_state = FALL;
            end
            DIG: begin
                if (ground) next_state = DIG;
                else next_state = FALL;
            end
            SPLATTER: next_state = SPLATTER;
        endcase
    end
    
    // Output logic
    assign walk_left = (state != SPLATTER) & (state == LEFT);
    assign walk_right = (state != SPLATTER) & (state == RIGHT);
    assign aaah = (state != SPLATTER) & (state == FALL);
    assign digging = (state != SPLATTER) & (state == DIG);
endmodule
