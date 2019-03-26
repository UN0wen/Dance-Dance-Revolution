`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:24:25 03/07/2019 
// Design Name: 
// Module Name:    level_rom 
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
module level_selector(
    input [(ADDR_WIDTH-1):0] addr,
    input [1:0] level_num, 
    input clk,
	 input rst,
    output reg [(DATA_WIDTH-1):0] note
    );
    
    parameter ADDR_WIDTH = 6;
    parameter DATA_WIDTH = 4;

    wire [3:0] note_level_1;
    wire [3:0] note_level_2;
    wire [3:0] note_level_3;

    level_rom1 level1 (
        .addr(addr),
        .clk(clk),
		  .rst(rst),
        .note(note_level_1)
    );

    level_rom2 level2 (
        .addr(addr),
        .clk(clk),
		  .rst(rst),
        .note(note_level_2)
    );

    level_rom3 level3 (
        .addr(addr),
        .clk(clk),
		  .rst(rst),
        .note(note_level_3)
    );

    
    always @ (posedge clk)
    begin
		if (rst)
			note <= 0;
		else
		begin
        case (level_num)
            2'b01: note <= note_level_1;
            2'b10: note <= note_level_2;
            2'b11: note <= note_level_3;
            default: note <= note_level_1;
        endcase
		end
    end
    
endmodule
