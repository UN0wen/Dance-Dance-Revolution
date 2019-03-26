// Send 1 signal out everytime button is pressed
module debouncer (
    input button,
    input clk,
    output button_pressed
);
    // SLOW CLOCK DIVIDER
    wire slowClk;
    reg slowClk_reg;
    reg [16:0] cnt;
    wire [17:0] cnt_inc;
    assign cnt_inc = cnt + 1;

    always @(posedge clk)
    begin
        if (rst)
        begin
            cnt <= 0;
            slowClk_reg <= 0;
        end
        else
        begin
            slowClk_reg <= cnt_inc[17];
            cnt <= cnt_inc[16:0];
        end
    end
    
    assign slowClk = slowClk_reg;
    
    // DEBOUNCER
    reg button_sync_0, button_sync_1;
    reg button_pressed_reg; 
    wire button_sync_1_bar;
    
    always @ (posedge slowClk) button_sync_0 <= button;

    always @ (posedge slowClk) button_sync_1 <= button_sync_0; 

    assign button_sync_1_bar = ~button_sync_1; 
    always @ (posedge slowClk) button_pressed_reg <= (button_sync_1_bar && button_sync_0); // 2 states ago it was 0, last state it was 1

    assign button_pressed = button_pressed_reg; 
endmodule