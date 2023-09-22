module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    parameter IDLE=0, RST=1, MONX1=2, MONX2=3, MONX3=4, MONY1=5, MONY2=6, STOP1=7, STOP0=8;
    
    reg [3:0] state, next_state;
    
    always @(posedge clk) begin
        if (~resetn) state <= IDLE;
        else state <= next_state;
    end
    
    always @(*) begin
        case (state)
            IDLE: next_state = resetn ? RST : IDLE;
            RST : next_state = MONX1;
            MONX1: next_state = x ? MONX2 : MONX1;
            MONX2: next_state = x ? MONX2 : MONX3;
            MONX3: next_state = x ? MONY1 : MONX1;
            MONY1: next_state = y ? STOP1 : MONY2;
            MONY2: next_state = y ? STOP1 : STOP0;
            STOP1: next_state = STOP1;
            STOP0: next_state = STOP0;
        endcase
    end
    
    assign f = state == RST;
    assign g = state == MONY1 || state == MONY2 || state == STOP1;
endmodule
