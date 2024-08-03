//---------------------------------------------------------------------- 
// File Name: wheels_pkg.svh
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 

`ifndef AVALON_SEQ_BASE__SV
`define AVALON_SEQ_BASE__SV
`include "avalon_pkg.svh"


class avalon_sequence_base extends uvm_sequence #(avalon_sequence_item);

	avalon_sequence_item   m_seq_item; 
	function new(string name="avalon_sequence_base");
		super.new(name);
		m_seq_item = new();
	endfunction

	virtual task body();
		// if (starting_phase!=null) begin
		// `uvm_info(get_type_name(),
		// 	$sformatf("%s post_body() dropping %s objection", 
		// 		get_sequence_path(),
		// 		starting_phase.get_name()), UVM_MEDIUM);
		// starting_phase.drop_objection(this);
		// end
		int seq_timer = 200;
    	`uvm_info(get_type_name(), $sformatf("avalon_sequence_base starting ..."), UVM_LOW);
		if (m_seq_item!=null) begin
			m_seq_item = new();
			m_seq_item.randomize();
		end
		`uvm_send(m_seq_item);
		# seq_timer;
	endtask

endclass : avalon_sequence_base

`endif

