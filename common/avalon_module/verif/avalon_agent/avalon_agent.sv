//---------------------------------------------------------------------- 
// File Name: libs_pkg.svh
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 

`ifndef AVALON_AGENT__SV
`define AVALON_AGENT__SV


// typedef class avalon_agent;


class avalon_agent extends uvm_agent;

   avalon_sequencer sqr;
   avalon_driver    drv;
   avalon_monitor   mon;

   virtual  avalon_if       vif;

   `uvm_component_utils_begin(avalon_agent)
      `uvm_field_object(sqr, UVM_ALL_ON)
      `uvm_field_object(drv, UVM_ALL_ON)
      `uvm_field_object(mon, UVM_ALL_ON)
   `uvm_component_utils_end
   
   function new(string name, uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      sqr = avalon_sequencer::type_id::create("sqr", this);
      drv = avalon_driver::type_id::create("drv", this);
      mon = avalon_monitor::type_id::create("mon", this);
      
      if (!uvm_config_db#(virtual  avalon_if)::get(this, "", "vif", vif)) begin
         `uvm_fatal("AVALON/AGT/NOVIF", "No virtual interface specified for this agent instance")
      end
	   uvm_config_db#(virtual  avalon_if)::set(this, "*", "vif", vif);

   endfunction: build_phase

   virtual function void connect_phase(uvm_phase phase);
      drv.seq_item_port.connect(sqr.seq_item_export);
   endfunction
endclass: avalon_agent

`endif


