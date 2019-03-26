`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:46:44 02/28/2019 
// Design Name: 
// Module Name:    keypad 
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
module keypad(
    input clk,
    input [3:0] Rows,
    output reg [3:0] Cols,
    output reg [3:0] keyValue,
    output reg keyPressed
    );
    
    reg [19:0] selectClk;
    localparam one_ms = 100000;
    
    always @ (posedge clk)
    begin
    // Choose first column
        if (selectClk == 20'b00011000011010100000)
        begin
            Cols <= 4'b0111;
            selectClk <= selectClk + 1;
        end
        
        // Start decoding first column
        else if (selectClk == 20'b00011000011010101000)
        begin
            case(Rows)
            4'b0111: keyValue <= 4'b0001;
            4'b1011: keyValue <= 4'b0100;
            4'b1101: keyValue <= 4'b0111;
            4'b1110: keyValue <= 4'b0000;
            endcase

            if (Rows !== 4'b1111) keyPressed <= 1;
            else keyPressed <= 0;
            selectClk <= selectClk + 1;  
        end
        
    // Choose second column
        else if (selectClk ==  20'b00110000110101000000)
        begin
            Cols <= 4'b1011;
            selectClk <= selectClk + 1;
        end
        // Start decoding second column
        else if (selectClk ==  20'b00110000110101001000)
        begin
            case(Rows)
            4'b0111: keyValue <= 4'b0010;
            4'b1011: keyValue <= 4'b0101;
            4'b1101: keyValue <= 4'b1000;
            4'b1110: keyValue <= 4'b1111;
            endcase

            if (Rows !== 4'b1111) keyPressed <= 1;
            else keyPressed <= 0;
            selectClk <= selectClk + 1;  
        end
    
    // Choose third column
        else if (selectClk == 20'b01001001001111100000)
        begin
            Cols <= 4'b1101;
            selectClk <= selectClk + 1;
        end
        // Start decoding third column
        else if (selectClk == 20'b01001001001111101000)
        begin
            case(Rows)
            4'b0111: keyValue <= 4'b0011;
            4'b1011: keyValue <= 4'b0110;
            4'b1101: keyValue <= 4'b1001;
            4'b1110: keyValue <= 4'b1110;
            endcase

            if (Rows !== 4'b1111) keyPressed <= 1;
            else keyPressed <= 0;
            selectClk <= selectClk + 1;  
        end
        
    // Choose fourth column
        else if (selectClk == 20'b01100001101010000000)
        begin
            Cols <= 4'b1110;
            selectClk <= selectClk + 1;
        end
        // Start decoding fourth column
        else if (selectClk == 20'b01100001101010001000)
        begin
            case(Rows)
            4'b0111: keyValue <= 4'b1010;
            4'b1011: keyValue <= 4'b1011;
            4'b1101: keyValue <= 4'b1100;
            4'b1110: keyValue <= 4'b1101;
            endcase

            if (Rows !== 4'b1111) keyPressed <= 1;
            else keyPressed <= 0;
            selectClk <= 0;  
        end
        
        else selectClk <= selectClk + 1;  
    end
endmodule
