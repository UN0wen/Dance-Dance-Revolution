module note_spawner(
    input clk, 
    input rst,
    input [7:0] noteAction,
	 input [1:0] level_num,
    input animate,
    output reg [NOTE_LOCATIONS_WIDTH:0] locations,
	 output reg [7:0] note_spawn
    );

    parameter NOTE_LOCATIONS_WIDTH = 31;
    parameter NOTE_COUNT_WIDTH = 7;
    parameter NOTE_COUNT_MAX = 100;
    parameter NOTE_WIDTH = 3;
    parameter NOTE_DELAY = 8'd180;
	 
    reg [5:0] note_count;
    reg [3:0] next_note;
    reg rst_pressed;
    reg [2:0] rst_counter;
    // notes
    reg [2:0] notes_on_screen;
    reg [3:0] current_note;
    reg ended;
    
    reg [7:0] note_delay;
    
    wire [3:0] next_note_wire;

    initial note_count = 6'd0;
    initial rst_pressed = 1'b0;
    initial rst_counter = 3'd0;    

    level_selector memory_reader (
		.addr(note_count),
		.level_num(level_num),
      .clk(clk),
		.rst(rst),
		.note(next_note_wire)
    );
    
    always @ (posedge clk)
    begin
        next_note <= next_note_wire;
    end
    // normal note parsing behavior
    always @ (posedge clk)
    begin
        if (rst) // stores value of rest for future clock cycles until all initial notes are made
        begin 
            rst_pressed <= 1'b1;
            note_count <= 8'b0000_0000;
            rst_counter <= 3'b000;
            notes_on_screen <= 3'b000;
				current_note <= 4'b0000;
				note_delay <= 8'b0000_0000;
        end
        
        // Initial spawn
        else if (rst_pressed) // inital note creation
        begin
            if (note_count < 6'b00_1000)
            begin
                case (rst_counter)
                    3'b000:
                        locations[3:0] <= next_note;
                    3'b001:
                        locations[7:4] <= next_note;
                    3'b010:
                        locations[11:8] <= next_note;
                    3'b011:
                        locations[15:12] <= next_note;
					3'b100:
						locations[19:16] <= next_note;
					3'b101:
						locations[23:20] <= next_note;
					3'b110:
						locations[27:24] <= next_note;
					3'b111:
						locations[31:28] <= next_note;
                endcase  
                note_count <= note_count + 1;
                rst_counter <= rst_counter + 1;
                current_note <= current_note + 1;
            end
            else
                rst_pressed <= 0;
        end
        
        else if (next_note == 4'b1111)
        begin
            ended <= 1;
        end
        
        // Notes despawn
        else if (noteAction !== 8'b0000_0000)
        begin
            case (noteAction)
                8'b0000_0001: locations[3:0] <= next_note;
                8'b0000_0010: locations[7:4] <= next_note;
                8'b0000_0100: locations[11:8] <= next_note;
                8'b0000_1000: locations[15:12] <= next_note;
				8'b0001_0000: locations[19:16] <= next_note;
				8'b0010_0000: locations[23:20] <= next_note;
				8'b0100_0000: locations[27:24] <= next_note;
				8'b1000_0000: locations[31:28] <= next_note;
            endcase
                note_count <= note_count + 1;
                notes_on_screen <= notes_on_screen - 1;
        end
        
        // Note creation
		  // Current note goes from 1 to 8, we play next note based on current note e.g. 8 -> create 1st note
        else if (animate)
        begin
            if (notes_on_screen >= 6) // max number of notes on screen at once
                note_spawn <= 0;
            else if (note_delay == NOTE_DELAY)
            begin 
                case (current_note)
                    4'b1000: note_spawn[0] <= 1;
                    4'b0001: note_spawn[1] <= 1;
                    4'b0010: note_spawn[2] <= 1;
                    4'b0011: note_spawn[3] <= 1;
                    4'b0100: note_spawn[4] <= 1;
				    4'b0101: note_spawn[5] <= 1;
                    4'b0110: note_spawn[6] <= 1;
                    4'b0111: note_spawn[7] <= 1;
                default: note_spawn <= 0;
                endcase
                note_delay <= 0;
                if (current_note == 4'b1000)
                    current_note <= 4'b0001;
                else 
                    current_note <= current_note + 1;
                notes_on_screen <= notes_on_screen + 1;
            end
            else
                note_delay <= note_delay + 1;
        end
        else
            note_spawn <= 0;
    end
endmodule