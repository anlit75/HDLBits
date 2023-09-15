module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    
    reg [7:0] inlast;

    always @(posedge clk) begin
        inlast <= in;
        pedge <= in & ~inlast;
    end
endmodule
