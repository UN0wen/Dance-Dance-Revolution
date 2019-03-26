`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:17:19 02/07/2019 
// Design Name: 
// Module Name:    clock 
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
module clock_divider(
    input rst,
    input clk,
    output reg pixelClk, // Pixel clock for VGA
    output reg displayClk // Display clock for seven segment display
    );
    
    reg [1:0] pixel_counter;
    wire [2:0] pixel_counter_inc;
    reg [16:0] display_counter;
    wire [17:0] display_counter_inc;
    
    assign pixel_counter_inc = pixel_counter + 1;
    assign display_counter_inc = display_counter + 1;

    always @(posedge clk)
    begin
        if (rst)
        begin
            displayClk <= 1'b0;
            display_counter  <= 0;

            pixelClk <= 1'b0;
            pixel_counter <= 1'b0;
        end
        else
        begin
           display_counter <= display_counter_inc[16:0];
           displayClk <= display_counter_inc[17];

           pixelClk <= pixel_counter_inc[2];
           pixel_counter <= pixel_counter_inc[1:0];
        end
    end
  
endmodule
