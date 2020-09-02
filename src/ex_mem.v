`include "defines.v"

module ex_mem(

	input wire						clk,
	input wire						rst,
	input wire[5:0]					pause,	
	input wire                   	clear,
	
	//input from ex
	input wire[31:0]       			ex_w_addr,
	input wire                    	ex_we,
	input wire[31:0]				ex_w_data,

	input wire[31:0]           		ex_hi,
	input wire[31:0]           		ex_lo,		
	input wire                    	ex_w_hilo, 	

	input wire                   	ex_cp0_we,
	input wire[4:0]              	ex_cp0_w_addr,
	input wire[31:0]          		ex_cp0_data,	

  	input wire[7:0]        			ex_op_code,	 
	input wire[31:0]          		ex_mem_addr,
	input wire[31:0]          		ex_operand2,	
  	input wire[31:0]             	ex_exception,
	input wire                   	ex_this_is_delayslot,
	input wire[31:0]          		ex_pc,
	
	
	
	//output to mem
	output reg[31:0]      			mem_w_addr,
	output reg                   	mem_we,
	output reg[31:0]				mem_w_data,
	output reg[31:0]          		mem_hi,
	output reg[31:0]          		mem_lo,
	output reg                   	mem_w_hilo,

  	output reg[7:0]        			mem_op_code,
	output reg[31:0]          		mem_mem_addr,
	output reg[31:0]          		mem_operand2,
	
	output reg                   	mem_cp0_we,
	output reg[4:0]              	mem_cp0_w_addr,
	output reg[31:0]          		mem_cp0_data,
	
	output reg[31:0]            	mem_exception,
  	output reg                  	mem_this_is_delayslot,
	output reg[31:0]         		mem_pc,
		
	output reg[63:0]    			mem_hilo,

	input wire						ex_tlb_wi,
	output reg						mem_tlb_wi,
    input wire						ex_tlb_wr,
	output reg						mem_tlb_wr,
	
	input wire						ex_tlb_re,
	output reg						mem_tlb_re,
	
	input wire                       ex_wrall,
	output reg                    mem_wrall,

	input wire						ex_tlb_find,
	output reg						mem_tlb_find
);


	always @ (posedge clk) begin
		if(!rst) begin
			mem_w_addr 				<= `zero32;
			mem_we 					<= 1'b0;
		  	mem_w_data 				<= `zero32;	
		  	mem_hi 					<= `zero32;
			mem_lo 					<= `zero32;
			mem_w_hilo 				<= 1'b0;		
			mem_op_code 			<= `NOP_OP;
			mem_mem_addr 			<= `zero32;
			mem_operand2 			<= `zero32;	
			mem_cp0_we 				<= 1'b0;
			mem_cp0_w_addr 			<= 5'b00000;
			mem_cp0_data 			<= `zero32;	
			mem_exception 			<= `zero32;
			mem_this_is_delayslot 	<= 1'b0;
	    	mem_pc 					<= `zero32;
			mem_tlb_wi				<= 1'b0;
			mem_tlb_wr				<= 1'b0;
			mem_tlb_find				<= 1'b0;
			mem_wrall                  <= 1'b0;
			mem_tlb_re                   <= 1'b0;
		end else if(clear) begin
			mem_w_addr 				<= `zero32;
			mem_we 					<= 1'b0;
			mem_w_data 				<= `zero32;
			mem_hi 					<= `zero32;
			mem_lo 					<= `zero32;
			mem_w_hilo 				<= 1'b0;
  			mem_op_code 			<= `NOP_OP;
			mem_mem_addr 			<= `zero32;
			mem_operand2 			<= `zero32;
			mem_cp0_we 				<= 1'b0;
			mem_cp0_w_addr 			<= 5'b00000;
			mem_cp0_data 			<= `zero32;
			mem_exception 			<= `zero32;
			mem_this_is_delayslot 	<= 1'b0;
	    	mem_pc 					<= `zero32;
	    	mem_hilo 				<= {`zero32, `zero32};  
            mem_tlb_wi				<= 1'b0;
			mem_tlb_wr				<= 1'b0;
			mem_tlb_find			<= 1'b0;		
			mem_wrall                <= 1'b0;
			mem_tlb_re                   <= 1'b0;
		end else if(pause[3] & !pause[4]) begin
			mem_w_addr 				<= `zero32;
			mem_we 					<= 1'b0;
		  	mem_w_data 				<= `zero32;
		  	mem_hi 					<= `zero32;
			mem_lo 					<= `zero32;
			mem_w_hilo 				<= 1'b0;
  			mem_op_code 			<= `NOP_OP;
			mem_mem_addr 			<= `zero32;
			mem_operand2 			<= `zero32;		
			mem_cp0_we 				<= 1'b0;
			mem_cp0_w_addr 			<= 5'b00000;
			mem_cp0_data 			<= `zero32;	
			mem_exception 			<= `zero32;
			mem_this_is_delayslot 	<= 1'b0;
	       	mem_pc 					<= `zero32;			 
            mem_tlb_wi				<= 1'b0;
			mem_tlb_wr				<= 1'b0;
			mem_tlb_find			<= 1'b0;			    
			mem_wrall                <= 1'b0;
			mem_tlb_re                   <= 1'b0;
		end else if(!pause[3]) begin
			mem_w_addr 				<= ex_w_addr;
			mem_we 					<= ex_we;
			mem_w_data 				<= ex_w_data;	
			mem_hi 					<= ex_hi;
			mem_lo 					<= ex_lo;
			mem_w_hilo 				<= ex_w_hilo;	
  			mem_op_code 			<= ex_op_code;
			mem_mem_addr 			<= ex_mem_addr;
			mem_operand2 			<= ex_operand2;
			mem_cp0_we 				<= ex_cp0_we;
			mem_cp0_w_addr 			<= ex_cp0_w_addr;
			mem_cp0_data 			<= ex_cp0_data;	
			mem_exception 			<= ex_exception;
			mem_this_is_delayslot 	<= ex_this_is_delayslot;
	   		mem_pc 					<= ex_pc;	
			mem_tlb_wi				<= ex_tlb_wi;	
			mem_tlb_wr				<= ex_tlb_wr;	
			mem_tlb_find			<= ex_tlb_find;	
			mem_wrall                <= ex_wrall;
			mem_tlb_re                   <= ex_tlb_re;
		end
	end
endmodule