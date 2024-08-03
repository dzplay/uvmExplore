//---------------------------------------------------------------------- 
// File Name: wheels_pkg.svh
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 

class avalon_config extends uvm_object;

   `uvm_object_utils(avalon_config)
   virtual avalon_if vif;

   function new(string name = "avalon_config");
      super.new(name);
   endfunction
  
endclass

