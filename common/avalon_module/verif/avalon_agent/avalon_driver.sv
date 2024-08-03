//---------------------------------------------------------------------- 
// File Name: wheels_pkg.svh
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 


`ifndef AVALON_DRIVER__SV
`define AVALON_DRIVER__SV

typedef class avalon_driver;
class avalon_driver_cbs extends uvm_callback;
    virtual task trans_received (avalon_driver xactor , avalon_sequence_item cycle);endtask
    virtual task trans_executed (avalon_driver xactor , avalon_sequence_item cycle);endtask
endclass

class avalon_driver extends uvm_driver#(avalon_sequence_item);

    `uvm_component_utils(avalon_driver)
  
	// event trig;
	virtual  avalon_if vif;
	avalon_config m_cfg_h;

	function new(string name,uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		// avalon_agent agent;
		// if ($cast(agent, get_parent()) && agent != null) begin
		//    vif = agent.vif;
		// end
		// else begin
		if (!uvm_config_db#(virtual  avalon_if)::get(this, "", "vif", vif)) begin
			`uvm_fatal("AVALON/DRV/NOVIF", "No virtual interface specified for this driver instance")
		end
		// end
	endfunction

	virtual protected task run_phase(uvm_phase phase);
		avalon_sequence_item tr;
		super.run_phase(phase);
		reset_proc();

		forever begin
			@ (this.vif.clk);
			seq_item_port.get_next_item(tr);


			// if (!this.vif.mck.at_posedge.triggered)
			// @ (this.vif.mck);
			
			// this.trans_received(tr);
			// `uvm_do_callbacks(avalon_driver,avalon_driver_cbs,trans_received(this,tr))
			
			case (tr.kind)
				avalon_sequence_item::READ:  this.read(tr.address, tr.wordburstcount);  
				avalon_sequence_item::WRITE: this.write(tr.address, tr.wordburstcount);
			endcase
			
        //  this.trans_executed(tr);
        //  `uvm_do_callbacks(avalon_driver,avalon_driver_cbs,trans_executed(this,tr))

         	seq_item_port.item_done();
		// ->trig ;
		end
	endtask: run_phase

	virtual protected task read(	int address, 
									int burstcount_w);
			// repeat (10) @(vif.clk);
			// Begin master burst read
			@(vif.clk);
			vif.control_go <= 1; 
			vif.control_read_base      <= address;
			vif.control_read_length    <= burstcount_w*4;
			@(vif.clk);
			vif.control_go <= 0; 
		endtask: read

   virtual protected task write(input bit [31:0] addr,
                                input bit [31:0] data);
    //   this.vif.mck.paddr   <= addr;
    //   this.vif.mck.pwdata  <= data;
    //   this.vif.mck.pwrite  <= '1;
    //   this.vif.mck.psel    <= '1;
    //   @ (this.vif.mck);
    //   this.vif.mck.penable <= '1;
    //   @ (this.vif.mck);
    //   this.vif.mck.psel    <= '0;
    //   this.vif.mck.penable <= '0;
   endtask: write

   virtual protected task trans_received(avalon_sequence_item tr);
   endtask
 
   virtual protected task trans_executed(avalon_sequence_item tr);
   endtask

   extern  virtual task reset_proc();

endclass: avalon_driver

task avalon_driver::reset_proc();
    int wordburstcount = 16;
    int address;
    address = 10*wordburstcount; 
	// @negedge(vif.reset);
	// vif.reset                  <= 1;
	vif.user_read_buffer       <= 0;
	vif.control_read_base      <= 0;
	vif.control_read_length    <= 0;
	vif.control_fixed_location <= 0;
	vif.control_go             <= 0;
	vif.master_waitrequest     <= 0;
	repeat (20) @(vif.clk);
	// vif.reset                  <= 0;
endtask: reset_proc

`endif


