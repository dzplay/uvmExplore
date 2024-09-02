//---------------------------------------------------------------------- 
// File Name: avalon_if_connection.sv
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 

`ifndef AVALON_IF_CONNECTION__SV
`define AVALON_IF_CONNECTION__SV
//
`define DUT_INST tb_top.dut

`timescale 1ns/1ns

module avalon_if_connection#();
	import uvm_pkg::*;

	avalon_if m_intf(`DUT_INST.clk, `DUT_INST.reset);
    
    // always_comb begin 
    assign  `DUT_INST.control_fixed_location  = m_intf.control_fixed_location ; // input  wire
    assign  `DUT_INST.control_read_base       = m_intf.control_read_base      ; // input 
    assign  `DUT_INST.control_read_length     = m_intf.control_read_length    ; // input 
    assign  `DUT_INST.control_go              = m_intf.control_go             ; // input 

    assign  m_intf.control_done                = `DUT_INST.control_done         ; // output
    assign  m_intf.control_early_done          = `DUT_INST.control_early_done   ; // output

    assign  `DUT_INST.user_read_buffer        = m_intf.user_read_buffer       ; // input 

    assign  m_intf.user_buffer_data            = `DUT_INST.user_buffer_data    ; // output
    assign  m_intf.user_data_available         = `DUT_INST.user_data_available ; // output

    assign  `DUT_INST.master_waitrequest      = m_intf.master_waitrequest     ; // input 
    assign  `DUT_INST.master_readdatavalid    = m_intf.master_readdatavalid   ; // input 
    assign  `DUT_INST.master_readdata         = m_intf.master_readdata        ; // input 

    assign  m_intf.master_address              = `DUT_INST.master_address     ; // output
    assign  m_intf.master_read                 = `DUT_INST.master_read        ; // output
    assign  m_intf.master_byteenable           = `DUT_INST.master_byteenable  ; // output
    assign  m_intf.master_burstcount           = `DUT_INST.master_burstcount  ; // output
    // end

	initial begin
	    uvm_config_db#(virtual  avalon_if)::set(null, "uvm_test_top.env.avalon_agt_i", "vif", m_intf);
	end

endmodule: avalon_if_connection

`endif
