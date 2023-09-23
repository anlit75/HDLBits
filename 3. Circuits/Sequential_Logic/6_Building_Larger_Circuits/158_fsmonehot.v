module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
); 

    // You may use these parameters to access state bits using e.g., state[B2] instead of state[6].
    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, Count=8, Wait=9;
    
    /*reg [9:0] next_state;
    
    always @(*) begin
        case (state)
            S: next_state = d ? S1 : S;
            S1: next_state = d ? S11 : S;
            S11: next_state = d ? S11 : S110;
            S110: next_state = d ? B0 : S;
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = Count;
            Count: next_state = done_counting ? Wait : Count;
            Wait: next_state = ack ? S : Wait;
        endcase
    end*/

    assign B3_next = state[B2];
    assign S_next = ~d && state[S] || ~d && state[S1] || ~d && state[S110] || ack && state[Wait];
    assign S1_next = d && state[S];
    assign Count_next = state[B3] || ~done_counting && state[Count];
    assign Wait_next = done_counting && state[Count] || ~ack && state[Wait];
    assign done = state[Wait];
    assign counting = state[Count];
    assign shift_ena = |state[B3:B0];

endmodule
