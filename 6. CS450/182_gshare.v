module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    
    parameter SNT=2'b00, WNT=2'b01, WT=2'b10, ST=2'b11;
    
    reg [1:0] PHT [127:0];

    always @(posedge clk, posedge areset) begin
        if (areset)
            predict_history <= 0;
        else if (train_valid && train_mispredicted)
            predict_history <= {train_history[5:0], train_taken};
        else if (predict_valid)
            predict_history <= {predict_history[5:0], predict_taken};
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset) 
            for (int i=0; i<128; i++) PHT[i] <= WNT;
        else begin
            case (PHT[train_history ^ train_pc])
                SNT: PHT[train_history ^ train_pc] <= train_valid ? (train_taken ? WNT : SNT) : SNT;
                WNT: PHT[train_history ^ train_pc] <= train_valid ? (train_taken ? WT : SNT) : WNT;
                WT:  PHT[train_history ^ train_pc] <= train_valid ? (train_taken ? ST : WNT) : WT;
                ST:  PHT[train_history ^ train_pc] <= train_valid ? (train_taken ? ST : WT) : ST;
            endcase
        end
    end
    
    assign predict_taken = PHT[predict_history ^ predict_pc][1];
endmodule