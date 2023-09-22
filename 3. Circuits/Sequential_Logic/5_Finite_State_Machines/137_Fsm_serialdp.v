module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output reg done
);

    // Modify FSM and datapath from Fsm_serialdata
    parameter START = 0, CHECK = 9, STOP = 10, IDEL = 11, ERROR = 12;
    
    reg [4:0] state, next_state;
    reg valid, start;
    
    wire odd;

    always @(*) begin
        start = 0;
        case (state)
            IDEL: begin next_state = in ? IDEL : START; start = 1; end
            STOP: begin next_state = in ? IDEL : START; start = 1; end
            CHECK: next_state = in ? STOP : ERROR;
            ERROR: next_state = in ? IDEL : ERROR;
            default: next_state = state + 1;
        endcase  
    end
    
    always @(posedge clk)
        if (reset)
            state <= IDEL;
        else begin
            state <= next_state;
            valid <= odd;
        end
    
    always @(posedge clk)
        if ((0 <= state) && (state < 8))
            out_byte[state] <= in;
    
    assign done = valid && (state == STOP);

    // New: Add parity checking.
    parity p(
        .clk(clk),
        .reset(reset || start),
        .in(in),
        .odd(odd)
    );

endmodule
