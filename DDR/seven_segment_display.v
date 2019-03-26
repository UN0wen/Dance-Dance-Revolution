`timescale 1ns / 1ps
//https://www.fpga4student.com/2017/09/seven-segment-led-display-controller-basys3-fpga.html for 7 seg display
module seven_segment_display(
    input rst,
    input displayClk,
    input [15:0] BCD,
    output reg [7:0] seg,
    output reg [3:0] an
    );
    

reg [1:0] LED_status = 2'b00;
reg [3:0] LED_out;

always @(posedge displayClk)
begin
    if (rst)
    begin
        LED_status <= 2'b00;
        LED_out <= 4'b0000;
        an <= 4'b0000;
    end
    else 
    begin
        case (LED_status)
            2'b00:
            begin
                an <= 4'b0111;
                LED_out <= BCD[15:12];
            end
            2'b01:
            begin
                an <= 4'b1011;
                LED_out <= BCD[11:8];
            end
            2'b10:
            begin
                an <= 4'b1101;
                LED_out <= BCD[7:4];
            end
            2'b11:
            begin
                an <= 4'b1110;
                LED_out <= BCD[3:0];
            end
        endcase
            
        if (LED_status == 2'b11) 
        LED_status <= 2'b00;
        else 
        LED_status <= LED_status + 1;
    end
end

always @ (LED_out)
begin
case(LED_out)
 4'b0000: seg = 8'b11000000; // "0"  
 4'b0001: seg = 8'b11111001; // "1" 
 4'b0010: seg = 8'b10100100; // "2" 
 4'b0011: seg= 8'b10110000; // "3" 
 4'b0100: seg= 8'b10011001; // "4" 
 4'b0101: seg= 8'b10010010; // "5" 
 4'b0110: seg= 8'b10000010; // "6" 
 4'b0111: seg= 8'b11111000; // "7" 
 4'b1000: seg= 8'b10000000; // "8"  
 4'b1001: seg= 8'b10010000; // "9" 
 default: seg = 8'b11111111;
endcase
end
endmodule
