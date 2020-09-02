`include "defines.v"

module mem(
	input wire						rst,
	
	//input from ex
	input wire[31:0]				w_data_i,
	//output to mem_wb
	output reg[31:0]				w_data_o,

  	input wire[7:0]       			mem_type_i,
	(*mark_debug = "true"*)input wire[31:0]         		mem_addr_i,
	input wire[31:0]         		rt,//rt reg
    
    output wire                      is_rd,
    output wire                         is_wr,

    input wire                          clear,
    
	//input from dcache
	input wire[31:0]          		dcache_data_i,
	//output to dcache
	output reg                   	mem_ce_o,	//read enable
	output reg[3:0]					mem_we_o,	//write enable
	output reg[31:0]          		mem_data_o,		
	
	output wire[2:0]                r_size,
	output wire[2:0]                w_size,

	output reg						r_addr_error, 
	output reg						w_addr_error,
	
	input wire                         data_d,
	input wire                         data_found,
	input wire                         data_v,
	output wire                    r_tlb_refill,
	output wire                    w_tlb_refill,
	output wire                    r_tlb_invalid,
	output wire                    w_tlb_invalid,
	output wire                    tlb_mo
);
    assign  is_rd =  ((mem_type_i==`LB_OP) || (mem_type_i==`LBU_OP) || (mem_type_i==`LH_OP)
                                    || (mem_type_i==`LHU_OP) || (mem_type_i==`LW_OP) || (mem_type_i==`LWL_OP) || (mem_type_i==`LWR_OP));
    assign r_tlb_refill = is_rd & ~data_found;
    assign r_tlb_invalid = is_rd & ~data_v;
    
    assign is_wr = (mem_type_i==`SB_OP) || (mem_type_i==`SH_OP) || (mem_type_i==`SW_OP) 
                                || (mem_type_i==`SWR_OP) || (mem_type_i==`SWL_OP);
    assign w_tlb_refill = is_wr & ~data_found;
    assign w_tlb_invalid = is_wr & ~data_v;
    assign tlb_mo = ~data_d & is_wr; 
   

	//write enable
	always @ (*) begin
		if(!rst) begin	
			mem_we_o 		= 4'b0000;     
		end else if(clear) begin
		    mem_we_o = 4'b0;
		end else begin
			case (mem_type_i)
			`SB_OP:
				case (mem_addr_i[1:0])
				2'b11: mem_we_o = 4'b1000;
				2'b10: mem_we_o = 4'b0100;
				2'b01: mem_we_o = 4'b0010;
				2'b00: mem_we_o = 4'b0001;	
				endcase				
			`SH_OP:		mem_we_o	   	= mem_addr_i[0] ? 4'b0000 : (mem_addr_i[1] ? 4'b1100 : 4'b0011);			
			`SW_OP:		mem_we_o 		= (mem_addr_i[1:0]==2'b00) ? 4'b1111 : 4'b0000;
			`SWL_OP:
			     case(mem_addr_i[1:0])
			     2'b11: mem_we_o = 4'b1000;
			     2'b10: mem_we_o = 4'b1100;
			     2'b01: mem_we_o = 4'b1110;
			     2'b00: mem_we_o = 4'b1111;
			     endcase
			`SWR_OP:
			     case(mem_addr_i[1:0])
			     2'b11: mem_we_o = 4'b1111;
			     2'b10: mem_we_o = 4'b0111;
			     2'b01: mem_we_o = 4'b0011;
			     2'b00: mem_we_o = 4'b0001;
			     endcase
			default:	mem_we_o 		= 4'b0000;
			endcase							
		end
	end
	
	assign w_size = mem_type_i==`SB_OP ? 3'b000 :
	                         mem_type_i == `SH_OP ? 3'b001 : 3'b010;

	//read enable
	always @ (*) begin
		if(!rst) begin	
			mem_ce_o 		= 1'b0;	   
		end else if(clear) begin
		    mem_ce_o = 1'b0;
		end else begin
			case (mem_type_i)
			`LB_OP:	mem_ce_o = 1'b1;
			`LBU_OP:mem_ce_o = 1'b1;		
			`LWL_OP:mem_ce_o = 1'b1;
			`LWR_OP:mem_ce_o = 1'b1;
			`LH_OP:	mem_ce_o = ~mem_addr_i[0];			
			`LHU_OP:mem_ce_o = ~mem_addr_i[0];
			`LW_OP: mem_ce_o = (mem_addr_i[1:0]==2'b00);
			default:mem_ce_o = 1'b0; 
			endcase							
		end
	end

    assign r_size = (mem_type_i==`LB_OP||mem_type_i==`LBU_OP) ? 3'b000 :
                              (mem_type_i==`LH_OP||mem_type_i==`LHU_OP) ? 3'b001 : 3'b010;

	//output to dcache write data
	always @ (*) begin
		if(!rst) begin	
			mem_data_o 		= `zero32;
		end else begin
			case (mem_type_i)
			`SB_OP:	mem_data_o 		= {4{rt[7:0]}};			
			`SH_OP:	mem_data_o 		= {2{rt[15:0]}};
			`SW_OP:	mem_data_o 		= rt;	
			`SWL_OP: 
                case(mem_addr_i[1:0])
                    2'b11: mem_data_o            = {rt[7:0], 24'b0};
                    2'b10: mem_data_o            = {rt[15:0], 16'b0};
                    2'b01: mem_data_o            = {rt[23:16], 8'b0};
                    2'b00: mem_data_o            = rt;
                endcase
            `SWR_OP:
                case(mem_addr_i[1:0])
                    2'b11: mem_data_o           = rt;
                    2'b10: mem_data_o           = {8'b0, rt[23:0]};
                    2'b01: mem_data_o           = {16'b0, rt[15:0]};
                    2'b00: mem_data_o           = {24'b0, rt[7:0]};
                endcase
			default:mem_data_o 		= `zero32;
			endcase							
		end
	end

	//read address error
	always @ (*) begin
		if(!rst) begin	
			r_addr_error	= 1'b0;	 
		end else begin
			case (mem_type_i)
			`LH_OP:	r_addr_error 	= mem_addr_i[0];
			`LHU_OP:r_addr_error 	= mem_addr_i[0];
			`LW_OP:	r_addr_error 	= mem_addr_i[0] | mem_addr_i[1];
			default:r_addr_error	= 1'b0;
			endcase							
		end
	end

	//write address error
	always @ (*) begin
		if(!rst) begin	
			w_addr_error	= 1'b0;		
		end else begin
			case (mem_type_i)
			`SH_OP:	w_addr_error 	= mem_addr_i[0];				
			`SW_OP:	w_addr_error	= mem_addr_i[1] | mem_addr_i[0];
			default:w_addr_error	= 1'b0;
			endcase							
		end
	end

	//output to wb write data
	always @ (*) begin
		if(!rst) begin	
			w_data_o		= `zero32;	        
		end else begin
			case (mem_type_i)
			`LB_OP:	
				case (mem_addr_i[1:0])
                    2'b11: w_data_o = {{24{dcache_data_i[31]}},dcache_data_i[31:24]};
                    2'b10: w_data_o = {{24{dcache_data_i[23]}},dcache_data_i[23:16]};
                    2'b01: w_data_o = {{24{dcache_data_i[15]}},dcache_data_i[15:8]};
                    2'b00: w_data_o = {{24{dcache_data_i[7]}},dcache_data_i[7:0]};
				endcase
			`LBU_OP:
				case (mem_addr_i[1:0])
                    2'b11: w_data_o = {{24{1'b0}},dcache_data_i[31:24]};
                    2'b10: w_data_o = {{24{1'b0}},dcache_data_i[23:16]};
                    2'b01: w_data_o = {{24{1'b0}},dcache_data_i[15:8]};
                    2'b00: w_data_o = {{24{1'b0}},dcache_data_i[7:0]};
				endcase	
			`LH_OP:	w_data_o 		= mem_addr_i[1] ? {{16{dcache_data_i[31]}},dcache_data_i[31:16]} : {{16{dcache_data_i[15]}},dcache_data_i[15:0]};				
			`LHU_OP:w_data_o 		= mem_addr_i[1] ? {16'b0,dcache_data_i[31:16]} : {16'b0,dcache_data_i[15:0]};		
			`LW_OP:	w_data_o 		= dcache_data_i;	
			`LWL_OP:
			     case(mem_addr_i[1:0])
			         2'b11: w_data_o     = {rt[31:8], dcache_data_i[31:24]}; 
			         2'b10: w_data_o     = {rt[31:16], dcache_data_i[31:16]};
			         2'b01: w_data_o     = {rt[31:24], dcache_data_i[31:8]};
			         2'b00: w_data_o     = dcache_data_i;
			     endcase
			`LWR_OP:
			     case(mem_addr_i[1:0])
			         2'b11: w_data_o     = dcache_data_i;
			         2'b10: w_data_o     = {dcache_data_i[23:0], rt[7:0]};
			         2'b01: w_data_o     = {dcache_data_i[15:0], rt[15:0]};
			         2'b00: w_data_o     = {dcache_data_i[7:0], rt[23:0]};
			     endcase
			default:w_data_o		= w_data_i;
			endcase							
		end
	end
		

endmodule