//---------------------------------------------------------------------- 
// File Name: ether.sv
// Author: dzplay
// Email: dzplay@qq.com
// Date: 2023.09.28
// MD5: 8d45881764a4ed4e17c03743f2cea131
//---------------------------------------------------------------------- 

typedef struct packed {
    logic [47:0]  dst_mac,
    logic [47:0]  src_mac,
    logic [15:0]  eth_type
} eth_hdr;

typedef struct packed {
    logic [5:0]  dscp       ,
    logic [1:0]  ecn        ,
    logic [15:0] length     ,
    logic [7:0]  ttl        ,
    logic [7:0]  protocol   ,
    logic [31:0] source_ip  ,
    logic [31:0] dest_ip     
} ip_hdr;
