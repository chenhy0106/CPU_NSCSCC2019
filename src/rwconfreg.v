`timescale 1ns / 1ps

`define WAIT 2'b00
`define RD 2'b10
`define RES 2'b11
`define WR 2'b01

module rwconfreg(
 input wire clk,
	input wire rst,
	
	//cpu side
	input wire 			cpu_rd_req,					//read data request
    input wire[3:0]    cpu_wr_req,					//write data request
	input wire[31:0] 	cpu_addr_i,					
	input wire[31:0] 	cpu_wr_data,
	
	output wire		 	cpu_mem_stall,
	output wire[31:0] 	cpu_rd_data,
	
	//ram side
	input wire[3:0] ram_rid,
	input wire           write_begin,
	input wire 			ram_rvalid,			
	input wire          ram_rlast,
	input wire[31:0] 	ram_data_i,
	input wire          ram_wready,
	input wire 			ram_bvalid,
	
	output reg          ram_wvalid,
	output reg          ram_wlast,
	output wire[31:0] 	ram_addr_o,
	output wire[31:0] 	ram_data_o,
	output reg 			ram_rdata,
	output reg[3:0]      	ram_wdata
    );
    
    reg cpu_rd_valid;//output data valid
    reg cpu_wr_valid;//write data finished
    reg[1:0] cur_state;
    reg[1:0] next_state;
    
    assign cpu_mem_stall = (cpu_rd_req&!cpu_rd_valid) | (|cpu_wr_req&!cpu_wr_valid);
    assign ram_addr_o = cpu_addr_i;
    assign ram_data_o = cpu_wr_data;
    assign cpu_rd_data = ram_data_i;
    
    always@(posedge clk)
    begin
        if(!rst)
            cur_state <= `WAIT;
        else
            cur_state <= next_state;
    end
    
    always@(*)
    begin
        next_state = `WAIT;
        case(cur_state)
        `WAIT://initial state
        begin
            if(|cpu_wr_req & write_begin)
                next_state = `WR;//write one word
            else if(cpu_rd_req)
                next_state = `RD;//read one word
            else 
                next_state = `WAIT;
        end
        `RD://read state
        begin
            if(ram_rvalid & ram_rid==4'b0001)
                next_state = `WAIT;
            else
                next_state = `RD;
        end
        `WR://write state
        begin
            if(ram_wready)
                next_state = `RES;
            else
                next_state = `WR;
        end
        `RES://wait respond state
        begin
            if(ram_bvalid)
                next_state = `WAIT;
            else
                next_state = `RES;
        end
        default:begin
        end
    endcase
    end
            
    always@(*)
    begin
        ram_wdata = 4'b0;//output to axi,write data req
        ram_wlast = 1'b0;
        ram_rdata = 1'b0;//output to axi,read data req
        cpu_rd_valid = 1'b0;
        cpu_wr_valid = 1'b0;
        ram_wvalid = 1'b0;
        case(cur_state)
        `WAIT:
        begin
            if(|cpu_wr_req)
                ram_wdata = cpu_wr_req;
             else if(cpu_rd_req)
                ram_rdata = 1'b1;
             else
             begin
                ram_rdata = 1'b0;
                ram_wdata = 4'b0;
             end
         end
         `RD:
         begin
            ram_rdata = 1'b1;
            if(ram_rvalid & ram_rid==4'b0001)
                cpu_rd_valid = 1'b1;
            else
                cpu_rd_valid = 1'b0;
        end
        `WR:
        begin
            ram_wdata = cpu_wr_req;
            ram_wvalid = 1'b1;
            ram_wlast = 1'b1;
        end
        `RES:
        begin
            if(ram_bvalid)
                cpu_wr_valid = 1'b1;
             else
                cpu_wr_valid = 1'b0;
        end
        default:begin
        end
        endcase
    end
                           
            
endmodule
