module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q 
); 
    
    reg [323:0] pad_broad;
    
    wire [255:0] q_next;
    wire [2:0] count;
    
    int pad;
    genvar i;
    
    // GoL broad padding
    always @(*) begin
        pad_broad[17:0] = {q[240], q[255:240], q[255]};
        pad_broad[323:306] = {q[0], q[15:0], q[15]};
        
        for (pad=0; pad<16; pad++) begin
            // pad_broad[ 35-:18] = {q[  0], q[ 15:  0], q[ 15]};
            // pad_broad[ 53-:18] = {q[ 16], q[ 31: 16], q[ 31]};
            // pad_broad[305-:18] = {q[240], q[255:240], q[255]};
            pad_broad[(pad+1)*18+17 -: 18] = {q[pad*16], q[pad*16+15 -: 16], q[pad*16+15]};
        end
    end
    
    // Walk all instance in broad and get new state
    generate
        for (i=0; i<256; i++) begin : C8
            count8 c8 (
                // i= 0: {pad_broad[ 2: 0], pad_broad[18], pad_broad[20], pad_broad[38:36]} 
                // i=16: {pad_broad[20:18], pad_broad[36], pad_broad[38], pad_broad[56:54]} 
                .data({
                    pad_broad[(i+ 2) + (i/16*2) -: 3], 
                    pad_broad[(i+18) + (i/16*2)], 
                    pad_broad[(i+20) + (i/16*2)], 
                    pad_broad[(i+38) + (i/16*2) -: 3]
                }), 
                .q(q[i]), 
                .qn(q_next[i])
            );
        end
    endgenerate
    
    // Update GoL broad
    always @(posedge clk) begin
        if (load) q <= data; 
        else begin
            q <= q_next;
        end
    end
endmodule

// Count number of alive neighbours & give next state
module count8 (
    input [7:0] data,
    input q, 
    output qn
);
    
    reg [2:0] count;
    
    always @(*) begin
       count = data[0] + data[1] + data[2] + data[3] + data[4] + data[5] + data[6] + data[7];
       case (count)
           3'd2: qn = q;
           3'd3: qn = 1'b1;
           default: qn = 1'b0;
       endcase 
    end
endmodule
