//---------------------------------------------------------------------- 
// File Name: libs_pkg.svh
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 
`ifndef TB_ENV__SV
`define TB_ENV__SV
import uvm_pkg::*;
// import avalon_pkg::*;

// typedef class avalon_agent;
// `include "avalon_sequence_base.sv"
// typedef class avalon_sequence_base;

class tb_env extends uvm_component;

	`uvm_component_utils(tb_env)

	// dut_regmodel regmodel; 
	avalon_agent    avalon_agt_i;
	// uvm_reg_sequence reg_seq_i;

`ifdef EXPLICIT_MON
  	 uvm_reg_predictor#(avalon_sequence_item) avalon2reg_predictor;
`endif

	function new(string name, uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		// if (regmodel == null) begin
		// 	regmodel = dut_regmodel::type_id::create("regmodel",,get_full_name());
		// 	regmodel.build();
		// 	regmodel.lock_model();
			
		avalon_agt_i = avalon_agent::type_id::create("avalon_agt_i", this);
// `ifdef EXPLICIT_MON
// 			avalon2reg_predictor = new("avalon2reg_predictor", this);
// `endif
// 		end
		
// 		begin
// 			string hdl_root = "tb_top.dut";
// 			regmodel.set_hdl_path_root(hdl_root);
// 		end

	endfunction

	virtual function void connect_phase(uvm_phase phase);
		if (avalon_agt_i != null) begin
// 			reg2avalon_adapter reg2avalon = new;
// 			regmodel.default_map.set_sequencer(avalon_agt_i.sqr,reg2avalon);
// `ifdef EXPLICIT_MON
// 			avalon2reg_predictor.map = regmodel.default_map;
// 			avalon2reg_predictor.adapter = reg2avalon;
// 			regmodel.default_map.set_auto_predict(0);
// 			avalon_agt_i.mon.ap.connect(avalon2reg_predictor.bus_in);
// `else
// 			regmodel.default_map.set_auto_predict(1);
// `endif
		end
	endfunction

	virtual task main_phase(uvm_phase phase);
		phase.raise_objection(this);

		// `uvm_info("RESET","Performing reset start", UVM_NONE);
		fork
			main_proc();
			timing_proc();
		join_any

		phase.drop_objection(this);
	endtask

	extern virtual task main_proc();
	extern virtual task timing_proc();

endclass

task tb_env::main_proc();
	avalon_sequence_base avalon_seq;
    avalon_seq = new();
	
	// int wordburstcount = 16;
    // int address;
    // address = 10*wordburstcount; 
	avalon_seq.m_seq_item.randomize();
	`uvm_info(get_type_name(),"start avalon sequence", UVM_NONE);
    avalon_seq.start(avalon_agt_i.sqr);
	`uvm_info(get_type_name(),"end avalon sequence", UVM_NONE);
endtask: main_proc

task tb_env::timing_proc();
	int env_timer = 1000_000_000;
	# env_timer;
	`uvm_info(get_type_name(), $sformatf("get time out during %d ns", env_timer), UVM_NONE)
endtask: timing_proc

`endif