module player_bar(
    input wire clk,           // base clock
    input wire btnR,
    input wire btnU,
    input wire btnD,
    input wire btnL,
    input wire [9:0] x, // Current pixel x,y location
    input wire [9:0] y,
    output is_player_bar        // Draw note if its in note's region
);

    `include "display_consts.vh"

    reg is_inside_bar;

    ////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// OUTER BOUNDS ///////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    wire column0_outer_bounds, column1_outer_bounds, column2_outer_bounds, column3_outer_bounds;
    assign column0_outer_bounds = (y >= PLAYER_Y && 
                                    y <= PLAYER_Y + NOTE_HEIGHT &&
                                    x >= COLUMN0_X  && 
                                    x <= COLUMN0_X + NOTE_WIDTH );

    assign column1_outer_bounds = (y >= PLAYER_Y && 
                                    y <= PLAYER_Y + NOTE_HEIGHT &&
                                    x >= COLUMN1_X  && 
                                    x <= COLUMN1_X + NOTE_WIDTH );

    assign column2_outer_bounds = (y >= PLAYER_Y && 
                                    y <= PLAYER_Y + NOTE_HEIGHT &&
                                    x >= COLUMN2_X  && 
                                    x <= COLUMN2_X + NOTE_WIDTH );

    assign column3_outer_bounds = (y >= PLAYER_Y && 
                                    y <= PLAYER_Y + NOTE_HEIGHT &&
                                    x >= COLUMN3_X  && 
                                    x <= COLUMN3_X + NOTE_WIDTH );


    ////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// INNER BOUNDS  //////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    wire column0_inner_bounds, column1_inner_bounds, column3_inner_bounds, column4_inner_bounds;
    assign column0_inner_bounds = (y >= PLAYER_Y + LINE_HEIGHT && 
                                    y <= PLAYER_Y + NOTE_HEIGHT - LINE_HEIGHT &&
                                    x >= COLUMN0_X + LINE_WIDTH && 
                                    x <= COLUMN0_X + NOTE_WIDTH - LINE_WIDTH );

    assign column1_inner_bounds = (y >= PLAYER_Y + LINE_HEIGHT && 
                                    y <= PLAYER_Y + NOTE_HEIGHT - LINE_HEIGHT &&
                                    x >= COLUMN1_X + LINE_WIDTH && 
                                    x <= COLUMN1_X + NOTE_WIDTH - LINE_WIDTH );

    assign column2_inner_bounds = (y >= PLAYER_Y + LINE_HEIGHT && 
                                    y <= PLAYER_Y + NOTE_HEIGHT - LINE_HEIGHT &&
                                    x >= COLUMN2_X + LINE_WIDTH && 
                                    x <= COLUMN2_X + NOTE_WIDTH - LINE_WIDTH );                                    

    assign column3_inner_bounds = (y >= PLAYER_Y + LINE_HEIGHT && 
                                    y <= PLAYER_Y + NOTE_HEIGHT - LINE_HEIGHT &&
                                    x >= COLUMN3_X + LINE_WIDTH && 
                                    x <= COLUMN3_X + NOTE_WIDTH - LINE_WIDTH );

    
    ////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// ASSIGN BOUNDS  //////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    parameter DELAY_DIV = 25000000;
    reg [26:0] delay_counter;
    reg btnL_d, btnU_d, btnR_d, btnD_d;
    
    always @ (posedge clk)
    begin
        if (delay_counter !== 0)
        begin
            if (btnL)
            begin
                btnL_d <= 1;
                delay_counter <= DELAY_DIV;
            end
            else if (btnR)
            begin
                btnR_d <= 1;
                delay_counter <= DELAY_DIV;
            end
            else if (btnU)
            begin
                btnU_d <= 1;
                delay_counter <= DELAY_DIV;
            end
            else if (btnD)
            begin
                btnD_d <= 1;
                delay_counter <= DELAY_DIV;
            end
            
            delay_counter <= delay_counter - 1;
        end
        else
        begin
            delay_counter <= DELAY_DIV;
            btnL_d <= 0;
            btnR_d <= 0;
            btnU_d <= 0;
            btnD_d <= 0;
        end
    end
    
    always @ (posedge clk)
    begin
    // TODO: ADD CHECKS FOR BUTTON PRESSES (IF BUTTON PRESS, COLOR IN A COLUMN)
            if (column0_outer_bounds | column1_outer_bounds | column2_outer_bounds | column3_outer_bounds)
            begin
                if ((column0_inner_bounds && btnL_d) | 
                    (column1_inner_bounds && btnU_d) | 
                    (column2_inner_bounds && btnD_d) |
                    (column3_inner_bounds && btnR_d))
                begin
                    is_inside_bar <= 1;
                end
                
                else if (column0_inner_bounds | column1_inner_bounds | column2_inner_bounds | column3_inner_bounds)
                begin
                    is_inside_bar <= 0;
                end
                else
                    is_inside_bar <= 1;
            end

            else 
                is_inside_bar <= 0;    
    end
    
    assign is_player_bar = is_inside_bar;
endmodule