
module nios_qsys (
	clk_clk,
	led_pio_export,
	light_i2c_opencores_export_scl_pad_io,
	light_i2c_opencores_export_sda_pad_io,
	light_int_external_connection_export,
	mm_bridge_for_hps_s0_waitrequest,
	mm_bridge_for_hps_s0_readdata,
	mm_bridge_for_hps_s0_readdatavalid,
	mm_bridge_for_hps_s0_burstcount,
	mm_bridge_for_hps_s0_writedata,
	mm_bridge_for_hps_s0_address,
	mm_bridge_for_hps_s0_write,
	mm_bridge_for_hps_s0_read,
	mm_bridge_for_hps_s0_byteenable,
	mm_bridge_for_hps_s0_debugaccess,
	mpu_i2c_opencores_export_scl_pad_io,
	mpu_i2c_opencores_export_sda_pad_io,
	mpu_int_external_connection_export,
	nios2_gen2_cpu_resetrequest_conduit_cpu_resetrequest,
	nios2_gen2_cpu_resetrequest_conduit_cpu_resettaken,
	pio_0_external_connection_export,
	reset_reset_n,
	rh_temp_drdy_n_external_connection_export,
	rh_temp_i2c_opencores_export_scl_pad_io,
	rh_temp_i2c_opencores_export_sda_pad_io,
	wifi_reset_pio_external_connection_export,
	wifi_uart0_external_connection_rxd,
	wifi_uart0_external_connection_txd,
	wifi_uart0_external_connection_cts_n,
	wifi_uart0_external_connection_rts_n,
	pid_top_0_conduit_end_1_readdata);	

	input		clk_clk;
	output	[7:0]	led_pio_export;
	inout		light_i2c_opencores_export_scl_pad_io;
	inout		light_i2c_opencores_export_sda_pad_io;
	input		light_int_external_connection_export;
	output		mm_bridge_for_hps_s0_waitrequest;
	output	[31:0]	mm_bridge_for_hps_s0_readdata;
	output		mm_bridge_for_hps_s0_readdatavalid;
	input	[0:0]	mm_bridge_for_hps_s0_burstcount;
	input	[31:0]	mm_bridge_for_hps_s0_writedata;
	input	[18:0]	mm_bridge_for_hps_s0_address;
	input		mm_bridge_for_hps_s0_write;
	input		mm_bridge_for_hps_s0_read;
	input	[3:0]	mm_bridge_for_hps_s0_byteenable;
	input		mm_bridge_for_hps_s0_debugaccess;
	inout		mpu_i2c_opencores_export_scl_pad_io;
	inout		mpu_i2c_opencores_export_sda_pad_io;
	input		mpu_int_external_connection_export;
	input		nios2_gen2_cpu_resetrequest_conduit_cpu_resetrequest;
	output		nios2_gen2_cpu_resetrequest_conduit_cpu_resettaken;
	output		pio_0_external_connection_export;
	input		reset_reset_n;
	input		rh_temp_drdy_n_external_connection_export;
	inout		rh_temp_i2c_opencores_export_scl_pad_io;
	inout		rh_temp_i2c_opencores_export_sda_pad_io;
	output		wifi_reset_pio_external_connection_export;
	input		wifi_uart0_external_connection_rxd;
	output		wifi_uart0_external_connection_txd;
	input		wifi_uart0_external_connection_cts_n;
	output		wifi_uart0_external_connection_rts_n;
	output	[31:0]	pid_top_0_conduit_end_1_readdata;
endmodule
