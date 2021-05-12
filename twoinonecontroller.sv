module twoinonecontroller(
		input  logic 			MAX10_CLK1_50,
		input  logic 			MAX10_CLK2_50,
		input	 logic			Reset,
		input  logic 			PixelClk,
		input  logic 			AudioClk,
		input  logic			LRClk,
		input  logic			Play,
		output logic [7:0]	CPRed,
		output logic [7:0]	CPGreen,
		output logic [7:0]	CPBlue,
		output logic 			I2SOut,
		//////////// SDRAM //////////
		output		 [12:0]	DRAM_ADDR,
		output		 [ 1:0]	DRAM_BA,
		output		      	DRAM_CAS_N,
		output		      	DRAM_CKE,
		output		      	DRAM_CLK,
		output		      	DRAM_CS_N,
		inout 		 [15:0]	DRAM_DQ,
		output		      	DRAM_LDQM,
		output		      	DRAM_RAS_N,
		output		      	DRAM_UDQM,
		output		      	DRAM_WE_N
);

	logic [15:0]	DataFeed; 	//Supplying two time interval data, the first 16 bit is going to be read by the audio controller
										//And the last 16 bit will be used by SDRAM to read the data
	logic [15:0]	DataFeed_Buffer;
										
	logic 			Read;
	logic				Read_Done;
	logic				Read_Counting;
	logic	[4:0]		Read_Track;
	logic 			Read_Reset;
	logic				Begin;
	
	always_ff @(posedge Play or posedge Reset) begin
		if(Reset)
			Begin <= 0;
		else
			Begin <= 1;
	end
	
	logic	[2:0]		LocalAddressKeeping;
	logic [21:0]	GlobalAddressKeeping;

	always_ff @(posedge AudioClk or posedge Reset) begin
		if (Reset) begin
			Read_Track <= 5'b0;
		end
		else begin
			Read_Track <= Read_Track+1;
			if (Read_Track == 5'b1)
				Read_Counting <= 1;
		end
	end
	
	audioController audio(.sampleClk(AudioClk), .Reset, .LRClk, .AudioEn(Play), .DataIn({DataFeed, 8'h0}), .Read, .DataOut(I2SOut));//, .testLED(LEDR[1:0]));
	
	//SDRAM_CTRL sdramctrlr(.readData(DataFeed_Buffer), .Reset, .Read, .*);
	sdram_controller_test sb(.*, .read_command(Read), .read_finished(Read_Done), .odata(DataFeed), .address({GlobalAddressKeeping, LocalAddressKeeping})); //0_0000010100001_0110100
	
	//HexDriver h1(.In0(GlobalAddressKeeping[3:0]),.Out0(HEX0));
	//HexDriver h2(.In0(GlobalAddressKeeping[7:4]),.Out0(HEX1));
	//HexDriver h3(.In0(GlobalAddressKeeping[11:8]),.Out0(HEX2));
	//HexDriver h4(.In0(GlobalAddressKeeping[15:12]),.Out0(HEX3));
	//HexDriver h5(.In0(GlobalAddressKeeping[19:16]),.Out0(HEX4));
	
	//assign LEDR[2:0] = LocalAddressKeeping;
	//assign LEDR[9] = Play;
	//assign LEDR[8] = I2SOut;
	//assign LEDR[7] = LRClk;
	//assign LEDR[6] = AudioClk;
	//assign LEDR[5] = Read;
	//assign LEDR[4] = Read_Done;
	
	always_ff @(LRClk) begin //when reading is finished
		if (Reset) begin
			LocalAddressKeeping <= 3'b0;
			GlobalAddressKeeping <= 3'b0;
			Read_Reset <= 0;
		end 
		else if (Begin) begin
			if (LocalAddressKeeping == 3'b111)
				LocalAddressKeeping <= 3'b000;
			else if (LocalAddressKeeping == 3'b000) begin
				LocalAddressKeeping <= LocalAddressKeeping + 1;
				GlobalAddressKeeping <= GlobalAddressKeeping + 1;
			end 
			else
				LocalAddressKeeping <= LocalAddressKeeping + 1;
		end
	end
	
	assign CPRed = 8'h77;
	assign CPGreen = 8'h77;
	assign CPBlue = 8'hff;
	
endmodule
