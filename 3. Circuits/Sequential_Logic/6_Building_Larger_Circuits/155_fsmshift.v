module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena
);
    
    reg [2:0] counter;
    reg FOUR;

    always @(posedge clk) begin
        if (reset) shift_ena <= 1'b1;
        else if (FOUR) shift_ena <= 1'b0;
    end
    
    always @(posedge clk) begin
        if (reset) counter <= 3'b0;
        else counter <= counter + 1'b1;
    end
    
    assign FOUR = counter == 3;
endmodule
