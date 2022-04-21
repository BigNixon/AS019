	component nios_qsys is
		port (
			clk_clk                                              : in    std_logic                     := 'X';             -- clk
			led_pio_export                                       : out   std_logic_vector(7 downto 0);                     -- export
			light_i2c_opencores_export_scl_pad_io                : inout std_logic                     := 'X';             -- scl_pad_io
			light_i2c_opencores_export_sda_pad_io                : inout std_logic                     := 'X';             -- sda_pad_io
			light_int_external_connection_export                 : in    std_logic                     := 'X';             -- export
			mm_bridge_for_hps_s0_waitrequest                     : out   std_logic;                                        -- waitrequest
			mm_bridge_for_hps_s0_readdata                        : out   std_logic_vector(31 downto 0);                    -- readdata
			mm_bridge_for_hps_s0_readdatavalid                   : out   std_logic;                                        -- readdatavalid
			mm_bridge_for_hps_s0_burstcount                      : in    std_logic_vector(0 downto 0)  := (others => 'X'); -- burstcount
			mm_bridge_for_hps_s0_writedata                       : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			mm_bridge_for_hps_s0_address                         : in    std_logic_vector(18 downto 0) := (others => 'X'); -- address
			mm_bridge_for_hps_s0_write                           : in    std_logic                     := 'X';             -- write
			mm_bridge_for_hps_s0_read                            : in    std_logic                     := 'X';             -- read
			mm_bridge_for_hps_s0_byteenable                      : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			mm_bridge_for_hps_s0_debugaccess                     : in    std_logic                     := 'X';             -- debugaccess
			mpu_i2c_opencores_export_scl_pad_io                  : inout std_logic                     := 'X';             -- scl_pad_io
			mpu_i2c_opencores_export_sda_pad_io                  : inout std_logic                     := 'X';             -- sda_pad_io
			mpu_int_external_connection_export                   : in    std_logic                     := 'X';             -- export
			nios2_gen2_cpu_resetrequest_conduit_cpu_resetrequest : in    std_logic                     := 'X';             -- cpu_resetrequest
			nios2_gen2_cpu_resetrequest_conduit_cpu_resettaken   : out   std_logic;                                        -- cpu_resettaken
			pio_0_external_connection_export                     : out   std_logic;                                        -- export
			reset_reset_n                                        : in    std_logic                     := 'X';             -- reset_n
			rh_temp_drdy_n_external_connection_export            : in    std_logic                     := 'X';             -- export
			rh_temp_i2c_opencores_export_scl_pad_io              : inout std_logic                     := 'X';             -- scl_pad_io
			rh_temp_i2c_opencores_export_sda_pad_io              : inout std_logic                     := 'X';             -- sda_pad_io
			wifi_reset_pio_external_connection_export            : out   std_logic;                                        -- export
			wifi_uart0_external_connection_rxd                   : in    std_logic                     := 'X';             -- rxd
			wifi_uart0_external_connection_txd                   : out   std_logic;                                        -- txd
			wifi_uart0_external_connection_cts_n                 : in    std_logic                     := 'X';             -- cts_n
			wifi_uart0_external_connection_rts_n                 : out   std_logic;                                        -- rts_n
			pid_top_0_conduit_end_1_readdata                     : out   std_logic_vector(31 downto 0)                     -- readdata
		);
	end component nios_qsys;

	u0 : component nios_qsys
		port map (
			clk_clk                                              => CONNECTED_TO_clk_clk,                                              --                                 clk.clk
			led_pio_export                                       => CONNECTED_TO_led_pio_export,                                       --                             led_pio.export
			light_i2c_opencores_export_scl_pad_io                => CONNECTED_TO_light_i2c_opencores_export_scl_pad_io,                --          light_i2c_opencores_export.scl_pad_io
			light_i2c_opencores_export_sda_pad_io                => CONNECTED_TO_light_i2c_opencores_export_sda_pad_io,                --                                    .sda_pad_io
			light_int_external_connection_export                 => CONNECTED_TO_light_int_external_connection_export,                 --       light_int_external_connection.export
			mm_bridge_for_hps_s0_waitrequest                     => CONNECTED_TO_mm_bridge_for_hps_s0_waitrequest,                     --                mm_bridge_for_hps_s0.waitrequest
			mm_bridge_for_hps_s0_readdata                        => CONNECTED_TO_mm_bridge_for_hps_s0_readdata,                        --                                    .readdata
			mm_bridge_for_hps_s0_readdatavalid                   => CONNECTED_TO_mm_bridge_for_hps_s0_readdatavalid,                   --                                    .readdatavalid
			mm_bridge_for_hps_s0_burstcount                      => CONNECTED_TO_mm_bridge_for_hps_s0_burstcount,                      --                                    .burstcount
			mm_bridge_for_hps_s0_writedata                       => CONNECTED_TO_mm_bridge_for_hps_s0_writedata,                       --                                    .writedata
			mm_bridge_for_hps_s0_address                         => CONNECTED_TO_mm_bridge_for_hps_s0_address,                         --                                    .address
			mm_bridge_for_hps_s0_write                           => CONNECTED_TO_mm_bridge_for_hps_s0_write,                           --                                    .write
			mm_bridge_for_hps_s0_read                            => CONNECTED_TO_mm_bridge_for_hps_s0_read,                            --                                    .read
			mm_bridge_for_hps_s0_byteenable                      => CONNECTED_TO_mm_bridge_for_hps_s0_byteenable,                      --                                    .byteenable
			mm_bridge_for_hps_s0_debugaccess                     => CONNECTED_TO_mm_bridge_for_hps_s0_debugaccess,                     --                                    .debugaccess
			mpu_i2c_opencores_export_scl_pad_io                  => CONNECTED_TO_mpu_i2c_opencores_export_scl_pad_io,                  --            mpu_i2c_opencores_export.scl_pad_io
			mpu_i2c_opencores_export_sda_pad_io                  => CONNECTED_TO_mpu_i2c_opencores_export_sda_pad_io,                  --                                    .sda_pad_io
			mpu_int_external_connection_export                   => CONNECTED_TO_mpu_int_external_connection_export,                   --         mpu_int_external_connection.export
			nios2_gen2_cpu_resetrequest_conduit_cpu_resetrequest => CONNECTED_TO_nios2_gen2_cpu_resetrequest_conduit_cpu_resetrequest, -- nios2_gen2_cpu_resetrequest_conduit.cpu_resetrequest
			nios2_gen2_cpu_resetrequest_conduit_cpu_resettaken   => CONNECTED_TO_nios2_gen2_cpu_resetrequest_conduit_cpu_resettaken,   --                                    .cpu_resettaken
			pio_0_external_connection_export                     => CONNECTED_TO_pio_0_external_connection_export,                     --           pio_0_external_connection.export
			reset_reset_n                                        => CONNECTED_TO_reset_reset_n,                                        --                               reset.reset_n
			rh_temp_drdy_n_external_connection_export            => CONNECTED_TO_rh_temp_drdy_n_external_connection_export,            --  rh_temp_drdy_n_external_connection.export
			rh_temp_i2c_opencores_export_scl_pad_io              => CONNECTED_TO_rh_temp_i2c_opencores_export_scl_pad_io,              --        rh_temp_i2c_opencores_export.scl_pad_io
			rh_temp_i2c_opencores_export_sda_pad_io              => CONNECTED_TO_rh_temp_i2c_opencores_export_sda_pad_io,              --                                    .sda_pad_io
			wifi_reset_pio_external_connection_export            => CONNECTED_TO_wifi_reset_pio_external_connection_export,            --  wifi_reset_pio_external_connection.export
			wifi_uart0_external_connection_rxd                   => CONNECTED_TO_wifi_uart0_external_connection_rxd,                   --      wifi_uart0_external_connection.rxd
			wifi_uart0_external_connection_txd                   => CONNECTED_TO_wifi_uart0_external_connection_txd,                   --                                    .txd
			wifi_uart0_external_connection_cts_n                 => CONNECTED_TO_wifi_uart0_external_connection_cts_n,                 --                                    .cts_n
			wifi_uart0_external_connection_rts_n                 => CONNECTED_TO_wifi_uart0_external_connection_rts_n,                 --                                    .rts_n
			pid_top_0_conduit_end_1_readdata                     => CONNECTED_TO_pid_top_0_conduit_end_1_readdata                      --             pid_top_0_conduit_end_1.readdata
		);

