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
module level_rom2(
    input [(ADDR_WIDTH-1):0] addr,
    input clk,
	 input rst,
    output reg [(DATA_WIDTH-1):0] note
    );
    
    parameter ADDR_WIDTH = 6;
    parameter DATA_WIDTH = 4;
    
    reg [3:0] level2 [48:0];

    initial
    begin
         level2[0] = 4'b1000;
			level2[1] = 4'b0010;
			level2[2] = 4'b0010;
			level2[3] = 4'b0100;
			level2[4] = 4'b1000;
			level2[5] = 4'b0100;
			level2[6] = 4'b1000;
			level2[7] = 4'b0100;
			level2[8] = 4'b1000;
			level2[9] = 4'b0001;
			level2[10] = 4'b0010;
			level2[11] = 4'b0100;
			level2[12] = 4'b1000;
			level2[13] = 4'b0010;
			level2[14] = 4'b1000;
			level2[15] = 4'b0100;
			level2[16] = 4'b0010;
			level2[17] = 4'b0010;
			level2[18] = 4'b0010;
			level2[19] = 4'b0010;
			level2[20] = 4'b0010;
			level2[21] = 4'b0100;
			level2[22] = 4'b0100;
			level2[23] = 4'b0010;
			level2[24] = 4'b0001;
			level2[25] = 4'b1000;
			level2[26] = 4'b0010;
			level2[27] = 4'b0100;
			level2[28] = 4'b0010;
			level2[29] = 4'b1000;
			level2[30] = 4'b0100;
			level2[31] = 4'b0001;
			level2[32] = 4'b0001;
			level2[33] = 4'b0001;
			level2[34] = 4'b0001;
			level2[35] = 4'b0010;
			level2[36] = 4'b0100;
			level2[37] = 4'b1000;
			level2[38] = 4'b0010;
			level2[39] = 4'b1000;
			level2[40] = 4'b0100;
			level2[41] = 4'b0010;
			level2[42] = 4'b0010;
			level2[43] = 4'b0001;
			level2[44] = 4'b1000;
			level2[45] = 4'b0100;
			level2[46] = 4'b0100;
			level2[47] = 4'b0100;
			level2[48] = 4'b1111;
    end
    
    always @ (posedge clk)
    begin
		if (rst)
			note <= 4'b1111;
		else
			note <= level2[addr];
    end
endmodule
