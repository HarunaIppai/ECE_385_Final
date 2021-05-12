module Note_Controller (input  logic [9:0]  Note_Update,
							   input  logic [2:0]  Spawn_0,
							   input  logic [2:0]  Spawn_1,
							   output logic [9:0]  Note_ON
);

	always_comb begin
		Note_ON = Note_Update;
		unique case (Spawn_0)
			3'b001 : begin
				if (Note_ON[0])
					Note_ON[1] = 1;
				else
					Note_ON[0] = 1;
			end
			3'b010 : begin
				if (Note_ON[2])
					Note_ON[3] = 1;
				else
					Note_ON[2] = 1;
			end
			3'b011 : begin
				if (Note_ON[4])
					Note_ON[5] = 1;
				else
					Note_ON[4] = 1;
			end
			3'b100 : begin
				if (Note_ON[6])
					Note_ON[7] = 1;
				else
					Note_ON[6] = 1;
			end
			3'b101 : begin
				if (Note_ON[8])
					Note_ON[9] = 1;
				else
					Note_ON[8] = 1;
			end
			default : begin
			end
		endcase
		unique case (Spawn_1)
			3'b001 : begin
				if (Note_ON[0])
					Note_ON[1] = 1;
				else
					Note_ON[0] = 1;
			end
			3'b010 : begin
				if (Note_ON[2])
					Note_ON[3] = 1;
				else
					Note_ON[2] = 1;
			end
			3'b011 : begin
				if (Note_ON[4])
					Note_ON[5] = 1;
				else
					Note_ON[4] = 1;
			end
			3'b100 : begin
				if (Note_ON[6])
					Note_ON[7] = 1;
				else
					Note_ON[6] = 1;
			end
			3'b101 : begin
				if (Note_ON[8])
					Note_ON[9] = 1;
				else
					Note_ON[8] = 1;
			end
			default : begin
			end
		endcase
	end
endmodule
							  