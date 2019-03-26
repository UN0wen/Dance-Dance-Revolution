// Send 1 signal out everytime button is pressed
module debouncerv2 (
    input button,
    input clk,
    output button_state
);
    reg button_sync_0, button_sync_1;

    initial button_state_reg = button;
    
    reg button_state_reg; 
    wire button_sync_1_bar;

    always @ (posedge clk) button_sync_0 <= button;

    always @ (posedge clk) button_sync_1 <= button_sync_0; 
    
    // if button current state is still the same as it was 2 states ago, button is idle
    wire button_idle = (button_sync_1 == button); 

    always @ (posedge clk) 
    begin
        if (button_idle) button_state_reg <= button_state_reg;
        else button_state_reg <= ~button_state_reg; 
    end

    assign button_state = button_state_reg; 

endmodule