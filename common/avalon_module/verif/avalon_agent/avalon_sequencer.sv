//---------------------------------------------------------------------- 
// File Name: wheels_pkg.svh
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 

`ifndef AVALON_SEQUENCER__SV
`define AVALON_SEQUENCER__SV

class avalon_sequencer extends uvm_sequencer #(avalon_sequence_item);

   `uvm_component_utils(avalon_sequencer)

   function new(input string name, uvm_component parent=null);
      super.new(name, parent);
   endfunction : new

endclass : avalon_sequencer

`endif

