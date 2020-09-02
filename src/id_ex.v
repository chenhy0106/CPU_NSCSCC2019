`include "defines.v"

module id_ex(

	input wire						clk,
	input wire						rst,
	input wire[5:0]					pause,
	input wire                   	clear,
	
	//input from id
	input wire[7:0]         		id_op_code,
	input wire[2:0]        			id_alu_type,
	input wire[31:0]           		id_operand1,
	input wire[31:0]           		id_operand2,
	input wire[31:0]       			id_w_addr,
	input wire                    	id_we,
	input wire[31:0]           		id_branch_return_addr,
	input wire                    	id_this_is_delayslot,
	input wire                    	id_next_is_delayslot,		
	(*mark_debug = "true"*)input wire[31:0]           		id_inst,		
	(*mark_debug = "true"*)input wire[31:0]           		id_pc,
	input wire[31:0]              	id_exception,
	input wire[2:0] 				id_branch_condition,
	input wire[31:0] 				id_branch_addr,
	input wire[31:0]               id_pc_8,

	input wire[31:0]               id_mem_addr_temp,
	output reg[31:0]               ex_mem_addr_temp,
	
	//output to ex'
	output reg[31:0]               ex_pc_8,
	output reg[2:0] 				ex_branch_condition,
	output reg[31:0] 				ex_branch_addr,
	output reg[7:0]         		ex_op_code,
	output reg[2:0]        			ex_alu_type,
	output reg[31:0]           		ex_operand1,
	output reg[31:0]           		ex_operand2,
	output reg[31:0]       			ex_w_addr,
	output reg                    	ex_we,
	output reg[31:0]           		ex_branch_return_addr,
  	output reg                    	ex_this_is_delayslot,
	output reg                    	ex_next_is_delayslot,
	output reg[31:0]          		ex_pc,	
	output reg[31:0]           		ex_inst,
	output reg[31:0]            	ex_exception,
	
	input wire [1:0]				bpu_counter_in,
	input wire [31:0]				bpu_target_in,
	output reg [1:0]				bpu_counter_out,
	output reg [31:0]				bpu_target_out,
	
    input wire						id_tlb_wi,
	output reg						ex_tlb_wi,
    input wire						id_tlb_wr,
	output reg						ex_tlb_wr,
	
    input wire						id_tlb_re,
	output reg						ex_tlb_re,

	input wire						id_tlb_find,
	output reg						ex_tlb_find
);

	always @ (posedge clk)
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_op_code 				<= `NOP_OP;
		else if(!pause[2]) 
			ex_op_code 				<= id_op_code;
	
	always @ (posedge clk)
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_tlb_wi 				<= 1'b0;
		else if(!pause[2]) 
			ex_tlb_wi 				<= id_tlb_wi;
			
    always @ (posedge clk)
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_tlb_wr 				<= 1'b0;
		else if(!pause[2]) 
			ex_tlb_wr 				<= id_tlb_wr;		
			
    always @ (posedge clk)
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_tlb_re 				<= 1'b0;
		else if(!pause[2]) 
			ex_tlb_re 				<= id_tlb_re;
			
    always @ (posedge clk)
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_tlb_find 				<= 1'b0;
		else if(!pause[2]) 
			ex_tlb_find 				<= id_tlb_find;
			
    always @ (posedge clk)
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_pc_8 				<= `zero32;
		else if(!pause[2]) 
			ex_pc_8				<= id_pc_8;

	always @ (posedge clk) 
		if (!rst | clear |(pause[2] & !pause[3]))
			ex_alu_type 			<= `NOP;
		else if(!pause[2]) 
			ex_alu_type 			<= id_alu_type;
	
    always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
            ex_branch_addr	<= `zero32;
		else if(!pause[2])
			ex_branch_addr 	<= id_branch_addr;

	always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_operand1 			<= `zero32;
		else if(!pause[2]) 
			ex_operand1 			<= id_operand1;


	always @ (posedge clk) 
		if (!rst |clear | (pause[2] & !pause[3]))
			ex_operand2 			<= `zero32;
		else if(!pause[2]) 
			ex_operand2 			<= id_operand2;
		

	always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_w_addr 				<= `zero32;
		else if(!pause[2])
			ex_w_addr 				<= id_w_addr;

	always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_we 					<= 1'b0;
		else if(!pause[2]) 
			ex_we 					<= id_we;		
	


	always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_branch_return_addr 	<= `zero32;			
		else if(!pause[2]) 
			ex_branch_return_addr 	<= id_branch_return_addr;
	


	always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_this_is_delayslot 	<= 1'b0;
		else if(!pause[2])
			ex_this_is_delayslot 	<= id_this_is_delayslot;

	always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_next_is_delayslot 	<= 1'b0;	
		else if(!pause[2]) 
	    	ex_next_is_delayslot 	<= id_next_is_delayslot;
	

	always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_inst 				<= `zero32;
		else if(!pause[2]) 
			ex_inst 				<= id_inst;			

	always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
			ex_exception 			<= `zero32;
		else if(!pause[2]) 
			ex_exception 			<= id_exception;

	always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
	       	ex_pc 					<= `zero32;	
		else if(!pause[2]) 
			ex_pc 					<= id_pc;	

	always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
            ex_branch_condition 	<= `NOT_BRANCH;
		else if(!pause[2])
			ex_branch_condition 	<= id_branch_condition;
	
	

//	always @ (posedge clk) 
//		if (!rst | clear | (pause[2] & !pause[3]))
//	       	ex_branch_addr_type 	<= `NOT_BRANCH;
//		else if(!pause[2]) 		
//			ex_branch_addr_type 	<= id_branch_addr_type;

	always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
			bpu_counter_out 		<= 2'b00;
		else if(!pause[2])
			bpu_counter_out		 	<= bpu_counter_in;

	always @ (posedge clk) 
		if (!rst | clear | (pause[2] & !pause[3]))
			bpu_target_out 			<= `zero32;
		else if(!pause[2]) 		
			bpu_target_out 			<= bpu_target_in;
    
    always @ (posedge clk) 
    if (!rst | clear | (pause[2] & !pause[3]))
        ex_mem_addr_temp 			<= `zero32;
    else if(!pause[2]) 		
        ex_mem_addr_temp 			<= id_mem_addr_temp;
endmodule