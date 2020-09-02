//16KB


`define RD_NEXT 		7'b0000001
`define RD_CACHE   	7'b0000011
`define RAM_WR_CACHE   	7'b0000111
`define CPU_WR_CACHE       7'b0001111
`define RD_RAM		7'b0011111
`define WR_RAM		7'b0111111
`define WAIT_RESP	7'b1111111

module dcache(
	input wire clk,
	input wire rst,
	
	//cpu side
	input wire 			cpu_rd_req,		//read data request
    input wire[3:0]    	cpu_wr_req,		//write data request
	input wire[31:0] 	ex_addr_i,		//address form ex stage, for reading
	input wire[31:0]  	mem_addr_i, 	//address from mem stage
	input wire[31:0] 	cpu_wr_data,
	
	output wire		 	cpu_mem_stall,	//pause pipeline
	output reg[31:0] 	cpu_rd_data,
	
	//ram side
	input wire         	write_begin,	//write enable, from axi
	input wire[3:0]     ram_rid,
	input wire 			ram_rvalid,			
	input wire          ram_rlast,
	input wire[31:0] 	ram_data_i,
	input wire          ram_wready,
	input wire 			ram_bvalid,
	input wire          ram_awready,
	
	output wire         ram_wlast,
    output reg          ram_wvalid,
	output reg[31:0] 	ram_addr_o,
	output reg[31:0] 	ram_data_o,
	output reg 			ram_rdata,
	output reg      	ram_wdata
	
    );
	
	reg[6:0]	cur_state;
	reg[6:0]	next_state;
	wire[21:0] 	cur_tag1, cur_tag2;								//tag corresponding to current address
	wire[31:0] 	rd_word1_1,rd_word2_1,rd_word3_1,rd_word4_1;	//read data from bram
	wire[31:0] 	rd_word1_2,rd_word2_2,rd_word3_2,rd_word4_2;	//read data from bram
	wire[21:0]	wr_tag;									//write tag to bram
	reg[31:0] 	wr_word1,wr_word2,wr_word3,wr_word4;	//write data to bram
	
	reg 		cpu_rd_valid;							//sign read data output is valid
	reg   		cpu_wr_valid;							//sign write data finished
	wire		hit_1, hit_2;								
	reg			we_ram, we_cpu;								//we_1:ram->dcache, we_2:cpu->dcache
	reg[15:0] 	we_cache1, we_cache2;	
	reg         read_begin;								//read data from axi begin
	reg[2:0]	wr_count;								//count for writing 4 words to axi
	reg[31:0]   word1,word2,word3,word4;				//buffer for read 4 words from axi
	reg         dirty;									//write dirty
	wire        bram_ce;
	wire select;
	reg[255:0]     LRU;
	
	blk_mem_gen_2 tag1(
	    .addra(mem_addr_i[11:4]),
        .clka(clk),
        .dina(wr_tag),
        .wea(|we_cache1),
        .addrb(ex_addr_i[11:4]),
        .enb(bram_ce),
        .clkb(clk),
        .rstb(~rst),
        .doutb(cur_tag1)
    );//tag
    
    blk_mem_gen_2 tag2(
	    .addra(mem_addr_i[11:4]),
        .clka(clk),
        .dina(wr_tag),
        .wea(|we_cache2),
        .addrb(ex_addr_i[11:4]),
        .enb(bram_ce),
        .clkb(clk),
        .rstb(~rst),
        .doutb(cur_tag2)
    );//tag

	blk_mem_gen_1 cache_data_1_1(
        .addra(mem_addr_i[11:4]),
        .clka(clk),
        .dina(wr_word1),
        .wea(we_cache1[3:0]),
        .addrb(ex_addr_i[11:4]),
        .clkb(clk),
        .enb(bram_ce),
        .rstb(~rst),
        .doutb(rd_word1_1)
    );//word1

    blk_mem_gen_1 cache_data_1_2(
        .addra(mem_addr_i[11:4]),
        .clka(clk),
        .dina(wr_word2),
        .wea(we_cache1[7:4]),
        .addrb(ex_addr_i[11:4]),
        .clkb(clk),
        .enb(bram_ce),
        .rstb(~rst),
        .doutb(rd_word2_1)
    );//word2

	blk_mem_gen_1 cache_data_1_3(
        .addra(mem_addr_i[11:4]),
        .clka(clk),
        .dina(wr_word3),
        .wea(we_cache1[11:8]),
        .addrb(ex_addr_i[11:4]),
        .clkb(clk),
        .enb(bram_ce),
        .rstb(~rst),
        .doutb(rd_word3_1)
    );//wrod3

    blk_mem_gen_1 cache_data_1_4(
        .addra(mem_addr_i[11:4]),
        .clka(clk),
        .dina(wr_word4),
        .wea(we_cache1[15:12]),
        .addrb(ex_addr_i[11:4]),
        .clkb(clk),
        .enb(bram_ce),
        .rstb(~rst),
        .doutb(rd_word4_1)
    );//wrod4
	
	blk_mem_gen_1 cache_data_2_1(
        .addra(mem_addr_i[11:4]),
        .clka(clk),
        .dina(wr_word1),
        .wea(we_cache2[3:0]),
        .addrb(ex_addr_i[11:4]),
        .clkb(clk),
        .enb(bram_ce),
        .rstb(~rst),
        .doutb(rd_word1_2)
    );//word1
    
    blk_mem_gen_1 cache_data_2_2(
        .addra(mem_addr_i[11:4]),
        .clka(clk),
        .dina(wr_word2),
        .wea(we_cache2[7:4]),
        .addrb(ex_addr_i[11:4]),
        .clkb(clk),
        .enb(bram_ce),
        .rstb(~rst),
        .doutb(rd_word2_2)
    );//word2
    
    blk_mem_gen_1 cache_data_2_3(
        .addra(mem_addr_i[11:4]),
        .clka(clk),
        .dina(wr_word3),
        .wea(we_cache2[11:8]),
        .addrb(ex_addr_i[11:4]),
        .clkb(clk),
        .enb(bram_ce),
        .rstb(~rst),
        .doutb(rd_word3_2)
    );//word3
    
    blk_mem_gen_1 cache_data_2_4(
        .addra(mem_addr_i[11:4]),
        .clka(clk),
        .dina(wr_word4),
        .wea(we_cache2[15:12]),
        .addrb(ex_addr_i[11:4]),
        .clkb(clk),
        .enb(bram_ce),
        .rstb(~rst),
        .doutb(rd_word4_2)
    );//word4
	
	assign cpu_mem_stall 	= (cpu_rd_req & !cpu_rd_valid) | (!cpu_wr_valid & |cpu_wr_req); //w/r task not finish, pause pipeline
	assign hit_1 		= (cur_tag1[19:0]==mem_addr_i[31:12])&cur_tag1[20];				//compare
	assign hit_2        = (cur_tag2[19:0]==mem_addr_i[31:12])&cur_tag2[20];
	assign ram_wlast 		= (wr_count == 3'b100);
	assign wr_tag 			= {dirty,1'b1,mem_addr_i[31:12]};
    assign bram_ce 			= ~(|we_cache1 | |we_cache2);
    assign select               = !cur_tag1[20] ? 1'b1 : 
                                            !cur_tag2[20] ? 1'b0 :
                                            !cur_tag1[21] ? 1'b1 :
                                            !cur_tag2[21] ? 1'b0 : 
                                            LRU[mem_addr_i[11:4]] ? 1'b0 : 1'b1;
	
	always@(posedge clk) begin
	   if(!rst)
	       LRU <= 256'b0;
	   else if(hit_1)
	       LRU[mem_addr_i[11:4]] <= 1'b1;
	   else if(hit_2)
	       LRU[mem_addr_i[11:4]] <= 1'b0;
	end
	
	always@(posedge clk)
    begin
		if( !rst )
			cur_state <= `RD_CACHE;
		else
			cur_state <= next_state;
    end
	
	always@(*)
	begin	
		next_state = `RD_CACHE;
		case(cur_state)	
			`RD_CACHE: begin
				if(!(hit_1|hit_2) & (cpu_rd_req | |cpu_wr_req)) begin
					if(cur_tag1[21] & cur_tag2[21])
						next_state = `WR_RAM;
					else
						next_state = `RD_RAM;
				end else if((hit_1|hit_2) & |cpu_wr_req)
					next_state = `CPU_WR_CACHE;
				else 
					next_state = `RD_CACHE;
			end
			
			`RAM_WR_CACHE:
				next_state = `RD_NEXT;

			`RD_NEXT:
				next_state = `RD_CACHE;

			`CPU_WR_CACHE:
				next_state = `RD_CACHE;
			
			`RD_RAM: begin
				if(ram_rlast & ram_rvalid & ram_rid==4'b0001)
					next_state = `RAM_WR_CACHE;
				else
					next_state = `RD_RAM;
			end
			
			`WR_RAM: begin
				if(ram_wlast)
					next_state = `WAIT_RESP;
				else
					next_state = `WR_RAM;
			end
			
			`WAIT_RESP: begin
				if(ram_bvalid)
					next_state = `RD_RAM;
				else
					next_state = `WAIT_RESP;
			end
		endcase
	end

	always@(*)
	begin
        cpu_wr_valid = 1'b0;
        cpu_rd_valid = 1'b0;
        dirty = 1'b0;
        we_cpu = 1'b0;
        we_ram = 1'b0;
        ram_addr_o = 32'b0;
        ram_rdata = 1'b0;
        ram_wdata = 1'b0;
        read_begin = 1'b0;
        we_cache1 = 16'h0000;
        we_cache2 = 16'h0000;
		case(cur_state)		
		`RD_CACHE: begin
			if(hit_1 & |cpu_wr_req) begin//write hit
				we_cpu = 1'b1;
                dirty = 1'b1;
                we_cache2 = 16'h0000;
				case(mem_addr_i[3:2])
					0: we_cache1 = {12'h000,cpu_wr_req}; 
					1: we_cache1 = {8'h00,cpu_wr_req,4'h0};
					2: we_cache1 = {4'h0,cpu_wr_req,8'h00}; 
					3: we_cache1 = {cpu_wr_req,12'h000}; 
				endcase
			end else if(hit_2 & |cpu_wr_req) begin
				we_cpu = 1'b1;
                dirty = 1'b1;
                we_cache1 = 16'h0000;
				case(mem_addr_i[3:2])
					0: we_cache2 = {12'h000,cpu_wr_req}; 
					1: we_cache2 = {8'h00,cpu_wr_req,4'h0};
					2: we_cache2 = {4'h0,cpu_wr_req,8'h00}; 
					3: we_cache2 = {cpu_wr_req,12'h000}; 
				endcase
			end	else if((hit_1|hit_2) & cpu_rd_req)//read hit
				cpu_rd_valid = 1'b1;
		end
		
		`RAM_WR_CACHE: begin//write data from ram to cache
			we_ram = 1'b1;
			if(select)
			     we_cache1 = 16'hffff;
			else
			     we_cache2 = 16'hffff;
        end
        
        `CPU_WR_CACHE: begin//write data from cpu to cache
			cpu_wr_valid = 1'b1;
		end

		`RD_RAM: begin//read ram 4 words
		    read_begin = 1'b1;
			if(ram_rlast & ram_rvalid & ram_rid==4'b0001)
                ram_rdata = 1'b0;
			else begin
                ram_rdata = 1'b1;
				ram_addr_o = {mem_addr_i[31:4],4'b0};
		    end
		end

		`WR_RAM: begin//write ram 4 words
		    ram_wdata = 1'b1;
		    if(select)
		      ram_addr_o = {cur_tag1[19:0],mem_addr_i[11:4], 4'b0};
		    else
		      ram_addr_o = {cur_tag2[19:0],mem_addr_i[11:4], 4'b0};
		end
		endcase	
	end

//write 4 words to ram
	always@(posedge clk) begin
		if( !rst ) begin
			ram_data_o 	<= 32'b0;
			ram_wvalid 	<= 1'b0;
			wr_count 	<= 3'b0;
		end else if(wr_count != 3'b100 & write_begin & ram_wready) begin
			wr_count <= wr_count + 1;
			ram_wvalid <= 1'b1;
			case(wr_count)
				0:ram_data_o <= select ? rd_word1_1 : rd_word1_2;
				1:ram_data_o <= select ? rd_word2_1 : rd_word2_2;
				2:ram_data_o <= select ? rd_word3_1 : rd_word3_2;
				3:ram_data_o <= select ? rd_word4_1 : rd_word4_2;
			endcase
	    end else if(wr_count!=3'b100 & write_begin & ~ram_wready) begin
	        ram_wvalid <= 1'b1;
//	        case(wr_count)
//				0:ram_data_o <= rd_word1;
//				1:ram_data_o <= rd_word2;
//				2:ram_data_o <= rd_word3;	
//				3:ram_data_o <= rd_word4;	
//            	default:ram_data_o <= ram_data_o;
//			endcase
		end else begin
		  ram_wvalid 	<= 1'b0;
		  wr_count 		<= 3'b0;
	    end
	end	
			
//read 4 words from ram
	always@(posedge clk)
	begin
		if( !rst ) begin
			word1 <= 32'b0;
			word2 <= 32'b0;
			word3 <= 32'b0;
			word4 <= 32'b0;
		end else if(read_begin && ram_rvalid && ram_rid==4'b0001) begin
			word1 <= word2;
			word2 <= word3;
			word3 <= word4;
			word4 <= ram_data_i;
		end
    end
	
//output data to cpu
	always@(*)
	begin
		if( !rst )
			cpu_rd_data = 32'b0;
		else
			case(mem_addr_i[3:2])
				0:cpu_rd_data = hit_1 ? rd_word1_1 : rd_word1_2;
				1:cpu_rd_data = hit_1 ? rd_word2_1 : rd_word2_2;
				2:cpu_rd_data = hit_1 ? rd_word3_1 : rd_word3_2;	
				3:cpu_rd_data = hit_1 ? rd_word4_1 : rd_word4_2;	
			endcase
	end

//write data to cache bram
	always@(*)
	begin
		if( !rst ) begin
			wr_word1 = 32'h0000;
			wr_word2 = 32'h0000;
			wr_word3 = 32'h0000;
			wr_word4 = 32'h0000;
		end else if(we_ram) begin
			wr_word1 = word1;
			wr_word2 = word2;
			wr_word3 = word3;
			wr_word4 = word4;
	    end else if(we_cpu) begin
			wr_word1 = cpu_wr_data;
			wr_word2 = cpu_wr_data; 
			wr_word3 = cpu_wr_data;
			wr_word4 = cpu_wr_data; 
		end else begin
			wr_word1 = 32'h0000;
			wr_word2 = 32'h0000;
			wr_word3 = 32'h0000;
			wr_word4 = 32'h0000;
		end
    end
	
endmodule
	