`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:52:32 03/13/2019 
// Design Name: 
// Module Name:    button_controller 
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
module button_controller(
	input clk, 
	input rst,
	input keyPressed,
	input btnLV1,
	input btnLV2, 
	input btnLV3,
	input btnCHGDIFF,
	input btnMID,
	output mode,
	output [1:0] level,
	output difficulty
    );
	 
	reg mode_reg, difficulty_reg;
	reg [1:0] level_reg;
	
	parameter DELAY_DIV = 50000000;
	reg [25:0] menu_delay;
    reg [25:0] diff_delay;
    
	initial
	begin
		level_reg = 2'b01;
        mode_reg = 1'b1;
	end
	
	always @ (posedge clk)
	begin
		if (rst)
		begin
			mode_reg <= 0;
			level_reg <= 2'b01;
			difficulty_reg <= 0;
		end
		
		else if (keyPressed)
		begin
			if (mode_reg == 1)
			begin
				if (btnLV1)
					level_reg <= 1;
				else if (btnLV2)
					level_reg <= 2;
				else if (btnLV3)
					level_reg <= 3;
				else if (btnMID)
					begin
						if (menu_delay == 0)
						begin
							mode_reg <= 0;
							menu_delay <= DELAY_DIV;
						end
					end
				else if (btnCHGDIFF)
                        if (diff_delay == 0)
						begin
                            difficulty_reg <= ~difficulty_reg;
							diff_delay <= DELAY_DIV;
						end
			end
			else
			begin
				if (btnMID)
				begin
					if (menu_delay == 0)
					begin
						mode_reg <= 1;
						menu_delay <= DELAY_DIV;
					end
				end
			end
		end
		else
        begin        
            if (menu_delay > 0)
                menu_delay <= menu_delay - 1;
            if (diff_delay > 0)
                diff_delay <= diff_delay - 1;
        end
	end
	
	assign level = level_reg;
	assign difficulty = difficulty_reg;
	assign mode = mode_reg;
endmodule
