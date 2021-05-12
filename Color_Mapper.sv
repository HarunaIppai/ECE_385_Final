//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( 
		input  logic [9:0]  Note_1_1_Y, Note_1_2_Y, 
		input  logic [9:0]  Note_2_1_Y, Note_2_2_Y,
		input  logic [9:0]  Note_3_1_Y, Note_3_2_Y, 
		input  logic [9:0]  Note_4_1_Y, Note_4_2_Y,
		input  logic [9:0]  Note_5_1_Y, Note_5_2_Y,
 		input  logic [9:0]  DrawX, DrawY, Note_ON,
      output logic [7:0]  Red, Green, Blue );
    
    logic note_on;
		
	  
    int DistX_1_1, DistX_1_2;
	 int DistX_2_1, DistX_2_2;
	 int DistX_3_1, DistX_3_2;
	 int DistX_4_1, DistX_4_2;
	 int DistX_5_1, DistX_5_2;
	 int DistY_1_1, DistY_1_2;
	 int DistY_2_1, DistY_2_2;
	 int DistY_3_1, DistY_3_2;
	 int DistY_4_1, DistY_4_2;
	 int DistY_5_1, DistY_5_2;
	 int Sizesq;
	 assign DistX_1_1 = DrawX - 90;
	 assign DistX_2_1 = DrawX - 205;
	 assign DistX_3_1 = DrawX - 320;
	 assign DistX_4_1 = DrawX - 435;
	 assign DistX_5_1 = DrawX - 550;
	 assign DistX_1_2 = DrawX - 90;
	 assign DistX_2_2 = DrawX - 205;
	 assign DistX_3_2 = DrawX - 320;
	 assign DistX_4_2 = DrawX - 435;
	 assign DistX_5_2 = DrawX - 550;
    assign DistY_1_1 = DrawY - Note_1_1_Y;
	 assign DistY_1_2 = DrawY - Note_1_2_Y;
	 assign DistY_2_1 = DrawY - Note_2_1_Y;
	 assign DistY_2_2 = DrawY - Note_2_2_Y;
	 assign DistY_3_1 = DrawY - Note_3_1_Y;
	 assign DistY_3_2 = DrawY - Note_3_2_Y;
	 assign DistY_4_1 = DrawY - Note_4_1_Y;
	 assign DistY_4_2 = DrawY - Note_4_2_Y;
	 assign DistY_5_1 = DrawY - Note_5_1_Y;
	 assign DistY_5_2 = DrawY - Note_5_2_Y;
	 assign Sizesq = 2116;
	  
    always_comb
    begin:Ball_on_proc
			note_on = 1'b0;
			if(Note_ON[0]) begin
				if ((DistX_1_1 * DistX_1_1) <= (Sizesq) && (DistY_1_1 * DistY_1_1) <= (Sizesq)) 
					note_on = 1'b1;
				//else 
					//note_on = 1'b0;
			end
			if(Note_ON[1]) begin
				if ((DistX_1_2 * DistX_1_2) <= (Sizesq) && (DistY_1_2 * DistY_1_2) <= (Sizesq)) 
					note_on = 1'b1;
			end
			if(Note_ON[2]) begin
				if ((DistX_2_1 * DistX_2_1) <= (Sizesq) && (DistY_2_1 * DistY_2_1) <= (Sizesq)) 
					note_on = 1'b1;
			end
			if(Note_ON[3]) begin
				if ((DistX_2_2 * DistX_2_2) <= (Sizesq) && (DistY_2_2 * DistY_2_2) <= (Sizesq)) 
					note_on = 1'b1;
			end
			if(Note_ON[4]) begin
				if ((DistX_3_1 * DistX_3_1) <= (Sizesq) && (DistY_3_1 * DistY_3_1) <= (Sizesq)) 
					note_on = 1'b1;
			end
			if(Note_ON[5]) begin
				if ((DistX_3_2 * DistX_3_2) <= (Sizesq) && (DistY_3_2 * DistY_3_2) <= (Sizesq)) 
					note_on = 1'b1;
			end
			if(Note_ON[6]) begin
				if ((DistX_4_1 * DistX_4_1) <= (Sizesq) && (DistY_4_1 * DistY_4_1) <= (Sizesq)) 
					note_on = 1'b1;
			end
			if(Note_ON[7]) begin
				if ((DistX_4_2 * DistX_4_2) <= (Sizesq) && (DistY_4_2 * DistY_4_2) <= (Sizesq)) 
					note_on = 1'b1;
			end
			if(Note_ON[8]) begin
				if ((DistX_5_1 * DistX_5_1) <= (Sizesq) && (DistY_5_1 * DistY_5_1) <= (Sizesq)) 
					note_on = 1'b1;
			end
			if(Note_ON[9]) begin
				if ((DistX_5_2 * DistX_5_2) <= (Sizesq) && (DistY_5_2 * DistY_5_2) <= (Sizesq)) 
					note_on = 1'b1;
			end
        
     end 
       
    always_comb
    begin:RGB_Display
		  if (DrawX > 44 && DrawX < 136 && DrawY > 308 && DrawY < 400)
		  begin
				if(DrawX > 50 && DrawX < 130 && DrawY > 314 && DrawY <394) begin
					Red = 8'h00;
					Green = 8'h99;
					Blue = 8'h99;
				end
				else begin
					Red = 8'h00;
					Green = 8'hcc;
					Blue = 8'hcc;
				end
		  end
		  else if (DrawX > 159 && DrawX < 251 && DrawY > 308 && DrawY < 400)
		  begin
				if(DrawX > 165 && DrawX < 245 && DrawY > 314 && DrawY <394) begin
					Red = 8'h99;
					Green = 8'h44;
					Blue = 8'h44;
				end
				else begin
					Red = 8'hcc;
					Green = 8'h66;
					Blue = 8'h66;
				end
		  end
		  else if (DrawX > 274 && DrawX < 366 && DrawY > 308 && DrawY < 400)
		  begin
				if(DrawX > 280 && DrawX < 360 && DrawY > 314 && DrawY <394) begin
					Red = 8'h99;
					Green = 8'h99;
					Blue = 8'h00;
				end
				else begin
					Red = 8'hcc;
					Green = 8'hcc;
					Blue = 8'h00;
				end
		  end
		  else if (DrawX > 389 && DrawX < 481 && DrawY > 308 && DrawY < 400)
		  begin
				if(DrawX > 395 && DrawX < 475 && DrawY > 314 && DrawY <394) begin
					Red = 8'h99;
					Green = 8'h00;
					Blue = 8'h99;
				end
				else begin
					Red = 8'hcc;
					Green = 8'h00;
					Blue = 8'hcc;
				end
		  end
		  else if (DrawX > 504 && DrawX < 596 && DrawY > 308 && DrawY < 400)
		  begin
				if(DrawX > 510 && DrawX < 590 && DrawY > 314 && DrawY <394) begin
					Red = 8'h44;
					Green = 8'h99;
					Blue = 8'h44;
				end
				else begin
					Red = 8'h66;
					Green = 8'hcc;
					Blue = 8'h66;
				end
		  end
		  else 
        begin 
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h7f - DrawX[9:3];
        end  
		  if ((note_on == 1'b1)) 
        begin 
            Red = 8'hee;
            Green = 8'h99;
            Blue = 8'h99;
        end
            
    end 
    
endmodule
