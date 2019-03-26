`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:10:44 03/14/2019 
// Design Name: 
// Module Name:    color_change 
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
module color_change(
    input clk,
    input rst,
    input btnCHGCOLOR,
    input mode,
    input keyPressed,
    output reg [7:0] VGA_NOTE,
    output reg [7:0] VGA_PLAYER,
    output reg [7:0] VGA_MENU
    );
    
    reg [1:0] color_opt;
    initial 
    begin
        color_opt = 0;
    end
    always @ (posedge clk)
    begin
        if (rst)
        begin
             VGA_PLAYER <= 8'b11100000;
             VGA_NOTE <= 8'b00000011;
             VGA_MENU <= 8'b11111111;
        end
        else if (keyPressed && mode && btnCHGCOLOR)
        begin
            color_opt <= color_opt + 1;
        end
        else
        begin
            if (color_opt == 2'b00)
            begin
             VGA_PLAYER <= 8'b11100000;
             VGA_NOTE <= 8'b00000011;
             VGA_MENU <= 8'b11111111;
            end
            else if (color_opt == 2'b01)
            begin
             VGA_PLAYER <= 8'b01010101;
             VGA_NOTE <= 8'b01111010;
             VGA_MENU <= 8'b10101010;
            end
            else if (color_opt == 2'b10)
            begin
             VGA_PLAYER <= 8'b00011111;
             VGA_NOTE <= 8'b11100011;
             VGA_MENU <= 8'b11100011;
            end
            else if (color_opt == 2'b11)
            begin
             VGA_PLAYER <= 8'b00011111;
             VGA_NOTE <= 8'b11100011;
             VGA_MENU <= 8'b00011111;
             end
         end
    end

endmodule
