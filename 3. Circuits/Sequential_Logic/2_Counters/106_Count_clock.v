module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
); 

    wire s2s, m2m, h2h;
    wire s2m, m2h, ap2ap;
    wire ap2pa;
    
    assign s2s = ss[3:0] == 4'h9;				// ??:??:?9		   -> ??:??:10
    assign s2m = ss == 8'h59;					// ??:??:59		   -> ??:?1:00
    assign m2m = mm[3:0] == 4'h9 && s2m;		// ??:?9:59		   -> ??:10:00
    assign m2h = mm == 8'h59 && s2m;			// ??:59:59		   -> ?1:00:00
    assign h2h = hh[3:0] == 4'h9 && m2h;		// ?9:59:59		   -> 10:00:00
    assign ap2ap = hh == 8'h12 && m2h;			// 12:59:59 am/pm  -> 01:00:00 am/pm
    assign ap2pa = hh == 8'h11 && m2h;			// 11:59:59 am/pm  -> 12:00:00 pm/am
    
    always @(posedge clk) begin
        if (reset) pm <= 1'b0;
        else if (ena) pm <= ap2pa ? ~pm : pm;
    end
    
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12; 
            mm <= 8'h0;
            ss <= 8'h0;
        end
        else if (ena) begin
            ss[3:0] <= ss[3:0] + 1'b1;
            
            // hh
            if (ap2pa) begin
                hh <= 8'h12;
                mm <= '0;
                ss <= '0;
            end
            else if (ap2ap) begin
                hh <= 8'h1;
                mm <= '0;
                ss <= '0;
            end
            else if (h2h) begin
                hh[7:4] <= hh[7:4] + 1'b1;
                hh[3:0] <= '0;
                mm <= '0;
                ss <= '0;
            end
            
            // mm to hh
            else if (m2h) begin
                hh[3:0] <= hh[3:0] + 1'b1;
                mm <= '0;
                ss <= '0;
            end
            else if (m2m) begin
                mm[7:4] <= mm[7:4] + 1'b1;
                mm[3:0] <= '0;
                ss <= '0;
            end
            
            // ss to mm
            else if (s2m) begin
                mm[3:0] <= mm[3:0] + 1'b1;
                ss <= '0;
            end
            else if (s2s) begin
                ss[7:4] <= ss[7:4] + 1'b1;
                ss[3:0] <= '0;
            end
        end
    end
endmodule
