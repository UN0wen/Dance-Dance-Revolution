`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:29:49 03/08/2019 
// Design Name: 
// Module Name:    sound_player 
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
module sound_player(
    input [7:0] noteAction,
    input [7:0] noteSuccessState,
    input clk,
    input rst,
    output buzzer_sound
    );

    reg [7:0] sound;
    
    buzzer_driver buzzer_driver (
        .clk(clk), 
        .rst(rst), 
        .sound(sound), 
        .buzzer(buzzer_sound)
    );
    
    always @ (posedge clk)
    begin
        if (rst)
        begin
            sound <= 0;
        end
        else if (noteAction !== 8'b0)
            sound <= noteSuccessState;
        else
            sound <= 0;
    end
endmodule
