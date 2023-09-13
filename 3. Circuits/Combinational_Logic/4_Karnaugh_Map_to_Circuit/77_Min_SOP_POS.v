module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 

    // The question is wrong, the correct one is:
    // "system generates a logic-1 when 2, 3, 7, 11 or 15 appears on the inputs."
    assign out_sop = (~a & ~b & c) | (c & d);
    assign out_pos = c & ((~a & ~b) | (d));
endmodule
