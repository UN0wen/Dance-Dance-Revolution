module buzzer_driver(
    input clk,
    input rst,
    input [7:0] sound,
    output reg buzzer
    );

    reg [18:0] buzzer_counter;
    reg [7:0] sound_d;
    parameter DELAY_DIV = 25000000;
    reg [26:0] delay_counter;
    
    always @ (posedge clk)
    begin
        if (rst)
            delay_counter <= DELAY_DIV;
        else if (delay_counter !== 0)
        begin
            if (sound != 8'b0000)
            begin
                sound_d <= sound;
                delay_counter <= DELAY_DIV;
            end
            else
					delay_counter <= delay_counter - 1;
        end
        else
        begin
            delay_counter <= DELAY_DIV;
            sound_d <= sound;
        end
    end
    
    always @(posedge clk)
    begin
        if (rst)
        begin
            buzzer <= 1'b0;
        end
        else if (sound_d !== 8'b0000)
        begin
            case (sound_d)
                8'b0000_1000, 8'b1000_0000 : 
                    begin
                        if (buzzer_counter != 19'b1111111111111111111) // 190.7 hZ
                        begin
                            buzzer_counter <= buzzer_counter + 1;
                        end
                        else
                        begin
                            buzzer_counter <= 19'd0;
                        end
                        buzzer <= buzzer_counter[18];
                    end
                8'b0000_0100, 8'b0100_0000 :
                    begin
                        if (buzzer_counter != 19'b0111111111111111111) // 381.5 Hz
                        begin
                            buzzer_counter <= buzzer_counter + 1;
                        end
                        else
                        begin
                            buzzer_counter <= 19'd0;
                        end
                        buzzer <= buzzer_counter[17];
                    end
                8'b0000_0010, 8'b0010_0000 :
                    begin
                        if (buzzer_counter != 19'b0011111111111111111) // 762.9 Hz
                        begin
                            buzzer_counter <= buzzer_counter + 1;
                        end
                        else
                        begin
                            buzzer_counter <= 19'd0;
                        end
                        buzzer <= buzzer_counter[16];
                    end
                8'b0000_0001, 8'b0001_0000 :
                    begin
                        if (buzzer_counter != 19'b0001111111111111111) // 1525.9 Hz
                        begin
                            buzzer_counter <= buzzer_counter + 1;
                        end
                        else
                        begin
                            buzzer_counter <= 19'd0;
                        end
                        buzzer <= buzzer_counter[15];
                    end
                default :
                    buzzer <= 1'b0;
            endcase
        end
        else
        begin
            buzzer <= 0;
            buzzer_counter <= 0;
        end
    end


    
endmodule
        