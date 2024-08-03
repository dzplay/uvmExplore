//---------------------------------------------------------------------- 
// File Name: wheels_pkg.svh
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 


`ifndef AVALON_MONITOR__SV
`define AVALON_MONITOR__SV


typedef class avalon_monitor;

class avalon_monitor_cbs extends uvm_callback;
  virtual function void trans_observed(avalon_monitor xactor,avalon_sequence_item cycle);
  endfunction:trans_observed
endclass: avalon_monitor_cbs


class avalon_monitor extends uvm_monitor;
   virtual avalon_if.passive vif;

   uvm_analysis_port#(avalon_sequence_item) ap;
   avalon_config m_cfg_h;

   `uvm_component_utils(avalon_monitor)

   function new(string name, uvm_component parent = null);
      super.new(name, parent);
      ap = new("ap", this);
   endfunction: new

   virtual function void build_phase(uvm_phase phase);
      avalon_agent agent;
      if ($cast(agent, get_parent()) && agent != null) begin
         vif = agent.vif;
      end
      else begin
         virtual avalon_if tmp;
         if (!uvm_config_db#(virtual  avalon_if)::get(this, "", "vif", tmp)) begin
            `uvm_fatal("AVALON/MON/NOVIF", "No virtual interface specified for this monitor instance")
         end
         vif = tmp;
      end
   endfunction

   virtual protected task run_phase(uvm_phase phase);
      super.run_phase(phase);
      // forever begin
      //    avalon_sequence_item tr;
         
      //    // Wait for a SETUP cycle
      //    do begin
      //       @ (this.vif.pck);
      //    end
      //    while (this.vif.pck.psel !== 1'b1 ||
      //           this.vif.pck.penable !== 1'b0);

      //    tr = avalon_sequence_item::type_id::create("tr", this);
         
      //    tr.kind = (this.vif.pck.pwrite) ? avalon_sequence_item::WRITE : avalon_sequence_item::READ;
      //    tr.addr = this.vif.pck.paddr;

      //    @ (this.vif.pck);
      //    if (this.vif.pck.penable !== 1'b1) begin
      //       `uvm_error("AVALON", "AVALON protocol violation: SETUP cycle not followed by ENABLE cycle");
      //    end
      //    tr.data = (tr.kind == avalon_sequence_item::READ) ? this.vif.pck.prdata :
      //                                          this.vif.pck.pwdata;

      //    trans_observed(tr);
      //    `uvm_do_callbacks(avalon_monitor,avalon_monitor_cbs,trans_observed(this,tr))

      //    ap.write(tr);
      // end
   endtask: run_phase

   virtual protected task trans_observed(avalon_sequence_item tr);
   endtask

endclass: avalon_monitor

`endif


