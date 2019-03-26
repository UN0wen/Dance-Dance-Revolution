`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:52:44 03/14/2019 
// Design Name: 
// Module Name:    high_score 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module high_score(
    input clk,
    input mode,
    input [1:0] level, 
    input [15:0] in_score,
    output [15:0] out_score
    );

    reg [15:0] hi_score_lv1;
    reg [15:0] hi_score_lv2;
    reg [15:0] hi_score_lv3;
    reg [15:0] out_score_reg;
    initial
    begin
        hi_score_lv1 = 0;
        hi_score_lv2 = 0;
        hi_score_lv3 = 0;
        out_score_reg = 0;
    end
    always @ (posedge clk)
    begin
        if (mode)
        begin
            case (level)
            2'b01: out_score_reg <= hi_score_lv1;
            2'b10: out_score_reg <= hi_score_lv2;
            2'b11: out_score_reg <= hi_score_lv3;
            default: out_score_reg <= 0;
            endcase
        end
        else
        begin
            if (level == 2'b01)
            begin
                if (in_score > hi_score_lv1)
                    hi_score_lv1 <= in_score;
            end
            
            if (level == 2'b10)
            begin
                if (in_score > hi_score_lv2)
                    hi_score_lv2 <= in_score;
            end
            
            if (level == 2'b11)
            begin
                if (in_score > hi_score_lv3)
                    hi_score_lv3 <= in_score;
            end
            
            out_score_reg <= in_score;
        end
    end
    
    assign out_score = out_score_reg;
endmodule
