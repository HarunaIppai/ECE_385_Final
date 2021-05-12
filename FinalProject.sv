//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module FinalProject (

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


	twoinonecontroller imac(.*, .Reset(Reset_h), .PixelClk(VGA_Clk), .AudioClk(ARDUINO_IO[5]), .LRClk(ARDUINO_IO[4]), .Play(~{KEY[1]}), .CPRed(), .CPGreen(), .CPBlue(), .I2SOut(ARDUINO_IO[2]));

	logic Reset_h, vssig, blank, sync, VGA_Clk;
	logic [35:0]  clockspeedcalculator;
	assign LEDR = current_stamina;
	
	//always_ff @(ARDUINO_IO[5]) begin
	//	clockspeedcalculator <= clockspeedcalculator + 1;
	//end
	//
	//logic [23:0] value;
	//
	//assign value = clockspeedcalculator[35:12];
	
	HexDriver h0(.In0(current_score[3:0]), .Out0(HEX0));
	HexDriver h1(.In0(current_score[7:4]), .Out0(HEX1));
	HexDriver h2(.In0(current_score[11:8]), .Out0(HEX2));
	HexDriver h3(.In0(current_score[15:12]), .Out0(HEX3));
	HexDriver h4(.In0(current_score[19:16]), .Out0(HEX4));
	HexDriver h5(.In0(current_score[23:20]), .Out0(HEX5));
	
//=======================================================
//  I2S declarations
//	 I2S Pins
//	 SCLK: D5
//	 LRCLK: D4
//	 MCLK: D3
//	 DIN: D2
//	 DOUT: D1
//=======================================================	
	logic [1:0] aud_mclk_ctr;
	//assign LEDR[0] = ~{KEY[1]};
	assign ARDUINO_IO[3] = aud_mclk_ctr[1];
	assign ARDUINO_IO[4] = 1'bz;
	assign ARDUINO_IO[5] = 1'bz;
	//Test the I2S Working Condition
	//assign ARDUINO_IO[1] = 1'bz;
	//assign ARDUINO_IO[2] = ARDUINO_IO[1];
	
	always_ff @(posedge MAX10_CLK1_50) begin
		aud_mclk_ctr <= aud_mclk_ctr + 1;
	end
//=======================================================
//  I2C declarations
//=======================================================
	logic i2c0_sda_in, i2c0_scl_in, i2c0_sda_oe, i2c0_scl_oe;
	assign i2c0_sda_in = ARDUINO_IO[14];
	assign i2c0_scl_in = ARDUINO_IO[15];
	assign ARDUINO_IO[14] = i2c0_sda_oe ? 1'b0 : 1'bz;
	assign ARDUINO_IO[15] = i2c0_scl_oe ? 1'b0 : 1'bz;
//=======================================================
//  Display Module declarations
//=======================================================
	logic [9:0] Note_Update;
	logic [9:0] Note_1_1_Y, Note_1_2_Y;
	logic [9:0] Note_2_1_Y, Note_2_2_Y;
	logic [9:0] Note_3_1_Y, Note_3_2_Y;
	logic [9:0] Note_4_1_Y, Note_4_2_Y;
	logic [9:0] Note_5_1_Y, Note_5_2_Y;
	//logic			Update_Clk;
	//logic [7:0] CPRed, CPGreen, CPBlue;
	vga_controller vga_ctrlr(.Clk(MAX10_CLK1_50), .Reset(Reset_h), .hs(VGA_HS), .vs(VGA_VS), .pixel_clk(VGA_Clk), .blank, .sync, .DrawX(drawxsig), .DrawY(drawysig));
	color_mapper clr_mpr(.Note_ON(Note_Update), .DrawX(drawxsig), .DrawY(drawysig), .Red, .Green, .Blue, .Note_1_1_Y, .Note_1_2_Y, .Note_2_1_Y, .Note_2_2_Y, .Note_3_1_Y, .Note_3_2_Y, .Note_4_1_Y, .Note_4_2_Y, .Note_5_1_Y, .Note_5_2_Y);
	note n(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode_0(keycode_0_export), .keycode_1(keycode_1_export), .Note_Update, .Note_1_1_Y, .Note_1_2_Y, .Note_2_1_Y, .Note_2_2_Y, .Note_3_1_Y, .Note_3_2_Y, .Note_4_1_Y, .Note_4_2_Y, .Note_5_1_Y, .Note_5_2_Y, .Spawn_0(spawn_0_export), .Spawn_1(spawn_1_export), .Stamina(current_stamina));
	//Note_Controller nc(.Spawn_0(spawn_0_export), .Spawn_1(spawn_1_export), .Note_ON, .Note_Update);
//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode_0_export, keycode_1_export;
	logic [2:0] spawn_0_export, spawn_1_export;
	logic [23:0] current_score;
	logic [9:0]	current_stamina;
	logic			end_var;
	assign		end_var = (current_stamina == 10'b1 ? 1 : 0);
	//assign keycode = SW[7:0];
	//assign spawn_0_export = 3'b010;
	//assign spawn_1_export = 3'b100;
//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	
	//assign LEDR = Note_Update;
	//HEX drivers to convert numbers to HEX output
	//HexDriver hex_driver4 (hex_num_4, HEX4[6:0]);
	//assign HEX4[7] = 1'b1;
	
	//HexDriver hex_driver3 (hex_num_3, HEX3[6:0]);
	//assign HEX3[7] = 1'b1;
	
	//HexDriver hex_driver1 (hex_num_1, HEX1[6:0]);
	//assign HEX1[7] = 1'b1;
	
	//HexDriver hex_driver0 (hex_num_0, HEX0[6:0]);
	//assign HEX0[7] = 1'b1;
	
	//fill in the hundreds digit as well as the negative sign
	//assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
	//assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
	
	
	//Assign one button to reset
	assign {Reset_h}= (!(KEY[0]) | end_var);

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[7:4];
	assign VGA_B = Blue[7:4];
	assign VGA_G = Green[7:4];
	
	//assign LEDR[9:4] = {spawn_0_export, spawn_1_export};
	
	
	FinalProjectSoC u0 (
		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		//.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		//.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		//.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		//.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		//.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		//.sdram_wire_ba(DRAM_BA),                             //.ba
		//.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		//.sdram_wire_cke(DRAM_CKE),                           //.cke
		//.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		//.sdram_wire_dq(DRAM_DQ),                             //.dq
		//.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		//.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		//.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		
		
		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_export(),
		.keycode_0_export,
		.keycode_1_export,
		.spawn_0_export,
		.spawn_1_export,
		.start_export(),
		.score_export(current_score),
		.endgg_export(end_var),
		
		//I2C
		.i2c0_sda_in,
		.i2c0_sda_oe,
		.i2c0_scl_in,
		.i2c0_scl_oe
		
	 );


//instantiate a vga_controller, ball, and color_mapper here with the ports.


endmodule
