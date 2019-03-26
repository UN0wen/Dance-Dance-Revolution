module note(
    input wire clk,           // base clock
    input wire animate,    // high for one tick at end of active drawing
    input wire note_rst,           // reset: move note out of screen
    input wire [1:0] slowFactor,
    input wire [3:0] keyValue, // Player pressed button
    input wire keyPressed,
    input wire [3:0] initial_loc,
    input wire [9:0] x, // Current pixel x,y location
    input wire [9:0] y,
//   output note_X,           // X location of note
//   output note_Y,           // Y location of note
    output reg noteAction,       // reached the end, missed note
    output reg noteSuccessState,   // player successfully hits note
    output is_note         // Draw note if its in note's region
);

`include "display_consts.vh"

localparam OFF_SCREEN = 10'd800; // 800,800 is off screen
// localparam SLOW_FACTOR = 2; // 60 / SLOW_FACTOR = Speed in pixels per second

reg [9:0] current_note_X;
reg [9:0] current_note_Y;
reg [1:0] player_column;
reg [1:0] note_column;

reg is_alive = 0;

wire is_in_hitbox;

reg [1:0] slow_counter;
// Set the initial location of the note
reg [9:0] initial_note_X;
reg [9:0] initial_note_Y;

// Mapping initial location to columns
always @ (initial_loc)
begin
    case (initial_loc)
        4'b0001: // far right
        begin
        initial_note_X = COLUMN3_X;   
        note_column = 2'b11;
        end
        4'b0010:         
        begin
        initial_note_X = COLUMN2_X;   
        note_column = 2'b10;
        end
        4'b0100:        
        begin
        initial_note_X = COLUMN1_X;   
        note_column = 2'b01;
        end  
        4'b1000:         
        begin
        initial_note_X = COLUMN0_X;   
        note_column = 2'b00;
        end
        default: initial_note_X = OFF_SCREEN;   
    endcase

    initial_note_Y = 0;   
end

initial
begin
        current_note_X <= initial_note_X;
        current_note_Y <= initial_note_Y;
end

// Mapping player button pressed to their appropriate columns
always @ (posedge clk)
begin
    if (keyPressed)
    begin
        case (keyValue)
            4'b0110: // far right
            player_column = 2'b11;
            4'b1000: 
            player_column = 2'b10;
            4'b0010:
            player_column = 2'b01;
            4'b0100:
            player_column = 2'b00;  
        endcase 
    end
    else 
        player_column = ~note_column;
end

assign is_in_hitbox = (player_column == note_column && 
                        current_note_Y >= PLAYER_Y - HALF_NOTE_HEIGHT &&
                        current_note_Y <= PLAYER_Y + HALF_NOTE_HEIGHT);

// Main
always @ (posedge clk)
begin
    if (note_rst)
    begin
        current_note_X <= initial_note_X;
        current_note_Y <= initial_note_Y;
        is_alive <= 1;
        noteAction <= 0;
    end
    // All note movement and checking goes here
    else if (animate) 
    begin
        // Checks if user hits note
        if (is_in_hitbox)
        begin
            current_note_X <= OFF_SCREEN;
            current_note_Y <= OFF_SCREEN;
            is_alive <= 0;
            noteAction <= 1;
            noteSuccessState <= 1;
        end

        // Checks if note has gone out of bounds
        else if (current_note_Y > PLAYER_Y + HALF_NOTE_HEIGHT)
        begin
            noteSuccessState <= 0;
            current_note_X <= OFF_SCREEN;
            current_note_Y <= OFF_SCREEN;
            is_alive <= 0;
            noteAction <= 1;
        end

        else if (is_alive)
        begin
            if (slow_counter == slowFactor)
            begin
                current_note_Y <= current_note_Y + 1;
                slow_counter <= 2'd1;
            end
            else
                slow_counter <= slow_counter + 1;
        end
    end
    
    if (is_alive != 1)
        noteAction <= 0;
end

assign is_note = (y >= current_note_Y && 
                    y <= current_note_Y + NOTE_HEIGHT &&
					x >= current_note_X  && 
                    x <= current_note_X + NOTE_WIDTH );

endmodule
