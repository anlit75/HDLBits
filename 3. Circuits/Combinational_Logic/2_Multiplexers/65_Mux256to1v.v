module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
    
    // Select starting at index "sel*4+3", 
    // then select a total width of 4 bits with decreasing (-:) index number.
    assign out = in[sel*4+3-:4];
endmodule
