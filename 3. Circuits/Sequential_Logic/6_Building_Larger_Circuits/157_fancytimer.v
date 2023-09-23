module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack 
);

    parameter SEARCH1=0, SEARCH2=1, SEARCH3=2, SEARCH4=3, SHIFT=4, COUNT=8, DONE=9;
    
    reg [3:0] state, next_state;
    reg [9:0] cnt;
    
    always @(posedge clk) begin
        if (reset) state <= SEARCH1;
        else state <= next_state;
    end
    
    always @(*) begin
        case (state)
            SEARCH1: next_state = data ? SEARCH2 : SEARCH1;
            SEARCH2: next_state = data ? SEARCH3 : SEARCH1;
            SEARCH3: next_state = data ? SEARCH3 : SEARCH4;
            SEARCH4: next_state = data ? SHIFT : SEARCH1;
            COUNT: next_state = (count==0 && cnt==999) ? DONE : COUNT;
            DONE: next_state = ack ? SEARCH1 : DONE;
            default: next_state = state + 1;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            count <= '0;
            cnt <= '0;
    	end
        else if (state >= SHIFT && state < COUNT) 
            count <= {count[2:0], data};
        else if (state == COUNT) begin
            if (cnt < 999) 
                cnt <= cnt + 1'b1;
            else begin
                cnt <= '0;
                count <= count - 1'b1; 
            end
        end
        else begin
            count <= '0;
            cnt <= '0;
    	end
    end
    
    assign counting = state == COUNT;
    assign done = state == DONE;
endmodule
