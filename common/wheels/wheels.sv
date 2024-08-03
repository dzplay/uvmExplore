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
    int     value_int  = -1; // default invald
    long    value_long = -1;
    string  value_str  = ""; 

    `uvm_object_utils_begin(KeyValue)
        `uvm_field_string(key, UVM_ALL_ON | UVM_NOPACK);
        `uvm_field_int(value, UVM_ALL_ON | UVM_NOPACK);
        `uvm_field_long(value, UVM_ALL_ON | UVM_NOPACK);
        `uvm_field_string(value_str, UVM_ALL_ON | UVM_NOPACK);
    `uvm_object_utils_end

    function new(string name="KeyValue");
        super.new(name);
        key = name;
    endfunction

endclass: KeyValue

`endif
