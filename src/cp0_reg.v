`include "defines.v"

module cp0_reg(

	input wire					clk,
	input wire					rst,
	
	//write cp0 register channel
	input wire                  we,
	input wire[4:0]             w_addr,
	input wire[31:0]         	w_data,

	//read cp0 register channel
	input wire[4:0]             r_addr,	
	output reg[31:0]         	r_data,	

	input wire[4:0]             exception,			//input exception flow
	input wire[5:0]             int,
	input wire[31:0]         inst_addr,
	input wire                  this_is_delayslot,
	input wire[31:0]         mem_addr,
	input wire                  r_tlb_refill,
	input wire                  r_tlb_invalid,

	output wire[31:0]		Count_o,
	output wire[31:0]		Status_o,
	output wire[31:0]		Cause_o,	
	output wire[31:0]		EPC_o,
	output wire[31:0]       random_o,
	output wire[31:0]       EBase_o, 
	
	output wire[2:0]         config_k0,
	// output wire                  timer_int_o    

	//tlb->cp0
	input wire						write_all,
	input wire[18:0]				VPN2,
	input wire[7:0]					ASID,
	input wire[11:0]				Mask,
	input wire[19:0]				PFN0,
	input wire[2:0]					c0,
	input wire						v0,
	input wire						d0,
	input wire						g0,
	input wire[19:0]				PFN1,
	input wire[2:0]					c1,
	input wire						v1,
	input wire						d1,
	input wire						g1,
	
	//read tlb reg
	//cp0->tlb
	output wire[4:0]				index_o,	
	output reg[18:0]				VPN2_o,
	output reg[7:0]					ASID_o,
	output reg[11:0]				Mask_o,
	output reg[23:0]				PFN0_o,
	output reg[2:0]					c0_o,
	output reg						v0_o,
	output reg						d0_o,
	output reg						g0_o,
	output reg[23:0]				PFN1_o,
	output reg[2:0]					c1_o,
	output reg						v1_o,
	output reg						d1_o,
	output reg						g1_o,
	
	input wire						w_index,
	input wire						found,
	input wire[4:0]					index_lo5
	
);

//exception
	reg[31:0]        BadVAddr;
	reg[31:0]        Count;
	reg[31:0]        Status;
	reg[31:0]        Cause;
	reg[31:0]        EPC;
    reg[31:0]        config_reg;
    reg[31:0]        random;
    reg[31:0]        EBase;
    reg[31:0]         compare;
    reg[31:0]         context;
    wire                 timer;
	assign Count_o		= Count;
	assign Status_o     = Status;
	assign Cause_o		= Cause;
	assign EPC_o 		= EPC;
	assign random_o = random;
	assign EBase_o = {2'b10, EBase[29:0]};

//tlb
	wire[31:0]	EntryHi;
	wire[31:0]	EntryLo0;
	wire[31:0] 	EntryLo1;
	wire[31:0]	PageMask;
	reg[31:0]	Index;
	assign EntryHi 	= {VPN2_o, 5'b0, ASID_o};
	assign PageMask = {7'b0, Mask_o, 13'b0};	
	assign EntryLo0 = {3'b0, PFN0_o, c0_o, d0_o, v0_o, g0_o};
	assign EntryLo1 = {3'b0, PFN1_o, c1_o, d1_o, v1_o, g1_o};
	assign index_o 	= Index[4:0];
	assign config_k0 = config_reg[2:0];
    
//    wire[31:0] mem_context_temp = mem_addr & contextconfig;
//    wire[31:0] inst_context_temp
///////////////Count///////////////////////
	reg count_dly;
	always@(posedge clk) begin
		if(!rst) begin
			Count <= `zero32;
			count_dly <= 1'b0;
		end else if(we && w_addr==`COUNT) begin
			Count 	<= w_data;
		end else if(timer && exception != `Interrupt) begin
		    Count <= Count;
		end else begin
			count_dly <= ~count_dly;//two clock, count + 1
		  	if(count_dly)
		      	Count <= Count + 1 ;
		end
	end
	
	assign timer = (Count == compare);

///////////status//cause//epc//////////////////
	always @ (posedge clk) begin
		if(!rst) begin
			Status 	<= 32'h00000000;
			Cause 	<= `zero32;
			EPC 	<= `zero32;
			BadVAddr <= `zero32;
			VPN2_o   <= 19'b0;
			ASID_o   <= 8'b0;
			PFN0_o <= 20'b0;
			c0_o <= 3'b0;
			d0_o <= 1'b0;
			v0_o <= 1'b0;
			g0_o <= 1'b0;
			PFN1_o <= 20'b0;
			c1_o <= 3'b0;
			d1_o <= 1'b0;
			v1_o <= 1'b0;
			g1_o <= 1'b0;
			Mask_o <= 12'b0;
			Index <= `zero32;
			config_reg <= `zero32;
			random <= `zero32;
			EBase    <= {1'b1 ,31'b0};
			compare <= 32'hffff_ffff;
			context <= 32'b0;
//			contextconfig <= 32'b0;
		end else begin
		  	Cause[15:10] <= {timer, int[4:0]};
		  	random         <= random + 1;
		    
		    if(write_all) begin
		        VPN2_o      <=	VPN2;
				ASID_o		<= 	ASID;
				PFN0_o		<= 	PFN0;
				PFN1_o		<= 	PFN1;
				{c0_o,d0_o,v0_o,g0_o}	<= {c0, d0, v0, g0};
				{c1_o,d1_o,v1_o,g1_o}	<= {c1, d1, v1, g1};
				Mask_o					<= Mask;
            end

			//write cp0 register from input
			if(we) begin
				case(w_addr) 
					`STATUS:begin
					    Status[22]                   <= w_data[22];
						Status[15:8]					<= w_data[15:8];
						Status[4:3]                   <= w_data[4:3];
						Status[1:0]                   <= w_data[1:0];
				    end
					`EPC:
						EPC 					<= w_data;
					`CAUSE:	begin
						Cause[9:8] 				<= w_data[9:8];
						Cause[23] 				<= w_data[23];
						Cause[22] 				<= w_data[22];
					end	
					`EntryHi: begin
						VPN2_o					<= w_data[31:13];
						ASID_o					<= w_data[7:0];
					end
					`EntryLo0: begin
						PFN0_o					<= w_data[25:6];
						{c0_o,d0_o,v0_o,g0_o}	<= w_data[5:0];
					end
					`EntryLo1: begin
						PFN1_o					<= w_data[25:6];
						{c1_o,d1_o,v1_o,g1_o}	<= w_data[5:0];
					end
					`PageMask: 
						Mask_o			<= w_data[24:13];
					`Index:
						Index[4:0]				<= w_data[4:0];		
					`config:
					    config_reg[2:0]                 <=  w_data[2:0];
					`EBase:
					    EBase[29:12]               <= w_data[29:12];
					`compare:
					    compare                    <= w_data;
					`context:
					    context                        <= w_data[31:23];
				endcase
			end else if(w_index) begin
				Index[31]				<= ~found;
				Index[4:0]				<= index_lo5;
//			end else if(we & sel==3'b001) begin
//			     case(w_addr)
//			     `contextconfig:
//			         contextconfig <= w_data;
//			     endcase
			end

			//write cp0 register by exception
			case (exception)
				`Interrupt:begin//interrupt
					Status[1] 		<= 1'b1;
//					Status[4:3]      <= 2'b00;
                    Cause[30]      <= timer;
					Cause[6:2] 		<= `Int;
					Cause[31]		<= this_is_delayslot;
					EPC	 			<= this_is_delayslot ? (inst_addr - 4) : inst_addr;
				end
				`TLBL:begin
                    if(!Status[1]) begin
						EPC			<= this_is_delayslot ? inst_addr - 4 : inst_addr;
						Cause[31]	<= this_is_delayslot;
					end
					VPN2_o           <= r_tlb_refill|r_tlb_invalid ? mem_addr[31:13] : inst_addr[31:13];
					BadVAddr 		<= r_tlb_refill|r_tlb_invalid ? mem_addr : inst_addr;
                    Status[1] 		<= 1'b1;
					Cause[6:2] 		<= `TLBL;
					context[22:4]  <= r_tlb_refill|r_tlb_invalid ? mem_addr[31:13] : inst_addr[31:13];
				end
				`AdEL:begin//read address error
				    if(!Status[1]) begin
						EPC			<= this_is_delayslot ? inst_addr - 4 : inst_addr;
						Cause[31]	<= this_is_delayslot;
					end

					//read inst address error/ read data address error
					BadVAddr 		<= (inst_addr[1:0]!=2'b00) ? inst_addr : mem_addr;
                    Status[1] 		<= 1'b1;
					Cause[6:2] 		<= `AdEL;
			    end
				`Sys:begin//syscall
				    if(!Status[1]) begin
						EPC			<= this_is_delayslot ? inst_addr - 4 : inst_addr;
						Cause[31]	<= this_is_delayslot;
					end
					Status[1] 		<= 1'b1;
					Cause[6:2] 		<= `Sys;			
				end
				`RI:begin//reserve inst error
					if(!Status[1]) begin
						EPC			<= this_is_delayslot ? inst_addr - 4 : inst_addr;
						Cause[31]	<= this_is_delayslot;
					end
					Status[1] 		<= 1'b1;
					Cause[6:2] 		<= `RI;					
				end
				`Bp:begin//break
					if(!Status[1]) begin
						EPC			<= this_is_delayslot ? inst_addr - 4 : inst_addr;
						Cause[31]	<= this_is_delayslot;
					end
					Status[1] 		<= 1'b1;
					Cause[6:2] 		<= `Bp;					
				end
				`Ov:begin//overflow
					if(!Status[1]) begin
						EPC			<= this_is_delayslot ? inst_addr - 4 : inst_addr;
						Cause[31]	<= this_is_delayslot;
					end
					Status[1] 		<= 1'b1;
					Cause[6:2] 		<= `Ov;					
				end		
				`TLBS:begin
                    if(!Status[1]) begin
						EPC			<= this_is_delayslot ? inst_addr - 4 : inst_addr;
						Cause[31]	<= this_is_delayslot;
					end
					VPN2_o           <= mem_addr[31:13];
					BadVAddr 		<= mem_addr;
					Status[1] 		<= 1'b1;
					Cause[6:2] 		<= `TLBS;	
					context[22:4]  <= mem_addr[31:13];
			    end
			    `Mod:begin
                    if(!Status[1]) begin
						EPC			<= this_is_delayslot ? inst_addr - 4 : inst_addr;
						Cause[31]	<= this_is_delayslot;
					end
					VPN2_o           <= mem_addr[31:13];
					BadVAddr 		<= mem_addr;
					Status[1] 		<= 1'b1;
					Cause[6:2] 		<= `Mod;
					context[22:4]  <= mem_addr[31:13];
			    end	
				`AdES:begin//write data address error
                    if(!Status[1]) begin
						EPC			<= this_is_delayslot ? inst_addr - 4 : inst_addr;
						Cause[31]	<= this_is_delayslot;
					end
					BadVAddr 		<= mem_addr;
					Status[1] 		<= 1'b1;
					Cause[6:2] 		<= `AdES;					
				end	
				`er: begin//eret 
				    //Status[4:3]      <= 2'b10;
					Status[1] 		<= 1'b0;
                end
			endcase				
		end 
	end

	//read cp0 register 		
	always @ (*) begin
		if(!rst)
			r_data = `zero32;
		else begin
			case (r_addr) 
				`COUNT:
					r_data = Count;
				`STATUS:
					r_data = Status;
				`CAUSE:
					r_data = Cause;
				`EPC:
					r_data = EPC;
				`BADVADDR:
					r_data = BadVAddr;
				`EntryHi:
					r_data = EntryHi;
				`EntryLo0:
					r_data = EntryLo0;
				`EntryLo1:
					r_data = EntryLo1;
				`PageMask:
					r_data = PageMask;
				`Index:
					r_data = Index;
			    `config:
			        r_data = config_reg;
			    `random:
			        r_data = {27'b0, random[4:0]};
			    `EBase:
			        r_data = EBase_o;
			    `compare:
			        r_data = compare;
			     `context:
			        r_data = context;
				default: begin
					r_data = `zero32;
				end			
			endcase		
		end
	end

endmodule