`include "defines.v"

module ex(
	input wire						rst,

	//from id
	input wire[7:0]         	op_code_i,
	input wire[2:0]        		alu_type,
	input wire[31:0]           	operand1,
	input wire[31:0]           	operand2,
	input wire                    	we_i,
	input wire[31:0]           	inst,	
	input wire[31:0]          	inst_addr,
	
	//from hilo reg
	input wire[31:0]           	hi_i,
	input wire[31:0]           	lo_i,

	//wb stage write hilo reg
	input wire[31:0]           	wb_hi_i,
	input wire[31:0]           	wb_lo_i,
	input wire                    	wb_whilo_i,
	
	//mem stage write hilo reg
	input wire[31:0]           	mem_hi_i,
	input wire[31:0]           	mem_lo_i,
	input wire                    	mem_whilo_i,
    
	//from dcache
    input wire                      wait_dcache,
	input wire[31:0]              	dcache_addr,
    
	//from mul module
    input wire[63:0]                mul_result_i,
    input wire                      mul_ready,	
	output wire              		mul_sel,
	output wire[31:0]       		mul_A,
	output wire[31:0]       		mul_B,

	//mem stage write cp0
  	input wire                    	mem_cp0_we,
	input wire[4:0]               	mem_cp0_w_addr,
	input wire[31:0]           	mem_cp0_wdata,
	
	//wb stage write cp0
  	input wire                    	wb_cp0_we,
	input wire[4:0]               	wb_cp0_w_addr,
	input wire[31:0]           	wb_cp0_wdata,

	//read from cp0
	input wire[31:0]           	cp0_data_i,
	output wire[4:0]               	cp0_r_addr_o,

	//write cp0
	output wire                    	cp0_we_o,
	output wire[4:0]               	cp0_w_addr_o,
	output wire[31:0]           	cp0_data_o,
	
	//to write back
	output wire                    	we_o,
	output wire[31:0]			wdata_o,

	//to hilo reg
	output wire[31:0]           	hi_o,
	output wire[31:0]           	lo_o,
	output wire                    	whilo_o,

	input wire[63:0]				div_result_i,
	input wire						div_valid,
	output wire                    	div_sel,
	output wire                    	div_sign,

	//output to dcache directly
	output wire[31:0]          		mem_addr_o,
	
	input wire[31:0]              	exception_i,
	output wire[31:0]             	exception_o,

	output wire						pause,

	//branch
	input wire 						branch_predict_flg,
	input wire[31:0]				branch_predict_addr,
	output wire 					ex_is_branch,
	input wire[2:0]         		branch_condition,
	input wire[31:0]     			branch_addr_i,
	input wire[31:0]             branch_return_addr,
	input wire[31:0]             pc_8,
	output reg              		branch,
	output wire[31:0]        		branch_addr_o,	

	// //tlb
	output wire						cp0_wrall_o,
	
    input wire[31:0]                   mem_addr_temp
);

	wire wait_div;
	assign pause = wait_div | mul_sel;
	
	assign mem_addr_o[11:0] = wait_dcache ? dcache_addr[11:0] : mem_addr_temp[11:0];
	assign mem_addr_o[31:12] = mem_addr_temp[31:12];

///////////select result to output/////////////	
	wire[31:0] logic;
	wire[31:0] shift;
	wire[31:0] move;
	wire[31:0] arithmetic;	
	assign wdata_o = 	(alu_type==`LOGIC) ? logic :
						(alu_type==`SHIFT) ? shift :
						(alu_type==`MOVE)	? move :
						(alu_type==`ARITHMETIC) ? arithmetic : 
						(alu_type==`JUMP_BRANCH) ? branch_return_addr : `zero32;
//////////////////////process branch////////////////////////////////////
	reg branch_real;
	always@(*) begin
		case(branch_condition)
			`EB: 	branch_real = (operand1 == operand2);
			`NEB: 	branch_real = (operand1 != operand2 );
			`GEB: 	branch_real = ~operand1[31];
			`GB: 	branch_real = ~operand1[31] & |operand1[30:0];
			`LBr: 	branch_real = operand1[31];
			`LEB: 	branch_real = operand1[31] | (operand1 == `zero32);
			`NC: 	branch_real = 1'b1;
			default:branch_real = 1'b0;
		endcase
	end

	assign ex_is_branch = (branch_condition != 3'b0);
	always@(*) begin
		if(ex_is_branch & !branch_real & !branch_predict_flg)			
			branch = 0;
		else if(ex_is_branch & (branch_real != branch_predict_flg))	 	
			branch = 1;
		else if(ex_is_branch & branch_real & branch_predict_flg)	
			branch = (branch_predict_addr != branch_addr_i);
		else 
			branch = 0;
	end

	reg predict_true;
	always @(*) begin
		if( ex_is_branch & !branch_real & !branch_predict_flg)	
			predict_true = 1;
		else if( ex_is_branch && (branch_real != branch_predict_flg ))	 
			predict_true = 0;
		else if(ex_is_branch && branch_real & branch_predict_flg)	
			predict_true = (branch_predict_addr != branch_addr_o);
		else 	
			predict_true = 1'bx;
	end

    assign branch_addr_o = branch_real ? branch_addr_i : pc_8;
////////////////////////////logic////////////////////////
	assign logic = 	(op_code_i==`OR_OP) ? operand1 | operand2 :
					(op_code_i==`AND_OP) ? operand1 & operand2 :
					(op_code_i==`NOR_OP) ? ~(operand1 | operand2) : 
					(op_code_i==`XOR_OP) ? operand1 ^ operand2 : `zero32;

////////////////////////shift///////////////////////////
	assign shift = 	(op_code_i==`SLL_OP) ? operand2 << operand1[4:0] : 
					(op_code_i==`SRL_OP) ? operand2 >> operand1[4:0] :
					(op_code_i==`SRA_OP) ? ({32{operand2[31]}} << (6'd32-{1'b0, operand1[4:0]})) | operand2 >> operand1[4:0] : `zero32;

///////////////////arithmetic///////////////////////////	
    wire[63:0] mul_result;
	wire[31:0] operand2_complement;
	wire[31:0] sum;
	wire operand1_l_operand2;	
	assign operand2_complement = ((op_code_i == `SUB_OP) || (op_code_i == `SUBU_OP) || (op_code_i == `SLT_OP)) ? (~operand2) + 1 : operand2;
	assign sum = operand1 + operand2_complement;						
	assign operand1_l_operand2 = (op_code_i == `SLT_OP) ? ((operand1[31] & !operand2[31]) | (!operand1[31] & !operand2[31] & sum[31]) |
			            				(operand1[31] & operand2[31] & sum[31])) : (operand1 < operand2);
	assign arithmetic = (op_code_i==`SLT_OP)|(op_code_i==`SLTU_OP) ? operand1_l_operand2 :
						(op_code_i==`ADD_OP)|(op_code_i==`ADDU_OP)|(op_code_i==`ADDIU_OP)
						|(op_code_i==`SUB_OP)|(op_code_i==`SUBU_OP)|(op_code_i==`ADDI_OP) ? sum : 
						(op_code_i == `MUL_OP) ? mul_result[31:0] : `zero32;

////////////////////////MFHI MFLO//////////////////////
	wire[31:0] HI;
	wire[31:0] LO;
	wire mem_cp0_hazard, wb_cp0_hazard;
	assign cp0_r_addr_o = inst[15:11];
	assign mem_cp0_hazard = mem_cp0_we & (mem_cp0_w_addr == inst[15:11]);
	assign wb_cp0_hazard = wb_cp0_we & (wb_cp0_w_addr == inst[15:11]);
	assign HI = mem_whilo_i ? mem_hi_i : wb_whilo_i ? wb_hi_i : hi_i;
	assign LO = mem_whilo_i ? mem_lo_i : wb_whilo_i ? wb_lo_i : lo_i;

	assign move = 	(op_code_i==`MFHI_OP) ? HI :
					(op_code_i==`MFLO_OP) ? LO :
					(op_code_i==`MFC0_OP) ? (mem_cp0_hazard ? mem_cp0_wdata : 
												wb_cp0_hazard ? wb_cp0_wdata : cp0_data_i) : `zero32; 

////////////////////////////////check overflow///////////////////
	wire overflow;
	assign exception_o = {exception_i[31:12],overflow,1'b0,exception_i[9:6],6'b0000000};
	assign overflow = ((!operand1[31] & !operand2_complement[31] & sum[31]) | (operand1[31] & operand2_complement[31] & !sum[31]))
						& ((op_code_i == `ADD_OP) || (op_code_i == `ADDI_OP) || (op_code_i == `SUB_OP)) ? 1'b1 : 1'b0; 
	assign we_o	= overflow ? 1'b0 : we_i;

////////////////////////////////move to HILO reg///////////////////
	wire is_mul;
	
	assign is_mul 	= (op_code_i == `MULT_OP) || (op_code_i == `MULTU_OP) || (op_code_i == `MUL_OP);
	assign whilo_o 	= is_mul | div_sel | (op_code_i==`MTHI_OP) | (op_code_i==`MTLO_OP);
	assign hi_o		= 	is_mul ? mul_result[63:32] : 
						div_sel ? div_result_i[31:0] : 
						op_code_i==`MTHI_OP ? operand1 :
						op_code_i==`MTLO_OP ? HI : `zero32;
	assign lo_o		= 	is_mul ? mul_result[31:0] : 
						div_sel ? div_result_i[63:32] : 
						op_code_i==`MTHI_OP ? LO :
						op_code_i==`MTLO_OP ? operand1 : `zero32;			

/////////////////////////////write cp0 reg///////////////////////
	assign cp0_w_addr_o = inst[15:11];
	assign cp0_we_o		= (op_code_i==`MTC0_OP);
	assign cp0_data_o 	= operand1;	

	// assign tlb_re_o 	= (op_code_i==`TLBR);
	assign cp0_wrall_o	= (op_code_i==`TLBR_OP);

//////////////////////////call multiplier IP////////////////////
	wire[63:0] mul_temp;
	assign mul_temp = (is_mul&mul_ready) ? mul_result_i : 64'b0;
	assign mul_sel	= is_mul & ~mul_ready;
	assign mul_result = ((op_code_i==`MULT_OP || op_code_i == `MUL_OP) & (operand1[31]^operand2[31])) ? ~mul_temp + 1 : mul_temp;
	assign mul_A = ((op_code_i == `MULT_OP || op_code_i == `MUL_OP) && operand1[31]) ? (~operand1 + 1) : operand1;
	assign mul_B = ((op_code_i == `MULT_OP || op_code_i == `MUL_OP) && operand2[31]) ? (~operand2 + 1) : operand2;		             																		

///////////////////////call div ipָ///////////////////////////	
	assign div_sel = (op_code_i==`DIV_OP) | (op_code_i==`DIVU_OP);
	assign wait_div = div_sel & ~div_valid;
	assign div_sign = (op_code_i==`DIV_OP);

//////////////////////tlb//////////////////////////////////////

endmodule