`include "defines.v"

module mem_wb(
	input wire					clk,
	input wire					rst,
	input wire[5:0]             pause,	
  	input wire                  clear,		
    
    input wire[31:0]         	mem_pc,

	input wire[31:0]     		mem_w_addr,
	input wire                  mem_we,
	input wire[31:0]			mem_w_data,
	input wire[31:0]         	mem_hi,
	input wire[31:0]         	mem_lo,
	input wire                  mem_w_hilo,		

	input wire                  mem_cp0_we,
	input wire[4:0]             mem_cp0_w_addr,
	input wire[31:0]         	mem_cp0_data,			

	output reg[31:0]     		wb_w_addr,
	output reg                  wb_we,
	output reg[31:0]			wb_w_data,
	output reg[31:0]        	 wb_hi,
	output reg[31:0]         	wb_lo,
	output reg                  wb_w_hilo,

	output reg                  wb_cp0_we,
	output reg[4:0]             wb_cp0_w_addr,
	output reg[31:0]         	wb_cp0_data,								       
	
	output reg[31:0]     		wb_pc,
	
	input wire                     mem_wrall,
	output reg                   wb_wrall,
	input wire                     mem_tlb_re,
	output reg                     wb_tlb_re,
	
	input wire                     mem_tlb_wi,
	output reg                     wb_tlb_wi,
    input wire                     mem_tlb_wr,
	output reg                     wb_tlb_wr
	
);


	always @ (posedge clk) begin
		if(!rst) begin
			wb_w_addr 		<= `zero32;
			wb_we 			<= 1'b0;
			wb_w_data 		<= `zero32;	
			wb_hi 			<= `zero32;
			wb_lo 			<= `zero32;
			wb_w_hilo 		<= `zero32;	
			wb_cp0_we 		<= 1'b0;
			wb_cp0_w_addr 	<= 5'b00000;
			wb_cp0_data 	<= `zero32;
			wb_pc 			<= `zero32;		
			wb_wrall     <= 1'b0;	
			wb_tlb_re   <= 1'b0;
			wb_tlb_wi <= 1'b0;
			wb_tlb_wr <= 1'b0;
		end else if(clear) begin
			wb_w_addr 		<= `zero32;
			wb_we 			<= 1'b0;
			wb_w_data 		<= `zero32;
			wb_hi 			<= `zero32;
			wb_lo 			<= `zero32;
			wb_w_hilo 		<= 1'b0;	
			wb_cp0_we 		<= 1'b0;
			wb_cp0_w_addr 	<= 5'b00000;
			wb_cp0_data 	<= `zero32;		
			wb_pc 			<= `zero32;		  		
			wb_wrall         <= 1'b0;		  	 
			wb_tlb_re   <= 1'b0; 	
            wb_tlb_wi <= 1'b0;
			wb_tlb_wr <= 1'b0;
		end else if(pause[4] & !pause[5]) begin
			wb_w_addr 		<= `zero32;
			wb_we 			<= 1'b0;
			wb_w_data 		<= `zero32;
			wb_hi 			<= `zero32;
			wb_lo 			<= `zero32;
			wb_w_hilo 		<= 1'b0;		
			wb_cp0_we 		<= 1'b0;
			wb_cp0_w_addr 	<= 5'b00000;
			wb_cp0_data 	<= `zero32;				
			wb_wrall         <= 1'b0;	  		  	  	  
			wb_tlb_re   <= 1'b0;
            wb_tlb_wi <= 1'b0;
			wb_tlb_wr <= 1'b0;
		end else if(!pause[4]) begin
			wb_w_addr 		<= mem_w_addr;
			wb_we 			<= mem_we;
			wb_w_data 		<= mem_w_data;
			wb_hi 			<= mem_hi;
			wb_lo 			<= mem_lo;
			wb_w_hilo 		<= mem_w_hilo;			
			wb_cp0_we 		<= mem_cp0_we;
			wb_cp0_w_addr 	<= mem_cp0_w_addr;
			wb_cp0_data 	<= mem_cp0_data;		
			wb_pc 			<= mem_pc;	  		
			wb_wrall     <= mem_wrall;
			wb_tlb_re   <= mem_tlb_re;
            wb_tlb_wi <= mem_tlb_wi;
			wb_tlb_wr <= mem_tlb_wr;
		end
	end
			
endmodule