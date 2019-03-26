`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:42:28 03/12/2019
// Design Name:   note_spawner
// Module Name:   C:/Users/152/Desktop/Proj4/note_spawnertb.v
// Project Name:  Proj4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: note_spawner
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module note_spawnertb;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] noteAction;
	reg [1:0] level_num;
	reg animate;

	// Outputs
	wire [15:0] locations;
	wire [3:0] note_spawn;

	// Instantiate the Unit Under Test (UUT)
	note_spawner uut (
		.clk(clk), 
		.rst(rst), 
		.noteAction(noteAction), 
		.level_num(level_num), 
		.animate(animate), 
		.locations(locations), 
		.note_spawn(note_spawn)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		noteAction = 0;
		level_num = 1;
		animate = 0;

		// Wait 100 ns for global reset to finish
		#100;
        rst = 0;
		
		#100000;
		noteAction = 4'b0001;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0010;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0100;
		#10; 
		noteAction = 0;
		#1000;
		noteAction = 4'b1000;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0001;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0010;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0100;
		#10; 
		noteAction = 0;
		#1000;
		noteAction = 4'b1000;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0001;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0010;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0100;
		#10; 
		noteAction = 0;
		#1000;
		noteAction = 4'b1000;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0001;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0010;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0100;
		#10; 
		noteAction = 0;
		#1000;
		noteAction = 4'b1000;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0001;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0010;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0100;
		#10; 
		noteAction = 0;
		#1000;
		noteAction = 4'b1000;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0001;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0010;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0100;
		#10; 
		noteAction = 0;
		#1000;
		noteAction = 4'b1000;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0001;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0010;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0100;
		#10; 
		noteAction = 0;
		#1000;
		noteAction = 4'b1000;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0001;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0010;
		#10;
		noteAction = 0;
		#1000;
		noteAction = 4'b0100;
		#10; 
		noteAction = 0;
		#1000;
		noteAction = 4'b1000;
		#10;
		noteAction = 0;
		// Add stimulus here
    
	end
    
    always #5 clk = ~clk;
    always #20 animate = ~animate;
endmodule

