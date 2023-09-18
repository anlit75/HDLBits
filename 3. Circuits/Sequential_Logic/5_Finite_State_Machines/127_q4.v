module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

    
    reg [1:0] state, next_state;
    
    parameter S1=0, S12=1, S23=2, S3=3;
    
    always @(posedge clk) begin
        if (reset) state <= S1;
        else state <= next_state;
    end
    
    always @(*) begin
        case (s)
            3'b000: next_state = S1;
            3'b001: next_state = S12;
            3'b011: next_state = S23;
            3'b111: next_state = S3;
        endcase

        case (state)
            S1 : {fr3, fr2, fr1} = 3'b111;
            S12: {fr3, fr2, fr1} = 3'b011;
            S23: {fr3, fr2, fr1} = 3'b001;
            S3 : {fr3, fr2, fr1} = 3'b000;
        endcase
    end
    
    
    always @(posedge clk) begin
        if (reset) dfr <= 1'b1;
        else if (next_state < state) dfr <= 1'b1;
        else if (next_state > state) dfr <= 1'b0;
        else dfr <= dfr;
    end
    
endmodule
