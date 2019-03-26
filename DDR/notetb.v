`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:28:40 03/07/2019
// Design Name:   note
// Module Name:   C:/Users/152/Desktop/Proj4/notetb.v
// Project Name:  Proj4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: note
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module notetb;

	// Inputs
	reg clk;
	reg animate;
	reg note_rst;
	reg [1:0] slowFactor;
	reg [3:0] keyValue;
	reg keyPressed;
	reg [3:0] initial_loc;
	reg [9:0] x;
	reg [9:0] y;

	// Outputs
	wire noteAction;
	wire noteSuccessState;
	wire is_note;

	// Instantiate the Unit Under Test (UUT)
	note uut (
		.clk(clk), 
		.animate(animate), 
		.note_rst(note_rst), 
		.slowFactor(slowFactor), 
		.keyValue(keyValue), 
		.keyPressed(keyPressed), 
		.initial_loc(initial_loc), 
		.x(x), 
		.y(y), 
		.noteAction(noteAction), 
		.noteSuccessState(noteSuccessState), 
		.is_note(is_note)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		animate = 0;
		note_rst = 0;
		slowFactor = 2;
		keyValue = 0;
		keyPressed = 0;
		initial_loc = 4'b0001;
		x = 0;
		y = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
    
    always #100 animate = ~animate;
    
      
endmodule

