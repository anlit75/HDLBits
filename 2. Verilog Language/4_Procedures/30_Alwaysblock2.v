// synthesis verilog_input_version verilog_2001
module top_module(
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   );

    // assign statement
    assign out_assign = a ^ b;
    
    // combinational always block
    always @(*) out_always_comb = a ^ b;    
    
    // clocked/sequential always block
    always @(posedge clk) out_always_ff <= a ^ b;
endmodule
