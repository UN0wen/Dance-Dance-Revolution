module vga_controller(
    input wire clk,           // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire rst,         // reset button
    input wire pixelClk,

    input wire [3:0] keyValue,
    input wire keyPressed,

    // VGA Outputs
    output wire Hsync,       // horizontal sync output
    output wire Vsync,       // vertical sync output
    output reg [7:0] VGA, // 8 bit VGA output, first 3 bits are red, next 3 bits are green, last 2 are blue
    output wire [7:0] noteAction,
    output wire [7:0] noteSuccessState,
    output wire mode,
    output wire [1:0] level
    
    );
    
    // parameter slowFactor = 2'd2; // change this to 3 or 4 to make notes slower, can make a new module to handle difficulty
				
    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
    wire [9:0] y;  // current pixel y position:  9-bit value: 0-511

    wire [31:0] initial_loc; // initial location of 8 notes, starting with 7:0 being note1 
    wire [7:0] note_spawn;
	wire [1:0] difficulty_converted;


//    parameter VGA_PLAYER = 8'b11100000;
//    parameter VGA_NOTE = 8'b00000011;
//    parameter VGA_BACKGROUND = 8'b00000000;
//    parameter VGA_MENU = 8'b11111111;
	parameter VGA_BACKGROUND = 8'b00000000;
    wire [7:0] VGA_NOTE;
    wire [7:0] VGA_MENU;
    wire [7:0] VGA_PLAYER;
    color_change color_changer (
    .clk(clk), 
    .rst(rst), 
    .btnCHGCOLOR(btnCHGCOLOR), 
    .mode(mode), 
    .keyPressed(keyPressed),  
    .VGA_NOTE(VGA_NOTE), 
    .VGA_PLAYER(VGA_PLAYER), 
    .VGA_MENU(VGA_MENU)
    );    
    wire draw_note1, draw_note2, draw_note3, draw_note4, draw_note5, draw_note6, draw_note7, draw_note8;

    keypad_decoder keypad_decoder (
		 .clk(clk), 
		 .keyValue(keyValue), 
		 .keyPressed(keyPressed), 
		 .btnMID(btnMID), 
		 .btnR(btnR), 
		 .btnL(btnL), 
		 .btnU(btnU), 
		 .btnD(btnD), 
		 .btnLV1(btnLV1), 
		 .btnLV2(btnLV2), 
		 .btnLV3(btnLV3), 
		 .btnCHGDIFF(btnCHGDIFF),
         .btnCHGCOLOR(btnCHGCOLOR)
    );   
    
	 button_controller button_controller (
		 .clk(clk), 
		 .rst(rst), 
		 .keyPressed(keyPressed), 
		 .btnLV1(btnLV1), 
		 .btnLV2(btnLV2), 
		 .btnLV3(btnLV3), 
		 .btnCHGDIFF(btnCHGDIFF), 
		 .btnMID(btnMID), 
		 .mode(mode), 
		 .level(level), 
		 .difficulty(difficulty)
    );
	 
	 menu menu (
		 .level(level), 
		 .diff(difficulty), 
		 .clk(clk), 
		 .rst(rst), 
		 .x(x), 
		 .y(y), 
		 .animate(animate), 
		 .is_menu(is_menu)
    );
	 
    vga640x480 vga640x480 (
        .clk(clk),
        .pixelClk(pixelClk),
        .rst(rst),
        .hs(Hsync), 
        .vs(Vsync), 
        .animate(animate),
        .x(x), 
        .y(y)
    );

    ////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// CREATE NOTES ///////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
	 
	 
    difficulty_converter difficulty_converter (
		 .difficulty(difficulty),
		 .clk(clk), 
		 .rst(rst),
		 .difficulty_converted(difficulty_converted)
    );


	 
    player_bar player_bar (
        .clk(clk), 
        .btnR(btnR), 
        .btnU(btnU), 
        .btnD(btnD), 
        .btnL(btnL), 
        .x(x), 
        .y(y), 
        .is_player_bar(is_player_bar)
    );
    
    note note1(
        .clk(clk),           // base clock
        .animate(animate),    // high for one tick at end of active drawing
        .note_rst(note_spawn[0]),           // reset: move note out of screen
        .slowFactor(difficulty_converted),
        .keyValue(keyValue), 
        .keyPressed(keyPressed), 
        .initial_loc(initial_loc[3:0]),
        .x(x), // Current pixel x,y location
        .y(y),
        .noteAction(noteAction[0]), 
        .noteSuccessState(noteSuccessState[0]), 
        .is_note(draw_note1)         // Draw note if its in note's region
    );

    note note2(
        .clk(clk),           // base clock
        .animate(animate),    // high for one tick at end of active drawing
        .note_rst(note_spawn[1]),           // reset: move note out of screen
        .slowFactor(difficulty_converted),
        .keyValue(keyValue), 
        .keyPressed(keyPressed), 
        .initial_loc(initial_loc[7:4]),
        .x(x), // Current pixel x,y location
        .y(y),
        .noteAction(noteAction[1]), 
        .noteSuccessState(noteSuccessState[1]),
        .is_note(draw_note2)         // Draw note if its in note's region
    );

    note note3(
        .clk(clk),           // base clock
        .animate(animate),    // high for one tick at end of active drawing
        .note_rst(note_spawn[2]),           // reset: move note out of screen
        .slowFactor(difficulty_converted),
        .keyValue(keyValue), 
        .keyPressed(keyPressed), 
        .initial_loc(initial_loc[11:8]),
        .x(x), // Current pixel x,y location
        .y(y),
        .noteAction(noteAction[2]), 
        .noteSuccessState(noteSuccessState[2]),
        .is_note(draw_note3)         // Draw note if its in note's region
    );
        
    note note4(
        .clk(clk),           // base clock
        .animate(animate),    // high for one tick at end of active drawing
        .note_rst(note_spawn[3]),           // reset: move note out of screen
        .slowFactor(difficulty_converted),
        .keyValue(keyValue), 
        .keyPressed(keyPressed), 
        .initial_loc(initial_loc[15:12]),
        .x(x), // Current pixel x,y location
        .y(y),
        .noteAction(noteAction[3]), 
        .noteSuccessState(noteSuccessState[3]),
        .is_note(draw_note4)         // Draw note if its in note's region
    );
	 
    note note5(
        .clk(clk),           // base clock
        .animate(animate),    // high for one tick at end of active drawing
        .note_rst(note_spawn[4]),           // reset: move note out of screen
        .slowFactor(difficulty_converted),
        .keyValue(keyValue), 
        .keyPressed(keyPressed), 
        .initial_loc(initial_loc[19:16]),
        .x(x), // Current pixel x,y location
        .y(y),
        .noteAction(noteAction[4]), 
        .noteSuccessState(noteSuccessState[4]), 
        .is_note(draw_note5)         // Draw note if its in note's region
    );

    note note6(
        .clk(clk),           // base clock
        .animate(animate),    // high for one tick at end of active drawing
        .note_rst(note_spawn[5]),           // reset: move note out of screen
        .slowFactor(difficulty_converted),
        .keyValue(keyValue), 
        .keyPressed(keyPressed), 
        .initial_loc(initial_loc[23:20]),
        .x(x), // Current pixel x,y location
        .y(y),
        .noteAction(noteAction[5]), 
        .noteSuccessState(noteSuccessState[5]),
        .is_note(draw_note6)         // Draw note if its in note's region
    );

    note note7(
        .clk(clk),           // base clock
        .animate(animate),    // high for one tick at end of active drawing
        .note_rst(note_spawn[6]),           // reset: move note out of screen
        .slowFactor(difficulty_converted),
        .keyValue(keyValue), 
        .keyPressed(keyPressed), 
        .initial_loc(initial_loc[27:24]),
        .x(x), // Current pixel x,y location
        .y(y),
        .noteAction(noteAction[6]), 
        .noteSuccessState(noteSuccessState[6]),
        .is_note(draw_note7)         // Draw note if its in note's region
    );
        
    note note8(
        .clk(clk),           // base clock
        .animate(animate),    // high for one tick at end of active drawing
        .note_rst(note_spawn[7]),           // reset: move note out of screen
        .slowFactor(difficulty_converted),
        .keyValue(keyValue), 
        .keyPressed(keyPressed), 
        .initial_loc(initial_loc[31:28]),
        .x(x), // Current pixel x,y location
        .y(y),
        .noteAction(noteAction[7]), 
        .noteSuccessState(noteSuccessState[7]),
        .is_note(draw_note8)         // Draw note if its in note's region
    );	 

        
    note_spawner note_spawner (
        .clk(clk), 
        .rst(mode), 
        .noteAction(noteAction), 
        .level_num(level), 
        .animate(animate), 
        .locations(initial_loc), 
        .note_spawn(note_spawn)
    );
    ////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// DRAW NOTES /////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
/*    reg [7:0] note_delay = 0;
    reg [1:0] note_cnt = 0;
    reg [2:0] num_notes = 0;
//    reg [3:0] next_note;
    reg [5:0] addr;
    
    level_selector level_selector (
    .addr(addr), 
    .level_num(2'b01), 
    .clk(clk), 
    .rst(rst), 
    .note(note)
    );
    
   always @ (posedge clk)
    begin
        if (noteAction !== 4'b0000)
        begin
         case (noteAction)
             4'b0001: initial_loc[3:0] <= note;
             4'b0010: initial_loc[7:4] <= note;
             4'b0100: initial_loc[11:8] <= note;
             4'b1000: initial_loc[15:12] <= note;
         default: initial_loc <= 0;
         endcase
            
         addr <= addr +1;
         note_delay <=0;
         note_cnt <=0;
        end 
        
        if (animate)
        begin
            if (num_notes >= 4) 
                note_spawn <= 0;
            else if (note_delay == 8'd180)
            begin 
                case (note_cnt)
                    2'b00: note_spawn[0] <= 1;
                    2'b01: note_spawn[1] <= 1;
                    2'b10: note_spawn[2] <= 1;
                    2'b11: note_spawn[3] <= 1;
                default: note_spawn <= 0;
                endcase
                note_delay <= 0;
                note_cnt <= note_cnt + 1;
                num_notes <= num_notes + 1;
            end
            else
                note_delay <= note_delay + 1;
        end
        else
            note_spawn <= 0;
    end*/

    always @ (posedge clk)
    begin
        if (rst)
        begin
            VGA <= VGA_BACKGROUND;
        end
        else if (mode == 0)
        begin
            if (draw_note1 | draw_note2 | draw_note3 | draw_note4 | draw_note5 | draw_note6 | draw_note7 | draw_note8) 
                VGA <= VGA_NOTE;
            else if (is_player_bar)
                VGA <= VGA_PLAYER;
            else
                VGA <= VGA_BACKGROUND;
        end
		  else
		  begin
				if (is_menu)
					VGA <= VGA_MENU;
				else
					VGA <= VGA_BACKGROUND;
		  end
		  
    end    
endmodule