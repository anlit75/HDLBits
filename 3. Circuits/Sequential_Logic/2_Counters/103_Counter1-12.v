module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); 

    count4 the_counter (clk, c_enable, c_load, c_d, Q);
	
    assign c_enable = enable;
    assign c_load = enable & (Q == 12) | reset;
    assign c_d = 1'b1;
    
endmodule
