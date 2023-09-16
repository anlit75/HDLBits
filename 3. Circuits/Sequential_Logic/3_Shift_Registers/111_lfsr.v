module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output reg [2:0] LEDR);  // Q

    mux_dff m1 (.clk(KEY[0]), .L(KEY[1]), .sel({SW[0], LEDR[2]}), .Q(LEDR[0]));
    mux_dff m2 (.clk(KEY[0]), .L(KEY[1]), .sel({SW[1], LEDR[0]}), .Q(LEDR[1]));
    mux_dff m3 (.clk(KEY[0]), .L(KEY[1]), .sel({SW[2], LEDR[1]^LEDR[2]}), .Q(LEDR[2]));
endmodule

module mux_dff (
    input clk, 
    input L, 
    input [1:0] sel, 
    output reg  Q
);
    
    always @(posedge clk)
        Q <= L ? sel[1] : sel[0];
endmodule
