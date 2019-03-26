`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:24:52 02/28/2019 
// Design Name: 
// Module Name:    BinaryToBCD 
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

// Algorithm: https://pubweb.eng.utah.edu/~nmcdonal/Tutorials/BCDTutorial/BCDConversion.html
module BinaryToBCD(
    input [15:0] binary,
    output reg [15:0] BCD
    );

    
    reg [4:0] i;
   
    always @ (binary)
    begin
        BCD = 16'b0;
        for (i = 0; i < 16; i = i + 1)
        begin
            BCD = {BCD[14:0], binary[15-i]}; // Shift right

            // Ones
            if (i < 15 && BCD[3:0] >= 5)
                BCD[3:0] = BCD[3:0] + 3;

            // Tens
            if (i < 15 && BCD[7:4] >= 5)
                BCD[7:4] = BCD[7:4] + 3;
            
            // For 4 digits
            if (i < 15 && BCD[11:8] >= 5)
                BCD[11:8] = BCD[11:8] + 3;
            
            if (i < 15 && BCD[15:12] >= 5)
                BCD[15:12] = BCD[15:12] + 3;
        end
    end

endmodule
