//---------------------------------------------------------------------- 
// File Name: wheels_pkg.svh
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 

`ifndef AVALON_PKG__SV
`define AVALON_PKG__SV

`include "avalon_if.sv"
`include "uvm_macros.svh"

package avalon_pkg; 

  import uvm_pkg::*;

  typedef virtual avalon_if avalon_vif;

  // typedef class avalon_sequence_base;
  typedef class avalon_agent;

 `include "avalon_sequence_item.sv"
 `include "avalon_config.sv"
//  `include "avalon_coverage.sv"
 `include "avalon_driver.sv"
 `include "avalon_monitor.sv"
 `include "avalon_sequencer.sv"
 `include "avalon_sequence.sv"
 `include "avalon_agent.sv"
endpackage:avalon_pkg

`endif
