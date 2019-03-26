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
module level_rom3(
    input [(ADDR_WIDTH-1):0] addr,
    input clk,
	 input rst,
    output reg [(DATA_WIDTH-1):0] note
    );
    
    parameter ADDR_WIDTH = 6;
    parameter DATA_WIDTH = 4;
    
    reg [3:0] level3 [48:0];

    initial
    begin
         level3[0] = 4'b0100;
			level3[1] = 4'b1000;
			level3[2] = 4'b0001;
			level3[3] = 4'b0001;
			level3[4] = 4'b0100;
			level3[5] = 4'b1000;
			level3[6] = 4'b0010;
			level3[7] = 4'b0001;
			level3[8] = 4'b1000;
			level3[9] = 4'b0001;
			level3[10] = 4'b1000;
			level3[11] = 4'b0010;
			level3[12] = 4'b0100;
			level3[13] = 4'b1000;
			level3[14] = 4'b1000;
			level3[15] = 4'b1000;
			level3[16] = 4'b0010;
			level3[17] = 4'b0010;
			level3[18] = 4'b0001;
			level3[19] = 4'b0100;
			level3[20] = 4'b1000;
			level3[21] = 4'b0001;
			level3[22] = 4'b0100;
			level3[23] = 4'b0010;
			level3[24] = 4'b1000;
			level3[25] = 4'b0100;
			level3[26] = 4'b0100;
			level3[27] = 4'b0010;
			level3[28] = 4'b0100;
			level3[29] = 4'b0010;
			level3[30] = 4'b1000;
			level3[31] = 4'b0001;
			level3[32] = 4'b0100;
			level3[33] = 4'b0010;
			level3[34] = 4'b0010;
			level3[35] = 4'b0001;
			level3[36] = 4'b0010;
			level3[37] = 4'b0001;
			level3[38] = 4'b0010;
			level3[39] = 4'b0010;
			level3[40] = 4'b0100;
			level3[41] = 4'b1000;
			level3[42] = 4'b1000;
			level3[43] = 4'b0001;
			level3[44] = 4'b0001;
			level3[45] = 4'b0001;
			level3[46] = 4'b0010;
			level3[47] = 4'b1000;
			level3[48] = 4'b1111;
	 end
    
    always @ (posedge clk)
    begin
		if (rst)
			note <= 4'b1111;
		else
			note <= level3[addr];
    end
endmodule
