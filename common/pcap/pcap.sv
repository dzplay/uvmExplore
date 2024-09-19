//---------------------------------------------------------------------- 
// File Name: pcap.sv
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2023.09.28
// MD5: 8d45881764a4ed4e17c03743f2cea131
// 
// pcap文件主要包含了三个部分，pcap文件头，数据包头，数据包内容。
// 在磁盘上的存储格式为
// 文件头 + 数据包头[0] + 数据包内容[0] + 数据包头[1] + 数据包内容[1] + … +数据包头[N] + 数据包内容[N]
//---------------------------------------------------------------------- 
`ifndef PCAP_SV
`define PCAP_SV



class pcap_pkt extends uvm_object;    	
	// 数据包头
	bit  [31:0]  tv_sec 	  ; // 时间戳秒字段
	bit  [31:0]  tv_usec	  ; // 时间戳微妙字段
	bit  [31:0]  caplen 	  ; // 捕获的数据包的长度(保存在pcap文件中的长度)单位是 Byte。
	bit  [31:0]  len		  ; // 离线数据长度：实际数据帧的长度，一般不大于caplen，多数情况下和Caplen数值相等。

	// 数据内容
	byte  		 pkt_content  [$] ; // 里面保存着网络上捕获的原始数据帧。长度为数据包头里面的caplen长度。

	pcap_pkt     next_pkt_h   ;  // null

    `uvm_object_utils_begin(pcap)
		`uvm_field_int(tv_sec 		  ,  UVM_PRINT)
		`uvm_field_int(tv_usec		  ,  UVM_PRINT)
		`uvm_field_int(caplen 		  ,  UVM_PRINT)
		`uvm_field_int(len			  ,  UVM_PRINT)
		`uvm_field_queue_int(pkt_content	  ,  UVM_PRINT)
    `uvm_object_utils_end

    function new(string name="pcap");
        super.new(name);
    endfunction

endclass : pcap_pkt

class pcap extends pcap_pkt;    
	// Pcap文件头
	bit  [31:0]  Magic	       = 'hA1B2C3D4  ;// 4Bytes, pcap文件标识，用于识别文件并确定字节顺序。0xA1B2C3D4用来表示按照原来的顺序读取，0xD4C3B2A1表 示下面的字节都要交换顺序读取。一般会采用0xD4C3B2A1，即所有字节都需要交换顺序读取。
	bit  [15:0]  version_major = 'h0200	     ;// 2Bytes, 主版本号，一般为 0x0200【实际上因为交换读取顺序，所以计算机看到的应该是 0x0002】
	bit  [15:0]  version_minor = 'h0400	     ;// 2Bytes, 次版本号，一般为 0x0400【计算机看到的应该是 0x0004】
	bit  [31:0]  timezoon	   = 'h0	     ;// 4Bytes, 当地的标准时间，如果用的是GMT则全零，一般都直接写 0000 0000
	bit  [31:0]  sigfigs 	   = 'h0	     ;// 4Bytes, 时间戳的精度，设置为全零即可
	bit  [31:0]  snaplen 	   = 'hffff_0000 ;// 4Bytes, 最大的存储长度，如果想把整个包抓下来，设置为 ffff 0000，但一般来说 ff7f 0000就足够了【计算机看到的应该是 0000 ff7f 】
	bit  [31:0]  linktype	   = 'h1 	     ;// 4Bytes, 链路类型，一般为Ethernet 即0x1。

	pcap_pkt     m_pcap_pkt    [$]           ;

	// user define
	bit  [31:0]  pkt_cnt       = 'h0         ; 

    `uvm_object_utils_begin(pcap)
		`uvm_field_int(Magic	      	  	  ,  UVM_PRINT)
		`uvm_field_int(version_major	  	  ,  UVM_PRINT)
		`uvm_field_int(version_minor	  	  ,  UVM_PRINT)
		`uvm_field_int(timezoon	  		  	  ,  UVM_PRINT)
		`uvm_field_int(sigfigs 	  		  	  ,  UVM_PRINT)
		`uvm_field_int(snaplen 	  		  	  ,  UVM_PRINT)
		`uvm_field_int(linktype	  		  	  ,  UVM_PRINT)
		`uvm_field_queue_object(m_pcap_pkt	  ,  UVM_PRINT)
		`uvm_field_int(pkt_cnt	  		  	  ,  UVM_PRINT)
    `uvm_object_utils_end

    function new(string name="pcap");
        super.new(name);
    endfunction

endclass : pcap


`endif // PCAP_SV
