module audioController(
	input  logic 			sampleClk,
	input  logic 			Reset,
	input  logic 			LRClk,
	input  logic			AudioEn,
	input  logic [23:0]	DataIn,
	output logic [1:0]	testLED,
	output logic			Read,
	output logic 			DataOut
);
logic [4:0] round_curr;
logic [4:0] round_next;
logic 		add_en;
logic			left_en;
logic			right_en;
logic			left_load;
logic			right_load;
logic			left_data;
logic			right_data;
logic			release_data;
logic			reset_round;

//Adder 	ad(.reset(reset_round), .add_en(add_en), .Data_In(round_curr), .Data_Out(round_next));
Reg_24 	la(.Clk(sampleCLK), .Reset, .Shift_In(0), .Load(left_load), .Shift_En(left_en), .D(DataIn), .Shift_Out(left_data), .Data_Out());
Reg_24 	ra(.Clk(sampleCLK), .Reset, .Shift_In(0), .Load(right_load), .Shift_En(right_en), .D(DataIn), .Shift_Out(right_data), .Data_Out());

	assign testLED = State;

	enum logic [1:0] {
			Stop,
			Wait, //need to match up with LRCLK, MODIFY
			audioLeft,
			audioRight
		} State, Next_state;
	always_ff @ (posedge sampleClk) begin
		if (Reset)
			begin
				State <= Stop;
				round_curr <= 5'b00000;
			end
		else
			begin
				
				if (reset_round)
					round_curr <= 5'b00000;
				else
					round_curr <= round_curr + 1;
				
				State <= Next_state;
			end
	end
	
	always_ff @ (negedge LRClk) begin //L channel activated
		release_data <= 0;
		if (State == Wait)
			release_data <= 1;
	end
	
	always_comb begin
	
	Next_state = State;
	add_en = 0;
	left_en = 0;
	right_en = 0;
	reset_round = 0;
	left_load = LRClk;
	right_load = !LRClk;
	DataOut = 0;
	Read = 0;
	unique case (State)
		Stop:
			if (AudioEn)
				Next_state = Wait;
			else
				Next_state = Stop;
		Wait:
			if (release_data == 1) begin
				Next_state = audioLeft;
				reset_round = 1;
			end
		audioLeft:
			if (LRClk) begin
				Next_state = audioRight;
				reset_round = 1;
			end
			else begin
				Next_state = audioLeft;
			end
		audioRight:
			if (!LRClk) begin
				Next_state = audioLeft;
				reset_round = 1;
			end
			else begin
				Next_state = audioRight;
			end
		default: ;
	endcase
	
	unique case (State)
		Stop:;
		Wait:
			;
		audioLeft: begin
			if (round_curr > 5'b00000 && round_curr <= 5'b11000) begin
				Read = 0;
				left_en = 1;
				DataOut = left_data;
			end
			else if (round_curr > 5'b11000) begin
				Read = 1;
				left_load = 1;
			end
				
		end
		audioRight: begin
			if (round_curr > 5'b00000 && round_curr <= 5'b11000) begin
				Read = 0;
				right_en = 1;
				DataOut = right_data;
			end
			else if (round_curr > 5'b11000) begin
				Read = 1;
				right_load = 1;
			end
		end
	endcase
	end
	//dummy + 24bit + 7bitzero
endmodule
