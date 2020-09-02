`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/26 19:12:00
// Design Name: 
// Module Name: tlb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//`define HI_VPN2 89:71
//`define HI_ASID 70:63
//`define PM 62:51
//`define GLO 50
//`define PFN0 49:30
//`define FLAG0 29:25
//`define PFN1 24:5
//`define FLAG1 4:0
//`define C0 29:27
//`define D0 26
//`define V0 25
//`define C1 4:2
//`define D1 1
//`define V1 0

module tlb
#(
	parameter tlb_num = 32
)
(
    input wire                      rst,
    input wire              		clk,
    input wire[5:0]                      pause,
 
    input wire                          user_m,
 
	input wire[7:0]					asid,
	input wire[2:0]                config_k0,
	//change inst
	input wire						inst_12,
	input wire[18:0]				inst_VPN2,
	output wire[19:0]				inst_PFN,
//	output reg[19:0]            inst_PFN_o,
	output wire						inst_c_o,
	output wire                      inst_v_o,
	output wire                     inst_found_o,

	//change data addr
	input wire						data_12,
	input wire[18:0]				data_VPN2,
	output wire[19:0]				data_PFN,
	output reg					data_c_o,
	output reg                     data_v_o,
	output reg                     data_d_o,
	output reg                     data_found_o,
	
	input wire[18:0]				cp0_VPN2,
	input wire						cp0_12,
	output reg[$clog2(tlb_num)-1:0] s_index,
	output reg						found,
	
	//cp0 -> TLB
	input wire						wi,
	input wire                         wr,
	input wire[$clog2(tlb_num)-1:0]	w_index_i,
	input wire[$clog2(tlb_num)-1:0]	w_random_i,
    input wire[18:0]				w_VPN2,
	input wire[7:0]					w_asid,
	input wire[11:0]				w_pagemask,
	input wire						w_global,
	input wire[19:0]				w_PFN0,
	input wire[2:0]				w_c0,
	input wire						w_d0,
	input wire						w_v0,
	input wire[19:0]				w_PFN1,
	input wire[2:0]				w_c1,
	input wire						w_d1,
	input wire						w_v1,
	
	//TLB -> cp0
	input wire						re,
	input wire[$clog2(tlb_num)-1:0]	r_index,
	output reg[18:0]				r_VPN2,
	output reg[7:0]				r_asid,
	output reg[11:0]				r_pagemask,
	output reg						r_global,
	output reg[19:0]				r_PFN0,
	output reg[2:0]				r_c0,
	output reg						r_d0,
	output reg						r_v0,
	output reg[19:0]				r_PFN1,
	output reg[2:0]				r_c1,
	output reg 					r_d1,
	output reg						r_v1
    );
    
    reg[18:0]  	inst_tlb_VPN2 [tlb_num-1:0];
	reg[7:0]	inst_tlb_asid [tlb_num-1:0];
	reg[11:0]	inst_tlb_pagemask [tlb_num-1:0];
	reg			inst_tlb_G [tlb_num-1:0];
	reg[19:0]	inst_tlb_PFN0 [tlb_num-1:0];
	reg[2:0]	inst_tlb_c0 [tlb_num-1:0];
	reg			inst_tlb_d0 [tlb_num-1:0];
	reg			inst_tlb_v0 [tlb_num-1:0];
	reg[19:0]	inst_tlb_PFN1 [tlb_num-1:0];
	reg[2:0]	inst_tlb_c1 [tlb_num-1:0];
	reg			inst_tlb_d1 [tlb_num-1:0];
	reg			inst_tlb_v1 [tlb_num-1:0];
	
	reg[18:0]  	tlb_VPN2 [tlb_num-1:0];
	reg[7:0]	tlb_asid [tlb_num-1:0];
	reg[11:0]	tlb_pagemask [tlb_num-1:0];
	reg			tlb_G [tlb_num-1:0];
	reg[19:0]	tlb_PFN0 [tlb_num-1:0];
	reg[2:0]	tlb_c0 [tlb_num-1:0];
	reg			tlb_d0 [tlb_num-1:0];
	reg			tlb_v0 [tlb_num-1:0];
	reg[19:0]	tlb_PFN1 [tlb_num-1:0];
	reg[2:0]	tlb_c1 [tlb_num-1:0];
	reg			tlb_d1 [tlb_num-1:0];
	reg			tlb_v1 [tlb_num-1:0];
	
//	reg          inst_odd, data_odd;
	
//	always@(*) begin
//	   case(inst_tlb_pagemask)
	       
	
	///////////////////inst_addr_change/////////////////
	wire[tlb_num-1:0] inst_hit_0, inst_hit_1; //data_hit_0, data_hit_1;
	genvar i;
	generate for(i=0;i<tlb_num;i=i+1) begin
		assign inst_hit_0[i] = (((inst_tlb_VPN2[i] & ~inst_tlb_pagemask[i])==(inst_VPN2 & ~inst_tlb_pagemask[i])) & (inst_tlb_G[i] | (inst_tlb_asid[i]==asid)));
		assign inst_hit_1[i] = (((inst_tlb_VPN2[i] & ~inst_tlb_pagemask[i])==(inst_VPN2 & ~inst_tlb_pagemask[i])) & (inst_tlb_G[i] | (inst_tlb_asid[i]==asid)));
	end endgenerate
	
	reg[19:0]		inst_PFN0;
	reg[2:0]		inst_c0;
	reg              inst_v0;
	reg[19:0]		inst_PFN1;
	reg[2:0]		inst_c1;
	reg              inst_v1;
	reg              inst_found;
	wire inst_unmapped;
	wire inst_c;
	reg[19:0]  inst_PFN_temp;
	
	assign inst_unmapped = (inst_VPN2[18:17]==2'b10);
//	assign inst_PFN_temp	= inst_unmapped ? {inst_VPN2[18:0], inst_12} : inst_12 ? inst_PFN1 : inst_PFN0;
	assign inst_PFN = inst_unmapped ? {3'b0, inst_VPN2[15:0],inst_12} : inst_PFN_temp;
	assign inst_c	= (inst_VPN2[18:16]==3'b101) ? 1'b1 : 
	                           (inst_VPN2[18:16]==3'b100) ? config_k0!=3'b011 : 
	                           inst_12 ? ~(inst_c1==3'b011) : ~(inst_c0==3'b011) ;
	
	reg[11:0]  inst_pagemask;
	
	always@(*) begin
	   case(inst_pagemask)
	   12'b0000_0000_0000 : inst_PFN_temp = inst_12 ? inst_PFN1 : inst_PFN0;
	   12'b0000_0000_00xx: inst_PFN_temp = {inst_VPN2[1] ? inst_PFN1[19:2] : inst_PFN0[19:2], inst_VPN2[0],inst_12};
	   12'b0000_0000_xxxx: inst_PFN_temp = {inst_VPN2[3] ? inst_PFN1[19:4] : inst_PFN0[19:4], inst_VPN2[2:0],inst_12};
	   12'b0000_00xx_xxxx: inst_PFN_temp = {inst_VPN2[5] ? inst_PFN1[19:6] : inst_PFN0[19:6], inst_VPN2[4:0],inst_12};
       12'b0000_xxxx_xxxx: inst_PFN_temp = {inst_VPN2[7] ? inst_PFN1[19:8] : inst_PFN0[19:8], inst_VPN2[6:0],inst_12};
       12'b00xx_xxxx_xxxx: inst_PFN_temp = {inst_VPN2[9] ? inst_PFN1[19:10] : inst_PFN0[19:10], inst_VPN2[8:0],inst_12};
       default: inst_PFN_temp = {inst_VPN2[11] ? inst_PFN1[19:12] : inst_PFN0[19:12] ,inst_VPN2[10:0],inst_12};
       endcase
   end
   
    assign inst_found_o = inst_found | inst_unmapped;
    assign inst_c_o = inst_c;
    assign inst_v_o = (user_m&inst_VPN2[18]) ? 1'b0 : (inst_unmapped | (inst_12 ? inst_v1 : inst_v0));
	integer j;
	always@(*)
	begin
		inst_PFN0 = 20'b0;
		inst_c0 = 3'b0;
		inst_v0 = 1'b0;
		inst_PFN1 = 20'b0;
		inst_c1 = 3'b0;
		inst_v1 = 1'b0;
		inst_found = 1'b0;
		inst_pagemask = 12'b0;
		for(j=0;j<tlb_num;j=j+1)
		begin
            inst_pagemask = inst_pagemask | ({12{inst_hit_0[j]}}&inst_tlb_pagemask[j]);
		    inst_found = inst_found | inst_hit_0[j] | inst_hit_1[j];
			inst_PFN0 	= inst_PFN0 | ({20{inst_hit_0[j]}} & inst_tlb_PFN0[j]);
			inst_c0 	= inst_c0 	| ({3{inst_hit_0[j]}} & inst_tlb_c0[j]);
			inst_v0 	= inst_v0	| (inst_hit_0[j] & inst_tlb_v0[j]);
			inst_PFN1 	= inst_PFN1  | ({20{inst_hit_1[j]}} & inst_tlb_PFN1[j]);
			inst_c1 	= inst_c1 	| ({3{inst_hit_1[j]}} & inst_tlb_c1[j]);
			inst_v1		= inst_v1	| (inst_hit_1[j] & inst_tlb_v1[j]);
		end
	end

	/////////////////////data addr change////////////////////
	genvar h;
	wire[tlb_num-1:0] data_hit_0, data_hit_1;
	generate for(h=0;h<tlb_num;h=h+1) begin
		assign data_hit_0[h] = (((tlb_VPN2[h] & ~tlb_pagemask[h])==(data_VPN2 & ~tlb_pagemask[h])) & (tlb_G[h] | (tlb_asid[h]==asid)));
		assign data_hit_1[h] = (((tlb_VPN2[h] & ~tlb_pagemask[h])==(data_VPN2 & ~tlb_pagemask[h])) & (tlb_G[h] | (tlb_asid[h]==asid)));
	end endgenerate
	
	integer k;
	reg[19:0]		data_PFN0;
	reg[2:0]		data_c0;
	reg              data_v0;
	reg              data_d0;
	reg[19:0]		data_PFN1;
	reg[2:0]		data_c1;
	reg              data_v1;
	reg              data_found;
	reg              data_d1;
	wire data_unmapped;
	wire data_c;
	reg[11:0]  data_pagemask;
	reg[19:0]  data_PFN_temp;
	
	always@(*) begin
	   case(data_pagemask)
	   12'b0000_0000_0000 : data_PFN_temp = data_12 ? data_PFN1 : data_PFN0;
	   12'b0000_0000_00xx: data_PFN_temp = {data_VPN2[1] ? data_PFN1[19:2] : data_PFN0[19:2], data_VPN2[0],data_12};
	   12'b0000_0000_xxxx: data_PFN_temp = {data_VPN2[3] ? data_PFN1[19:4] : data_PFN0[19:4], data_VPN2[2:0],data_12};
	   12'b0000_00xx_xxxx: data_PFN_temp = {data_VPN2[5] ? data_PFN1[19:6] : data_PFN0[19:6], data_VPN2[4:0],data_12};
       12'b0000_xxxx_xxxx: data_PFN_temp = {data_VPN2[7] ? data_PFN1[19:8] : data_PFN0[19:8], data_VPN2[6:0],data_12};
       12'b00xx_xxxx_xxxx: data_PFN_temp = {data_VPN2[9] ? data_PFN1[19:10] : data_PFN0[19:10], data_VPN2[8:0],data_12};
       default: data_PFN_temp = {data_VPN2[11] ? data_PFN1[19:12] : data_PFN0[19:12] ,data_VPN2[10:0],data_12};
       endcase
   end
	
	assign data_unmapped = (data_VPN2[18:17]==2'b10);
//	assign data_PFN_temp	= data_unmapped ? {data_VPN2[18:0], data_12} : data_12 ? data_PFN1 : data_PFN0;
	assign data_PFN = data_unmapped ? {3'b0, data_VPN2[15:0], data_12} : data_PFN_temp;
	assign data_c	= (data_VPN2[18:16]==3'b101) ? 1'b1 :
	                           (data_VPN2[18:16]==3'b100) ? config_k0!=3'b011 : 
	                           data_12 ? ~(data_c1==3'b011) : ~(data_c0==3'b011);
	
    always@(posedge clk) begin
        if(!pause[4]) begin
           data_found_o <= data_found | data_unmapped;
           data_c_o <= data_c;
           data_v_o <= (user_m&data_VPN2[18]) ? 1'b0 : (data_unmapped | (data_12 ? data_v1 : data_v0));
           data_d_o <= data_unmapped |  (data_12 ? data_d1 : data_d0);
	   end
	end
//    assign data_found_o <= data_found | data_unmapped;
//    assign data_c_o = data_c;
//    assign data_v_o = data_unmapped | (data_12 ? data_v1 : data_v0);
//    assign data_d_o = data_unmapped |  (data_12 ? data_d1 : data_d0); =  
	always@(*)
	begin
		data_PFN0 = 20'b0;
		data_c0 = 3'b0;
		data_v0 = 1'b0;
		data_d0 = 1'b0;
		data_PFN1 = 20'b0;
		data_c1 = 3'b0;
		data_v1 = 1'b0;
		data_d1 = 1'b0;
		data_found = 1'b0;
		data_pagemask = 12'b0;
		for(k=0;k<tlb_num;k=k+1)
		begin
		    data_pagemask = data_pagemask | ({12{data_hit_0[k]}}&tlb_pagemask[k]);
		    data_found = data_found | data_hit_0[k] | data_hit_1[k];
			data_PFN0 	= data_PFN0 | ({20{data_hit_0[k]}} & tlb_PFN0[k]);
			data_c0 	= data_c0 	| ({3{data_hit_0[k]}} & tlb_c0[k]);
			data_v0 	= data_v0	| (data_hit_0[k] & tlb_v0[k]);
			data_d0   = data_d0  | (data_hit_0[k] & tlb_d0[k]);
			data_PFN1 	= data_PFN1 | ({20{data_hit_1[k]}} & tlb_PFN1[k]);
			data_c1 	= data_c1 	| ({3{data_hit_1[k]}} & tlb_c1[k]);
			data_v1		= data_v1	| (data_hit_1[k] & tlb_v1[k]);
			data_d1   = data_d1  | (data_hit_1[k] & tlb_d1[k]);
		end
	end
	
	///////////////////////////TLBWI////////////////////////
	integer l;
	wire[4:0]  w_index;
	assign w_index= wi ? w_index_i : wr ? w_random_i : 5'b0;
	
	always@(posedge clk)
	begin
		if(!rst) begin
			for(l=0;l<tlb_num;l=l+1) begin
                tlb_VPN2[l] 		<= 	19'b0;
                tlb_asid[l] 		<= 	8'b0;
                tlb_pagemask[l] 	<= 	11'b0;
                tlb_G[l] 			<= 	1'b0;
                tlb_PFN0[l]			<= 	20'b0;
                tlb_c0[l]			<= 	3'b0;
                tlb_d0[l]			<= 	1'b0;
                tlb_v0[l]			<= 	1'b0;
                tlb_PFN1[l]			<= 	20'b0;
                tlb_c1[l]			<= 	3'b0;
                tlb_d1[l]			<= 	1'b0;
                tlb_v1[l]			<= 	1'b0;
                inst_tlb_VPN2[l] 		<= 	19'b0;
                inst_tlb_asid[l] 		<= 	8'b0;
                inst_tlb_pagemask[l] 	<= 	11'b0;
                inst_tlb_G[l] 			<= 	1'b0;
                inst_tlb_PFN0[l]			<= 	20'b0;
                inst_tlb_c0[l]			<= 	3'b0;
                inst_tlb_d0[l]			<= 	1'b0;
                inst_tlb_v0[l]			<= 	1'b0;
                inst_tlb_PFN1[l]			<= 	20'b0;
                inst_tlb_c1[l]			<= 	3'b0;
                inst_tlb_d1[l]			<= 	1'b0;
                inst_tlb_v1[l]			<= 	1'b0;
            end
		end else if(wi|wr)
		begin
			tlb_VPN2[w_index] 		<= 	w_VPN2;
			tlb_asid[w_index] 		<= 	w_asid;
			tlb_pagemask[w_index] 	<= 	w_pagemask;
			tlb_G[w_index] 			<= 	w_global;
			tlb_PFN0[w_index]		<= 	w_PFN0;
			tlb_c0[w_index]			<= 	w_c0;
			tlb_d0[w_index]			<= 	w_d0;
			tlb_v0[w_index]			<= 	w_v0;
			tlb_PFN1[w_index]		<= 	w_PFN1;
			tlb_c1[w_index]			<= 	w_c1;
			tlb_d1[w_index]			<= 	w_d1;
			tlb_v1[w_index]			<= 	w_v1;
			
			inst_tlb_VPN2[w_index] 		<= 	w_VPN2;
			inst_tlb_asid[w_index] 		<= 	w_asid;
			inst_tlb_pagemask[w_index] 	<= 	w_pagemask;
			inst_tlb_G[w_index] 			<= 	w_global;
			inst_tlb_PFN0[w_index]		<= 	w_PFN0;
			inst_tlb_c0[w_index]			<= 	w_c0;
			inst_tlb_d0[w_index]			<= 	w_d0;
			inst_tlb_v0[w_index]			<= 	w_v0;
			inst_tlb_PFN1[w_index]		<= 	w_PFN1;
			inst_tlb_c1[w_index]			<= 	w_c1;
			inst_tlb_d1[w_index]			<= 	w_d1;
			inst_tlb_v1[w_index]			<= 	w_v1;
		end
	end
	
	////////////////////////TLBR///////////////////////////
	
	always@(*)
	begin
            if(re) begin
			r_VPN2 			= tlb_VPN2[r_index];
			r_asid 		= tlb_asid[r_index];
			r_pagemask		= tlb_pagemask[r_index];
			r_global		= tlb_G[r_index];
			r_PFN0			= tlb_PFN0[r_index];
			r_c0			= tlb_c0[r_index];
			r_d0			= tlb_d0[r_index];
			r_v0			= tlb_v0[r_index];
			r_PFN1			= tlb_PFN1[r_index];
			r_c1			= tlb_c1[r_index];
			r_d1			= tlb_d1[r_index];
			r_v1			= tlb_v1[r_index];
		end else begin
			r_VPN2 			= 19'b0;
			r_asid 			= 8'b0;
			r_pagemask		= 11'b0;
			r_global		= 1'b0;
			r_PFN0			= 20'b0;
			r_c0			= 3'b0;
			r_d0			= 1'b0;
			r_v0			= 1'b0;
			r_PFN1			= 20'b0;
			r_c1			= 3'b0;
			r_d1			= 1'b0;
			r_v1			= 1'b0;
		end
	end
	
	genvar n;
	wire[tlb_num-1:0] hit;
	generate for(n=0;n<tlb_num;n=n+1) begin
		assign hit[n] = (((tlb_VPN2[n] & ~tlb_pagemask[n])==(cp0_VPN2 & ~tlb_pagemask[n])) & (tlb_G[n] | (tlb_asid[n]==asid)));
//		assign hit_1[n] = (((tlb_VPN2[n] & ~tlb_pagemask[n])==(cp0_VPN2 & ~tlb_pagemask[n])) & (tlb_G[n] | (tlb_asid[n]==asid))) & cp0_12;
	end endgenerate
	
//	reg[4:0] 	index0, index1;
//	reg			found0,found1;
//	assign found = found0 | found1;
//	assign s_index = found0 ? index0 : index1;

	integer m;
	always@(*) begin
	    found = 1'b0;
	    s_index = 5'b0;
//		index0 = 5'b0;
//		index1 = 5'b0;
//		found0 = 1'b0;
//		found1 = 1'b0;
		for(m=0;m<tlb_num;m=m+1) begin
		    found = found | hit[m] ;
		    s_index = s_index | ({5{hit[m]}} & m);
//			index0 = index0 | ({5{hit_0[m]}} & m);
//			found0 = found0 | hit_0[m];
//			index1 = index0 | ({5{hit_1[m]}} & m);
//			found1 = found1 | hit_1[m];
		end
	end



endmodule
	