`include "defines.v"

module id(
    input wire						rst,
    input wire[31:0]		        pc_i,
    input wire[31:0]                inst_i,
    input wire                          inst_found,
    input wire                          inst_v,
    
      //pre_is_load
    input wire[7:0]			        ex_opcode_i,

    input wire						ex_we_i,
    input wire[31:0]				ex_wdata_i,
    input wire[31:0]                ex_waddr_i,
    
    input wire						mem_we_i,
    input wire[31:0]				mem_wdata_i,
    input wire[31:0]                mem_waddr_i,
    
    input wire[31:0]                operand1_i,
    input wire[31:0]                operand2_i,

    input wire                      this_is_delayslot_i,

    output reg                      operand1_re_o,
    output reg                      operand2_re_o,     
    output wire[31:0]               operand1_addr_o,
    output wire[31:0]               operand2_addr_o, 	      
    
    output reg[2:0]                 branch_condition,
    output reg[2:0]                 branch_addr_type,
    output reg[31:0]                branch_return_addr_o,
    output reg[31:0]               branch_addr_o,
    output wire[31:0]               pc_8,

    output reg[7:0]                 opcode_o,
    output reg[2:0]                 alu_type_o,
    output reg[31:0]                operand1_o,
    output reg[31:0]                operand2_o,
    output reg[31:0]                waddr_o,
    output reg                      we_o,

    output reg                      next_is_delayslot_o,
    output wire                     this_is_delayslot_o,

    output wire[31:0]               exception_o,

    output wire                     tlb_wr_o,
    output wire                     tlb_re_o,
    output wire                     tlb_find_o,
    output wire                     tlb_wi_o,
    
    output wire[31:0]             mem_addr_temp,
    
    output wire                     pause                 
);

    wire[5:0] op = inst_i[31:26];
    wire[4:0] op2 = inst_i[10:6];
    wire[5:0] func = inst_i[5:0];
    wire[4:0] op4 = inst_i[20:16];
    reg[31:0]	imm;
    reg instvalid;
    wire[31:0] pc_plus_8;


    wire wait_operand1_load;
    wire wait_operand2_load;
    wire pre_inst_is_load;
    wire exception_syscall;
    wire exception_eret;
    wire exception_break;

    assign pc_plus_8 = pc_i + 8;
    assign mem_addr_temp = operand1_o + {{16{inst_i[15]}},inst_i[15:0]};

    assign pause = wait_operand1_load | wait_operand2_load;
    assign pre_inst_is_load = ((ex_opcode_i == `LB_OP) || 
                            (ex_opcode_i == `LBU_OP)||
                            (ex_opcode_i == `LH_OP) ||
                            (ex_opcode_i == `LHU_OP)||
                            (ex_opcode_i == `LW_OP)||
                            (ex_opcode_i == `LWL_OP)||
                            (ex_opcode_i == `LWR_OP)) ? 1'b1 : 1'b0;

      assign exception_o = {17'b0,~inst_v, ~inst_found,exception_eret,2'b0, ~instvalid, exception_syscall,1'b0, exception_break,6'b0};

//////////////////////opcode//////////////////////////////////
    always @ (*) begin	
        if (!rst)
            opcode_o = `NOP_OP;	
        else if(!inst_v || !inst_found)
            opcode_o = `NOP_OP;
        else if(inst_i == `ERET) 
            opcode_o = `ERET_OP;					
        else if(inst_i[31:21] == 11'b01000000100 && inst_i[10:3] == 8'b0)
            opcode_o = `MTC0_OP;	
        else if(inst_i[31:21] == 11'b01000000000 && inst_i[10:3] == 8'b0)
                opcode_o = `MFC0_OP;	
        else
            case (op)
            `SPECIAL_INST:  begin
                case(func)
                    `SLL:       opcode_o = `SLL_OP;
                    `SRL:       opcode_o = `SRL_OP;
                    `SRA:       opcode_o = `SRA_OP;
                    `SYSCALL:   opcode_o = `SYSCALL_OP;
                    `OR:        opcode_o = `OR_OP;
                    `AND:	    opcode_o = `AND_OP; 	
                    `XOR:	    opcode_o = `XOR_OP;				
                    `NOR:	    opcode_o = `NOR_OP;
                    `SLLV:      opcode_o = `SLL_OP;
                    `SRLV:      opcode_o = `SRL_OP;					
                    `SRAV:      opcode_o = `SRA_OP;
                    `MFHI:      opcode_o = `MFHI_OP;
                    `MFLO:      opcode_o = `MFLO_OP;
                    `MTHI:      opcode_o = `MTHI_OP;
                    `MTLO:      opcode_o = `MTLO_OP;
                    `SLT:       opcode_o = `SLT_OP;
                    `SLTU:      opcode_o = `SLTU_OP;
                    `ADD:       opcode_o = `ADD_OP;
                    `ADDU:      opcode_o = `ADDU_OP;
                    `SUB:       opcode_o = `SUB_OP;
                    `SUBU:      opcode_o = `SUBU_OP;
                    `MULT:      opcode_o = `MULT_OP;
                    `MULTU:     opcode_o = `MULTU_OP;
                    `DIV:       opcode_o = `DIV_OP;
                    `DIVU:      opcode_o = `DIVU_OP;
                    `JR:        opcode_o = `JR_OP;
                    `JALR:      opcode_o = `JALR_OP;												 											  											
                default:	    opcode_o = `NOP_OP;
                endcase		
            end						  
            `SPECIAL2_INST: begin
                case(func)
                    `MUL: opcode_o = `MUL_OP;
                endcase
             end
              `ORI:   opcode_o = `OR_OP;
            `ANDI:  opcode_o = `AND_OP;
            `XORI:  opcode_o = `XOR_OP;
            `ADDIU: opcode_o = `ADDIU_OP;
            `LUI:   opcode_o = `OR_OP;
            `SLTI:  opcode_o = `SLT_OP;
            `SLTIU: opcode_o = `SLTU_OP;
            `ADDI:	opcode_o = `ADDI_OP;
            `J:	    opcode_o = `J_OP;
            `JAL:   opcode_o = `JAL_OP;
            `BEQ:	opcode_o = `BEQ_OP;
            `BGTZ:	opcode_o = `BGTZ_OP;
            `BLEZ:	opcode_o = `BLEZ_OP;
            `BNE:	opcode_o = `BLEZ_OP;
            `LB:	opcode_o = `LB_OP;
            `LBU:	opcode_o = `LBU_OP;
            `LH:	opcode_o = `LH_OP;
            `LHU:	opcode_o = `LHU_OP;
            `LW:	opcode_o = `LW_OP;
            `SB:	opcode_o = `SB_OP;
            `SH:	opcode_o = `SH_OP;
            `SW:	opcode_o = `SW_OP;
            `LWL:opcode_o = `LWL_OP;
            `LWR:opcode_o = `LWR_OP;
            `SWR:opcode_o = `SWR_OP;
            `SWL:opcode_o = `SWL_OP;
            `REGIMM_INST:
                case (op4)
                `BGEZ:	opcode_o = `BGEZ_OP;
                `BGEZAL:opcode_o = `BGEZAL_OP;
                `BLTZ:	opcode_o = `BGEZAL_OP;
                `BLTZAL:opcode_o = `BGEZAL_OP;					
                default:	opcode_o = `NOP_OP;
                endcase	
            `COP0:
                case(func)
                    `TLBR:opcode_o = `TLBR_OP;	
                     default:
                    opcode_o = `NOP_OP;
                endcase																												  	
            default:    opcode_o = `NOP_OP;
            endcase
    end

/////////////////////alu type/////////////////////////////
    always @ (*) begin	
        if (!rst) 
            alu_type_o = `NOP;	
        else if(inst_i == `ERET) 
            alu_type_o = `NOP;   				
        else if(inst_i[31:21] == 11'b01000000000 && inst_i[10:3] == 8'b0) 
            alu_type_o = `MOVE;	
        else if(inst_i[31:21] == 11'b01000000100 && inst_i[10:3] == 8'b0) 
            alu_type_o = `NOP;
        else begin	
            case (op)
            `SPECIAL_INST:
                case (func)
                  `SYSCALL, `BREAK:   
                    alu_type_o = `NOP;    
                `OR, `AND, `XOR, `NOR:	    
                    alu_type_o = `LOGIC; 	
                `SLLV,`SRLV,`SRAV, `SLL, `SRL, `SRA:      
                    alu_type_o = `SHIFT;	
                `MFHI,`MFLO:      
                    alu_type_o = `MOVE;   
                `SLT, `SLTU,`ADD,`ADDU,`SUB,`SUBU:       
                    alu_type_o = `ARITHMETIC;				
                `JR,`JALR:        
                    alu_type_o = `JUMP_BRANCH;   
                default:	    alu_type_o = `NOP;
                endcase					
            `SPECIAL2_INST: 
            case(func)
                `MUL: alu_type_o = `ARITHMETIC;	
                default: alu_type_o = `NOP;
            endcase  									  
            `ORI, `ANDI, `XORI,`LUI:	
                alu_type_o = `LOGIC; 
            `ADDIU,`SLTI,`SLTIU, `ADDI:    
                alu_type_o = `ARITHMETIC; 
            `J,`JAL,`BEQ,`BGTZ,`BLEZ,`BNE:		
                alu_type_o = `JUMP_BRANCH; 
            `REGIMM_INST:
                case (op4)
                `BGEZ, `BGEZAL, `BLTZ, `BLTZAL:	alu_type_o = `JUMP_BRANCH; 
                default:	alu_type_o = `NOP;	
                endcase

            default:		alu_type_o = `NOP;	
            endcase
        end
    end

///////////////////////wb reg addr//////////////////////////
    always @ (*) begin	
        if (!rst) 
            waddr_o = 5'b00000;	
        else if(inst_i[31:21] == 11'b01000000000 && inst_i[10:3] == 8'b0) 
            waddr_o = inst_i[20:16];	
        else
            case (op)					  
              `ORI,`ANDI,`XORI,`LUI,`SLTI,`SLTIU,`ADDI,
            `LB,`LBU,`LH,`LHU,`LW, `LWL, `LWR, `ADDIU:	
                waddr_o = inst_i[20:16];
            `JAL:	waddr_o = 5'b11111;	
            `REGIMM_INST:
                case (op4)
                `BGEZAL, `BLTZAL:	waddr_o = 5'b11111;  						
                default:    waddr_o = inst_i[15:11];	
                endcase																													  	
            default:	waddr_o = inst_i[15:11];	
            endcase
    end

///////////////////wb write enable////////////////////
    always @ (*) begin	
        if (!rst) 
            we_o = 1'b0;	
        else if(inst_i == `ERET) 
            we_o = 1'b0;						
        else if(inst_i[31:21] == 11'b01000000000 && inst_i[10:3] == 8'b0)
            we_o = 1'b1;
        else if(inst_i[31:21] == 11'b01000000100 && inst_i[10:3] == 8'b0)
            we_o = 1'b0;			
        else
            case (op)
            `SPECIAL_INST:
                case (func)
                `OR,`AND,`XOR,`NOR,`SLLV,`SRLV,
                `SRAV,`MFHI,`MFLO,`SLT,`SLTU,`ADD,
                `ADDU,`SUB,`SUBU,`JALR: 
                    we_o = (op2==5'b00000);	
                `SLL, `SRL, `SRA:
                    we_o = (inst_i[25:21]==5'b00000);
                default:	we_o = 1'b0;
                endcase												  
            `ORI,`ANDI,`XORI,`ADDIU,`LUI,`SLTI,`SLTIU,
            `ADDI,`JAL,`LB,`LBU,`LH,`LHU,`LW, `LWL, `LWR:	
                we_o = 1'b1;							
            `REGIMM_INST:
                case (op4)
                `BGEZAL,`BLTZAL:
                    we_o = 1'b1;							
                default:	we_o = 1'b0;	
                endcase	
            default:	we_o = 1'b0;	
            endcase		  
    end

/////////////////////////inst valid///////////////////////////////
    always @ (*) begin	
        if (!rst)
            instvalid = 1'b1;	
        else if(inst_i == `ERET) 
            instvalid = 1'b1; 		
        else if(inst_i[31:21] == 11'b01000000000 && inst_i[10:3] == 8'b0)//mfc0
            instvalid = 1'b1;	   
        else if(inst_i[31:21] == 11'b01000000100 && inst_i[10:3] == 8'b0)
            instvalid = 1'b1;	 	
        else  
            case (op)
            `SPECIAL_INST:
                case (func)
                    `SYSCALL:   instvalid = 1'b1; 
                    `BREAK:     instvalid = 1'b1;	
                    `SYNC: instvalid = 1'b1;
                    `OR,`AND,`XOR,`NOR,`SLLV,`SRLV,`SRAV,
                    `MFHI,`MFLO,`MTHI,`MTLO,`SLT,`SLTU,`ADD,
                    `ADDU,`SUB,`SUBU,`MULT,`MULTU,`DIV,`DIVU,
                    `JR,`JALR:  
                        instvalid = (op2==5'b00000);
                    `SLL,`SRL,`SRA:
                        instvalid = (inst_i[25:21]==5'b00000);		
                    default:	instvalid = 1'b0;	   
                endcase	
            `SPECIAL2_INST: 
                case(func)
                    `MUL: instvalid = 1'b1;
                    default: instvalid = 1'b0;
                endcase 
            `CACHE: instvalid = 1'b1;							
            `ORI,`ANDI,`XORI,`ADDIU,`LUI,`SLTI,`SLTIU,`ADDI,
            `J,`JAL,`BEQ,`BGTZ,`BLEZ,`BNE,`LB,`LBU,`LH,
            `LHU,`LW,`SB,`SH,`SW,`LWL,`LWR,`SWR,`SWL:	
                instvalid = 1'b1;		
            `REGIMM_INST:
                case (op4)
                `BGEZ:	instvalid = 1'b1;	
                `BGEZAL:instvalid = 1'b1;
                `BLTZ:	instvalid = 1'b1;	
                `BLTZAL:instvalid = 1'b1;				
                default:	instvalid = 1'b0;	   
                endcase	
            `COP0:
                case(func)
                `TLBWI: instvalid = 1'b1;
                `TLBR:instvalid = 1'b1;
                `TLBP:instvalid = 1'b1;
                `TLBWR: instvalid = 1'b1;
                default: instvalid = 1'b0;
                endcase
            default:    instvalid = 1'b0;	   
        endcase	
    end

//////////////////////read operand1 enable////////////////////////////////
    always @ (*) begin	
        if (!rst)
            operand1_re_o = 1'b0;	
        else if(inst_i == `ERET) 
            operand1_re_o = 1'b0;				
        else if(inst_i[31:21] == 11'b01000000000 && inst_i[10:3] == 8'b0) 
            operand1_re_o = 1'b0;
        else if(inst_i[31:21] == 11'b01000000100 && inst_i[10:3] == 8'b0) 
            operand1_re_o = 1'b1;		
        else begin   
            case (op)
            `SPECIAL_INST:
                case (func)
                    `SYSCALL: operand1_re_o = 1'b0;	
                    `BREAK:   operand1_re_o = 1'b0;	
                    `OR,`AND,`XOR,`NOR,`SLLV,`SRLV,`SRAV,
                    `MFHI,`MFLO,`MTHI,`MTLO,`SLT,`SLTU,`ADD,
                    `ADDU,`SUB,`SUBU,`MULT,`MULTU,`DIV,`DIVU,
                    `JR,`JALR:  
                        operand1_re_o = (op2 == 5'b00000);	
                    `SLL,`SRL,`SRA:
                        operand1_re_o = 1'b0;
                    default:	operand1_re_o = 1'b0;	
                endcase	
            `SPECIAL2_INST: 
                case(func)
                    `MUL: operand1_re_o = 1'b1;
                    default: operand1_re_o = 1'b0;
                endcase   
            `ORI,`ANDI,`XORI,`ADDIU,`SLTI,`SLTIU,`ADDI,`BEQ,
            `BGTZ,`BLEZ,`BNE,`LB,`LBU,`LH,`LHU,`LW,`SB,`SH,
            `SW, `SWL,`SWR, `LWL, `LWR:	
                operand1_re_o = 1'b1;	
            `REGIMM_INST:
                case (op4)
                `BGEZ,`BGEZAL,`BLTZ,`BLTZAL:
                    operand1_re_o = 1'b1;						
                default:	operand1_re_o = 1'b0;	
                endcase																											  	
            default:	operand1_re_o = 1'b0;	
            endcase	
        end
    end

//////////////////operand2 read enable////////////////////////
    always @ (*) begin	
        if (!rst)
            operand2_re_o = 1'b0;	
        else if(inst_i == `ERET)
            operand2_re_o = 1'b0;				
        else if(inst_i[31:21] == 11'b01000000000 && inst_i[10:3] == 8'b0)
            operand2_re_o = 1'b0;		
        else if(inst_i[31:21] == 11'b01000000100 && inst_i[10:3] == 8'b0)
            operand2_re_o = 1'b0;	  
        else begin
            operand2_re_o = 1'b0;
            case (op)
            `SPECIAL_INST:	
                case (func)
                `OR,`AND,`XOR,`NOR,`SLLV,`SRLV,`SRAV,`SLT,`SLTU,
                `ADD,`ADDU,`SUB,`SUBU,`MULT,`MULTU,`DIV,`DIVU:  
                    operand2_re_o = (op2 == 5'b00000);
                `SLL,`SRL,`SRA:
                    operand2_re_o = 1'b1;
                default:	operand2_re_o = 1'b0;
                endcase
            `SPECIAL2_INST: 
                case(func)
                    `MUL: operand2_re_o = 1'b1;
                    default: operand2_re_o = 1'b0;
                endcase  
            `BEQ,`BNE,`SB,`SH,`SW,`SWL,`SWR, `LWL, `LWR:	
                operand2_re_o = 1'b1;  																						  	
            default:	operand2_re_o = 1'b0;
            endcase		  //case op
        end
    end

///////////////operand1 reg addr ///////////////////////////
    assign operand1_addr_o = (inst_i[31:21]==11'b01000000100)&(inst_i[10:3] == 8'b0) ? 
                                                    inst_i[20:16] : inst_i[25:21];	
///////////////operand2 reg addr/////////////////////////////////
    assign operand2_addr_o = inst_i[20:16];	

/////////////////imm//////////////////////////
    always @ (*) begin	
        if (!rst) 
            imm = 32'h0;		
        else if (inst_i[31:21] == 11'b00000000000 & (func == `SLL | func == `SRL | func == `SRA)) 
            imm[4:0] = inst_i[10:6];		
        else 
            case (op)
            `ORI,`ANDI,`XORI:	
                imm = {16'h0, inst_i[15:0]};	
            `LUI:	imm = {inst_i[15:0], 16'h0};			
            `ADDIU,`SLTI,`SLTIU,`ADDI:	
                imm = {{16{inst_i[15]}}, inst_i[15:0]};																															  	
            default:	imm = `zero32;
            endcase		
    end

///////////////////////////branch return addr//////////////////////////
    always @ (*) begin	
        if (!rst)
            branch_return_addr_o = `zero32;
        else
            case (op)
            `SPECIAL_INST:
                case (func)		
                `JALR:  branch_return_addr_o = pc_plus_8;												 											  											
                default:	branch_return_addr_o = `zero32;
                endcase	
            `JAL:	branch_return_addr_o = pc_plus_8 ;					
            `REGIMM_INST:
                case (op4)
                `BGEZAL,`BLTZAL:	
                    branch_return_addr_o = pc_plus_8;					
                default:	    branch_return_addr_o = `zero32;
                endcase																											  	
            default:	branch_return_addr_o = `zero32;
            endcase
    end

//////////////////////////////next is delayslot//////////////////////////
    always @ (*) begin	
        if (!rst)
            next_is_delayslot_o = 1'b0;
        else 
            next_is_delayslot_o = 1'b0;	
            case (op)
            `SPECIAL_INST:	
                case (func)			
                `JR,`JALR:  
                    next_is_delayslot_o = 1'b1;
                default:	next_is_delayslot_o = 1'b0;	
                endcase																  
            `J,`JAL,`BEQ,`BGTZ,`BLEZ,`BNE:	
                next_is_delayslot_o = 1'b1;								
            `REGIMM_INST:		begin
                case (op4)
                    `BGEZ,`BGEZAL,`BLTZ,`BLTZAL:
                        next_is_delayslot_o = 1'b1;	
                    default:	next_is_delayslot_o = 1'b0;	
                    endcase
                end																															  	
            default:	next_is_delayslot_o = 1'b0;	
            endcase
    end

/////////////////eret syscall break///////////////
assign exception_syscall = (op==`SPECIAL_INST) & (func==`SYSCALL);

assign exception_eret = (inst_i==`ERET);

assign exception_break = (op==`SPECIAL_INST)&(func==`BREAK);

////////////////branch compare///////////////////////
    always @ (*) begin	
        if (!rst) 
            branch_condition = `NOT_BRANCH;
        else 
            case (op)
            `SPECIAL_INST:
                case (func)		
                `JR,`JALR:  
                    branch_condition = `NC;
                default:	branch_condition = `NOT_BRANCH;
                endcase																  
            `J,`JAL:	
                branch_condition = `NC;
            `BEQ:	branch_condition = `EB;
            `BGTZ:	branch_condition = `GB;
            `BLEZ:	branch_condition = `LEB;
            `BNE:	branch_condition = `NEB;
            `REGIMM_INST:
                case (op4)
                `BGEZ,`BGEZAL:
                    branch_condition = `GEB;
                `BLTZ,`BLTZAL:
                    branch_condition = `LBr;
                default:	branch_condition = `NOT_BRANCH;
                endcase	
            default:	branch_condition = `NOT_BRANCH;
            endcase
    end

///////////////////branch addr type//////////////////////
    wire[31:0] imm_sll2_signedext = {{14{inst_i[15]}}, inst_i[15:0], 2'b00 };  
    wire[31:0] pc_4 = pc_i + 4;
    wire[31:0] rel_branch_addr = pc_4 + imm_sll2_signedext;
    wire[31:0] fdir = {pc_4[31:28], inst_i[25:0], 2'b00};
    assign pc_8 = pc_i + 8;
    always @ (*) begin	
        if (!rst) 
            branch_addr_o = 32'b0;				
        else
            branch_addr_o = 32'b0;			
            case (op)
            `SPECIAL_INST:
                case (func)		
                `JR,`JALR: 
                    branch_addr_o = operand1_o;									 											  											
                default:	branch_addr_o = 32'b0;		
                endcase									
            `J,`JAL:	
                branch_addr_o = fdir;
            `BEQ,`BGTZ,`BLEZ,`BNE:	
                branch_addr_o = rel_branch_addr;					
            `REGIMM_INST:
                case (op4)
                `BGEZ,`BGEZAL,`BLTZ,`BLTZAL:
                    branch_addr_o = rel_branch_addr;
                default:	branch_addr_o = 32'b0;				
                endcase
            endcase		  
    end

//////////////////operand1 source///////////////////
    always @ (*) begin
        if(!rst)
            operand1_o = `zero32;	
        else if(pre_inst_is_load & (ex_waddr_i==operand1_addr_o) & operand1_re_o )
            operand1_o = 32'b0;			
        else if(operand1_re_o & ex_we_i & (ex_waddr_i == operand1_addr_o))
            operand1_o = ex_wdata_i;
        else if(operand1_re_o & mem_we_i & (mem_waddr_i == operand1_addr_o))
            operand1_o = mem_wdata_i;	 			
        else if(operand1_re_o)
            operand1_o = operand1_i;
        else if(!operand1_re_o)
            operand1_o = imm;
        else
            operand1_o = `zero32;
    end

//////////////////stall for operand1 load from mem//////////////////
    assign wait_operand1_load = pre_inst_is_load & (ex_waddr_i == operand1_addr_o & operand1_re_o);

////////////////operand2 source//////////////////////
    always @(*) begin
        if(!rst)
            operand2_o = `zero32;
        else if(pre_inst_is_load & ex_waddr_i == operand2_addr_o & operand2_re_o)
            operand2_o = 32'b0;
        else if(operand2_re_o & ex_we_i & (ex_waddr_i == operand2_addr_o)) 
            operand2_o = ex_wdata_i;
        else if(operand2_re_o & mem_we_i & (mem_waddr_i == operand2_addr_o))
            operand2_o = mem_wdata_i;		
        else if(operand2_re_o) 
            operand2_o = operand2_i;
        else if(!operand2_re_o) 
            operand2_o = imm;
        else
            operand2_o = `zero32;
    end

//////////////////stall fro operand1 load from mem//////////////////////////////
    assign wait_operand2_load = (pre_inst_is_load & (ex_waddr_i == operand2_addr_o) & operand2_re_o);

///////////////////
    assign this_is_delayslot_o = this_is_delayslot_i;

////////////tlb//////////////////

    assign tlb_wr_o = (op==`COP0) & (func==`TLBWR); 
    assign tlb_wi_o = (op==`COP0) & (func==`TLBWI);
    assign tlb_re_o = (op==`COP0) & (func==`TLBR);
    assign tlb_find_o = (op==`COP0) & (func==`TLBP);
endmodule
