//---------------------------------------------------------------------- 
// File Name: wheels_pkg.svh
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 

`ifndef AVALON_IF__SV
`define AVALON_IF__SV
`define FIFODEPTH_LOG2_DEF 5

`timescale 1ns/1ns

interface avalon_if#(
    parameter MAXBURSTCOUNT = 16,  // in word
    parameter BURSTCOUNTWIDTH = 5,

    parameter DATAWIDTH = 32,
    parameter BYTEENABLEWIDTH = 4,
    parameter ADDRESSWIDTH = 32,

    parameter FIFODEPTH = 32,
    parameter FIFODEPTH_LOG2 = `FIFODEPTH_LOG2_DEF,
    parameter FIFOUSEMEMORY = 1  // set to 0 to use LEs instead
);
   // wire [31:0] paddr;
   // wire        psel;
   // wire        penable;
   // wire        pwrite;
   // wire [31:0] prdata;
   // wire [31:0] pwdata;


   logic    clk;                                                // input 
   logic    reset;                                              // input 

   // control inputs and outputs
   logic  control_fixed_location;                               // input 
   logic  [ADDRESSWIDTH-1:0] control_read_base;                 // input 
   logic  [ADDRESSWIDTH-1:0] control_read_length;               // input 
   logic  control_go;                                           // input 
   logic  control_done;                                         // output
   // don't use this unless you know what you are doing,
   // it's going to fire when the last read is posted,
   // not when the last data returns!
   logic    control_early_done;                                 // output

   // user logic inputs and outputs
   logic   user_read_buffer;                                    // input 
   logic   [DATAWIDTH-1:0] user_buffer_data;                    // output
   logic   user_data_available;                                 // output

   // master inputs and outputs
   logic   master_waitrequest;                                  // input 
   logic   master_readdatavalid;                                // input 
   logic   [DATAWIDTH-1:0] master_readdata;                     // input 
   logic   [ADDRESSWIDTH-1:0] master_address;                   // output
   logic   master_read;                                         // output
   logic   [BYTEENABLEWIDTH-1:0] master_byteenable;             // output
   logic   [BURSTCOUNTWIDTH-1:0] master_burstcount;             // output



   clocking mck @(posedge clk);
		input   control_done, control_early_done, user_buffer_data, user_data_available, 
				master_address, master_read, master_byteenable, master_burstcount;
		output  clk, reset, control_fixed_location, control_read_base, control_read_length, control_go, 
				user_read_buffer, master_waitrequest, master_readdatavalid, master_readdata;
    //   sequence at_posedge;
    //      1;
    //   endsequence : at_posedge
   endclocking: mck

   clocking sck @(posedge clk);
		output  clk, reset, control_done, control_early_done, user_buffer_data, user_data_available, 
				master_address, master_read, master_byteenable, master_burstcount;
		input   control_fixed_location, control_read_base, control_read_length, control_go, 
				user_read_buffer, master_waitrequest, master_readdatavalid, master_readdata;

    //   sequence at_posedge_; // FIXME todo review 
    //      1;
    //   endsequence : at_posedge_
   endclocking: sck

   clocking pck @(posedge clk);
        input   clk, reset;
		input   control_done, control_early_done, user_buffer_data, user_data_available, 
				master_address, master_read, master_byteenable, master_burstcount;
		input   control_fixed_location, control_read_base, control_read_length, control_go, 
				user_read_buffer, master_waitrequest, master_readdatavalid, master_readdata;
   endclocking: pck

   modport master(clocking mck);
   modport slave(clocking sck);
   modport passive(clocking pck);

endinterface: avalon_if

`endif
