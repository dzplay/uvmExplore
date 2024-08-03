`ifndef TB_TOP__SV
`define TB_TOP__SV

`include  "avalon_pkg.svh"
`include  "tb_env.sv"

module tb_top;
// program tb_top;

   // pkg
   import uvm_pkg::*;
   import avalon_pkg::*;
   // import tb_env_pkg::*;
   `include  "test_base.sv"


   // instance
   avalon_if  m_vif();
   burst_read_master dut(
      .clk                     (m_vif.clk                    ),// input 
      .reset                   (m_vif.reset                  ),// input 
      .control_fixed_location  (m_vif.control_fixed_location ),// input 
      .control_read_base       (m_vif.control_read_base      ),// input 
      .control_read_length     (m_vif.control_read_length    ),// input 
      .control_go              (m_vif.control_go             ),// input 
      .control_done            (m_vif.control_done           ),// output
      .control_early_done      (m_vif.control_early_done     ),// output
      .user_read_buffer        (m_vif.user_read_buffer       ),// input 
      .user_buffer_data        (m_vif.user_buffer_data       ),// output
      .user_data_available     (m_vif.user_data_available    ),// output
      .master_waitrequest      (m_vif.master_waitrequest     ),// input 
      .master_readdatavalid    (m_vif.master_readdatavalid   ),// input 
      .master_readdata         (m_vif.master_readdata        ),// input 
      .master_address          (m_vif.master_address         ),// output
      .master_read             (m_vif.master_read            ),// output
      .master_byteenable       (m_vif.master_byteenable      ),// output
      .master_burstcount       (m_vif.master_burstcount      ) // output
   );

   // initial
   // begin
   //    // null, "",:-用于在全局配置表.
   //    uvm_config_db#(avalon_if)::set(null, "", "m_vif", m_vif);
   // end

   // run test
   initial
   begin
      $timeformat(-9, 0, "ns", 5);
      run_test();
   end

   // clk
   always #10 m_vif.clk = ~m_vif.clk;

endmodule: tb_top
// endprogram: tb_top

`endif