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
    longint value_long = -1;
    string  value_str  = ""; 

    `uvm_object_utils_begin(KeyValue)
        `uvm_field_string(key, UVM_ALL_ON | UVM_NOPACK);
        `uvm_field_int(value_int, UVM_ALL_ON | UVM_NOPACK);
        `uvm_field_int(value_long, UVM_ALL_ON | UVM_NOPACK);
        `uvm_field_string(value_str, UVM_ALL_ON | UVM_NOPACK);
    `uvm_object_utils_end

    function new(string name="KeyValue");
        super.new(name);
        key = name;
    endfunction

endclass: KeyValue

typedef  bit  [7:0]  ByteList [$];

virtual class Bits2Bytes #(parameter bit_width=32);
    // static function automatic ByteList pack_data( bit [bit_width-1:0] data_in);
    static function automatic bit  [7:0] [$] pack_data( bit [bit_width-1:0] data_in, bit msb=0);
        bit  [7:0]  data_out [$];
        if (msb) begin
            data_out = {<<8{data_in}};
        end
        else begin
            data_out = {>>8{data_in}};
        end
		`uvm_info("", $sformatf("data_in bit width: %d", $bits(data_in)), UVM_LOW);
        foreach(data_out[i]) begin
    		`uvm_info("", $sformatf("data_out[%d] bit width: %d", i, data_out[i]), UVM_LOW);
        end
    	// if $bits(t)
	endfunction: pack_data
endclass: Bits2Bytes

`endif
