
module FinalProjectSoC (
	clk_clk,
	endgg_export,
	hex_digits_export,
	i2c0_sda_in,
	i2c0_scl_in,
	i2c0_sda_oe,
	i2c0_scl_oe,
	key_external_connection_export,
	keycode_0_export,
	keycode_1_export,
	leds_export,
	reset_reset_n,
	score_export,
	spawn_0_export,
	spawn_1_export,
	spi0_MISO,
	spi0_MOSI,
	spi0_SCLK,
	spi0_SS_n,
	start_export,
	usb_gpx_export,
	usb_irq_export,
	usb_rst_export);	

	input		clk_clk;
	input		endgg_export;
	output	[15:0]	hex_digits_export;
	input		i2c0_sda_in;
	input		i2c0_scl_in;
	output		i2c0_sda_oe;
	output		i2c0_scl_oe;
	input	[1:0]	key_external_connection_export;
	output	[7:0]	keycode_0_export;
	output	[7:0]	keycode_1_export;
	output	[13:0]	leds_export;
	input		reset_reset_n;
	output	[23:0]	score_export;
	output	[2:0]	spawn_0_export;
	output	[2:0]	spawn_1_export;
	input		spi0_MISO;
	output		spi0_MOSI;
	output		spi0_SCLK;
	output		spi0_SS_n;
	output		start_export;
	input		usb_gpx_export;
	input		usb_irq_export;
	output		usb_rst_export;
endmodule
