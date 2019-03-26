module buzzer_driver2(
    input clk,
    input rst,
    output reg buzzer
    );


    reg [16:0] buzzer_counter;

    always @(posedge clk)
    begin
        if (rst)
        begin
            buzzer_counter <= 17'b0;
        end
        else
        begin
           if (buzzer_counter != 17'b11111111111111111)
           begin
              buzzer_counter <= buzzer_counter + 1;
           end
           else
           begin
              buzzer_counter <= 17'b0;
           end
           buzzer = buzzer_counter[16];
        end
    end


endmodule
        