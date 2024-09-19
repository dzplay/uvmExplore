`ifndef TB_TOP__SV
`define TB_TOP__SV

// `include  "avalon_pkg.svh"
// `include  "tb_env.sv"

module tb_top;
// program tb_top;

   // pkg
   import uvm_pkg::*;
   import avalon_pkg::*;
   // import tb_env_pkg::*;
   `include  "test_base.sv"  // import test_pkg::*;

   bit clk = 0;
   bit rst = 1;

   // instance
   // avalon_if  m_intf(clk, rst);
   burst_read_master dut(
      .clk                     (clk                           ),// input 
      .reset                   (rst                           ) //,// input 
      // .control_fixed_location  (m_intf.control_fixed_location ),// input 
      // .control_read_base       (m_intf.control_read_base      ),// input 
      // .control_read_length     (m_intf.control_read_length    ),// input 
      // .control_go              (m_intf.control_go             ),// input 
      // .control_done            (m_intf.control_done           ),// output
      // .control_early_done      (m_intf.control_early_done     ),// output
      // .user_read_buffer        (m_intf.user_read_buffer       ),// input 
      // .user_buffer_data        (m_intf.user_buffer_data       ),// output
      // .user_data_available     (m_intf.user_data_available    ),// output
      // .master_waitrequest      (m_intf.master_waitrequest     ),// input 
      // .master_readdatavalid    (m_intf.master_readdatavalid   ),// input 
      // .master_readdata         (m_intf.master_readdata        ),// input 
      // .master_address          (m_intf.master_address         ),// output
      // .master_read             (m_intf.master_read            ),// output
      // .master_byteenable       (m_intf.master_byteenable      ),// output
      // .master_burstcount       (m_intf.master_burstcount      ) // output
   );

   // // inf & reset
   // initial
   // begin
   //    // null, "",:-用于在全局配置表.
   //    uvm_config_db#(virtual  avalon_if)::set(null, "*", "vif", m_intf);
   //    #100 rst = 0;
   // end
   avalon_if_connection avalon_if_connection_i();  // replace to iff

   // run test
   initial
   begin
      $timeformat(-9, 0, "ns", 5);
      run_test();
   end

   // clk & rst
   // always #10 force clk = ~clk; // 不会起作用到dut.clk, need find out
   // always #10ns force dut.clk = ~dut.clk;
   always #10 clk = ~clk; // 不会起作用到dut.clk, need find out

   initial
   begin
      #100ns rst = 0;
   end


endmodule: tb_top
// endprogram: tb_top

`endif