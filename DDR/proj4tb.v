`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:25:06 03/05/2019
// Design Name:   top
// Module Name:   C:/Users/152/Desktop/Proj4/proj4tb.v
// Project Name:  Proj4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module proj4tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [7:0] seg;
	wire [3:0] an;
	wire Hsync;
	wire Vsync;
	wire [7:0] VGA;

	// Bidirs
	wire [7:0] JA;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.rst(rst), 
		.JA(JA), 
		.seg(seg), 
		.an(an), 
		.Hsync(Hsync), 
		.Vsync(Vsync), 
		.VGA(VGA)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
        rst = 0;
		// Add stimulus here

	end
      
    always #5 clk = ~clk;
endmodule

