module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 

    MUXDFF md1 (.KEY(KEY), .R(SW[3]), .Q(LEDR[3]));
    MUXDFF md2 (.KEY({LEDR[3], KEY[2:0]}), .R(SW[2]), .Q(LEDR[2]));
    MUXDFF md3 (.KEY({LEDR[2], KEY[2:0]}), .R(SW[1]), .Q(LEDR[1]));
    MUXDFF md4 (.KEY({LEDR[1], KEY[2:0]}), .R(SW[0]), .Q(LEDR[0]));
endmodule

module MUXDFF (
	input [3:0] KEY,
    input R, 
    output Q
);

    always @(posedge KEY[0]) begin
        Q <= KEY[2] ? R : (KEY[1] ? KEY[3] : Q);
    end
endmodule
