module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

    parameter LOAD=0, COUNT=1, TC=2;
    
    reg [1:0] state=LOAD, next_state;
    reg [9:0] cnt;
    
    always @(posedge clk) begin
       state <= next_state;
    end
    
    always @(*) begin
        case (state)
            LOAD: next_state = load ? (data==0 ? TC : COUNT) : LOAD;
            COUNT: next_state = load ? (data==0 ? TC : COUNT) : (cnt > 1 ? COUNT : TC);
            TC: next_state = load ? (data==0 ? TC : COUNT) : TC;
        endcase
    end
    
    always @(posedge clk) begin
        if (load) cnt <= data;
        else if (state == COUNT) cnt <= cnt - 1'b1;
        else cnt <= 1'b0;
    end
    
    assign tc = state == TC;
endmodule
