module SDRAMTester(

		///////// Clocks /////////
      input     MAX10_CLK1_50, 
		input     MAX10_CLK2_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 
		
);

	logic [15:0] data;
	logic			 read_sgn;
	assign		 read_sgn = ~{KEY[1]};
	logic	[24:0] address;
	logic 		 Reset;
	
	assign Reset = ~{KEY[0]};
	
	always_ff @(posedge read_sgn) begin
		address <= address + 1;
	end
	
	assign LEDR = address[9:0];
	
	sdram_controller_test sb(.*, .read_command(read_sgn), .read_finished(), .odata(data), .address(address)); //0_0000010100001_0110100
	
	HexDriver h0(.In0(data[3:0]), .Out0(HEX0[6:0]));
	HexDriver h1(.In0(data[7:4]), .Out0(HEX1[6:0]));
	HexDriver h2(.In0(data[11:8]), .Out0(HEX2[6:0]));
	HexDriver h3(.In0(data[15:12]), .Out0(HEX3[6:0]));
	//HexDriver h4(.In0(data[123:120]), .Out0(HEX4[6:0]));
	//HexDriver h5(.In0(data[127:124]), .Out0(HEX5[6:0]));
	//assign LEDR[9:6] = DataFeed_Buffer[27:24];
	//SDRAM_CTRL sdramctrlr(.readData(DataFeed_Buffer), .Reset, .Read, .*,.Addr(26'h5D7ED0));

endmodule 