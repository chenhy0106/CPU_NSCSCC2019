`timescale 1ns / 1ps

//r/w data(cache) is different from r/w confreg(uncache)
//this is 2->1 bridge. choose one module by address
module cache_confreg(
    input wire clk,
	input wire rst,
	
	//cpu side
	input wire[3:0]   r_size,
	input wire[3:0]   w_size,
	input wire          uncache,
	input wire[31:0] 	ex_addr_i,					//from ex stage, read cache line in advance

	input wire 			cpu_rd_req,					//read data request
    input wire[3:0]     cpu_wr_req,					//write data req

	input wire[31:0]    mem_addr_i,                 //from mem stage, for compare and write
	input wire[31:0] 	cpu_wr_data,
	
	output wire		 	cpu_mem_stall,
	output wire[31:0] 	cpu_rd_data,
	
	//ram side
	input wire[3:0]     ram_rid,
	input wire          write_begin,
	input wire 			ram_rvalid,			
	input wire          ram_rlast,
	input wire[31:0] 	ram_data_i,
	input wire			ram_wready,
	input wire 			ram_bvalid,
	
	output wire[3:0]   ram_arsize,
	output wire[3:0]   ram_awsize,
	output wire[3:0]   ram_arlen,
	output wire[3:0]   ram_awlen,
	output wire         ram_wlast,
	output wire         ram_wvalid,
	output wire[31:0] 	ram_addr_o,
	output wire[31:0] 	ram_data_o,
	output wire 	    ram_rdata,
	output wire[3:0]    ram_wdata
    );
    
    wire                    r_confreg;
    wire[3:0]               w_confreg;
    wire                    r_dcache;
    wire[3:0]               w_dcache;
    wire                    dcache_stall_mem;
    wire                    confreg_stall_mem;
    wire[31:0]              dcache_data_o_cpu;
    wire[31:0]              confreg_data_o_cpu;
    wire                    confreg_wlast;
    wire                    dcache_wlast;   
    wire[31:0]              confreg_addr_o;
    wire[31:0]              dcache_addr_o;
    wire[31:0]              confreg_data_o;
    wire[31:0]              dcache_data_o;
    wire                    confreg_rdata;
    wire                    dcache_rdata;
    wire[3:0]               confreg_wdata;
    wire                    dcache_wdata;
    wire                    dcache_wvalid;
    wire                    confreg_wvalid;
   
    assign r_confreg        = uncache ? cpu_rd_req : 1'b0;
    assign w_confreg        = uncache ? cpu_wr_req : 4'b0000;
    assign r_dcache         =  uncache ? 1'b0 : cpu_rd_req;
    assign w_dcache         =  uncache ? 4'b0 : cpu_wr_req;
    assign cpu_mem_stall    = confreg_stall_mem | dcache_stall_mem;
    assign cpu_rd_data      = uncache ? confreg_data_o_cpu : dcache_data_o_cpu;
    
    assign ram_awsize      = uncache ? w_size : 3'b010;
    assign ram_arsize       = uncache ? r_size : 3'b010;
    assign ram_arlen        = uncache ? 4'b0000 : 4'b0011;
    assign ram_awlen       = uncache ? 4'b0000 : 4'b0011;
    assign ram_wlast        = uncache ? confreg_wlast : dcache_wlast;
    assign ram_addr_o       = uncache ? confreg_addr_o : dcache_addr_o;
    assign ram_data_o       = uncache ? confreg_data_o : dcache_data_o;
    assign ram_rdata        = uncache ? confreg_rdata : dcache_rdata;
    assign ram_wdata        = uncache ? confreg_wdata : {4{dcache_wdata}};
    assign ram_wvalid       = uncache ? confreg_wvalid : dcache_wvalid;
    
    dcache dcache0(
    .clk(clk),
    .rst(rst),
    
    .cpu_rd_req(r_dcache),
    .cpu_wr_req(w_dcache),
    .mem_addr_i(mem_addr_i),
    .ex_addr_i(ex_addr_i),
    .cpu_wr_data(cpu_wr_data),
    
    .cpu_mem_stall(dcache_stall_mem),
    .cpu_rd_data(dcache_data_o_cpu),

    .ram_rid(ram_rid),
    .write_begin(write_begin),
    .ram_rvalid(ram_rvalid),
    .ram_rlast(ram_rlast),
    .ram_data_i(ram_data_i),
    .ram_wready(ram_wready),
    .ram_bvalid(ram_bvalid),
    
    .ram_wlast(dcache_wlast),
    .ram_wvalid(dcache_wvalid),
    .ram_addr_o(dcache_addr_o),
    .ram_data_o(dcache_data_o),
    .ram_rdata(dcache_rdata),
    .ram_wdata(dcache_wdata)
    );
            
    rwconfreg rwconfreg0(
    .clk(clk),
    .rst(rst),
    
    .cpu_rd_req(r_confreg),
    .cpu_wr_req(w_confreg),
    .cpu_addr_i(mem_addr_i),
    .cpu_wr_data(cpu_wr_data),
    
    .cpu_mem_stall(confreg_stall_mem),
    .cpu_rd_data(confreg_data_o_cpu),
    
    .write_begin(write_begin),
    .ram_rvalid(ram_rvalid),
    .ram_rlast(ram_rlast),
    .ram_data_i(ram_data_i),
    .ram_wready(ram_wready),
    .ram_bvalid(ram_bvalid),
    
    .ram_rid(ram_rid),
    .ram_wvalid(confreg_wvalid),
    .ram_wlast(confreg_wlast),
    .ram_addr_o(confreg_addr_o),
    .ram_data_o(confreg_data_o),
    .ram_rdata(confreg_rdata),
    .ram_wdata(confreg_wdata)
    );
            
endmodule
