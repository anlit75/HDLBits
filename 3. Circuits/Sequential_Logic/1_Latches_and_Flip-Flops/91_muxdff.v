module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    
    reg m_out;

    always @(*) begin
        case (L)
            1'b0: m_out = q_in;
            1'b1: m_out = r_in;
            default: m_out = 1'b0;
        endcase
    end
    
    always @(posedge clk) begin
        Q <= m_out;
    end
endmodule
