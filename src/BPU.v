module bpu(
   input             clk,
   input             rstn,                 // 低电平复�?
   input [31:0]   pc_i, 			             // 目前分支指令�?在PC的�??
   
   input id_isBranchInst_i,                     //ID级输入：是否为跳转指令（决定是否输出预测信息�?
   input ex_isBranchInst_i,                     //EX：是否是跳转指令（决定是否更新BTB�?
   input [31:0]   ex_branch_inst_pc_i,        //EX的指令PC（更新BTB�?
   input [31:0]   ex_real_branch_target_i,    //实际的跳转地�?
   input [31:0]   idex_predict_branch_target_i,  //ID/EX流水线寄存器输入：跳转预测地�?
   input [1:0]    idex_predict_counter_i,                   //ID/EX流水线寄存器输入：跳转状态计数器
   input          ex_actual_taken_i,                            //EX段输入：是否真正有跳�?
   
   output        pre_taken_o,           //输出：预测结果是否跳转（给IF�?
   output [31:0] pre_target_o,          //输出：跳转指令后的地�?（给IF和ID/EX寄存器）
   output [1:0]  pre_counter_o,      //输出：预测的计数器（给ID/EX寄存器）
   input wire [5:0] stall
);
   //pc_i是当前分支指令所在的PC
   //下一个时钟上升沿，输出预测结果pre_taken_o和pre_target_o
   //在EX阶段确定分支是否执行
   //比较预测的分支地�?和实际的分支地址，比较taken和pre_taken
   //功能描述
   //第一周期：读出跳转指指令(Branch->IF)
   //第二周期：读出延迟槽指令，跳转指令提供预测结�?(Branch->ID)
   //第三周期：PC在预测器预测的预测的方向取指令，同时，跳转指令已经执行到EX阶段，可以知道跳转结�?(Branch->EX)
   //此时，将跳转指令的预测结果反馈给前面的流水线级和BPU。如果相等，则继续执行，如果不相等，送新PC，清除第1�?2级流水线
   
   parameter PC_width = 32; // PC的宽�?
   parameter BTB_Entry_width = 10; // BTB入口地址的宽�?
   reg [33:0] wr_BTB;
   reg [1:0] new_predict_counter;
   reg update_BTB;

   //饱和计数器和BTB更新逻辑
   always @(*)  begin
   if(!rstn)  begin
   wr_BTB = 0;
   new_predict_counter = 0;
   update_BTB = 0;
   end
   else begin
     if(ex_isBranchInst_i)  begin
        update_BTB = 1'b1;
        if(ex_actual_taken_i)  begin
			    new_predict_counter = idex_predict_counter_i + ~(idex_predict_counter_i==2'b11) ;
			    wr_BTB = { new_predict_counter, ex_real_branch_target_i} ;
        end
        else    begin
			    new_predict_counter = idex_predict_counter_i - ~(idex_predict_counter_i==2'b00);
			    wr_BTB = { new_predict_counter, idex_predict_counter_i} ;
        end
    end
    else begin
        update_BTB = 1'b0;
        new_predict_counter = 2'b00;
        wr_BTB = 34'b0 ;
    end
  end
  end   
   
   
   wire [BTB_Entry_width-1:0] tb_entry;
   wire [BTB_Entry_width-1:0] set_tb_entry;
   wire [33:0]dina;
   wire [33:0]dout;
   assign dina = wr_BTB;
   
   assign pre_taken_o =   dout[33] & id_isBranchInst_i;
   assign pre_target_o =  dout[31:0];
   assign pre_counter_o =  dout[33:32];
   
   //使用PC�?11-2位作为BTB的入口地地址   
   assign tb_entry =   pc_i[11:2];			
   assign set_tb_entry = ex_branch_inst_pc_i[11:2];
   
   bpu_mem BTB_mem (  //双口写优先RAM
  //写部�?
  .clka(clk), 
  .wea(update_BTB),      // input wire [0 : 0] wea
  .addra(set_tb_entry),  // input wire [9 : 0] addra
  .dina(dina),    // input wire [33 : 0] dina

  //读部�?
  .clkb(clk),    // input wire clkb
  .addrb(tb_entry),  // 入口地址（分支指令所在的地址�?
  .doutb(dout)  // 预测结果：包含有2个部分：[33:32]是分支计数器，[31:0]是目标的PC
   );


   
endmodule