module score_keeping(
    input clk,
    input rst,
    input [7:0] noteAction,
    input [7:0] noteSuccessState,
    output reg [15:0] score,
    output reg [6:0] multiplier
    );

    reg [6:0] score_streak;
    reg score_action, score_type;
    
    initial multiplier = 7'd1;
    initial score = 16'd0;
    initial score_streak = 7'd0;
    
    always @ (noteAction)
    begin
        if (noteAction == 8'b0000_0000)
            score_action <= 1'b0;
        else
            score_action <= 1'b1;
            
        case (noteAction)
			  8'b0000_0001 : score_type <= noteSuccessState[0];
			  8'b0000_0010 : score_type <= noteSuccessState[1];
			  8'b0000_0100 : score_type <= noteSuccessState[2];
			  8'b0000_1000 : score_type <= noteSuccessState[3];
			  8'b0001_0000 : score_type <= noteSuccessState[4];
			  8'b0010_0000 : score_type <= noteSuccessState[5];
			  8'b0100_0000 : score_type <= noteSuccessState[6];
			  8'b1000_0000 : score_type <= noteSuccessState[7];
        default: score_type <= 0;
        endcase
    end
    
    always @(posedge clk)
    begin
        if (rst)
        begin
            score <= 0;
            multiplier <= 1;
            score_streak <=  0;
        end 
        else if (score_action)
        begin
            case (score_type)
                1'b1 :
                    begin
                        if ( (score + multiplier) > 16'd9999)
                            score <= 16'd9999;
                        else
                            score <= score + multiplier;

                        score_streak <= score_streak + 1;
								
                    end
                1'b0 :
                    begin
                        multiplier <= 7'd1;
                        score_streak <= 7'd0;
                    end
            endcase
        end
        
        if (score_streak == multiplier && multiplier != 7'd99)
        begin
            score_streak <= 7'd0;
            multiplier <= multiplier + 1;
        end
    end

endmodule