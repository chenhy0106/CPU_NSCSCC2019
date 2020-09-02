`define zero32      32'h00000000
`define StartPc     32'hbfc00000

`define AND         6'b100100
`define OR          6'b100101
`define XOR         6'b100110
`define NOR         6'b100111
`define ANDI        6'b001100
`define ORI         6'b001101
`define XORI        6'b001110
`define LUI         6'b001111

`define SLL         6'b000000
`define SLLV        6'b000100
`define SRL         6'b000010
`define SRLV        6'b000110
`define SRA         6'b000011
`define SRAV        6'b000111

`define MFHI        6'b010000
`define MTHI        6'b010001
`define MFLO        6'b010010
`define MTLO        6'b010011

`define SLT         6'b101010
`define SLTU        6'b101011
`define SLTI        6'b001010
`define SLTIU       6'b001011   
`define ADD         6'b100000
`define ADDU        6'b100001
`define SUB         6'b100010
`define SUBU        6'b100011
`define ADDI        6'b001000
`define ADDIU       6'b001001

`define MUL            6'b000010
`define MULT        6'b011000
`define MULTU       6'b011001

`define DIV         6'b011010
`define DIVU        6'b011011

`define J           6'b000010
`define JAL         6'b000011
`define JALR        6'b001001
`define JR          6'b001000
`define BEQ         6'b000100
`define BGEZ        5'b00001
`define BGEZAL      5'b10001
`define BGTZ        6'b000111
`define BLEZ        6'b000110
`define BLTZ        5'b00000
`define BLTZAL      5'b10000
`define BNE         6'b000101

`define LWL         6'b100010
`define LWR         6'b100110
`define LB          6'b100000
`define LBU         6'b100100
`define LH          6'b100001
`define LHU         6'b100101
`define LW          6'b100011
`define SB          6'b101000
`define SH          6'b101001
`define SW          6'b101011
`define SWL         6'b101010
`define SWR         6'b101110

`define TLBWI       6'b000010
`define TLBWR     6'b000110
`define TLBR        6'b000001
`define TLBP        6'b001000

`define CACHE    6'b101111
`define SYNC    6'b001111

`define BREAK       6'b001101
`define SYSCALL     6'b001100 

`define ERET        32'b01000010000000000000000000011000

`define NOP             6'b000000

`define COP0            6'b010000
`define SPECIAL_INST    6'b000000
`define REGIMM_INST     6'b000001
`define SPECIAL2_INST   6'b011100

//AluOp
`define AND_OP      8'b00100100
`define OR_OP       8'b00100101
`define XOR_OP      8'b00100110
`define NOR_OP      8'b00100111
`define ANDI_OP     8'b01011001
`define ORI_OP      8'b01011010
`define XORI_OP     8'b01011011
`define LUI_OP      8'b01011100   

`define SLL_OP      8'b01111100
`define SLLV_OP     8'b00000100
`define SRL_OP      8'b00000010
`define SRLV_OP     8'b00000110
`define SRA_OP      8'b00000011
`define SRAV_OP     8'b00000111

`define MFHI_OP     8'b00010000
`define MTHI_OP     8'b00010001
`define MFLO_OP     8'b00010010
`define MTLO_OP     8'b00010011

`define SLT_OP      8'b00101010
`define SLTU_OP     8'b00101011
`define SLTI_OP     8'b01010111
`define SLTIU_OP    8'b01011000   
`define ADD_OP      8'b00100000
`define ADDU_OP     8'b00100001
`define SUB_OP      8'b00100010
`define SUBU_OP     8'b00100011
`define ADDI_OP     8'b01010101
`define ADDIU_OP    8'b01010110
`define MULT_OP     8'b00011000
`define MULTU_OP    8'b00011001
`define MUL_OP          8'b00011010

`define DIV_OP      8'b00011010
`define DIVU_OP     8'b00011011

`define J_OP        8'b01001111
`define JAL_OP      8'b01010000
`define JALR_OP     8'b00001001
`define JR_OP       8'b00001000
`define BEQ_OP      8'b01010001
`define BGEZ_OP     8'b01000001
`define BGEZAL_OP   8'b01001011
`define BGTZ_OP     8'b01010100
`define BLEZ_OP     8'b01010011
`define BLTZ_OP     8'b01000000
`define BLTZAL_OP   8'b01001010
`define BNE_OP      8'b01010010

`define LW_OP       8'b11100011
`define LB_OP       8'b11100000
`define LBU_OP      8'b11100100
`define LH_OP       8'b11100001
`define LHU_OP      8'b11100101
`define LWL_OP      8'b11100110
`define LWR_OP      8'b11100111
`define SB_OP       8'b11101000
`define SH_OP       8'b11101001
`define SW_OP       8'b11101011
`define SWL_OP      8'b11101100
`define SWR_OP      8'b11101101

`define MFC0_OP     8'b01011101
`define MTC0_OP     8'b01100000

`define SYSCALL_OP  8'b00001100
   
`define ERET_OP     8'b01101011

`define TLBWI_OP    8'b0011100
`define TLBR_OP      8'b0011101
// `define TLBP_OP     8'b0011110

`define NOP_OP      8'b00000000

//AluSel
`define LOGIC       3'b001
`define SHIFT       3'b010
`define MOVE        3'b011	
`define ARITHMETIC  3'b100	
`define JUMP_BRANCH 3'b110

//CP0 reg
`define COUNT       5'b01001
`define COMPARE     5'b01011
`define STATUS      5'b01100
`define CAUSE       5'b01101
`define EPC         5'b01110
`define BADVADDR    5'b01000
`define EBase       5'b01111
`define config      5'b10000
`define random    5'b00001
`define compare   5'b01011
`define context      5'b00100
`define contextconfig 5'b00100

//branch
`define NOT_BRANCH  3'b000
`define EB          3'b001
`define NEB         3'b010
`define GEB         3'b011
`define GB          3'b100 
`define LEB         3'b101 
`define LBr         3'b110
`define NC          3'b111 

`define REG         3'b001
`define RELA        3'b010
`define FDIR        3'b100

`define Interrupt 5'h10
//exception type
`define Int         5'h00
`define AdEL        5'h04
`define RI          5'h0a
`define Sys         5'h08
`define Bp          5'h09
`define Ov          5'h0c 
`define AdES        5'h05
`define er          5'h0e
`define TLBL        5'h02
`define TLBS        5'h03
`define Mod        5'h01

//tlb
`define Index       5'b00000
`define EntryLo0    5'b00010
`define EntryLo1    5'b00011
`define PageMask    5'b00101
`define EntryHi     5'b01010 
