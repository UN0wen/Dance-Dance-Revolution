`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:00:11 03/07/2019
// Design Name:   score_keeping
// Module Name:   C:/Users/152/Desktop/Proj4/score_keeping_tb.v
// Project Name:  Proj4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: score_keeping
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module score_keeping_tb;

	// Inputs
	reg clk;
	reg [3:0] noteAction;
	reg [3:0] noteSuccessState;

	// Outputs
	wire [15:0] score;
	wire [6:0] multiplier;

	// Instantiate the Unit Under Test (UUT)
	score_keeping uut (
		.clk(clk), 
		.noteAction(noteAction), 
		.noteSuccessState(noteSuccessState), 
		.score(score), 
		.multiplier(multiplier)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		noteAction = 0;
		noteSuccessState = 0;

		// Wait 100 ns for global reset to finish
		#100;
        noteAction = 4'b0001;
        noteSuccessState = 4'b0001;
        
        #10;
        noteAction = 4'b0000;
        
        #100;
        noteAction = 4'b1000;
        
        #10;
        noteAction = 4'b0000;
		// Add stimulus here

	end
    
    always #5 clk = ~clk;
endmodule

