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

// animal cage 传入的参数类型可以为支持的任意类型.

virtual class animal;
   protected int age=-1;
   protected string name;

   function new(int a, string n);
      age = a;
      name = n;
   endfunction : new

   function int get_age();
      return age;
   endfunction : get_age

   function string get_name();
      return name;
   endfunction : get_name

   pure virtual function void make_sound();

endclass : animal


class lion extends animal;

   bit              thorn_in_paw = 0;

   function new(int age, string n);
      super.new(age, n);
   endfunction : new

   function void make_sound();
      `uvm_info("", $sformatf("The lion, %s, says Roar", get_name()), UVM_LOW);
   endfunction : make_sound
   
endclass : lion


class chicken extends animal;

   function new(int age, string n);
      super.new(age, n);
   endfunction : new

   function void make_sound();
      `uvm_info("", $sformatf("The Chicken, %s, says BECAWW", get_name()), UVM_LOW);
   endfunction : make_sound


endclass : chicken

class animal_factory;

   static function animal make_animal(string species, 
                                      int age, string name);
      chicken chicken;
      lion lion;
      case (species)
        "lion" : begin
           lion = new(age, name);
           return lion;
        end

        "chicken" : begin
           chicken = new(age, name);
           return chicken;
        end

        default : 
          $fatal (1, {"No such animal: ", species});
        
      endcase // case (species)
      
   endfunction : make_animal
   
endclass : animal_factory



// class animal_cage #(type T=animal);
class animal_cage #(type T=int);

   static T cage[$];

   static function void cage_animal(T l);
      cage.push_back(l);
   endfunction : cage_animal

   static function void list_animals();
      `uvm_info("", "Animals in cage:", UVM_LOW); 
      foreach (cage[i])
        `uvm_info("", cage[i].get_name(), UVM_LOW);
   endfunction : list_animals

endclass : animal_cage

class test extends uvm_test;
    `uvm_component_utils(test)

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction

//    virtual task run_phase(uvm_phase phase);
    virtual task main_phase(uvm_phase phase);
        phase.raise_objection(this); 
        // 不加raise_objection则0 ns直接结束，不消耗仿真时间；原因待分析 [Done]
        `uvm_info("raise_objection start", "car.drive begin...", UVM_NONE);
        main_proc(); 
        `uvm_info("raise_objection finish", "car.drive stop...", UVM_NONE);
        phase.drop_objection(this);

    endtask

    virtual function void report();
        $write("** UVM TEST PASSED **\n");
    endfunction

    virtual task main_proc();
        animal animal_h;
        lion   lion_h;
        chicken  chicken_h;
        bit cast_ok;
        
        animal_h = animal_factory::make_animal("lion", 15, "Mustafa");
        animal_h.make_sound();

        cast_ok = $cast(lion_h, animal_h);
        if ( ! cast_ok) 
            $fatal(1, "Failed to cast animal_h to lion_h");
        
        if (lion_h.thorn_in_paw) `uvm_info("", "He looks angry!", UVM_LOW);
        animal_cage#(lion)::cage_animal(lion_h);
        
        if (!$cast(lion_h, animal_factory::make_animal("lion", 2, "Simba")))
            $fatal(1, "Failed to cast animal from factory to lion_h");
        
        animal_cage#(lion)::cage_animal(lion_h);
        
        if(!$cast(chicken_h ,animal_factory::make_animal("chicken", 1, "Clucker")))
            $fatal(1, "Failed to cast animal factory result to chicken_h");
        
        animal_cage #(chicken)::cage_animal(chicken_h);

        if(!$cast(chicken_h, animal_factory::make_animal("chicken", 1, "Boomer")))
            $fatal(1, "Failed to cast animal factory result to chicken_h");

        animal_cage #(chicken)::cage_animal(chicken_h);

        `uvm_info("", "-- Lions --", UVM_LOW);
        animal_cage #(lion)::list_animals();
        `uvm_info("", "-- Chickens --", UVM_LOW);
        animal_cage #(chicken)::list_animals();
    endtask

endclass



initial
    begin
        run_test();
    end

endprogram
