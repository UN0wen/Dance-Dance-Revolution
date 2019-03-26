module top(
    // Buttons on board
    input wire clk,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire rst,         // reset button
    
    // Inputs for keypad 
    inout [7:0] JA,
    
    // Seven segment display outputs
    output wire [7:0] seg,
    output wire [3:0] an,
    
    // VGA Outputs
    output wire Hsync,       // horizontal sync output
    output wire Vsync,       // vertical sync output
    output wire [7:0] VGA, // 8 bit VGA output, first 3 bits are red, next 3 bits are green, last 2 are blue
    
    // LED output
    output [3:0] Led,
    
    // Sound output
    output wire buzzer 
    );
    
    wire [15:0] BCD; 
    wire [15:0] score;
    wire [15:0] out_score;
    wire [7:0] noteAction;
    wire [7:0] noteSuccessState;
    wire [1:0] level;
    
    // Outputs for keypad
    wire [3:0] keyValue;
    wire keyPressed;
    
    reg [7:0] color_out; // Color to put out
    wire animate;
    
    // Instantiate the module
    clock_divider clock_divider (
    .rst(rst), 
    .clk(clk), 
    .pixelClk(pixelClk), 
    .displayClk(displayClk)
    );

    vga_controller vga_controller(
    // Clocks and button on board
    .clk(clk),           // board clock: 100 MHz on Arty/Basys3/Nexys
    .rst(rst),         // reset button
    .pixelClk(pixelClk),

    // Keypad inputs
    .keyValue(keyValue),
    .keyPressed(keyPressed),
    
    // VGA Outputs
    .Hsync(Hsync),       // horizontal sync output
    .Vsync(Vsync),       // vertical sync output
    .VGA(VGA), // 8 bit VGA output, first 3 bits are red, next 3 bits are green, last 2 are blue
    
    // Note outputs
    .noteAction(noteAction),
    .noteSuccessState(noteSuccessState),
    
    .mode(mode),
    .level(level)
    );
    
    seven_segment_display seven_segment_display (
    .rst(rst), 
    .displayClk(displayClk), 
    .BCD(BCD), 
    .seg(seg), 
    .an(an)
    );
    
    //Sound player
     sound_player sound_player (
    .noteAction(noteAction), 
    .noteSuccessState(noteSuccessState), 
    .clk(clk), 
    .rst(rst),
    .buzzer_sound(buzzer)
    );
    
    keypad keypad (
    .clk(clk), 
    .Rows(JA[7:4]), 
    .Cols(JA[3:0]), 
    .keyValue(keyValue),
    .keyPressed(keyPressed)
    );
    
     BinaryToBCD binaryToBCD (
     .binary(out_score), 
     .BCD(BCD)
     );
     
     score_keeping score_keeping (
        .clk(clk),
		  .rst(mode),
        .noteAction(noteAction), 
        .noteSuccessState(noteSuccessState), 
        .score(score), 
        .multiplier(multiplier)
    );
    
    high_score high_score (
        .clk(clk), 
        .mode(mode), 
        .level(level), 
        .in_score(score), 
        .out_score(out_score)
    );
    assign Led = noteAction;
endmodule