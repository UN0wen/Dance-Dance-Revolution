`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:49:54 03/09/2019
// Design Name:   vga_controller
// Module Name:   /home/ise/Desktop/3-7-19/Proj4/vgatb.v
// Project Name:  Proj4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vgatb;

	// Inputs
	reg clk;
	reg rst;
	reg pixelClk;
	reg [3:0] keyValue;
	reg keyPressed;

	// Outputs
	wire Hsync;
	wire Vsync;
	wire [7:0] VGA;
	wire [3:0] noteAction;
	wire [3:0] noteSuccessState;

	// Instantiate the Unit Under Test (UUT)
	vga_controller uut (
		.clk(clk), 
		.rst(rst), 
		.pixelClk(pixelClk), 
		.keyValue(keyValue), 
		.keyPressed(keyPressed), 
		.Hsync(Hsync), 
		.Vsync(Vsync), 
		.VGA(VGA), 
		.noteAction(noteAction), 
		.noteSuccessState(noteSuccessState)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		pixelClk = 0;
		keyValue = 0;
		keyPressed = 0;

		// Wait 100 ns for global reset to finish
		#1000;
      rst = 0;  
		// Add stimulus here

	end
	
	always #1 clk = ~clk;
	always #4 pixelClk = ~pixelClk;
      
endmodule

