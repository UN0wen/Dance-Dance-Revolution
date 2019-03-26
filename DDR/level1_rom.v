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
module level_rom1(
    input [(ADDR_WIDTH-1):0] addr,
    input clk,
	 input rst,
    output reg [(DATA_WIDTH-1):0] note
    );
    
    parameter ADDR_WIDTH = 6;
    parameter DATA_WIDTH = 4;
    
	 reg [49:0] level1 [3:0];
	 
    initial
    begin
	      level1[0] = 4'b0001;
			level1[1] = 4'b0001;
			level1[2] = 4'b1000;
			level1[3] = 4'b0010;
			level1[4] = 4'b1000;
			level1[5] = 4'b0001;
			level1[6] = 4'b0001;
			level1[7] = 4'b0100;
			level1[8] = 4'b0100;
			level1[9] = 4'b0010;
			level1[10] = 4'b0010;
			level1[11] = 4'b0100;
			level1[12] = 4'b1000;
			level1[13] = 4'b0100;
			level1[14] = 4'b1000;
			level1[15] = 4'b1000;
			level1[16] = 4'b0010;
			level1[17] = 4'b0100;
			level1[18] = 4'b0100;
			level1[19] = 4'b0100;
			level1[20] = 4'b0010;
			level1[21] = 4'b1000;
			level1[22] = 4'b0001;
			level1[23] = 4'b0010;
			level1[24] = 4'b0100;
			level1[25] = 4'b0010;
			level1[26] = 4'b0010;
			level1[27] = 4'b0010;
			level1[28] = 4'b0001;
			level1[29] = 4'b0001;
			level1[30] = 4'b0100;
			level1[31] = 4'b0010;
			level1[32] = 4'b0010;
			level1[33] = 4'b1000;
			level1[34] = 4'b0001;
			level1[35] = 4'b0010;
			level1[36] = 4'b0001;
			level1[37] = 4'b0100;
			level1[38] = 4'b1000;
			level1[39] = 4'b0001;
			level1[40] = 4'b1000;
			level1[41] = 4'b0001;
			level1[42] = 4'b1000;
			level1[43] = 4'b0100;
			level1[44] = 4'b0010;
			level1[45] = 4'b0001;
			level1[46] = 4'b0100;
			level1[47] = 4'b0100;
			level1[48] = 4'b1111;
    end
    
    always @ (posedge clk)
    begin
		if (rst)
			note <= 4'b0;
		else
			note <= level1[addr];
    end
endmodule
