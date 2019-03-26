`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:20:36 03/14/2019 
// Design Name: 
// Module Name:    difficulty_converter 
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
module difficulty_converter(
    input wire difficulty,
	 input wire clk, 
	 input wire rst,
    output reg [1:0] difficulty_converted
    );

always @ (posedge clk)
begin
	if (rst)
	begin
		difficulty_converted <= 2;
	end
	else
	begin
		case (difficulty)
			1'b0 : difficulty_converted <= 2'b11;
			1'b1 : difficulty_converted <= 2'b01;
			default: difficulty_converted <= 2'b11;
		endcase
	end
end

endmodule
