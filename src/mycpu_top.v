`timescale 1ns / 1ps

module mycpu_top(
        input wire[5:0] int,

        input wire aclk,
        input wire aresetn,
        
        //ar
        output wire[3:0] arid,
        output wire[31:0] araddr,
        output wire[3:0] arlen,
        output wire[2:0] arsize,
        output wire[1:0] arburst,
        output wire[1:0] arlock,
        output wire[1:0] arcache,
        output wire[2:0] arprot,
        output wire       arvalid,
        input wire         arready,
        
        //r
        input wire[3:0]   rid,
        input wire[31:0] rdata,
        input wire[1:0]   rresp,
        input wire          rlast,
        input wire          rvalid,
        output wire         rready,
        
        //aw
        output wire[3:0] awid,
        output wire[31:0] awaddr,
        output wire[7:0] awlen,
        output wire[2:0] awsize,
        output wire[1:0] awburst,
        output wire[1:0] awlock,
        output wire[3:0] awcache,
        output wire[2:0] awprot,
        output wire        awvalid,
        input   wire       awready,
        
        //w
        output wire[3:0]   wid,
        output wire[31:0] wdata,
        output wire[3:0]   wstrb,
        output wire           wlast,
        output wire           wvalid,
        input    wire         wready,
        
        input wire[3:0] bid,
        input wire[1:0] bresp,
        input wire        bvalid,
        output wire       bready,
        
        output wire[31:0] debug_wb_pc,
        output wire[3:0]   debug_wb_rf_wen,
        output wire[4:0]   debug_wb_rf_wnum,
        output wire[31:0] debug_wb_rf_wdata
    );

	//id->id_ex
	wire[2:0] 			id_branch_condition_o;
	wire[31:0] 			id_branch_addr_o;
	wire[31:0]         id_pc_8;
	wire[7:0] 			id_op_code_o;
	wire[2:0] 			id_alu_type_o;
	wire[31:0] 			id_operand1_o;
	wire[31:0] 			id_operand2_o;
	wire 				id_we_o;
	wire[31:0] 			id_waddr_o;
	wire 				id_this_is_delayslot_o;
	wire[31:0] 			id_return_addr_o;	
	wire[31:0] 			id_exception_o;
	wire				id_tlb_wi_o;
	wire				id_tlb_wr_o;
	wire				ex_tlb_wi_i;
	wire             ex_tlb_wr_i;

	//id_ex->ex
	wire[31:0]       ex_pc_8;
	wire[2:0] 			ex_branch_condition_o;
	wire[31:0] 			ex_branch_addr_o;
	wire[7:0] 			ex_op_code_i;
	wire[2:0] 			ex_alu_type_i;
	wire[31:0] 			ex_operand1_i;
	wire[31:0] 			ex_operand2_i;
	wire 				ex_we_i;
	wire[31:0] 			ex_waddr_i;
	wire 				ex_this_is_delayslot_i;	
	wire[31:0] 			ex_return_addr_i;	
	wire[31:0] 			ex_inst_i;
	wire[31:0] 			ex_exception_i;	
	wire[31:0] 			ex_inst_addr_i;	

	//ex->ex_mem
	wire 				ex_we_o;
	wire[31:0] 			ex_wdata_o;
	wire[31:0] 			ex_hi_o;
	wire[31:0] 			ex_lo_o;
	wire 				ex_whilo_o;

	wire 				ex_cp0_we_o;
	wire[4:0] 			ex_cp0_w_addr_o;
	wire[31:0] 			ex_cp0_data_o; 	
	wire[31:0] 			ex_exception_o;

	//ex_mem->mem
	wire 				mem_we_i;
	wire[31:0] 			mem_waddr_i;
	wire[31:0] 			mem_wdata_i;
	wire[31:0] 			mem_hi_i;
	wire[31:0] 			mem_lo_i;
	wire 				mem_whilo_i;		
	wire[7:0] 			mem_opcode_i;
	wire[31:0] 			mem_operand2_i;		
	wire 				mem_cp0_we_i;
	wire[4:0] 			mem_cp0_waddr_i;
	wire[31:0] 			mem_cp0_data_i;	
	wire 				mem_this_is_delayslot;
	wire[31:0] 			mem_inst_addr_i;	
	wire				mem_tlb_wi_i;
	wire				mem_tlb_wr_i;

	//mem/ex->addr_change
	wire[31:0] 			mem_mem_addr_i;
	wire[31:0] 			ex_mem_addr_o;
	wire[31:0] 			ex_addr_i;
	wire[19:0] 			ex_addr_o;

	//mem->mem/wb
	wire[31:0] 			mem_wdata_o;

	//exception
	wire[31:0] 			exception_i;
	wire[4:0] 			exception_o;	

	//mem<->dcache_confreg
	wire 				mem_ce_o;
	wire[3:0] 			mem_we_o;
	wire[31:0] 			mem_data_i;
	wire[31:0] 			mem_data_o;

	//wb->regfile	
	wire[3:0] 				regfile_we;
	wire[31:0] 			regfile_waddr;
	wire[31:0] 			regfile_wdata;
	wire[31:0] 			wb_hi_i;
	wire[31:0] 			wb_lo_i;
	wire 				wb_whilo_i;		
	wire 				wb_cp0_we_i;
	wire[4:0] 			wb_cp0_waddr_i;
	wire[31:0] 			wb_cp0_data_i;		

	//if<->regfile
	wire 				operand1_re;
	wire 				operand2_re;
	wire[31:0] 			operand1;
	wire[31:0] 			operand2;
	wire[31:0] 			operand1_addr;
	wire[31:0] 			operand2_addr;

	//hilo output 
	wire[31:0] 			hi_o;
	wire[31:0]   		lo_o;

	//ex<->div
	wire[63:0] 			div_result;
	wire 				div_valid;
	wire 				div_sign;
	wire 				div_sel;
	//ex<->mul
	wire[31:0] 			mul_A;
	wire[31:0] 			mul_B;
	wire 				mul_sel;
	wire[63:0] 			mul_result;
	wire          		mul_ready;

	wire 				this_is_delayslot_i;
	wire 				next_inst_in_delayslot_o;

	wire[31:0] 			cp0_data_o;
	wire[4:0] 			cp0_raddr_i;
	wire[31:0] 			cp0_count;
	wire[31:0]			cp0_status;
	wire[31:0]			cp0_cause;
	wire[31:0]			cp0_epc;

	wire 				clear;

    wire mem_wrall;
    wire wb_wrall;
    wire mem_tlb_re;
	//cp0->tlb
	wire[4:0] 	index_o;
	wire[18:0]					VPN2_o;
	wire[7:0]					asid_o;
	wire[11:0]					Mask_o;
	wire            			global_o;
	wire[23:0]					PFN0_o;
	wire[2:0]						c0_o;
	wire						v0_o;
	wire						d0_o;
	wire						g0_o;
	wire[23:0]					PFN1_o;
	wire	[2:0]					c1_o;
	wire						v1_o;
	wire						d1_o;
	wire						g1_o;
	
    wire wb_tlb_wi;
    wire wb_tlb_wr;
    wire mem_tlb_find_o;

///////////////debug signal//////////////////
	assign debug_wb_rf_wen = regfile_we;
	assign debug_wb_rf_wnum = regfile_waddr;
	assign debug_wb_rf_wdata = regfile_wdata;

/////////////pause pipeline signal//////////
	wire[5:0] 	pause;
	wire 		pc_pause;
	wire 		id_pause;	
	wire 		ex_pause;
	wire 		mem_pause;
	assign 	pause = (mem_pause|wb_cp0_we_i|wb_wrall|wb_tlb_wr|wb_tlb_wi) ? 6'b011111 : 
				   	(ex_pause|mem_tlb_re|mem_tlb_wi_i|mem_tlb_wr_i|mem_tlb_find_o)	? 6'b001111 :
					(pc_pause)  ? 6'b001111 :
					(id_pause)  ? 6'b000111 : 6'b000000;


///////////////////////axi///////////////////
    wire 		addr_valid;
	wire 		r_inst;
	wire 		r_data;
	wire[3:0] 	w_data; 

	wire	 	req_inst;               //pc->icache
	wire[31:0] 	icache_addr_i;          //icache->axi
	wire[31:0] 	icache_data;
	wire[3:0]      icache_arlen;
	wire        cpu_rlast;
	wire        cpu_rvalid;
	wire[31:0] 	cpu_inst_o;             //icache->if
	wire[3:0]   cpu_rid;
	
	wire[3:0]      data_arlen;
	wire[3:0]      data_awlen;
	wire[31:0] 	data_addr;                   
	wire        data_bvalid;
	wire[31:0]  data_din;
	wire[31:0]  data_dout;
	wire        data_wlast;
	wire        data_wvalid;
	wire        data_wready;
    wire[2:0]   data_r_size;
    wire[2:0]   data_w_size;
    AXIAccessor AXIAccessor0(
        .clk(aclk),
        .rstn(aresetn),
        
        .arid(arid),
        .araddr(araddr),
        .arlen(arlen),
        .arsize(arsize),
        .arburst(arburst),
        .arlock(arlock),
        .arcache(arcache),
        .arprot(arprot),
        .arvalid(arvalid),
        .arready(arready),
        
        .rid(rid),
        .rdata(rdata),
        .rresp(rresp),
        .rlast(rlast),
        .rvalid(rvalid),
        .rready(rready),
        
        .awid(awid),
        .awaddr(awaddr),
        .awlen(awlen),
        .awsize(awsize),
        .awburst(awburst),
        .awlock(awlock),
        .awcache(awcache),
        .awprot(awprot),
        .awvalid(awvalid),
        .awready(awready),
        
        .wid(wid),
        .wdata(wdata),
        .wstrb(wstrb),
        .wlast(wlast),
        .wvalid(wvalid),
        .wready(wready),
        
        .bid(bid),
        .bresp(bresp),
        .bvalid(bvalid),
        .bready(bready),
        
        ///////connect to cpu/////////
        .inst_req(r_inst),
        .inst_addr(icache_addr_i),
		.inst_arlen(icache_arlen),
        .cpu_rid_o(cpu_rid),
        .inst_data(icache_data),
        .cpu_rlast_o(cpu_rlast),
        .cpu_rvalid_o(cpu_rvalid),
        .write_begin(addr_valid),
        
        .data_r_size(data_r_size),
        .data_w_size(data_w_size),
        .data_reqr(r_data),
        .data_reqw(w_data),
        .data_arlen(data_arlen),
        .data_awlen(data_awlen),
        .data_din(data_din),
        .data_addr(data_addr),
        .data_dout(data_dout),
        .data_wlast(data_wlast),
        .data_wvalid(data_wvalid),
        .data_wready(data_wready),
        .data_bvalid(data_bvalid)
    );

///////////////////if1//////////////////////////
	wire 		branch;
	wire[31:0] branch_addr;
    wire[31:0] 	if1_pc_o;   
    wire[31:0] 	if2_pc_o;   
	wire[31:0] 	epc_if_i;
    wire[31:0] 	if_addr_i;
    
    wire 		cache_en;
    wire[31:0] 	inst;

	wire [31:0]	bpu_pre_addr;
	wire 		bpu_pre_taken;

    if1 if1_0(
        .clk(aclk),
        .rst(aresetn),
        
        .pause(pause),
        .clear(clear),
        .branch_redirect_flag(branch),
//        .cache_hit(~pc_pause),
        .if2_pc(if2_pc_o),
        .epc(epc_if_i),
        .branch_redirect_addr(branch_addr),
        
		.pre_branch_addr(bpu_pre_addr),
		.pre_branch_taken(bpu_pre_taken),

        .inst_addr(if_addr_i),  
        .pc_o(if1_pc_o),
        .cache_en(cache_en)
    );


//////////////////icache, as if2//////////////////
	wire[19:0] if_addr_o;
	wire           uncache_if;
	reg[31:0]  inst_addr_dly;
	wire           inst_found;
	wire           inst_v;
//	always@(posedge aclk) begin
//	   if(!aresetn)
//	       inst_addr_dly <= 32'b0;
//	   else if(!pause[0])
//	       inst_addr_dly <= {if_addr_o,if_addr_i[11:0]};
//	end
    icache icache0(
        .clk(aclk),
        .rst(aresetn),
        
        //cpu side
        .clear(clear),
        
        //if1
        .cache_en(cache_en),
        .pc_i(if1_pc_o),
        .inst_addr(if_addr_i[11:0]),
        .inst_addr_dly({if_addr_o,if1_pc_o[11:0]}),
        .pause(pc_pause),
        .pc_o(if2_pc_o),
        .inst_o(inst),

		.uncached_i(uncache_if),
		.inst_found(inst_found),
		.inst_v(inst_v),
        
        //ram side
        .inst_req_o(r_inst),
        .araddr(icache_addr_i),
		.arlen(icache_arlen),
        .ram_data_i(icache_data),
        
        //axi
        .rid(cpu_rid),
        .rlast(cpu_rlast),
        .rvalid(cpu_rvalid)
	);
        
///////////////branch pre///////////////////
	wire id_isBranchInst;
	wire ex_isBranchInst;
	wire [1:0] bpu2idex_cnt;
	wire [1:0] idex2bpu_cnt;
	wire [31:0] idex_pre_addr_out;
	wire ex2bpu_isBranch;

	bpu bpu0(
  	.clk(aclk),
   	.rstn(aresetn),
   	.pc_i(if1_pc_o), 
	.id_isBranchInst_i(next_inst_in_delayslot_o),
    .ex_isBranchInst_i(ex2bpu_isBranch),
    .ex_branch_inst_pc_i(ex_inst_addr_i),
   	.ex_real_branch_target_i(branch_addr),
   	.idex_predict_branch_target_i(idex_pre_addr_out),
   	.idex_predict_counter_i(idex2bpu_cnt),
    .ex_actual_taken_i(branch), 
   
  	.pre_taken_o(bpu_pre_taken),
   	.pre_target_o(bpu_pre_addr), 
   	.pre_counter_o(bpu2idex_cnt),
	.stall(pause)
	);

///////////// w/r dcache and confreg/////////
    wire[3:0]   mem_w_size;
    wire[3:0]   mem_r_size;
    wire uncache_data;
	reg[31:0] ex_addr_dly;
	always@(posedge aclk)
	begin
	   if(!aresetn)
	       ex_addr_dly <= 32'b0;
	   else if(!pause[4])
	       ex_addr_dly <= {ex_addr_o,ex_addr_i[11:0]};
	end
    cache_confreg cache_confreg0(
        .clk(aclk),
        .rst(aresetn),
        
        .r_size(mem_r_size),
        .w_size(mem_w_size),
        .uncache(uncache_data),
        .mem_addr_i(ex_addr_dly),
        .ex_addr_i({ex_addr_o,ex_addr_i[11:0]}),

		.cpu_rd_req(mem_ce_o),
        .cpu_wr_req(mem_we_o),
        //.mem_addr_i(mem_mem_addr_o),
        .cpu_wr_data(mem_data_o),
        
        .cpu_mem_stall(mem_pause),
        .cpu_rd_data(mem_data_i),
        
        .ram_rid(cpu_rid),
        .write_begin(addr_valid),
        .ram_rvalid(cpu_rvalid),
        .ram_rlast(cpu_rlast),
        .ram_data_i(data_dout),
        .ram_wready(data_wready),
        .ram_bvalid(data_bvalid),
        
        .ram_arsize(data_r_size),
        .ram_awsize(data_w_size),
        .ram_awlen(data_awlen),
        .ram_arlen(data_arlen),
        .ram_wlast(data_wlast),
        .ram_wvalid(data_wvalid),
        .ram_addr_o(data_addr),
        .ram_data_o(data_din),
        .ram_rdata(r_data),
        .ram_wdata(w_data)
    );

//////////if_id pipeline reg/////////////
	wire[31:0] id_pc_i;
	wire[31:0] id_inst_i;
	wire           id_inst_found;
	wire           id_inst_v;
	if_id if_id0(
		.clk(aclk),
		.rst(aresetn),
		.pause(pause),
		.branch(branch),
		.clear(clear),
		.if2_pc(if2_pc_o),
		.if2_inst(inst),
		.if_inst_found(inst_found),
		.id_inst_found(id_inst_found),
		.id_pc(id_pc_i),
		.id_inst(id_inst_i),
		.if_inst_v(inst_v),
		.id_inst_v(id_inst_v)   	
	);
	
	wire id_tlb_re;
	wire id_tlb_find_o;
    wire[31:0] ex_mem_addr_temp;
    wire[31:0] id_mem_addr_temp;
	id id0(
		.rst(aresetn),
		.pc_i(id_pc_i),
		.inst_i(id_inst_i),
		.inst_found(id_inst_found),
		.inst_v(id_inst_v),
		
		//from ex
    	.ex_opcode_i(ex_op_code_i),
		.ex_we_i(ex_we_o),
		.ex_wdata_i(ex_wdata_o),
		.ex_waddr_i(ex_waddr_i),

		//from mem
		.mem_we_i(mem_we_i),
		.mem_wdata_i(mem_wdata_o),
		.mem_waddr_i(mem_waddr_i),

		.operand1_i(operand1),
		.operand2_i(operand2),

	  	.this_is_delayslot_i(this_is_delayslot_i),

		//to regfile
		.operand1_re_o(operand1_re),
		.operand2_re_o(operand2_re), 	  
		.operand1_addr_o(operand1_addr),
		.operand2_addr_o(operand2_addr), 
	  
		.branch_condition(id_branch_condition_o),
		.branch_addr_o(id_branch_addr_o),       
		.pc_8(id_pc_8),
		.branch_return_addr_o(id_return_addr_o),		

		//to id_ex
		.opcode_o(id_op_code_o),
		.alu_type_o(id_alu_type_o),
		.operand1_o(id_operand1_o),
		.operand2_o(id_operand2_o),
		.waddr_o(id_waddr_o),
		.we_o(id_we_o),

		.next_is_delayslot_o(next_inst_in_delayslot_o),
		.this_is_delayslot_o(id_this_is_delayslot_o),

		.exception_o(id_exception_o),

		.tlb_wi_o(id_tlb_wi_o),
		.tlb_wr_o(id_tlb_wr_o),
		.tlb_re_o(id_tlb_re),
		.tlb_find_o(id_tlb_find_o),
		
        .mem_addr_temp(id_mem_addr_temp),
		
		.pause(id_pause)
	);

/////////////////regfile//////////////

	regfile regfile1(
		.clk(aclk),
		.rst(aresetn),

		.we(regfile_we),
		.waddr(regfile_waddr),
		.wdata(regfile_wdata),

		.re1(operand1_re),
		.raddr1(operand1_addr),
		.rdata1(operand1),

		.re2(operand2_re),
		.raddr2(operand2_addr),
		.rdata2(operand2)
	);
    
    wire ex_tlb_re;
	wire ex_tlb_find_i;
	id_ex id_ex0(
		.clk(aclk),
		.rst(aresetn),
		.pause(pause),
		.clear(clear),
		
		//input from id
		.id_op_code(id_op_code_o),
		.id_alu_type(id_alu_type_o),
		.id_operand1(id_operand1_o),
		.id_operand2(id_operand2_o),
		.id_w_addr(id_waddr_o),
		.id_we(id_we_o),
		.id_branch_return_addr(id_return_addr_o),
		.id_this_is_delayslot(id_this_is_delayslot_o),
		.id_next_is_delayslot(next_inst_in_delayslot_o),	
		.id_pc(id_pc_i),		
		.id_inst(id_inst_i),		
		.id_exception(id_exception_o),
		.id_branch_condition(id_branch_condition_o),
		.id_branch_addr(id_branch_addr_o),	
		.id_pc_8(id_pc_8),
	
		.id_mem_addr_temp(id_mem_addr_temp),
		.ex_mem_addr_temp(ex_mem_addr_temp),
		//output to ex
		.ex_pc_8(ex_pc_8),
        .ex_branch_condition(ex_branch_condition_o),
		.ex_branch_addr(ex_branch_addr_o),
		.ex_op_code(ex_op_code_i),
		.ex_alu_type(ex_alu_type_i),
		.ex_operand1(ex_operand1_i),
		.ex_operand2(ex_operand2_i),
		.ex_w_addr(ex_waddr_i),
		.ex_we(ex_we_i),
		.ex_branch_return_addr(ex_return_addr_i),
  		.ex_this_is_delayslot(ex_this_is_delayslot_i),
		.ex_next_is_delayslot(this_is_delayslot_i),
		.ex_inst(ex_inst_i),
		.ex_pc(ex_inst_addr_i),
		.ex_exception(ex_exception_i),

		.bpu_counter_in(bpu2idex_cnt),
	    .bpu_target_in(bpu_pre_addr),
	   	.bpu_counter_out(idex2bpu_cnt),
	    .bpu_target_out(idex_pre_addr_out),

		.id_tlb_wi(id_tlb_wi_o),
		.ex_tlb_wi(ex_tlb_wi_i),
        .id_tlb_wr(id_tlb_wr_o),
		.ex_tlb_wr(ex_tlb_wr_i),
		
		.id_tlb_re(id_tlb_re),
		.ex_tlb_re(ex_tlb_re),

		.id_tlb_find(id_tlb_find_o),
		.ex_tlb_find(ex_tlb_find_i)
	);		
	
	wire ex_wrall;
	ex ex0(
		.rst(aresetn),

		//from id
		.op_code_i(ex_op_code_i),
		.alu_type(ex_alu_type_i),
		.operand1(ex_operand1_i),
		.operand2(ex_operand2_i),
		.we_i(ex_we_i),
		.inst(ex_inst_i),
		.inst_addr(ex_inst_addr_i),
		
		.hi_i(hi_o),
		.lo_i(lo_o),

		.wb_hi_i(wb_hi_i),
		.wb_lo_i(wb_lo_i),
		.wb_whilo_i(wb_whilo_i),
		.mem_hi_i(mem_hi_i),
		.mem_lo_i(mem_lo_i),
		.mem_whilo_i(mem_whilo_i),
		
        .wait_dcache(mem_pause),
        .dcache_addr(mem_mem_addr_i),

		.mul_result_i(mul_result),
		.mul_ready(mul_ready),
		.mul_sel(mul_sel),
		.mul_A(mul_A),
		.mul_B(mul_B),

  		.mem_cp0_we(mem_cp0_we_i),
		.mem_cp0_w_addr(mem_cp0_waddr_i),
		.mem_cp0_wdata(mem_cp0_data_i),  

		.wb_cp0_we(wb_cp0_we_i),
		.wb_cp0_w_addr(wb_cp0_waddr_i),
		.wb_cp0_wdata(wb_cp0_data_i),

		.cp0_data_i(cp0_data_o),
		.cp0_r_addr_o(cp0_raddr_i),		

		.cp0_we_o(ex_cp0_we_o),
		.cp0_w_addr_o(ex_cp0_w_addr_o),
		.cp0_data_o(ex_cp0_data_o),	

		.we_o(ex_we_o),
		.wdata_o(ex_wdata_o),

		.hi_o(ex_hi_o),
		.lo_o(ex_lo_o),
		.whilo_o(ex_whilo_o),

		.div_result_i(div_result),
		.div_valid(div_valid),
		.div_sel(div_sel),
		.div_sign(div_sign),

		.branch_predict_flg(idex2bpu_cnt[1]),
		.branch_predict_addr(idex_pre_addr_out),  	
		.ex_is_branch(ex2bpu_isBranch),
        .branch_condition(ex_branch_condition_o),
        .branch_addr_i(ex_branch_addr_o),
        .pc_8(ex_pc_8),
	    .branch_return_addr(ex_return_addr_i),  
		.branch(branch),
		.branch_addr_o(branch_addr),

		.mem_addr_o(ex_addr_i),

		.exception_i(ex_exception_i),
		.exception_o(ex_exception_o),

		.pause(ex_pause),

		.cp0_wrall_o(ex_wrall),
		
		.mem_addr_temp(ex_mem_addr_temp)
	);

  	ex_mem ex_mem0(
		.clk(aclk),
		.rst(aresetn),
	  	.pause(pause),
	  	.clear(clear),

		.ex_w_addr(ex_waddr_i),
		.ex_we(ex_we_o),
		.ex_w_data(ex_wdata_o),

		.ex_hi(ex_hi_o),
		.ex_lo(ex_lo_o),
		.ex_w_hilo(ex_whilo_o),		

		.ex_cp0_we(ex_cp0_we_o),
		.ex_cp0_w_addr(ex_cp0_w_addr_o),
		.ex_cp0_data(ex_cp0_data_o),		

  		.ex_op_code(ex_op_code_i),
		.ex_mem_addr(ex_addr_i),
		.ex_operand2(ex_operand2_i),			
    	.ex_exception(ex_exception_o),
		.ex_this_is_delayslot(ex_this_is_delayslot_i),
		.ex_pc(ex_inst_addr_i),	

		.mem_w_addr(mem_waddr_i),
		.mem_we(mem_we_i),
		.mem_w_data(mem_wdata_i),
		.mem_hi(mem_hi_i),
		.mem_lo(mem_lo_i),
		.mem_w_hilo(mem_whilo_i),

  		.mem_op_code(mem_opcode_i),
		.mem_mem_addr(mem_mem_addr_i),
		.mem_operand2(mem_operand2_i),	

		.mem_cp0_we(mem_cp0_we_i),
		.mem_cp0_w_addr(mem_cp0_waddr_i),
		.mem_cp0_data(mem_cp0_data_i),

		.mem_exception(exception_i),
  		.mem_this_is_delayslot(mem_this_is_delayslot),
		.mem_pc(mem_inst_addr_i),

		.ex_tlb_wr(ex_tlb_wr_i),
		.mem_tlb_wr(mem_tlb_wr_i),
        .ex_tlb_wi(ex_tlb_wi_i),
		.mem_tlb_wi(mem_tlb_wi_i),
		
		.ex_wrall(ex_wrall),
		.mem_wrall(mem_wrall),
        
        .ex_tlb_re(ex_tlb_re),
        .mem_tlb_re(mem_tlb_re),
        
		.ex_tlb_find(ex_tlb_find_i),
		.mem_tlb_find(mem_tlb_find_o)
	);
	
	wire r_addr_error;
	wire w_addr_error;
	wire data_found;
    wire r_tlb_refill;
    wire w_tlb_refill;
    wire r_tlb_invalid;
    wire w_tlb_invalid;
    wire tlb_mo;
    wire[31:0] cp0_ebase;
    wire is_rd;
    wire is_wr;
	exception exception0(
		.rst(aresetn),

        .ebase(cp0_ebase),

		.status(cp0_status),
		.cause(cp0_cause),
		
		.is_rd(is_rd),
		.is_wr(is_wr),
		.r_addr_error(r_addr_error),
		.w_addr_error(w_addr_error),
		
		.inst_addr(mem_inst_addr_i),

		.exception_i(exception_i),	
		.exception_o(exception_o),

		.EPC(cp0_epc),
		.excep_pc(epc_if_i),
		.clear(clear),
		
		.r_tlb_refill(r_tlb_refill),
		.w_tlb_refill(w_tlb_refill),
		.r_tlb_invalid(r_tlb_invalid),
		.w_tlb_invalid(w_tlb_invalid),
		.tlb_mo(tlb_mo)
	);

    wire data_d;
    wire data_v;
	mem mem0(
		.rst(aresetn),
		
		//input from ex
		.w_data_i(mem_wdata_i),
		//output to mem_wb
		.w_data_o(mem_wdata_o),		

  		.mem_type_i(mem_opcode_i),
		.mem_addr_i(mem_mem_addr_i),
		.rt(mem_operand2_i),
		.dcache_data_i(mem_data_i),
		.mem_ce_o(mem_ce_o),		
		.mem_we_o(mem_we_o),
		.mem_data_o(mem_data_o),	
        
        .r_size(mem_r_size),
        .w_size(mem_w_size),
        
    	.r_addr_error(r_addr_error),
		.w_addr_error(w_addr_error),
		
		.data_d(data_d),
		.data_v(data_v),
		.data_found(data_found),
		.r_tlb_refill(r_tlb_refill),
		.w_tlb_refill(w_tlb_refill),
		.r_tlb_invalid(r_tlb_invalid),
		.w_tlb_invalid(w_tlb_invalid),
		.tlb_mo(tlb_mo),
		
		.is_rd(is_rd),
		.is_wr(is_wr),
		
		.clear(clear)
	);

    wire tlb_re_o;

	mem_wb mem_wb0(
		.clk(aclk),
		.rst(aresetn),
        .pause(pause),
        .clear(clear),

		.mem_pc(mem_inst_addr_i),

		.mem_w_addr(mem_waddr_i),
		.mem_we(mem_we_i),
		.mem_w_data(mem_wdata_o),
		.mem_hi(mem_hi_i),
		.mem_lo(mem_lo_i),
		.mem_w_hilo(mem_whilo_i),			
	
		.mem_cp0_we(mem_cp0_we_i),
		.mem_cp0_w_addr(mem_cp0_waddr_i),
		.mem_cp0_data(mem_cp0_data_i),					
	
		.wb_w_addr(regfile_waddr),
		.wb_we(regfile_we),
		.wb_w_data(regfile_wdata),
		.wb_hi(wb_hi_i),
		.wb_lo(wb_lo_i),
		.wb_w_hilo(wb_whilo_i),
		
		.wb_cp0_we(wb_cp0_we_i),
		.wb_cp0_w_addr(wb_cp0_waddr_i),
		.wb_cp0_data(wb_cp0_data_i)	,					
									       	
        .wb_pc(debug_wb_pc),
        
        .mem_wrall(mem_wrall),
        .wb_wrall(wb_wrall),
        .mem_tlb_re(mem_tlb_re),
        .wb_tlb_re(tlb_re_o),
        
        .mem_tlb_wi(mem_tlb_wi_i),
        .mem_tlb_wr(mem_tlb_wr_i),
        .wb_tlb_wi(wb_tlb_wi),
        .wb_tlb_wr(wb_tlb_wr)
	);

	hilo_reg hilo_reg0(
		.clk(aclk),
		.rst(aresetn),
	
		.we(wb_whilo_i),
		.hi_i(wb_hi_i),
		.lo_i(wb_lo_i),
	
		.hi_o(hi_o),
		.lo_o(lo_o)	
	);

	wire[18:0]	cp0_VPN2_i;
	wire[7:0]	cp0_ASID_i;
	wire[11:0]	cp0_Mask_i;
	wire[19:0]	cp0_PFN0_i;
	wire[2:0]	cp0_c0_i;
	wire		cp0_v0_i;
	wire		cp0_d0_i; 
	wire[19:0]	cp0_PFN1_i;
	wire[2:0]	cp0_c1_i;
	wire		cp0_v1_i;
	wire		cp0_d1_i;
	wire		cp0_g_i; 
	wire[4:0]		index_lo5;
	wire     tlb_found_o;
	wire[2:0]  config_k0;
	wire[31:0] cp0_random;
	cp0_reg cp0_reg0(
		.clk(aclk),
		.rst(aresetn),
		
		.we(wb_cp0_we_i),
		.w_addr(wb_cp0_waddr_i),
		.w_data(wb_cp0_data_i),	

		.r_addr(cp0_raddr_i),
		.r_data(cp0_data_o),
		
		.exception(exception_o),
		.int(int),
		.inst_addr(mem_inst_addr_i),
		.this_is_delayslot(mem_this_is_delayslot),
		.mem_addr(mem_mem_addr_i),
		.r_tlb_refill(r_tlb_refill),
		.r_tlb_invalid(r_tlb_invalid),
		
		.Count_o(cp0_count),
		.Status_o(cp0_status),
		.Cause_o(cp0_cause),
		.EPC_o(cp0_epc),
		.random_o(cp0_random),
		.EBase_o(cp0_ebase),
		
		.config_k0(config_k0),

       	.write_all(wb_wrall),
       	.VPN2(cp0_VPN2_i),
		.ASID(cp0_ASID_i),
		.Mask(cp0_Mask_i),
		.PFN0(cp0_PFN0_i),
		.c0(cp0_c0_i),
		.v0(cp0_v0_i),
		.d0(cp0_d0_i),
		.g0(cp0_g_i),
		.PFN1(cp0_PFN1_i),
		.c1(cp0_c1_i),
		.v1(cp0_v1_i),
		.d1(cp0_d1_i),
		.g1(cp0_g_i),

		.index_o(index_o),
		.VPN2_o(VPN2_o),
		.ASID_o(asid_o),
		.Mask_o(Mask_o),
		.PFN0_o(PFN0_o),
		.c0_o(c0_o),
		.v0_o(v0_o),
		.d0_o(d0_o),
		.g0_o(g0_o),
		.PFN1_o(PFN1_o),
		.c1_o(c1_o),
		.v1_o(v1_o),
		.d1_o(d1_o),
		.g1_o(g1_o),

		.w_index(mem_tlb_find_o),
		.found(tlb_found_o),
		.index_lo5(index_lo5)
	);
	
	mul mul0(
		.clk(aclk),
		.rst(aresetn),
		.mul_A(mul_A),
		.mul_B(mul_B),
		.mul_sel(mul_sel),
		.mul_result(mul_result),
		.mul_ready(mul_ready)
    );

	div div0(
		.clk(aclk),
		.sel_div(div_sel),
	   
		.sign(div_sign),
		.divisor_i(ex_operand2_i),
		.dividend_i(ex_operand1_i),
		.result(div_result),
		.out_valid(div_valid)
    );

	tlb tlb0(
	    .rst(aresetn),
		.clk(aclk),
        .pause(pause),
        
        .user_m(cp0_status[4:1]==4'b1000),
		.asid(asid_o),
		.config_k0(config_k0),
		
		.cp0_12(VPN2_o[0]),
		.cp0_VPN2(VPN2_o),
		.s_index(index_lo5),
		.found(tlb_found_o),

		.inst_12(if1_pc_o[12]),
		.inst_VPN2(if1_pc_o[31:13]),
		.inst_PFN(if_addr_o),
		.inst_c_o(uncache_if),
		.inst_v_o(inst_v),
		.inst_found_o(inst_found),

		.data_12(ex_addr_i[12]),
		.data_VPN2(ex_addr_i[31:13]),
		.data_PFN(ex_addr_o),
		.data_c_o(uncache_data),
		.data_v_o(data_v),
		.data_d_o(data_d),
		.data_found_o(data_found),

		.wi(wb_tlb_wi),
		.wr(wb_tlb_wr),
		.w_random_i(cp0_random[4:0]),
		.w_index_i(index_o),
		.w_VPN2(VPN2_o),
		.w_asid(asid_o),
		.w_pagemask(Mask_o),
		.w_global(g0_o&g1_o),
		.w_PFN0(PFN0_o[19:0]),
		.w_c0(c0_o),
		.w_d0(d0_o),
		.w_v0(v0_o),
		.w_PFN1(PFN1_o[19:0]),
		.w_c1(c1_o),
		.w_d1(d1_o),
		.w_v1(v1_o),

		.re(tlb_re_o),
		.r_index(index_o),
		.r_VPN2(cp0_VPN2_i),
		.r_asid(cp0_ASID_i),
		.r_pagemask(cp0_Mask_i),
		.r_global(cp0_g_i),
		.r_PFN0(cp0_PFN0_i),
		.r_c0(cp0_c0_i),
		.r_d0(cp0_d0_i),
		.r_v0(cp0_v0_i),
		.r_PFN1(cp0_PFN1_i),
		.r_c1(cp0_c1_i),
		.r_d1(cp0_d1_i),
		.r_v1(cp0_v1_i)
	);
	
//	I_TLB I_TLB0(
//	    .clk(aclk),
//	    .rst(aresetn),
	    
//        .asid(asid_o),
//	   	.inst_12(if1_pc_o[12]),
//		.inst_VPN2(if1_pc_o[31:13]),
//		.inst_PFN(if_addr_o),
//		.inst_c_o(uncache_if),
//		.inst_v_o(inst_v),
//		.inst_found_o(inst_found),
		
//		.we(mem_tlb_we_i),
//		.w_index(index_o),
//		.w_VPN2(VPN2_o),
//		.w_asid(asid_o),
//		.w_pagemask(Mask_o),
//		.w_global(g0_o&g1_o),
//		.w_PFN0(PFN0_o[19:0]),
//		.w_c0(c0_o),
//		.w_d0(d0_o),
//		.w_v0(v0_o),
//		.w_PFN1(PFN1_o[19:0]),
//		.w_c1(c1_o),
//		.w_d1(d1_o),
//		.w_v1(v1_o)
//	);
    
endmodule
