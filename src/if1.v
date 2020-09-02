`timescale 1ns / 1ps

module if1(
    input               clk,
    input               rst,
    
    input wire[5:0]     pause,
    input               clear,
    input               cache_hit,
    input wire[31:0]    if2_pc,
    input wire[31:0]    epc,

    input               branch_redirect_flag,
    input wire[31:0]    branch_redirect_addr,

    input wire[31:0]    pre_branch_addr,
    input wire          pre_branch_taken,
    
    output wire[31:0]   inst_addr,
    output reg[31:0]    pc_o,
    output reg          cache_en
    );
    
    reg     [31:0]      next_pc;
    wire    [31:0]      seq_pc;
    assign seq_pc       = pc_o + 4; 
    assign inst_addr    = next_pc;
    
    always@(*)
    begin
        if(!rst)
            next_pc = 32'hbfbffffc;
        else if(clear)
            next_pc = epc;
        else if(pause[0])
            next_pc = if2_pc;
        //预测失败的情况优先级更高
        else if(branch_redirect_flag)
            next_pc = branch_redirect_addr;
        //分支预测加入
        else if(pre_branch_taken)
            next_pc = pre_branch_addr;
        else
            next_pc = seq_pc;
    end
    
    //if1_if2 pipeline reg
    always@(posedge clk)
    begin
        if(!rst)
            pc_o <= 32'hbfbffffc;
        else if(clear)
            pc_o <= epc;
        else if(!pause[0])
            pc_o <= next_pc;
    end
    
    always@(posedge clk)
    begin
        if(!rst)
            cache_en <= 1'b0;
        else
            cache_en <= 1'b1;
    end
            
endmodule   
