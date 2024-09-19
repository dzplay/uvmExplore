//---------------------------------------------------------------------- 
// File Name: libs_pkg.svh
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 


`ifndef ALVAON_SEQUENCE_ITEM__SV
`define ALVAON_SEQUENCE_ITEM__SV

class avalon_sequence_item extends uvm_sequence_item;
  
	typedef enum {READ, WRITE} kind_e;
	rand bit   [31:0] address; 
	rand logic [31:0] wordburstcount;
	rand kind_e kind;  

	constraint wordburstcount_cons { (wordburstcount < 20); }
	
	
	`uvm_object_utils_begin(avalon_sequence_item)
		`uvm_field_int(address, UVM_ALL_ON | UVM_NOPACK);
		`uvm_field_int(wordburstcount, UVM_ALL_ON | UVM_NOPACK);
		`uvm_field_enum(kind_e,kind, UVM_ALL_ON | UVM_NOPACK);
	`uvm_object_utils_end
   
   function new (string name = "avalon_sequence_item");
      super.new(name);
   endfunction

   function string convert2string();
     return $sformatf("kind=%s addr=%0h wordburstcount=%0h",kind,address,wordburstcount);
   endfunction

endclass: avalon_sequence_item


class reg2avalon_adapter extends uvm_reg_adapter;

  `uvm_object_utils(reg2avalon_adapter)

   function new(string name = "reg2avalon_adapter");
      super.new(name);
   endfunction 

  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    avalon_sequence_item req = avalon_sequence_item::type_id::create("avalon_sequence_item");
    // req.kind = (rw.kind == UVM_READ) ? avalon_sequence_item::READ : avalon_sequence_item::WRITE;
    // req.addr = rw.addr;
    // req.data = rw.data;
    return req;
  endfunction

  virtual function void bus2reg(uvm_sequence_item bus_item,
                                ref uvm_reg_bus_op rw);
    avalon_sequence_item req;
    if (!$cast(req,bus_item)) begin
      `uvm_fatal("req","Provided bus_item is not of the correct type")
      return;
    end
    // rw.kind = req.kind == avalon_sequence_item::READ ? UVM_READ : UVM_WRITE;
    // rw.addr = req.addr;
    // rw.data = req.data;
    // rw.status = UVM_IS_OK;
  endfunction

endclass


`endif
