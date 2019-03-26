`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:46:53 03/08/2019
// Design Name:   sound_player
// Module Name:   C:/Users/152/Desktop/3-7-19/Proj4/soundtb.v
// Project Name:  Proj4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sound_player
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module soundtb;

	// Inputs
	reg [3:0] noteAction;
	reg [3:0] noteSuccessState;
	reg clk;
    reg rst;
	// Outputs
	wire buzzer_sound;

	// Instantiate the Unit Under Test (UUT)
	sound_player uut (
		.noteAction(noteAction), 
		.noteSuccessState(noteSuccessState), 
		.clk(clk),
        .rst(rst),
		.buzzer_sound(buzzer_sound)
	);

	initial begin
		// Initialize Inputs
		noteAction = 0;
		noteSuccessState = 0;
		clk = 0;
        rst = 1;
        
        #5;
        rst = 0;
		// Wait 100 ns for global reset to finish
		#100;
        noteAction = 4'b1000;
        noteSuccessState = 4'b1000;
        
        #5;
        noteAction = 4'b0000;
		  
		  #1215752;
		  noteAction = 4'b0001;
		  noteSuccessState = 4'b0001;
		  #5;
		  noteAction = 4'b0000;
		// Add stimulus here

	end
    
    always #5 clk = ~clk;
endmodule

