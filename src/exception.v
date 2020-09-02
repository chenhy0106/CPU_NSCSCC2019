`include "defines.v"

module exception(
    input wire          rst,
    
    input wire[31:0]    ebase,

    input wire[31:0]    cause, 
    input wire[31:0]    status,
    
    input wire          is_rd,
    input wire          is_wr,
    input wire          r_addr_error,
    input wire          w_addr_error,
    input wire          r_tlb_refill,
    input wire          w_tlb_refill,
    input wire          r_tlb_invalid,
    input wire          w_tlb_invalid,
    input wire          tlb_mo,
    
    input wire[31:0]    inst_addr,

    input wire[31:0]    exception_i,
    output reg[4:0]     exception_o,

    input wire[31:0]    EPC,
    output reg[31:0]    excep_pc,
    output reg          clear//clear pipeline
);

    wire[31:0] base_addr = status[22] ? 32'hbfc00200 : {ebase[31:12], 12'b0};

	always @ (*) 
	begin
		if(!rst) begin
            clear       = 1'b0;
			exception_o = 5'h00;
            excep_pc    = `zero32;
		end else if(inst_addr != `zero32) begin
			if(((cause[15:8] & status[15:8]) != 8'h00) & !status[1] & status[0] & ~(is_rd|is_wr)) begin//interrupt
                exception_o = `Interrupt;
                clear       = 1'b1;
                excep_pc    = cause[23] ? base_addr + 12'h200 : base_addr + 12'h180;
           end else if(inst_addr[1:0]!=2'b00) begin//read inst addr error
                exception_o = `AdEL;
                clear       = 1'b1;
                excep_pc    = base_addr + 12'h180;
            end else if(exception_i[13]) begin//inst tlb not found
                exception_o = `TLBL;
                clear       = 1'b1;
                excep_pc    = status[1] ? base_addr + 12'h180 : base_addr;
            end else if(exception_i[14]) begin//inst tlb invalid
                exception_o = `TLBL;
                clear       = 1'b1;
                excep_pc    =  base_addr + 12'h180;

			end else if(exception_i[9]) begin//reseve inst
    			exception_o = `RI;
                clear       = 1'b1;
                excep_pc    =base_addr + 12'h180;
			end else if(exception_i[8]) begin//syscall
                exception_o = `Sys;
                clear       = 1'b1;
                excep_pc    = base_addr + 12'h180;
			end else if(exception_i[6]) begin//break
    			exception_o = `Bp;
                clear       = 1'b1;
                excep_pc    = base_addr + 12'h180;
			end else if(exception_i[11]) begin//overflow
    			exception_o = `Ov;
                clear       = 1'b1;
                excep_pc    = base_addr + 12'h180;
            end else if(r_tlb_refill) begin
                exception_o = `TLBL;
                clear       = 1'b1;
                excep_pc    = status[1] ? base_addr + 12'h180 : base_addr;
            end else if(w_tlb_refill) begin
                exception_o = `TLBS;
                clear       = 1'b1;
                excep_pc    = status[1] ? base_addr + 12'h180 : base_addr;        
            end else if(r_tlb_invalid) begin
                exception_o = `TLBL;
                clear       = 1'b1;
                excep_pc    = base_addr + 12'h180;
            end else if(w_tlb_invalid) begin
                exception_o = `TLBS;
                clear       = 1'b1;
                excep_pc    = base_addr + 12'h180;
            end else if(tlb_mo) begin
                exception_o = `Mod;
                clear       = 1'b1;
                excep_pc    = base_addr + 12'h180;
			end else if(r_addr_error) begin
    			exception_o = `AdEL;
                clear       = 1'b1;
                excep_pc    = base_addr + 12'h180;
			end else if(w_addr_error) begin//write data addr error
				exception_o = `AdES;
                clear       = 1'b1;
                excep_pc    = base_addr + 12'h180;
			end else if(exception_i[12]) begin//eret
                exception_o = `er;
                clear       = 1'b1;
                excep_pc    = EPC;
            end else begin
                exception_o = 5'h00;
                clear       = 1'b0;
                excep_pc    = `zero32;
            end
		end
		else begin
            clear       = 1'b0;
			exception_o = 5'h00;
            excep_pc    = `zero32;
		end
	end	
	
endmodule