`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:14:32 03/05/2019 
// Design Name: 
// Module Name:    keypad_decoder 
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
module keypad_decoder(
    input clk,
    input [3:0] keyValue,
    input keyPressed,
    output reg btnMID, // Middle button to pause
    output reg btnR, // left right up down 
    output reg btnL,
    output reg btnU,
    output reg btnD,
	 output reg btnLV1, // A B C D respectively
	 output reg btnLV2,
	 output reg btnLV3,
	 output reg btnCHGDIFF,
     output reg btnCHGCOLOR
    );
    
    // reg [3:0] button_sync_1, button_sync_0;
    // wire button_sync_1_bar;
    // wire btnIDLE;
    // always @ (posedge clk) button_sync_0 <= binary;

    // always @ (posedge clk) button_sync_1 <= button_sync_0;

    always @ (posedge clk)
    begin
        if (keyPressed)
        begin

        case (keyValue)
            4'd2: btnU <= 1;
            4'd4: btnL <= 1;
            4'd5: btnMID <= 1;
            4'd6: btnR <= 1;
            4'd8: btnD <= 1;
            4'd10: btnLV1 <= 1;
            4'd11: btnLV2 <= 1;
            4'd12: btnLV3 <= 1;
            4'd13: btnCHGDIFF <= 1;
            4'd14: btnCHGCOLOR <= 1;
            default: btnMID <= 0;
        endcase
        end

        else
        begin
            btnU <= 0;
            btnL <= 0;
            btnMID <= 0;
            btnR <= 0;
            btnD <= 0;
            btnLV1 <= 0;
            btnLV2 <= 0;
            btnLV3 <= 0;
            btnCHGDIFF <= 0;
            btnCHGCOLOR <= 0;
        end
    end

endmodule
