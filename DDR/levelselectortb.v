`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:30:50 03/12/2019
// Design Name:   level_selector
// Module Name:   /home/ise/ISE_shared_folder/3-8-2019/3-7-19/Proj4/levelselectortb.v
// Project Name:  Proj4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: level_selector
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module levelselectortb;

	// Inputs
	reg [5:0] addr;
	reg [1:0] level_num;
	reg clk;
	reg rst;
	// Outputs
	wire [3:0] note;

	// Instantiate the Unit Under Test (UUT)
	level_selector uut (
		.addr(addr), 
		.level_num(level_num), 
		.clk(clk), 
		.rst(rst),
		.note(note)
	); 

	initial begin
		// Initialize Inputs
		addr = 0;
		level_num = 1;
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 0;
		// Add stimulus here

	end
   
	always @ (posedge clk)
	begin
	 	if (rst)
			addr <= 0;
		else if (note == 4'b1111)
			addr <= 0;
		else
			addr <= addr + 1;
	end
	
	always #5 clk = ~clk;
endmodule

