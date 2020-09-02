// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Tue Aug 25 23:16:07 2020
// Host        : Lenovo-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               E:/chy/soc_up/vivado_xpr/project_1/project_1/project_1.srcs/sources_1/ip/blk_mem_gen_2/blk_mem_gen_2_stub.v
// Design      : blk_mem_gen_2
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module blk_mem_gen_2(clka, wea, addra, dina, clkb, rstb, enb, addrb, doutb, 
  rsta_busy, rstb_busy)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[7:0],dina[21:0],clkb,rstb,enb,addrb[7:0],doutb[21:0],rsta_busy,rstb_busy" */;
  input clka;
  input [0:0]wea;
  input [7:0]addra;
  input [21:0]dina;
  input clkb;
  input rstb;
  input enb;
  input [7:0]addrb;
  output [21:0]doutb;
  output rsta_busy;
  output rstb_busy;
endmodule
