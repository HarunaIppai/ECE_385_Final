//-------------------------------------------------------------------------
//    Note.sv modified from Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  note ( input   logic			Reset, frame_clk,
					input   logic [7:0]  keycode_0, keycode_1,
					input	  logic [2:0]	Spawn_0,
					input	  logic [2:0]  Spawn_1,
               output  logic [9:0]  Note_1_1_Y, Note_1_2_Y, 
					output  logic [9:0]  Note_2_1_Y, Note_2_2_Y,
					output  logic [9:0]  Note_3_1_Y, Note_3_2_Y, 
					output  logic [9:0]  Note_4_1_Y, Note_4_2_Y,
					output  logic [9:0]  Note_5_1_Y, Note_5_2_Y,
					output  logic [9:0]  Stamina,
					output  logic [9:0]  Note_Update
					);
    
    //logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 logic [9:0] Note_1_1_Y_Pos, Note_1_2_Y_Pos;
	 logic [9:0] Note_2_1_Y_Pos, Note_2_2_Y_Pos;
	 logic [9:0] Note_3_1_Y_Pos, Note_3_2_Y_Pos;
	 logic [9:0] Note_4_1_Y_Pos, Note_4_2_Y_Pos;
	 logic [9:0] Note_5_1_Y_Pos, Note_5_2_Y_Pos;
	 logic [4:0] Key_Pressed_0, Key_Pressed_1; 
	 logic		 SpawnState;
	 logic		 SpawnPending;
	 
	 assign SpawnPending = Spawn_0[0] | Spawn_0[1] | Spawn_0[2] | Spawn_1[0] | Spawn_1[1] | Spawn_1[2]; //The Spawn is not zero
	 
    //parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    //parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis
    //parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    //parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    //parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    //parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    //parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    //parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis
	 
	 //parameter [9:0] Spawn_X_1_Center = 90;
	 //parameter [9:0] Spawn_X_2_Center = 205;
	 //parameter [9:0] Spawn_X_3_Center = 320;
	 //parameter [9:0] Spawn_X_4_Center = 435;
	 //parameter [9:0] Spawn_X_5_Center = 550;
	 parameter [9:0] Spawn_Y = 80;
    parameter [9:0] Note_Y_Max=520;     // Where it fully disappears
    parameter [9:0] Note_Y_Step=3;      // Step size on the Y axis

    //assign Ball_Size = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 
	
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
			begin 
				Note_1_1_Y_Pos <= Spawn_Y;
				Note_1_2_Y_Pos <= Spawn_Y;
				Note_2_1_Y_Pos <= Spawn_Y;
				Note_2_2_Y_Pos <= Spawn_Y;
				Note_3_1_Y_Pos <= Spawn_Y;
				Note_3_2_Y_Pos <= Spawn_Y;
				Note_4_1_Y_Pos <= Spawn_Y;
				Note_4_2_Y_Pos <= Spawn_Y;
				Note_5_1_Y_Pos <= Spawn_Y;
				Note_5_2_Y_Pos <= Spawn_Y;
				Note_Update <= 10'b0000000000;
				Key_Pressed_0 <= 5'b00000;
				Key_Pressed_1 <= 5'b00000;
				SpawnState <= 1'b0;
				Stamina <= 10'b1111111111;
			end
        else 
			begin 
				if (!SpawnPending) begin //There is no pending spawn
					SpawnState <= 0;
				end
				else if (!SpawnState) begin //There is pending spawn and has not been spawned
					SpawnState <= 1; //Mark it as spawned and begin spawning
						unique case (Spawn_0)
							3'b001 : begin
								if (!Note_Update[0]) begin
									Note_Update[0] <= 1;
									Note_1_1_Y_Pos <= Spawn_Y;
								end
								else if (Note_Update[0] && !Note_Update[1]) begin
									Note_Update[1] <= 1;
									Note_1_2_Y_Pos <= Spawn_Y;
								end
							end
							3'b010 : begin
								if (!Note_Update[2]) begin
									Note_Update[2] <= 1;
									Note_2_1_Y_Pos <= Spawn_Y;
								end
								else if (Note_Update[2] && !Note_Update[3]) begin
									Note_Update[3] <= 1;
									Note_2_2_Y_Pos <= Spawn_Y;
								end
							end
							3'b011 : begin
								if (!Note_Update[4]) begin
									Note_Update[4] <= 1;
									Note_3_1_Y_Pos <= Spawn_Y;
								end
								else if (Note_Update[4] && !Note_Update[5]) begin
									Note_Update[5] <= 1;
									Note_3_2_Y_Pos <= Spawn_Y;
								end
							end
							3'b100 : begin
								if (!Note_Update[6]) begin
									Note_Update[6] <= 1;
									Note_4_1_Y_Pos <= Spawn_Y;
								end
								else if (Note_Update[6] && !Note_Update[7]) begin
									Note_Update[7] <= 1;
									Note_4_2_Y_Pos <= Spawn_Y;
								end
							end
							3'b101 : begin
								if (!Note_Update[8]) begin
									Note_Update[8] <= 1;
									Note_5_1_Y_Pos <= Spawn_Y;
								end
								else if (Note_Update[8] && !Note_Update[9]) begin
									Note_Update[9] <= 1;
									Note_5_2_Y_Pos <= Spawn_Y;
								end
							end
							default : begin
							end
						endcase
						unique case (Spawn_1)
							3'b001 : begin
								if (!Note_Update[0]) begin
									Note_Update[0] <= 1;
									Note_1_1_Y_Pos <= Spawn_Y;
								end
								else if (Note_Update[0] && !Note_Update[1]) begin
									Note_Update[1] <= 1;
									Note_1_2_Y_Pos <= Spawn_Y;
								end
							end
							3'b010 : begin
								if (!Note_Update[2]) begin
									Note_Update[2] <= 1;
									Note_2_1_Y_Pos <= Spawn_Y;
								end
								else if (Note_Update[2] && !Note_Update[3]) begin
									Note_Update[3] <= 1;
									Note_2_2_Y_Pos <= Spawn_Y;
								end
							end
							3'b011 : begin
								if (!Note_Update[4]) begin
									Note_Update[4] <= 1;
									Note_3_1_Y_Pos <= Spawn_Y;
								end
								else if (Note_Update[4] && !Note_Update[5]) begin
									Note_Update[5] <= 1;
									Note_3_2_Y_Pos <= Spawn_Y;
								end
							end
							3'b100 : begin
								if (!Note_Update[6]) begin
									Note_Update[6] <= 1;
									Note_4_1_Y_Pos <= Spawn_Y;
								end
								else if (Note_Update[6] && !Note_Update[7]) begin
									Note_Update[7] <= 1;
									Note_4_2_Y_Pos <= Spawn_Y;
								end
							end
							3'b101 : begin
								if (!Note_Update[8]) begin
									Note_Update[8] <= 1;
									Note_5_1_Y_Pos <= Spawn_Y;
								end
								else if (Note_Update[8] && !Note_Update[9]) begin
									Note_Update[9] <= 1;
									Note_5_2_Y_Pos <= Spawn_Y;
								end
							end
							default : begin
							end
						endcase
				end
				 //if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
					//  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  
				 //else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
					//  Ball_Y_Motion <= Ball_Y_Step;
					  
				 //else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
					//  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  
				 //else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the Left edge, BOUNCE!
					//  Ball_X_Motion <= Ball_X_Step;
					  
				 //else
				 
				 Key_Pressed_0 <= Key_Pressed_0;
				 Key_Pressed_1 <= Key_Pressed_1;
				 Note_1_1_Y_Pos <= Note_1_1_Y_Pos;
				 Note_1_2_Y_Pos <= Note_1_2_Y_Pos;
				 Note_2_1_Y_Pos <= Note_2_1_Y_Pos;
				 Note_2_2_Y_Pos <= Note_2_2_Y_Pos;
				 Note_3_1_Y_Pos <= Note_3_1_Y_Pos;
			  	 Note_3_2_Y_Pos <= Note_3_2_Y_Pos;
				 Note_4_1_Y_Pos <= Note_4_1_Y_Pos;
				 Note_4_2_Y_Pos <= Note_4_2_Y_Pos;
				 Note_5_1_Y_Pos <= Note_5_1_Y_Pos;
				 Note_5_2_Y_Pos <= Note_5_2_Y_Pos;
				 
				 if (Note_1_1_Y_Pos - 10'd46 >= 479) begin
					Note_1_1_Y_Pos <= Note_1_2_Y_Pos;
					Note_1_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
					Note_Update[0] <= Note_Update[1];
					Note_Update[1] <= 0;
					Key_Pressed_0[0] <= 1;
					Stamina <= {1'b0, Stamina[9:1]};
				 end
				 
				 if (Note_2_1_Y_Pos - 10'd46 >= 479) begin
					Note_2_1_Y_Pos <= Note_2_2_Y_Pos;
					Note_2_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
					Note_Update[2] <= Note_Update[3];
					Note_Update[3] <= 0;
					Key_Pressed_0[1] <= 1;
					Stamina <= {1'b0, Stamina[9:1]};
				 end
				 
				 if (Note_3_1_Y_Pos - 10'd46 >= 479) begin
					Note_3_1_Y_Pos <= Note_3_2_Y_Pos;
					Note_3_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
					Note_Update[4] <= Note_Update[5];
					Note_Update[5] <= 0;
					Key_Pressed_0[2] <= 1;
					Stamina <= {1'b0, Stamina[9:1]};
				 end
				 
				 if (Note_4_1_Y_Pos - 10'd46 >= 479) begin
					Note_4_1_Y_Pos <= Note_4_2_Y_Pos;
					Note_4_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
					Note_Update[6] <= Note_Update[7];
					Note_Update[7] <= 0;
					Key_Pressed_0[3] <= 1;
					Stamina <= {1'b0, Stamina[9:1]};
				 end
				 
				 if (Note_5_1_Y_Pos - 10'd46 >= 479) begin
					Note_5_1_Y_Pos <= Note_5_2_Y_Pos;
					Note_5_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
					Note_Update[8] <= Note_Update[9];
					Note_Update[9] <= 0;
					Key_Pressed_0[4] <= 1;
					Stamina <= {1'b0, Stamina[9:1]};
				 end
				 
				 if (Note_Update[0] && keycode_0 != 8'h07) begin
					Note_1_1_Y_Pos <= (Note_Y_Step + Note_1_1_Y_Pos);
				 end
				 else
					Note_1_1_Y_Pos <= Spawn_Y;
					
				 if (Note_Update[1] && keycode_0 != 8'h07) begin
					Note_1_2_Y_Pos <= (Note_Y_Step + Note_1_2_Y_Pos);
				 end
				 else
					Note_1_2_Y_Pos <= Spawn_Y;
					
				 if (Note_Update[2] && keycode_0 != 8'h09) begin
					Note_2_1_Y_Pos <= (Note_Y_Step + Note_2_1_Y_Pos);
				 end
				 else
					Note_2_1_Y_Pos <= Spawn_Y;
					
				 if (Note_Update[3] && keycode_0 != 8'h09) begin
					Note_2_2_Y_Pos <= (Note_Y_Step + Note_2_2_Y_Pos);
				 end
				 else
					Note_2_2_Y_Pos <= Spawn_Y;
					
				 if (Note_Update[4] && keycode_0 != 8'h2c) begin
					Note_3_1_Y_Pos <= (Note_Y_Step + Note_3_1_Y_Pos);
				 end
				 else
					Note_3_1_Y_Pos <= Spawn_Y;
					
				 if (Note_Update[5] && keycode_0 != 8'h2c) begin
					Note_3_2_Y_Pos <= (Note_Y_Step + Note_3_2_Y_Pos);
				 end
				 else
					Note_3_2_Y_Pos <= Spawn_Y;
					
				 if (Note_Update[6] && keycode_0 != 8'h0d) begin
					Note_4_1_Y_Pos <= (Note_Y_Step + Note_4_1_Y_Pos);
				 end
				 else
					Note_4_1_Y_Pos <= Spawn_Y;
					
				 if (Note_Update[7] && keycode_0 != 8'h0d) begin
					Note_4_2_Y_Pos <= (Note_Y_Step + Note_4_2_Y_Pos);
				 end
				 else
					Note_4_2_Y_Pos <= Spawn_Y;
					
				 if (Note_Update[8] && keycode_0 != 8'h0e) begin
					Note_5_1_Y_Pos <= (Note_Y_Step + Note_5_1_Y_Pos);
				 end
				 else
					Note_5_1_Y_Pos <= Spawn_Y;
					
				 if (Note_Update[9] && keycode_0 != 8'h0e) begin
					Note_5_2_Y_Pos <= (Note_Y_Step + Note_5_2_Y_Pos);
				 end
				 else
					Note_5_2_Y_Pos <= Spawn_Y;
				 
				 case (keycode_0)
					8'h07 : begin //clear the first note on the first column and move the second note to the first note
								if (!Key_Pressed_0[0]) begin //the key is previously not pressed
									Note_1_1_Y_Pos <= Note_1_2_Y_Pos;
									Note_1_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
									Note_Update[0] <= Note_Update[1];
									Note_Update[1] <= 0;
									Key_Pressed_0[0] <= 1;
								end
							  end
					        
					8'h09 : begin
								if (!Key_Pressed_0[1]) begin //the key is previously not pressed
									Note_2_1_Y_Pos <= Note_2_2_Y_Pos;
									Note_2_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
									Note_Update[2] <= Note_Update[3];
									Note_Update[3] <= 0;
									Key_Pressed_0[1] <= 1;
								end
							  end

							  
					8'h2c : begin
								if (!Key_Pressed_0[2]) begin //the key is previously not pressed
									Note_3_1_Y_Pos <= Note_3_2_Y_Pos;
									Note_3_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
									Note_Update[4] <= Note_Update[5];
									Note_Update[5] <= 0;
									Key_Pressed_0[2] <= 1;
								end
							  end
							  
					8'h0d : begin
								if (!Key_Pressed_0[3]) begin //the key is previously not pressed
									Note_4_1_Y_Pos <= Note_4_2_Y_Pos;
									Note_4_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
									Note_Update[6] <= Note_Update[7];
									Note_Update[7] <= 0;
									Key_Pressed_0[3] <= 1;
								end
							  end	
					8'h0e : begin
								if (!Key_Pressed_0[4]) begin //the key is previously not pressed
									Note_5_1_Y_Pos <= Note_5_2_Y_Pos;
									Note_5_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
									Note_Update[8] <= Note_Update[9];
									Note_Update[9] <= 0;
									Key_Pressed_0[4] <= 1;
								end
							  end		 
					default: begin
									Key_Pressed_0 <= 5'b0;
								end
				 endcase
				 case (keycode_1)
					8'h07 : begin //clear the first note on the first column and move the second note to the first note
								if (!Key_Pressed_1[0]) begin //the key is previously not pressed
									Note_1_1_Y_Pos <= Note_1_2_Y_Pos;
									Note_1_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
									Note_Update[0] <= Note_Update[1];
									Note_Update[1] <= 0;
									Key_Pressed_1[0] <= 1;
								end
							  end
					        
					8'h09 : begin
								if (!Key_Pressed_1[1]) begin //the key is previously not pressed
									Note_2_1_Y_Pos <= Note_2_2_Y_Pos;
									Note_2_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
									Note_Update[2] <= Note_Update[3];
									Note_Update[3] <= 0;
									Key_Pressed_1[1] <= 1;
								end
							  end

							  
					8'h2c : begin
								if (!Key_Pressed_1[2]) begin //the key is previously not pressed
									Note_3_1_Y_Pos <= Note_3_2_Y_Pos;
									Note_3_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
									Note_Update[4] <= Note_Update[5];
									Note_Update[5] <= 0;
									Key_Pressed_1[2] <= 1;
								end
							  end
							  
					8'h0d : begin
								if (!Key_Pressed_1[3]) begin //the key is previously not pressed
									Note_4_1_Y_Pos <= Note_4_2_Y_Pos;
									Note_4_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
									Note_Update[6] <= Note_Update[7];
									Note_Update[7] <= 0;
									Key_Pressed_1[3] <= 1;
								end
							  end	
					8'h0e : begin
								if (!Key_Pressed_1[4]) begin //the key is previously not pressed
									Note_5_1_Y_Pos <= Note_5_2_Y_Pos;
									Note_5_2_Y_Pos <= Spawn_Y; //Need to work on this so that 2 disappears, maybe using inout?
									Note_Update[8] <= Note_Update[9];
									Note_Update[9] <= 0;
									Key_Pressed_1[4] <= 1;
								end
							  end		 
					default: begin
									Key_Pressed_1 <= 5'b0;
								end
				 endcase
				 
			
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
			
		end  
    end
       
    assign Note_1_1_Y = Note_1_1_Y_Pos;
    assign Note_1_2_Y = Note_1_2_Y_Pos;
    assign Note_2_1_Y = Note_2_1_Y_Pos;
    assign Note_2_2_Y = Note_2_2_Y_Pos;
	 assign Note_3_1_Y = Note_3_1_Y_Pos;
    assign Note_3_2_Y = Note_3_2_Y_Pos;
    assign Note_4_1_Y = Note_4_1_Y_Pos;
    assign Note_4_2_Y = Note_4_2_Y_Pos;
    assign Note_5_1_Y = Note_5_1_Y_Pos;
    assign Note_5_2_Y = Note_5_2_Y_Pos;

endmodule
