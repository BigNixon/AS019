	nios_qsys u0 (
		.clk_clk                                              (<connected-to-clk_clk>),                                              //                                 clk.clk
		.led_pio_export                                       (<connected-to-led_pio_export>),                                       //                             led_pio.export
		.light_i2c_opencores_export_scl_pad_io                (<connected-to-light_i2c_opencores_export_scl_pad_io>),                //          light_i2c_opencores_export.scl_pad_io
		.light_i2c_opencores_export_sda_pad_io                (<connected-to-light_i2c_opencores_export_sda_pad_io>),                //                                    .sda_pad_io
		.light_int_external_connection_export                 (<connected-to-light_int_external_connection_export>),                 //       light_int_external_connection.export
		.mm_bridge_for_hps_s0_waitrequest                     (<connected-to-mm_bridge_for_hps_s0_waitrequest>),                     //                mm_bridge_for_hps_s0.waitrequest
		.mm_bridge_for_hps_s0_readdata                        (<connected-to-mm_bridge_for_hps_s0_readdata>),                        //                                    .readdata
		.mm_bridge_for_hps_s0_readdatavalid                   (<connected-to-mm_bridge_for_hps_s0_readdatavalid>),                   //                                    .readdatavalid
		.mm_bridge_for_hps_s0_burstcount                      (<connected-to-mm_bridge_for_hps_s0_burstcount>),                      //                                    .burstcount
		.mm_bridge_for_hps_s0_writedata                       (<connected-to-mm_bridge_for_hps_s0_writedata>),                       //                                    .writedata
		.mm_bridge_for_hps_s0_address                         (<connected-to-mm_bridge_for_hps_s0_address>),                         //                                    .address
		.mm_bridge_for_hps_s0_write                           (<connected-to-mm_bridge_for_hps_s0_write>),                           //                                    .write
		.mm_bridge_for_hps_s0_read                            (<connected-to-mm_bridge_for_hps_s0_read>),                            //                                    .read
		.mm_bridge_for_hps_s0_byteenable                      (<connected-to-mm_bridge_for_hps_s0_byteenable>),                      //                                    .byteenable
		.mm_bridge_for_hps_s0_debugaccess                     (<connected-to-mm_bridge_for_hps_s0_debugaccess>),                     //                                    .debugaccess
		.mpu_i2c_opencores_export_scl_pad_io                  (<connected-to-mpu_i2c_opencores_export_scl_pad_io>),                  //            mpu_i2c_opencores_export.scl_pad_io
		.mpu_i2c_opencores_export_sda_pad_io                  (<connected-to-mpu_i2c_opencores_export_sda_pad_io>),                  //                                    .sda_pad_io
		.mpu_int_external_connection_export                   (<connected-to-mpu_int_external_connection_export>),                   //         mpu_int_external_connection.export
		.nios2_gen2_cpu_resetrequest_conduit_cpu_resetrequest (<connected-to-nios2_gen2_cpu_resetrequest_conduit_cpu_resetrequest>), // nios2_gen2_cpu_resetrequest_conduit.cpu_resetrequest
		.nios2_gen2_cpu_resetrequest_conduit_cpu_resettaken   (<connected-to-nios2_gen2_cpu_resetrequest_conduit_cpu_resettaken>),   //                                    .cpu_resettaken
		.pio_0_external_connection_export                     (<connected-to-pio_0_external_connection_export>),                     //           pio_0_external_connection.export
		.reset_reset_n                                        (<connected-to-reset_reset_n>),                                        //                               reset.reset_n
		.rh_temp_drdy_n_external_connection_export            (<connected-to-rh_temp_drdy_n_external_connection_export>),            //  rh_temp_drdy_n_external_connection.export
		.rh_temp_i2c_opencores_export_scl_pad_io              (<connected-to-rh_temp_i2c_opencores_export_scl_pad_io>),              //        rh_temp_i2c_opencores_export.scl_pad_io
		.rh_temp_i2c_opencores_export_sda_pad_io              (<connected-to-rh_temp_i2c_opencores_export_sda_pad_io>),              //                                    .sda_pad_io
		.wifi_reset_pio_external_connection_export            (<connected-to-wifi_reset_pio_external_connection_export>),            //  wifi_reset_pio_external_connection.export
		.wifi_uart0_external_connection_rxd                   (<connected-to-wifi_uart0_external_connection_rxd>),                   //      wifi_uart0_external_connection.rxd
		.wifi_uart0_external_connection_txd                   (<connected-to-wifi_uart0_external_connection_txd>),                   //                                    .txd
		.wifi_uart0_external_connection_cts_n                 (<connected-to-wifi_uart0_external_connection_cts_n>),                 //                                    .cts_n
		.wifi_uart0_external_connection_rts_n                 (<connected-to-wifi_uart0_external_connection_rts_n>),                 //                                    .rts_n
		.pid_top_0_conduit_end_1_readdata                     (<connected-to-pid_top_0_conduit_end_1_readdata>)                      //             pid_top_0_conduit_end_1.readdata
	);

