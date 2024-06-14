//---------------------------------------------------------------------- 
//   Copyright 2010-2011 Synopsys, Inc. 
//   Copyright 2010 Mentor Graphics Corporation
//   All Rights Reserved Worldwide 
// 
//   Licensed under the Apache License, Version 2.0 (the 
//   "License"); you may not use this file except in 
//   compliance with the License.  You may obtain a copy of 
//   the License at 
// 
//       http://www.apache.org/licenses/LICENSE-2.0 
// 
//   Unless required by applicable law or agreed to in 
//   writing, software distributed under the License is 
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
//   CONDITIONS OF ANY KIND, either express or implied.  See 
//   the License for the specific language governing 
//   permissions and limitations under the License. 
//----------------------------------------------------------------------


program top;

`include "uvm_macros.svh"
import uvm_pkg::*;

// event在进程控制中需要做好timing计算，否则易出现死锁；
class car_event;
    event e_stall; 
    event e_park; 
    
    task stall;
        `uvm_info("car::", "stall started", UVM_NONE); 
        #1ns; 
        -> e_stall; // 发送event
        @e_park;    // 等待event
        `uvm_info("car::", "stall finished", UVM_NONE); 
    endtask
    
    task park;
        @e_stall;   // 等待event
        `uvm_info("car::", "park started", UVM_NONE); 
        #1ns; 
        -> e_park;  // 发送event
        `uvm_info("car::", "park finished", UVM_NONE); 
    endtask
    task drive() ;
        fork
            this.stall(); 
            this.park(); 
        join_none 
        #10ns; 
    endtask 
endclass

class test extends uvm_test;
   car_event car;
   `uvm_component_utils(test)

   function new(string name, uvm_component parent = null);
      super.new(name, parent);
      car = new();
   endfunction

   virtual task run_phase(uvm_phase phase);
      // Set a drain time on the objection if needed
      phase.raise_objection(this); // 不加这玩意则0 ns直接结束，不消耗仿真时间；原因待分析 [TODO]
      `uvm_info("drive start", "Setting drain time of 10", UVM_NONE);

      // Run a bunch of processes in parallel
      car.drive(); 
      `uvm_info("drive finish", "Setting drain time of 10", UVM_NONE);
      // uvm_test_done.set_drain_time(this,10);
      phase.drop_objection(this);

    endtask

   virtual function void report();
      $write("** UVM TEST PASSED **\n");
   endfunction
endclass



initial
  begin
     run_test();
  end

endprogram
