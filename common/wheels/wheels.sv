//---------------------------------------------------------------------- 
// File Name: wheels.sv
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 

`ifndef WHEELS_SV
`define WHEELS_SV

typedef enum bit {true=0, false=1} bool_e; 

class KeyValue extends uvm_object;

  string  key;
  int     value;

   `uvm_object_utils_begin(KeyValue)
     `uvm_field_string(key, UVM_ALL_ON | UVM_NOPACK);
     `uvm_field_int(value, UVM_ALL_ON | UVM_NOPACK);
   `uvm_object_utils_end

  function new(string name="KeyValue");
     super.new(name);
  endfunction

endclass: KeyValue

`endif
