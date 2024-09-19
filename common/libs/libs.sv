//---------------------------------------------------------------------- 
// File Name: libs.sv
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2024.07.16
// MD5: 8d45881764a4ef2cea131d4e17c03743
//---------------------------------------------------------------------- 

`ifndef LIBS_SV
`define LIBS_SV

typedef enum bit {true=0, false=1} bool_e; 
typedef int queue_int [$];
typedef bit [7:0] queue_byte [$];

class KeyValue #(type T=int) extends uvm_object;
    // @T: int, longint, string
    //  T support for rand: [integral,  enum, packed struct, bit]

    string  key  ;
    rand T  value;

    `uvm_object_utils_begin(KeyValue)
        `uvm_field_string(key  ,  UVM_PRINT)
        `uvm_field_int   (value,  UVM_PRINT)
    `uvm_object_utils_end

    function new(string name="KeyValue");
        super.new(name);
        this.key = name;
    endfunction

    virtual function init(string key="kv", T value);
        this.key   = key;
        this.value = value;
    endfunction

    virtual task self_test();
        `uvm_info(get_type_name(), $sformatf("self test start..."), UVM_LOW);
        for (int i=0; i<8; i=i+1) begin
            this.randomize();
            `uvm_info(get_type_name(), $sformatf("round%0d, k:%s, v:0x%h", i, this.key, this.value), UVM_LOW);
        end
        `uvm_info(get_type_name(), $sformatf("self test finish..."), UVM_LOW);
    endtask

endclass: KeyValue


virtual class Bits2Bytes #(parameter bit_width=32);
    // @call: Bits2Bytes #(256)pack_data('hbaba_5a5a);
    static function automatic queue_byte pack_data( bit [bit_width-1:0] data_in, bit msb=0);
        queue_byte  data_out ;
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
        return data_out;
	endfunction: pack_data
endclass: Bits2Bytes


class BitMap #(parameter WIDTH=32) extends uvm_object;
    bit  [WIDTH-1: 0] bitmap    ;
    queue_int         id        ;

    `uvm_object_utils_begin(BitMap)
        `uvm_field_int         (bitmap,  UVM_PRINT)
        `uvm_field_queue_int   (id,      UVM_PRINT)
    `uvm_object_utils_end

    function new(string name="BitMap");
        super.new(name);
    endfunction

    virtual function void add(int id);
        if (id < WIDTH) begin
            this.bitmap  = this.bitmap | (1 << id);
        end else begin
            `uvm_error(get_type_name(), $sformatf("id:%0d out of RANGE:%0d", id, WIDTH));
        end
    endfunction : add

    virtual function void del(int id);
        if (id < WIDTH) begin
            this.bitmap  = (this.bitmap | (1 << id)) ^ ((1 << id));
        end else begin
            `uvm_error(get_type_name(), $sformatf("id:%0d out of RANGE:%0d", id, WIDTH));
        end
    endfunction : del

    virtual function automatic queue_int get();
        queue_int ret ;
        int round = 1;
        bit  [WIDTH-1: 0] bitmap_tmp = this.bitmap;
        longint seg;
        int j;
        round = ($bits(this.bitmap) + 31)/ 32;
        for (int i=0; i<round; i=i+1) begin
            if (bitmap_tmp == 0) break;
            seg = bitmap_tmp % (1 << 32); // int'(1 << 32) = 0, cause x;
            j = 0;
            // `uvm_info(get_type_name(), $sformatf("i:%d, j:%d, seg:%d, bitmap_tmp:%d", i, j, longint'(bitmap_tmp % (1 << 32)), bitmap_tmp), UVM_LOW);
            do begin
                // `uvm_info(get_type_name(), $sformatf("i:%d, j:%d", i, j), UVM_LOW);
                if ((seg % 2) == 1) begin
                    ret.push_back(i*32 + j);
                end
                j = j + 1;
                seg = seg/2;
            end while (seg > 0);
            bitmap_tmp = bitmap_tmp / (1 << 32);
        end
        this.id = ret;
        return ret;
    endfunction : get

    virtual function void self_test();
        int tmp_id [$] = {1, 3, 5, 7, 9};
        int tmp_id2 [$] = {1, 5, 7};
        foreach(tmp_id[i]) begin
            this.add(tmp_id[i]);
        end 
        this.get();
        `uvm_info(get_type_name(), $sformatf("\n%s", this.sprint()), UVM_LOW);
        foreach(tmp_id2[i]) begin
            this.del(tmp_id2[i]);
        end 
        this.get();
        `uvm_info(get_type_name(), $sformatf("\n%s", this.sprint()), UVM_LOW);
    endfunction : self_test

endclass: BitMap


`endif
