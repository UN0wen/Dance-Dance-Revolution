// Ref : http://www.webdiaz.com/fpga%20number.html
module letters(
input  [2:0] letter, // L E V D I F : 7 in total
input  [9:0] x,
input [9:0] y,
//positioning offset
input [9:0] x_pos,
input [9:0] y_pos,
input [9:0] box_width,
input [9:0] box_height,
output out
);

reg blockout;
wire blockC1,blockC2,blockC3,blockC4,blockC5;
wire blockB1,blockB2,blockB3,blockB4,blockB5;
wire blockA1,blockA2,blockA3,blockA4,blockA5;
wire allblocks;

wire [10:0] column1,column2,column3;
wire [10:0] row1,row2,row3,row4,row5;

assign   column1 = x_pos+box_width+1;
assign	column2 = x_pos+box_width+box_width+1;
assign	column3 = x_pos+box_width+box_width+box_width+1;

assign	row1 = y_pos+box_height+1;
assign	row2 = y_pos+box_height+box_height+1;
assign	row3 = y_pos+box_height+box_height+box_height+1;
assign	row4 = y_pos+box_height+box_height+box_height+box_height+1;
assign	row5 = y_pos+box_height+box_height+box_height+box_height+box_height+1;




assign out = blockout;

//the blocks

//first column
assign blockA1 = (x>x_pos)&&(x <= column1)&&(y>y_pos)&&(y<= row1);
assign blockA2 = (x>x_pos)&&(x <= column1)&&(y>row1)&&(y<= row2);
assign blockA3 = (x>x_pos)&&(x <= column1)&&(y>row2)&&(y<= row3);
assign blockA4 = (x>x_pos)&&(x <= column1)&&(y>row3)&&(y<= row4);
assign blockA5 = (x>x_pos)&&(x <= column1)&&(y>row4)&&(y<= row5);

//second column

assign blockB1 = (x>column1)&&(x<= column2)&&(y>y_pos)&&(y<= row1);
assign blockB2 = (x>column1)&&(x<= column2)&&(y>row1)&&(y<= row2);
assign blockB3 = (x>column1)&&(x<= column2)&&(y>row2)&&(y<= row3);
assign blockB4 = (x>column1)&&(x<= column2)&&(y>row3)&&(y<= row4);
assign blockB5 = (x>column1)&&(x<= column2)&&(y>row4)&&(y<= row5);

//third column

assign blockC1 = (x>column2)&&(x <= column3)&&(y>y_pos)&&(y <= row1);
assign blockC2 = (x>column2)&&(x <= column3)&&(y>row1)&&(y <= row2);
assign blockC3 = (x>column2)&&(x <= column3)&&(y>row2)&&(y <= row3);
assign blockC4 = (x>column2)&&(x <= column3)&&(y>row3)&&(y <= row4);
assign blockC5 = (x>column2)&&(x <= column3)&&(y>row4)&&(y <= row5);
assign allblocks = (x > x_pos)&&(x <= column3)&&(y>y_pos)&&(y <= row5);

always @ (*)
begin
	case (letter)
		// X   XXX X X XX  XXX XXX  
		// X   X   X X X X  X  X    X
		// X   XXX X X X X  X  XX   
		// X   X   X X X X  X  X    X
		// XXX XXX  X  XX  XXX X
		// L
		0:blockout = blockA1||blockA2||blockA3||blockA4||blockA5||blockB5||blockC5;
		// E
		1:blockout = allblocks&&(~(blockB2||blockB4||blockC2||blockC4));
		// V
		2:blockout = allblocks&&(~(blockB1||blockB2||blockB3||blockB4||blockC5||blockA5));
		// D
		3:blockout = allblocks&&(~(blockB2||blockB3||blockB4||blockC1||blockC5));
		// I
		4:blockout = allblocks&&(~(blockA2||blockA3||blockA4||blockC2||blockC3||blockC4));
		// F
		5:blockout = blockA1||blockA2||blockA3||blockA4||blockA5||blockB1||blockC1||blockB3;
		// colon
		6:blockout = blockB2||blockB4;
		default: blockout = 0;
	endcase
end
endmodule