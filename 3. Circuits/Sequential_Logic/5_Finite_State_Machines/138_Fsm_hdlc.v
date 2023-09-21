module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err
);

    reg [1:0] state, next_state;
    reg [3:0] counter;
    
    parameter IDLE=0, DISC=1, FLAG=2, ERR=3;
    
    always @(posedge clk) begin
        if (reset) state <= IDLE;
        else state <= next_state;
    end
    
    always @(posedge clk) begin
        if (reset) counter <= '0;
        else if (state != IDLE)
            counter <= in ? counter + 1'b1 : '0;
        else counter <= '0;
    end
    
    always @(*) begin
        case (state)
            IDLE: next_state = in ? DISC : IDLE;
            DISC: next_state = in && counter == 4 ? FLAG : in ? DISC : IDLE;
            FLAG: next_state = in ? ERR : IDLE;
            ERR: next_state = in ? ERR : IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;;
            flag <= 1'b0;
            err <= 1'b0;
        end
        else begin
            disc <= ~in && counter == 4;
            flag <= ~in && state == FLAG;
            err <= next_state == ERR;
        end
    end
endmodule
