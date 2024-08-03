
`ifndef TB_ENV_PKG__SV
`define TB_ENV_PKG__SV

`include "avalon_if.sv"
`include "uvm_macros.svh"

package tb_env_pkg; 
import avalon_pkg::*;
// 
// `include "tb_env_cfg.sv"
// `include "ref_model.sv"
// `include "avalon_agent_scb.sv"
// `include "tb_env_cov.sv"
`include "tb_env.sv"

endpackage:tb_env_pkg

`endif