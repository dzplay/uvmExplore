

// `include "uvm_macros.svh"
// `include "burst_read_master.v"
// `include "avalon_pkg.svh"

// class my_catcher extends uvm_report_catcher;
//    static int seen = 0;
//    virtual function action_e catch();
//       if (get_severity() == UVM_ERROR && get_id() == "RegModel") begin
//          seen++;
//          set_severity(UVM_INFO);
//          set_action(UVM_DISPLAY);
//       end
//       return THROW;
//    endfunction
// endclass
// import tb_env_pkg::*;

import tb_env_pkg::*; // 

class test extends uvm_test;

   `uvm_component_utils(test)

   tb_env env;
   // my_catcher catch;
   
   function new(string name, uvm_component parent=null);
      super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      env = tb_env::type_id::create("env", this);
      // catch = new();
      // uvm_report_cb::add(null, catch);
      // catch.callback_mode(0);
   endfunction

   virtual task main_phase(uvm_phase phase);
      phase.raise_objection(this);

      phase.drop_objection(this);
   endtask: main_phase

   virtual function void final_phase(uvm_phase phase);
      uvm_report_server svr;
      svr = _global_reporter.get_report_server();

      if (svr.get_severity_count(UVM_FATAL) +
          svr.get_severity_count(UVM_ERROR) == 0)
         $write("** UVM TEST PASSED **\n");
      else
         $write("!! UVM TEST FAILED !!\n");
   endfunction

endclass