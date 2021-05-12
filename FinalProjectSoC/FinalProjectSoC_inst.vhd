	component FinalProjectSoC is
		port (
			clk_clk                        : in  std_logic                     := 'X';             -- clk
			endgg_export                   : in  std_logic                     := 'X';             -- export
			hex_digits_export              : out std_logic_vector(15 downto 0);                    -- export
			i2c0_sda_in                    : in  std_logic                     := 'X';             -- sda_in
			i2c0_scl_in                    : in  std_logic                     := 'X';             -- scl_in
			i2c0_sda_oe                    : out std_logic;                                        -- sda_oe
			i2c0_scl_oe                    : out std_logic;                                        -- scl_oe
			key_external_connection_export : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			keycode_0_export               : out std_logic_vector(7 downto 0);                     -- export
			keycode_1_export               : out std_logic_vector(7 downto 0);                     -- export
			leds_export                    : out std_logic_vector(13 downto 0);                    -- export
			reset_reset_n                  : in  std_logic                     := 'X';             -- reset_n
			score_export                   : out std_logic_vector(23 downto 0);                    -- export
			spawn_0_export                 : out std_logic_vector(2 downto 0);                     -- export
			spawn_1_export                 : out std_logic_vector(2 downto 0);                     -- export
			spi0_MISO                      : in  std_logic                     := 'X';             -- MISO
			spi0_MOSI                      : out std_logic;                                        -- MOSI
			spi0_SCLK                      : out std_logic;                                        -- SCLK
			spi0_SS_n                      : out std_logic;                                        -- SS_n
			start_export                   : out std_logic;                                        -- export
			usb_gpx_export                 : in  std_logic                     := 'X';             -- export
			usb_irq_export                 : in  std_logic                     := 'X';             -- export
			usb_rst_export                 : out std_logic                                         -- export
		);
	end component FinalProjectSoC;

	u0 : component FinalProjectSoC
		port map (
			clk_clk                        => CONNECTED_TO_clk_clk,                        --                     clk.clk
			endgg_export                   => CONNECTED_TO_endgg_export,                   --                   endgg.export
			hex_digits_export              => CONNECTED_TO_hex_digits_export,              --              hex_digits.export
			i2c0_sda_in                    => CONNECTED_TO_i2c0_sda_in,                    --                    i2c0.sda_in
			i2c0_scl_in                    => CONNECTED_TO_i2c0_scl_in,                    --                        .scl_in
			i2c0_sda_oe                    => CONNECTED_TO_i2c0_sda_oe,                    --                        .sda_oe
			i2c0_scl_oe                    => CONNECTED_TO_i2c0_scl_oe,                    --                        .scl_oe
			key_external_connection_export => CONNECTED_TO_key_external_connection_export, -- key_external_connection.export
			keycode_0_export               => CONNECTED_TO_keycode_0_export,               --               keycode_0.export
			keycode_1_export               => CONNECTED_TO_keycode_1_export,               --               keycode_1.export
			leds_export                    => CONNECTED_TO_leds_export,                    --                    leds.export
			reset_reset_n                  => CONNECTED_TO_reset_reset_n,                  --                   reset.reset_n
			score_export                   => CONNECTED_TO_score_export,                   --                   score.export
			spawn_0_export                 => CONNECTED_TO_spawn_0_export,                 --                 spawn_0.export
			spawn_1_export                 => CONNECTED_TO_spawn_1_export,                 --                 spawn_1.export
			spi0_MISO                      => CONNECTED_TO_spi0_MISO,                      --                    spi0.MISO
			spi0_MOSI                      => CONNECTED_TO_spi0_MOSI,                      --                        .MOSI
			spi0_SCLK                      => CONNECTED_TO_spi0_SCLK,                      --                        .SCLK
			spi0_SS_n                      => CONNECTED_TO_spi0_SS_n,                      --                        .SS_n
			start_export                   => CONNECTED_TO_start_export,                   --                   start.export
			usb_gpx_export                 => CONNECTED_TO_usb_gpx_export,                 --                 usb_gpx.export
			usb_irq_export                 => CONNECTED_TO_usb_irq_export,                 --                 usb_irq.export
			usb_rst_export                 => CONNECTED_TO_usb_rst_export                  --                 usb_rst.export
		);

