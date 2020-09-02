`timescale 1ns / 1ps

`define INIT 3'b001
`define RDRAM 3'b010
`define WRITE 3'b100

module icache(
    input wire               clk,
    input wire               rst,

    //cpu side     
    input wire               clear,
    
    //if1
    input wire              cache_en,
    input wire[31:0]        pc_i,
    input wire[11:0]       inst_addr,
     input wire[31:0]        inst_addr_dly,
     input wire                 inst_found,
     input wire                 inst_v,
    
    output                  pause,
    output wire[31:0]       pc_o,
    output reg[31:0]        inst_o,
    
    input wire              uncached_i,
    output wire           is_tlb,

    //ram side
    output reg              inst_req_o,   
    output wire[31:0]       araddr,
    output wire[3:0]        arlen,
    input    wire[31:0]     ram_data_i,
    
    input wire[3:0]         rid,
    input  wire             rlast,
    input  wire             rvalid     
    );

    wire                            hit1, hit2;
    wire        [148:0]             block_1, block_2;//read cache line from bram
    reg         [2:0]               cur_state;
    reg         [2:0]               next_state;
    reg         [31:0]              word1, word2,word3, word4;
    reg         [256:0]             LRU;
    reg                             we1,we2;
    wire        [148:0]             wr_block;//write bram
    wire        [7:0]               group_addr;
    reg                             write_begin;
    wire                            uncached, cached;

   
    assign araddr       = uncached ? inst_addr_dly : {inst_addr_dly[31:4],4'b0};
    assign arlen        = uncached ? 4'b0000 : 4'b0011;
    assign group_addr   = inst_addr[11:4];
    assign wr_block     = {1'b1, inst_addr_dly[31:12], word4, word3, word2, word1};
    
    blk_mem_gen_0 cache_data_1(.addra(group_addr), .rsta(~rst), .clka(clk), .dina(wr_block), .douta(block_1), .wea(we1));//group 1
    blk_mem_gen_0 cahce_data_2(.addra(group_addr), .rsta(~rst), .clka(clk), .dina(wr_block), .douta(block_2), .wea(we2));//group 2

//if2/////////////////////////
    assign hit1 = (block_1[147:128] == inst_addr_dly[31:12]) & block_1[148];
    assign hit2 = (block_2[147:128] == inst_addr_dly[31:12]) & block_2[148];
    assign cached = cache_en & ~(hit1|hit2) & ~uncached_i;
    assign uncached = cache_en & uncached_i & ~(rlast & rvalid & rid==4'b0000);
    assign pause    = (cached | uncached) & inst_found & inst_v ;
    assign pc_o = pc_i;
    
    always@(*) begin
        if(uncached_i)
            inst_o = ram_data_i;
        else
            case(pc_i[3:2])
                2'b00: inst_o = hit1 ? block_1[31:0] : block_2[31:0];
                2'b01: inst_o = hit1 ? block_1[63:32] : block_2[63:32];
                2'b10: inst_o = hit1 ? block_1[95:64] : block_2[95:64];
                2'b11: inst_o = hit1 ? block_1[127:96] : block_2[127:96];
            endcase
    end
    
////////////////////
     
    always@(posedge clk)
    begin
            if( !rst )
                cur_state <= `INIT;
            else if(clear)
                cur_state <= `INIT;
            else
                cur_state <= next_state;
    end
	
	always@(*)
	begin
	   next_state = `INIT;
        case(cur_state)
        `INIT:
        begin	
            if(pause)//!hit
                next_state = `RDRAM;
            else
                next_state = `INIT;
        end
        `RDRAM://wait 4 words
        begin
            if(rvalid && rlast && rid==4'b0000) begin
                next_state = `WRITE;
            end
            else
                next_state = `RDRAM;
        end
        `WRITE://write to bram
            next_state = `INIT;
            
        default:
            next_state = `INIT;
        endcase
    end
		
    always@(*)
	begin	
	if(clear)
	begin
        inst_req_o = 1'b0; 
        write_begin = 1'b0;
     end
     else
      begin
            inst_req_o = 1'b0; 
            write_begin = 1'b0;
            case(cur_state)
                `RDRAM:  
                begin
                    if( rvalid && rlast && rid==4'b0000)
                        inst_req_o = 1'b0;
                    else
                        inst_req_o = 1'b1;
                    write_begin = 1'b1;
                end
                      
                `WRITE:begin
                    write_begin = 1'b1;
                end
                
                default:begin
                end
           endcase
      end 
end               

    //not LRU! 
    always@(posedge clk)
    begin
         if( !rst )
             LRU <= 512'b0;
         else
         begin
             if(hit1)
                 LRU[inst_addr_dly[11:4]] <= 1'b1;
             else if(hit2)
                 LRU[inst_addr_dly[11:4]] <= 1'b0;
         end
    end
       
    //collect four words
    always@(posedge clk)
    begin
        if( !rst )
        begin
            word1 <= 32'b0;
            word2 <= 32'b0;
            word3 <= 32'b0;
            word4 <= 32'b0;
            end
        else if(write_begin && rvalid && rid==4'b0000)
        begin
            word1 <= word2;
            word2 <= word3;
            word3 <= word4;
            word4 <= ram_data_i;
        end
    end
        
    //write bram enble signal
    always@(posedge clk)
    begin
        if( !rst )
        begin
            we1<=0;we2<=0;
        end
        else if(write_begin & rvalid & rlast & rid==4'b0000 & cached)
        begin
            if( block_1[148] & block_2[148])
            begin
                if(LRU[inst_addr_dly[11:4]])
                begin
                    we1 <= 1'b0;
                    we2 <= 1'b1;
                end
                else
                begin
                    we1 <= 1'b1;
                    we2 <= 1'b0;
                end
            end
            else if(!block_1[148])
                begin      
                    we1 <= 1'b1;
                    we2 <= 1'b0;
                end
            else
                begin
                    we1 <= 1'b0;
                    we2 <= 1'b1;
                end
        end
        else
        begin
                we1<=0;we2<=0;
        end
    end
                
endmodule
