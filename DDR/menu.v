`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:52:48 03/13/2019 
// Design Name: 
// Module Name:    menu 
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
module menu(
	input [1:0] level,
	input diff,
	input clk,
	input rst,
	input [9:0] x,
	input [9:0] y,
	input animate,
	output is_menu 
);
	
	parameter LEVEL_START_Y = 10'd100;
	parameter CHAR_WIDTH = 10'd16;
	parameter DIFF_START_Y = 10'd200;
	parameter START_X  = 10'd60;
	
	// L E V E L
	wire firstL_pos, secondL_pos, firstE_pos, secondE_pos, firstV_pos, levelColon_pos, level_number_pos;
	
	wire firstD_pos, firstI_pos, firstF_pos, secondF_pos, diff_number_pos;
	
	// y location of each char
	wire [9:0] char2_pos;
	wire [9:0] char3_pos;
	wire [9:0] char4_pos;
   wire [9:0]	char5_pos;
	wire [9:0] colon_pos;
   wire [9:0]	number_pos;
	
	assign char2_pos = START_X + CHAR_WIDTH * 5;
	assign char3_pos = START_X + CHAR_WIDTH * 10;
	assign char4_pos = START_X + CHAR_WIDTH * 15;
	assign char5_pos = START_X + CHAR_WIDTH * 20;
	assign colon_pos = START_X + CHAR_WIDTH * 25;
	assign number_pos = START_X + CHAR_WIDTH * 30;
	
	// LEVEL LINE
	letters firstL (
    .letter(3'b000), 
    .x(x), 
    .y(y), 
    .x_pos(START_X), 
    .y_pos(LEVEL_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(firstL_pos)
    );
	 
	 letters firstE (
    .letter(3'b001), 
    .x(x), 
    .y(y), 
    .x_pos(char2_pos), 
    .y_pos(LEVEL_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(firstE_pos)
    );
	 
	 letters firstV (
    .letter(3'b010), 
    .x(x), 
    .y(y), 
    .x_pos(char3_pos), 
    .y_pos(LEVEL_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(firstV_pos)
    );
	 
	 letters secondE (
    .letter(3'b001), 
    .x(x), 
    .y(y), 
    .x_pos(char4_pos), 
    .y_pos(LEVEL_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(secondE_pos)
    );
	 
	 letters secondL (
    .letter(3'b000), 
    .x(x), 
    .y(y), 
    .x_pos(char5_pos), 
    .y_pos(LEVEL_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(secondL_pos)
    );
	
	letters level_colon (
    .letter(3'b110), 
    .x(x), 
    .y(y), 
    .x_pos(colon_pos), 
    .y_pos(LEVEL_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(levelColon_pos)
    );
	 
	 number level_number (
    .num(level), 
    .x(x), 
    .y(y), 
    .x_pos(number_pos), 
    .y_pos(LEVEL_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(level_number_pos)
    );
	 
	 // DIFF LINE
	 letters firstD (
    .letter(3'b011), 
    .x(x), 
    .y(y), 
    .x_pos(START_X), 
    .y_pos(DIFF_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(firstD_pos)
    );
	 
	 letters firstI (
    .letter(3'b100), 
    .x(x), 
    .y(y), 
    .x_pos(char2_pos), 
    .y_pos(DIFF_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(firstI_pos)
    );
	 
	 letters firstF (
    .letter(3'b101), 
    .x(x), 
    .y(y), 
    .x_pos(char3_pos), 
    .y_pos(DIFF_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(firstF_pos)
    );
	 
	 letters secondF (
    .letter(3'b101), 
    .x(x), 
    .y(y), 
    .x_pos(char4_pos), 
    .y_pos(DIFF_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(secondF_pos)
    );
	 
	
	letters diff_colon (
    .letter(3'b110), 
    .x(x), 
    .y(y), 
    .x_pos(char5_pos), 
    .y_pos(DIFF_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(diffColon_pos)
    );
	 
	 number diff_number (
    .num(diff), 
    .x(x), 
    .y(y), 
    .x_pos(number_pos), 
    .y_pos(DIFF_START_Y), 
    .box_width(CHAR_WIDTH), 
    .box_height(CHAR_WIDTH), 
    .out(diff_number_pos)
    );
	 
	 wire is_level, is_diff;
	 assign is_level = firstL_pos||firstE_pos||firstV_pos||secondE_pos||secondL_pos||levelColon_pos||level_number_pos;
	 assign is_diff = firstD_pos||firstI_pos||firstF_pos||secondF_pos||diffColon_pos||diff_number_pos;
	 
	 assign is_menu = is_level||is_diff;

endmodule
