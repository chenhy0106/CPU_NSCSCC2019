// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Tue Aug 25 23:18:32 2020
// Host        : Lenovo-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               E:/chy/soc_up/vivado_xpr/project_1/project_1/project_1.srcs/sources_1/ip/mult_gen_0/mult_gen_0_sim_netlist.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_14,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module mult_gen_0
   (CLK,
    A,
    B,
    CE,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [31:0]B;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [63:0]P;

  wire [31:0]A;
  wire [31:0]B;
  wire CE;
  wire CLK;
  wire [63:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "5" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "63" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_0_mult_gen_v12_0_14 U0
       (.A(A),
        .B(B),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "1" *) (* C_A_WIDTH = "32" *) (* C_B_TYPE = "1" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "32" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "5" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "63" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_14" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_gen_0_mult_gen_v12_0_14
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [31:0]A;
  input [31:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [63:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [31:0]A;
  wire [31:0]B;
  wire CE;
  wire CLK;
  wire [63:0]P;
  wire [47:0]PCASC;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "5" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "63" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_0_mult_gen_v12_0_14_viv i_mult
       (.A(A),
        .B(B),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCASC(PCASC),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
g7azmhtm6FcP7uNFjuXJjN8Z6yccOPk3SSjzvKB27peFKmnPmQmov5+YTGwYqqN9LpdyiUExk8K6
vPnJqontvQ==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
MFrqn2K0Cr7TmQ5al162oDGiY83d+AkTWOgFyXPYrTNznygR/tx44RAp24ytphNK9p6shs2EFMg/
Qqz0l8DCWiVEoJ/T8vMpnAn7Y+poGVGS1qAR3qE2njrl81VcGBZJeFaWIudhfr/DLTuuf2T/dWDU
YpelM3KbfYNPPiPy8PU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FZca5XZouG+/BYoQ8qrJTmnJanku4IprIWRkO6VciHehE5WehR0wsZJhfKlqLEeY1oTPA4bXaxmY
NjYkrop4EOwW8t47/hj2kFLI1OKUAE/TAhCGg/aNSOViUbB3dUomG/y+TBuDt9L6g0Arj1vb/5Pt
IChc5ZdEfRr1lJMTpFfP+5qmEH6lePPdzgPZATPB4Zrj0P6EyiEsU1FKBuAKd9iYNGiLCxVomaz0
3/RwK2Nl+/l4mc7PJt5Hso+4s1qHb4s2wD+OgbIwdH26ZkEnKVFpaLiuWQKu9uhDLGnsBMPf7XDE
p29f+mrvP9Zi/3nonA2aBKrTwR7XuH+ZYoakxA==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
jP68OjlYJglq3zpmKrXOhq7Sex8XNW8fQKp4hUNmuw06OOoKhQASNTnjtyVjAIk/VXb64ViBu1ds
cNMJybDSWBhnChfJq4h9PNybShGJXxSm3NDOo5wUHKf10Eti3fSotB9rVks+tNdTEZo4O97kgfdD
G1FNOqlsYcQiShEGLLiEQ2yYtgJBxJ+jc8mFjIEfPhAYy1ElrvtFEpnhkNS2LfE7xdWOQdO/XoKK
ibeY08pgncTI3pvO6TMbXushf0AX2S7hgfk8ysZrT+0gktqFrJnyR6oljS6VVPLtRNW2vo/cC8XQ
Bzvwwt4cpSo5KLS4XxB6qClZipItck2AUEdIbQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
o7jAZIoXlFbFtDYmtXhfRBlb07dhBb6Wp03mlT4T0FXtvccSHWhWZgc+VUNwt6TohLihOwvSipPP
XVXpGL4pUVYNdQBCVpFzhMkt6jhyUgsF5t10yI5Of6YEfQrDHigceoBukM3+/zJHPprrPQE6FUvC
wXSGhBCXnHJs1R+n4l0714w8/WftPQhlD9QGQp1qT2VARQXUKBRxcRjxe9TcLfs0P4xnN7uHu0R6
JTmV+MHmhGpetSZGx+B2Wa1MQofUPURqwE70IwBoUhdXH8+39DT5I6x2+wMY6RcVATnhNd2BCgPd
RzAhwfrcqRiU9aB+eNNdFR8ve9M2nGMmV2JxZg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Cl1Dz+fZIDYEIQuUd0pSg+5jknmtX/JERd+yOZ2SRaVra/4pU/eCTjEXMzhz4VFGYB6dgUxMsGBk
nL2WNdn/uaSPpi6mNF0UHQvZik4pUkYPrnRbFveVqW8i1t95SG0RW96uD19206lWrp5U1lqc4fH7
sfKHi8ZpU3MAg0DOO0E=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Qqp76m2aV9ue8Qai7QUavb+lhRYdu/txrnwYLzwTe0vS0S2OD1vxr8VeIT3bF/ZuXlTGm4S/UCSF
bgOPp7VqEOeGNfsSPK+VpQ+foQMENCQYccwKquBDSg/sLjpPK9uuoGLBLxjw2OwsRzplVFXiPcRN
LYK1/FmCP7RJBNgmhh/ti99a+WSl6i2YIIRGocNplQlG8FXq8ZTTHd/x2Gtdf/zGvJOy/fNsos6S
Oq9yJ0rMmbGeWbri5c04gZM08pUmXBsivgOHm2IVEZZFM4SBqrsi0xa52hs2kelc3iKJcWiTvU3X
0fJP9qNFuIjXBPPZvEYwhVtIh6DwiIC2viSscQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
T4Lyx5n2cvVc1AFLrt/A/ArM42Adk0aNH+VofTCnzC+pm1a0Fm2yUxw6mSnJhxlZTdsHb4qjkbgY
9gB32eTwVHlmVmon5JwucXIxnevodcRjyn8VydBqvAalUu3OWZlVEN/E5ZqONVYEElnc52cGgLlK
/262p8L1rR/cuosHMZsVP+nd7NlV5MJEMIJGnQ95K29cLsHGUKFkRESB8Dtr4P83XuJSB0Avs2zi
yPP6pH6PQGE1404GUQwAFwbYjBWA1LITAxlDbbdEodURYgkOzJU4aXwuzswHiWTqtji3ES5BF30s
HZmPSp1ym/32pXmRQf6PMDAIoUi+R8K1pfz/Bw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
EcWkQZP/k4EQOsx8F1BssR0GJYEyj7tlHQAceBOhlARikxkK3rRMCm5kWYUyL+/wGi+RZV9TWTHI
DETS5FvXjn9azjqiCbn5D5Ko+rZmTBF4pGlKM9IMoQAFgy1KSzVSn0TOWCzdBFuxs1ptlIAEB3ed
g0M6n0yiNtW/LhDTKM97xnDqTTSChxR/jwfXE45eVkmSdzwbBpNTMHmJRAxWxLRxqQawdRa+jruq
iPlW8AD772XxzlxTUOxxzIfMcoFmsRerHYcOMvLfIMsFd6HNUlS+e2O92F7qGJ81dxtsJtat8KrU
z0hmnZovx9HDKc3u+ujigAXTSPiNyZfKiQYEhw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 43120)
`pragma protect data_block
f6g7Fsh/B1Z9BwYbypFHL/Id6QnAmpP0GZKCsWEhgVO7REydk9cklpKVVC1PF76Cuel2C1XUdl1P
oojO5sJSphM2dd2QVchVm/gm/8/7Xdo8+V3qVYjDztiSPEjyX699iVkR6WqWnzJ2D3GsaoZ3ivkK
5r+3JlZLaLeic1IS7/jsvEvRKO0dOsojB/U0uUGFrwjqQgLN90syuk41YGaZziW6uMkKjvcELxgk
b9YShAvOuu9LRZbq5BywZTsoh8iWcxrlpohAw407sLJto9BovwB8PdOwM8We4AwBx9+ABfUhyvLq
SVqTAoBnrVk7L63rUPEEihewKEzXZHhYkcG0Kl2/Z9cQ4JNepknUDt1PvMz21s5gv63zfXe0i2Ho
2qKPpsEOngQX0sRcNiOwPl6B1AeqxKJh9zg8lYeC7tXuEwr67ZANkITupWPSCP/hmVTLhDFHrNm5
nqHc6wvCvb90MBudTZBcFxtXhYxvurZITW2uNC8GxKXFtYI/EB/0XJM8Ow+UKSRiiXvHJba953jl
BHTl7ihAcqjhuZ33s6YYv81JajMeu0pxEuG8l+fn6uHI5nglXtHWTbNsD7XI2y5Nu7g+1cWe0K+l
4noBPxcfdveBuCVdZ19l3JDyIGBM3N8CeARwKWxChv2v2fQ0c37zf/eLUmYnIEbv8vKXRwGI50CV
x+E6otwzpaumoVyXpchpPnWhf+Zp2eYJF43W+1PMqzXjy7qbuPe/KjWu9O3+jDnahc2ayZJoxk2V
uISWgCsQ0eRKEjRzKIR43wG1BsjFx6IQ343kNhBBm0G+9Um053tk9ovPvyb+oNLN+CS44CjAvOIc
6BpCROapRU7PUtPYCmhrjmHsviiPX6q6g6C0ZOC+zp4gZRAmNbg3tVkuZCDcFdXsgdH4Xc4lBvse
bRTAI3iGw0jKhq7Vv3pXHIH88pmLV9q4SnaLqIB+LlIzGeazUjJH9x8DxfYfn7oEwb/hlUU26zw9
f/xTRR3eMOuTJa/kkvawXl+Vv1lbKnHmt/9TA//ME+8ZrziQJUfDNAkzs3kH1wTPXLOuGg3VmZ9J
/ExZMTdh8cxw2Xus16hwGQnzi0gDIY1Ry+c2D3egne7yMGQkgV00FirrAG87D4scg6p3Nqug2aE6
GeEaZhIu/bU/IPID/NOCHb+shgN2A1vXDEzRhZ7inS/aWU294xff/g9AxGPMUgltNzSSlG8/Upql
PtLfF1np1ZCOY3LTLHpp/T5D3s98CaiTVe0iVE53kNctOnrAudZNmLFtEzfNdlDM9n1PAaeh43jB
PUf8dAQz1zsZQbA9leWG9/XawCqwJ8j5R4ncb89gn6qG6SJUYMC43tLC04XDuVZKsSaaZlP5lZ3C
7t78PrIFUQd/p9aZ3kXzThYBORwYpp4vTqdUDi9Ee4gqXp10VLTHgPrPDUoe/2Hca9xrf6syaTKE
gYrtfDQlxLj0U7/kDVXNODdKIoC/x8R5zPeP4/OD0VuaBcT5cpB94W7H2Sbz97zM8Axpiz9ssLKY
8ag2KzkpWVU3gYzcSASQNJ5dAkCa2xaTElKaCzMy6W4A5GM8h+khHQTOeiVv51yyIp5TZOjb6LeG
cTXt+oPMepAQRkp9oC4EtrDnpvw4P4PDRAZBzwFZJ6Ghx6Ln2MR3kEFN5zISb523ZLwwbwsoCci2
8nCKa1RuGKXjVdj/zMuEM0prJc3uqRCYuxJ++ghBRm3n7qwO7s2dNQew9fjx4oXWj/c+t/AoVlkG
qao265ytnQ8/5+njk84OpeehvyIJPNSYSYDQaYf0O+pfoqe0rqxksLftZud455z9+KaixA7Wb3L9
YVaPM2TjtGso8adZrtYI30ar+f5fKtWMN8lumwTi2IiP1L0ObcCnpXmdlrXxjQtP6sW/2AkY1auc
5Qd8ac/oOQV5Bp2nMrgy3vNsJs3nJ3y0nMc85vQkXGC6+D+wmrUB1Hl0eKW4Bpl2+Ix7oXSfa+F3
jcTxOGr2ngVNTx3dniqbFogf/hSwaIut9+QO3k0ADymjzhnlPlguOsU9HocpbAQtrAFt9qlh8WLD
sz1w45BDWzln2pXmzZu1pJfvuvH/rKHwx4lfCCABWFAJuhye0ZozH5aQMz+x699HF8+HLp37PmV/
m+3VEDPzQgf3U6mZnPIchQP611k9acEwjEUFPpBpI/mI/CPKtgQ8+n0wZZvwLG/ngwRjWKAI7LnQ
xvd/vz0D8h04SJQixEGt3iKx08ZyZs+CTfuJ0pRlYZ1UknNuhma8+mBF7p8WiLgwUf7sjakkVvzn
b2w4f+hiwLM6p7cWhC3hhtP/O0qsIcsOnLIp1QFfu9PdEjSqfZizQIGQSoTGGakLuzhWs3cRpymd
X0mz15vzOyLSDMNKIC16XYrTFhh53hio0eXPJwLWlVOAE3X6qtYUc8s5YfK8HXLsMBCglGkj6OIt
t3a2g5R/OscBs9diF4kBx7Jwh2gqMv7fJ5QuEnXQY1rs3EaInykipIFVBxURI4rOpdiNwaaz/Psp
QPVqTb/OkWLqtm9BhHbalUUArDiX0t+I1TciWkY1tyNPiScdgCEanYuBLXBGW0hIjuMFns/RtWeP
plufmD1Sc0jV63IaaojorK+X2ZASGInkeEpzMy+0Hsvy1oyx4RVq6Hc/d5hPKcLjziTxdSzSnw1a
prk3lvO3VULPN/l/Q+kjWXrSVA8bZZ48s/XuunIeHn9knE3JdT4YN4UFWsQCsQfpgUnYmLhXw6qJ
LwPfU8+/vCFyGgw/FuEuonZtUhNCDDoVdcncWqLOcYur9H/fpPxc5xkxvanJwJSjiDFol4919+WW
X3DEugsPUIogRzXnuKe/nQU7yEY+5TVM3REYzimiYo3AtRAGnE4xEy8WBNQA0f+sg/lYzU+M/K5b
BgPAXiA4oGU0HpOCj1DuXQXwFHroOf53myxQHz7ordne0UNhw0oCEmSQONYUlJA0VIu4NaHaRYgP
Z2pR/FQ7FZF5uNXLo5LfHGm54ZFH7NmPoQ/E11Efd3/gFRPljQariItXW+8Hvy1X4nQMhH2cFQPi
ddwSVe3++ygZevRoUYB0nkiMnvRNP8LLOV7BAgm0irJ+GTP11sji4pLTzLp5LJXIzoJmrx2kydIg
NiFK91K9FGK8O3GmD78jW3HkQGCNcZlAuowWErX42tx2dWPmJJNve+j9AcnAlrNWxbPj6k4SmkmU
kBus30T5B7QU+NFAThSRzY1g7PnvWSj5p/RzARuKH6RYlb83l60/ItRaIw066mLYk4haI9W8WY5k
s8sLcapweoxQ8M1stvr7uoFnATrNUtTJRG3OA9Z1qiN35LeVs/3K2NIer/J0vvUAXn1HAAdWe7sN
rDKktjGeZz32i8r9oGbjdT06GQWov38nO31USejdnwlV8W0v69HASMXi7RAj0Xrrmz1NRR+nlBg0
zb2PY+/yn2xSaIDkNfsGVsKoCUfvtS7C4kgzo/R/IzfSfZFlUhVv89+sj1R1QTtdS4FdhMaylkVk
Fmll/yDNwoe1SoiMZSel++aUDj9VGVIrkvpy7l+3h0cICmbnUpjiv56q/rDBa4BKCzWiOxYKcUE7
zBU9oAdu+A5A9ko+0LxZw+EFn53n3YTW7CXLVZAb8MVGdIbU2qT+KWfhnrUPpRAKYcYH1kEyPD0/
Vf9RMwoouaKBEAzTw1RYvQGjx4PTROLvhEjF38qu/7ZcgZoDCysgGhr4JS3TDf8WCP3PcHtjxZTb
mo3bfj/gyTNISK9MqjTAdO4UPkDusdY0h9ENzF7KGqsbOuTwF381Rrb7oEQTwYvJoZLfSCXm55eH
NCJwaNX6MufTN5c8pcvnovFLRHaIZ+ZOwIKTn+JBMLG4dyK0/4WezotxpJuQ+RnEN/8+q6vSa+Ez
eELEvzjiK8S7LFeuF/JzLa8xsncAoaR+/0hCNGCkbGL9iWRHuX8Jg0d/fxPAls4/6aNkIagleXrQ
Hbl/hpB2vk7rkOSgcrIOJ7fWrReUO/BGm6Hgyskw/+YdIOOnkf73bzCNm5KDeA6TrF2RF3kGAEnL
MaXqVgHKnRQyB/NMQvlPRthdTsozLddRiViFLOZ1Q2G5By/xfDNJmQG8qLR/tPIKr8FL7OPdPHA4
bArzRQhUjxs6cjpSeTCWucbqggbwN2x7t2WELI3HPZln7ynWIf9skk8wg4NSTEh0gR8/sZ3eOMC+
s4OSHfOeCpfNsz9XFnJcqiO27yqquA3ru/uqnD/sZ9r7g1zHl2qtSXv6PowIpf/x1Tn61wINaRLc
m5OVSgICylrrhzS9qZxh7O5lXChstyYsP4c7vUXufNDFrpRYIswvE8LUQKYd3eUJ0yROTL9sVcMP
j7NOScA50OB1dMjU8J8x3XOlfsBiXJQlqDFg5HKiyazGq011uthVv7X43OC6pnhCfYYiqFMlWx77
ZfSY+0lxf5H8P2+oi+l1RqllGzDdzXQ1qeqv/4+wKiKDtm1thAygIrv9LSAt69No1NItOJ2Nty+c
dXETb5WLhsKa6t0Io4hSIMqhtNdbvaxAvId2muWXCeMAKzzKl8hIMZ3MU9L3vbDVXUz7L9ZbEDRu
unO9jk08auGdY+eJMwz1n8aITP8ZB+hmqLME+zT3nFWlfNhCLNp6cqUEr6TqUFgSj0HmRADcYZd+
YIsMx4g8lLo3VBHzfsW5efQ8vk4W1417AggelLprfn9D5BJvllN6wjN1Un9HFSH+0APbjGDEXJIV
GHp8P0pPB8ahjUsf5UzapUqmwqJSmhW0Zh502CwoqWpXUvLnThMdBdrS1oLizOcgBHqKmM37IQja
FTcNcxvJla7iOHrJ/zgSFk9Sp8mlFHHLIsYboa6Xdd98qHda5kk3l/z1mpJ/DYE1BWF7eiPRhq14
rQJ4TspJYoGieVe7R9yHy/idv6F/8gvo0WOA21TkJb83IzPOjsfaGWUfYJUIH5JuRcvgDO+rej5f
jEb03XW4L8BA6Dc2jaWdxvYA6Qs/xekoPVyEeTEUq/v5jCnO9TmFGyZyBj9Ix18BT74O9HEK7UJj
aWaV0H3UveuJLkLmCDpEguRarYjSFGFSUw50h6Fs5NnBwUJ0ZUS/92bSrcTJ2rFtYfJ3daBLBp5D
uxwy0jtpYzHz7oHyzmC6VX5Qy0pjvXt9fDTRnn15otNJLxH2ut1v78hwM+MRxz5/AtMVRfJIwojx
pEZqXVes+vyB2azOKEpPJk0FlMfdn3XxZvVuJkP1VLerEldn/RZaV8kAAjBdo/ry6MYRXUTy3kx0
GHphdPN6IPxmus5KX5/v6YNgqsItJh5P6FRrmlBrB9ZIv2eDNPVbdF3zxW6xgWV28FghEdpsUSVG
cgOeYk2AsAq6q0o8a83vz3RQ0/JZWtb0+/WgOTGXwPLQq9MzW3o8+43XXUDdoJ3T82XySaES7hFq
gQbFXVKZ8EwzW4QRUBdZvQ5ejZ8Q5tm9Jbpo3/faRATT7JoqeBnEJWtqWSA+WpFXZ2sVMkBbvDIY
1RrtEM48cAxk4WRaRqU5XjdB94PatTGNVGkj7WIXLe2qTP6QVXq5MOpBSJFZ7l+3t2QGRTe8bgRx
V7pXTtSM/muCW9rIjSrnGxjxd7VFPWwHiV+Z1sLHlXaGF09f1gPSp3SyTsib8gTW6JgZZwnY+H0s
TGbF1Uv/QVp452eM0uztFdE6ITi04GaBd4wjfaVpf47sz9nzDOrM/OOQAYcI9EWMzBS6lv/iXG53
Gj7aGQaKrNJKdXRdPHq2mCQSOWx1SAqBkTTznp8foUB1BUNfLjAmx2QhFVzveKDGHmSMMHkc3vrp
/5FTnBrxMAHwGAT2469BeOhtqLvD1Sa7NG3bwkOl6cn6/JkAYWc5hm87aoAj5cVmPgI4OLhiyKfR
kq+PS+ISJUTN625/uucp72DnJ7eFJ2YbpQJvahu75XHp6EGqFOOlFp7EdfUOtkMb7ruAiMiOx4g4
OqHUOdW7lD3vqhHhE+vu2NgdUR2K6GW2LcfWAQ0USyirzHkLhRypLQxkGxmlex13pPJYT5rlbqjx
2arl9rh+nXiaTF/r7YaMa5/rvChLp/EDHWeIGpTMMbeXfGQK2kXHCcnpfjXBHNd+E/u7AJlRYxt5
CMI3fzYDpXolXTcY/dZlbts0yZpS/Lj8J5tTTk/rrgDTAhJcfcjYqYOVRT1S9wJvDcP8CExhitEu
RR//d2NbXaYJL/6I9NctQHLxf8FSwGEVc6p29K+OtQjpkGRCkk9PFA1MSc2d/a6M6kCwbxD4USH2
GhQZR4/r2tNWeybZdzcx6iLZwEdQFXvB3lZdh8NTDCbAZ00XrT/ap7t8Evf6/l+FPyU6ReVdkpji
4yd/5SbkMPEnt742gDe+6SQ2ypccvD8bLhi2bYwneb7g7Car1leiMHBYOskTHlWyltZ35at2GapI
k1gLDhaL2HWfPFzAoZ2NnIFKFbbRHNTBbK48feGav3IisUGwLmxkI321irH+cxzQPDMH3Nn/IrDz
4EN9KJc8iXdYkS3wIzQ+UXjf1RsuYy2V8dcnahyXfzzpXumsLo+56xD1VTdxcTWmdvL/DtB1L/2D
Y7Xml2APN3wuKPOsg3ooqUVMGbenRu+j+hApgHZYbTffRp4E8NTeDY20XIvGsJ4pq4TQPyJbOFs1
2yYiuYb7qMkC4UEYq1Vl4NSjSjPHOwj3MJsYQhvg/J74ic+u5tmS4xfPR7IODFobLYkeCXdAXDBV
na57+HEfiYXSY5CnTCFXc3/80qn6Hyr51IvKc0w92JYkOlnQU32koq1qVnE6jmsVxc5/1wdNakGo
DaBJ3dzjCawWXnQtu2g3oXLi/8AGu3TkVskrGM7nvzgLDWB3Vr/NZNsXioU8ugBK6tn3r0iulhFr
iLC/H6CjxviEVoF8rxnLTJdFU/2Skhs6ugzBv7Sp6wN1/pvqoWwAlJBxc6NvNoobp2yCyHjO7Ka7
paJB+zlBKVsHYR3lEFdqwLBWq9Zalv9/73nrrDIjVPO/HMwEMq4rC1mRniFoHxJkFg2UmIyUAd3j
guVHWw/8fyzcusHbkXzdUYCBCopzkgTaGIuE2ek3iuMhmXfjO6mhs1/w+fdd7tKJaN9G4Hk0R80s
wyI13DPx9w5u1ntm9BrxknCV1QO8xrNGZZOX/c7jrZ594nVfLsR9LH2HxEjj0As+s9qXQ9dQyjF+
Amaev9ijxQN70xWnNE7lbqjfD4AXqAw7nfYXvv6NPvs9/qdmk9Rq6i6jAN++y8v0btP80NFxUvTa
8aKMXTDkvBv98rT3R5/OU9GzPgQRJFnRoiTn1a7u6FxiPgQ6pPQ4MMnhGjUHt8B7BAE1Rthv1HBj
BUja8jGBg7KbnpV9ftlU2mzPSI8m6YO8fIEj0BdCyVd8iZbtJUOFfyNujyxGUYGQrvzkwzB0QvDP
E6LL03dS4yZJWMaulJoHLyC1aAxM0bhfC7CvEUR/C5k4deCf+EYi4yezwWZifcQyasrrR76E5dTW
PTTITpKvzGo6nMNHBtZW+ZPQcePIODftEtDKFiStyXqshd/wfoA2wmdb8/+5cMZOErpsYtaDs8x9
9qFJRYakYC/tyELLkzimk002Xx4j+ERXGe95zD4TaNrkwbvUuDdaTRLMuxAGYnWt4WaR6GYxJBMA
1iJkRxq6mp294Fd+iQ/tZrH4DVQZRJYh/9DZ0VmOZF3DYGaObEDZz2kHsR7uPWN3vkpj+FCDn+YS
KBDisdCEsacN6OMa8oDf9IHkrGzJzGo19q8ReG3cl4huaK9qiw2otquJYqMdsEExVC009OhY1yB+
4X0BXVQMbyabWVOE2JFqINjVsGTQEZ/8K3mWJwF1OCkeOx1l4ATX16Ayivp34Z2uYNeX8/WFxC8S
G3XVvpbdE+YscetngUCPe/0uQis2+XgeD3SPaQEy0FPJzmTymx/+ZHNkPBuraCyTVSmV0zJkg6nR
9ohVdwpYjiuPbygwqOczCUfqRkdRzC1StSabZnT0wW7IyFJpkfz0K9lf4/a2D+I6bmzwvCgSPDfK
Ptq5Ia9CDOMNXWXe8mgZMkXDS4KwA63ARU5nzniFpYvTGg/MBdlLXbyOjYXe3X2hnpouz5kBfpB/
kTdm57GJHlYg8b00rLTiBq9OOnK6PBXyVLAuCBTPPYi1YV6wD3PeSpgyigmikoD2P0pMb1lyK4YY
ldXi98e1Hggtfa7M2Ds9QUX0TFod9Ze1O1akxRJebmZkPih+AlQWKSmkFFXuwgHv6ty4QJbafuXo
lwPowU4EFnujdovR1WadtlD6A0Fq/iOBn1ikSM+ngj0KOAjOkwXcvPQvK+8bXg1PbvRNCNqRcHqB
PJlj+p51DWCnY5H3fc+fNutWskAsLX7Rr2k7P2d+ekpHOuYULS6nyfmmthCkSC9i+5bhDcBa0dYA
mxP7tztDQNaWCOcVOsg0YHewybeumm14QkzSaP6QjSk5kpBGp275RGQ/nnhPOhLl2OtotNamr90h
+FYp2lgMWo5x65Q4V6Ej4NJKTx3z6wYAf3tMv3AaOZXc3uOjMVg3v6MndayEpoz8lrzXnGrNiLJj
hrhfkhCc4ymtsiPgBik4JVyAsvUPa7kwO+FKZTC/bzYrrGos5BEcLDY3bc0PzCEwGTh2+q+5CilJ
ammqiaMXTpFU3+5p1obg7QOn4M12pnbViHe6C06Ok/iMl3NpdZKVimOmkUxYQZsVWaV7nwL2rgKC
+25WfemeG8pRroKwO4WEMm2AlBkbxNY4hJT1BeWsLElLC7NJkXmAXQppD/vtUtuX00DedDtMryKS
asRFKCaUF603obabgeJsFI+g1k2IC7WZJyuu8sRba5lLOY2oIu3nvydbNThteZ3NJafEprTUy+7x
cHyRxB3UpROv9TiR7Ei6L1+qHPsbqGSk9UdqtUA8gWdQeC9F1KNaGiqATL1mGy9nJXhk0NC22+84
txHa7v6mc/UFuqBlFa7fy/segJa4pnfxoLqMaNKtJy9hROXg+ruPFDdZ+7sMtdBu+DSP1s24PP1K
Mpg+3JFVqbJYOSYmKMqH3Wzxb368azB9+BfCzBQKvMwa3GHoNBlDVII82amSCnLLWFe200+EdNbj
quQI97ABTj0eq2kMfvSArYX4zxXYBHiaa9ruxQAN4OyKhvUDxGZAFaEfKx0w5pW4T2vk84RThX74
zi7g3nYj0nl5y6BTBKujrmNGDkxdkCWg3Djah/tmJAcWjWB2+uttj/+SLxFTiUwyZrXMlnxhm6ct
3+C9EtR08zDdpu4AORIAwmhKFZdeB5zaDg2TVFtauIH2HkxaCAvAISV0r68AJPw39OE5MTzWE9tN
5fHc7EeW5z243MIgBRSgJMSWc+uUdoqB+opASCN7UHhlF32Qa9klvW8dY4wnRazr5SWQI+bQywb6
uQhXu2JeoxEgBn+A1yomgXZiy6zptfd2Z1MK7PyG7zJthia2cNmufRPD5RJG8cLQLad872znqwv+
3Eq6vN7ks5rMjXpLa4EWOWQAXTodBNHDs2QljFNigcyUUP9copBIFKcTvXI95FmFYhdGLVcxVtfj
0Bw77DYJpc9a/tBm/wRTgOZkJllmXUZXNdRcv5N1i+u3u3/HESeEbQgONm32I9qjQN8aIQiHTl46
sbpcdfFEvBor5vRp6NJUytbywrf+I296ho5qdsNdvIHMQGV8rH2T09sezwm6Dnaf3QrlWpkbB6Wp
LR+HsgMq82Sve/0eB5CslauHYc1ut0hz5EYJ+SuAWgg0Kspdw6TL8irnJyL6FW4gpotw3adP7AH9
4qSl7gep1sezt4rMfm6QqP5qVnXc2comoQ0BTnLmwz1/ehiSjT3zzxZ49peLp4EOEeSvdBXWvBmB
xJmnNv7yHlKmnqpY7ZmHhB4AClf11nlu2UXGJ5K6txAaw0azxeYxqN6ckQ0jAz5zzW2/UNi4Fdu3
DqttZafB8V16/jAaTUEww3eV6sOj8fecmEUDW+MCKjUaviYl83RRAJUDVfLNT47GF0Rpim8HGJxd
t32+0BV1w4Nqbg2QtU8K1zcJAAnGmU8fSqiADZ10HZnstw9V0ZrbnQIU996U8lw0ulTN9WiFw9Pz
1S/cVRyy4mCelEp8dtnnR8LKfq24TAYKg6u8WBqNSrBgXesrTYa/t3H36ijfDJGsDVIK/+GgBRf6
fWHwBAeXlZHb3xU6T7fUJCNI99ZyKGWozELXrK4KCQvh4ZMe2ef3rAejQ1mM0vC5eWatI5VTMhPp
6O5WhCxbG6Az/9yRqN4q69EUl+ZKxFuUKrCCYjf7tqTet6oXsn9mOGebeupQxw5awnaB7zDYOD+B
iIQUHiqAhDuEwcl/WvxIXov3KPd2U7W28rlH3QB9Lq2w/N16/aA10Yj2FqMhx8ya+5ibsTchi7ST
ONHUWn2WfYWcF7c93OAAWnN3ktazUbLLimmYd0CEXRKA+v5Quxz3DO9LzA80Gb2BKIw5cbECRn6L
QeDpNlBIpVy7zdXEX+IGHwi9gdpJbtZp3+u55mmqeDjw5G3BYdoaLdLOtpjwXCdoyA+87sLf2fXk
WlW1knoSWtZRlbc6v1bxXDlXeiY3YWkYXKD0moG7rs/A/xFzgeXtxcvDTkCm7eZ52RO5ELbWdmpI
haUq8IYs8YYzyauoEIPjzhqaHiPQmMTAizQNYtiVCBDzMxs+iEKntBitfFfQA2DKU0KUja8+tA9b
tWm+0w+tsoGTdJEDsKyPc13tFrFn5rWAkFswPr6D3YUCi4Q2q2dIU0jyhDO8OaU56MoHdB3fvF2j
Y3VU4aHJo8czAPb3dQxT0cIxSpIl5JymmhaeFgzxhoa0IF7l/ArmfV5ng8W1caCgEBrJgWrPrhjT
gEu+6CQUc4O2Ntig+AZHx8siKfru+wRbZE1cO6bXCT7IdXfIxFvAYfP7YrFClU0Cy0FMahnU+rfO
hTO+od3s3Pjpt0MIRA3TOhtjYLqcsI8Co65HTC+XYVLm5LpPtkzyl4F+y2RR3h+qhRQatcqeWSlr
N9UZkk3KMR9qr/c/4eZgsyrVv9jqXOZtb+a3u863PBqMDc/NuaUQxs6nd/aZ2kA3fseA7DQXfN9H
uDp1M6uqbiSwPkJ52MiX2fCRDyLIHEk1357ljTePhXuSFMDff8QKM/WP+6hOQupnbDnpWWVj2oD6
vHYkEcZtcKvrgExpvQKfYAmgXf76Oh85MOBu7eKEbz37GtAKPtLHX3yZR13Ddksk0ZifbwCHz/p5
3i3SpFyJ57S/cOoTeZPbTTmMioVWIpwL7hObgeFHngp1fv/B/0shfh/DG3lGhaRcFVhsC6S+iE2+
/Cd4CHRD+ZZ8XLXQ0iblARipHLTqsDYv2VEvJIDaoMowqDFkMeFBeNzzyLaxbVWzINfUOPw10Eqo
631aZMdOp5QuYILIJHj7TARGU0NlcCpntIqZZBcAD1JMaQYr8qWzCTAjDwfDBDqT+F9m+xg91IYc
gd8hl4mzub3R1BHqrc0XTmGGFFvocDASnfUB0yM/eOIlggTYIs5lzk0eAXq/6mrQTvddio6wfDP1
HBTMiizLr5OyfD54Ppj6T3TPbWSr6mZqOhCh7VUYnEg/5B2E/t5lv0Dem64S1e3UJV+4Wh9IKRJD
vhIIE4Ji2NeuUJGx6RfbmZS/EWqzELSJNGcR0T0ye0d+zeP8WFi6vrdBG3S+580aVcX3yfvoLYxr
Mu9sGpWCWtFmmOXGwl4i1uObg1f0PnnSeRRJwUwPFDsvqCWIP590fSodXTWNZM9KlxAb2yJPwnRv
voC+EEFMUeD+UDQqGJ3TuYwUR8uZIGtDdwdPsl8kJsnLAwFhVE8/zKbx/EQ6FXgf/q6P6KeKAs4T
GvHyCAqcCiIq8E91LrHUvsEi0tA3v9O5o41O2vZbxKW5fF5BDan3g0NbJzhpzNUhIocU16ysrbKp
9ThbOqgza40oQEcHBqtGzNto3N29t5odItWfoxl15FeGJqUcEFmjswHgiMNo/DB5wvkNBjXG1/5n
hTEr7x41Xskr8v+xWdrm9bvytapySwo869V/xNETSLuy63JunSk6i50ulyn9XGupVeBQZMWa5WKO
Apljr4KzE/4CX3jym/j8hG2tXh0QwbBIAU/jiEI4Gf7LeVJJtN6pWvNpzLFcM8IGUaLlyydnCJfe
z75h9l6+Bmzu4Tm2mvguFH6MsxPFXrWEmKH9vsVSqzz4ViwkR8Dglq6ugPHP3DbJSupJfN+Qjs/l
UB4AOJUNA0mB+ocA6eiigeTbahmsdfbye/+usxDYtL0iiIRXewjhiP5BYnyPtbsub2+oIe0yt8Ji
vXhITCX7FGQ3mhhszWZInR4w5PcsWg9yqC2ZQ2hlOKYYBpSn+SYhCnj20mEhvZ0M78vmFJQUbnw6
1ACFDNhGqN/jwvo2rLDcPFf2JrVO1iFo0iwNwpZd7SlhEb0+cqSv64kZT/dtaGEPCzUwhN9+LqQB
dxMCYxQM+uUKgpQxKiYGmNXDJl1ZHR7YAp6e2vTyOzSViQBW6WvjnFY7A5c+pWvELg1OOCjx6LL5
aWjH/KePUS1MTFkh+nVFj+8Fhrzo9pCDBTyfvRmEPmtPStavd17hFh+4P1pkGacoZ26ZaIe2umJd
u9t/DgtkjiCnBHVW8noF3sihmmoMBKF7q4czKU5P5mZ9++5bNLrW5vagrxPdYtbfWfzhesdfk5Uz
ACg1SXbfGpLUsT67OAYUowfLYGx0sIDGEdKJSRXnBJW9OOMJwkvgEDpV5UlSx4cugZjXP0pxg+j/
PRh2oa3OELxcJUeO8SKzo9TJebO/sYEMNOR/EBVPurtbcMqHnW5aHmKXuFJ7rhw/E5JMFeKg3ZxB
+x1fgt2KnWqenpOcNiW2rB7mrEgYyZZ/z4ArH8HaDMRO0m6fY60hgIpgb0x2zA1KjG54hbCvCtSu
NrL8yQndsQuUay44/VZuCLL38gN4KjEoU6Zwj5zc6nC49RdFsx09EgRPh6qI5nAbQUgmSgqJjYT8
R26pFtrOfJ8BkKpm0YXoWIYzm9sv3WfEfRwhw/pYiGBZE5qadUzLIXkG+VbvDMjETj17aawvQ/Wk
4rx/dNU2+1bTq4UUPM8a5roT9QicxUwM1K/bMDzFuAKYz+syW9rbCku1vjsb/9y6viLWWCK2LLch
rtders4vxvLcqEwY1E2MC6VOb+0XNg2UXhugDcYVmHi+KDCN7bXqkzSjSOED0CePXg4xawY5pHLG
//kprb2XZSNRz6T8vHVVojADCcZJisA+iQRIGmSaxwWxs/d8M0fH5gIsC++bNnjY5VJyYS7VALxb
BE8MxkokD/Z+AZhlOkDYlPBdS0ZrUy34Y50xKEzafc3A/VP7viz2XVVqpNDJrmepycxgBqDzHcFU
/U45M5AMqL4qfGxr9+vWc5mF3j7C42mFqH1g8sEIcP6WIopP6RS6ku2Fe/Vmx0t/XRqwSh166Wov
yQpYCMfeshvkgxWUHwiMQRfGjczZU2Q3ScNJYE0Ejty6+KnCpmHOArrNcKx7qmWob6ZgAMx9nD61
A3UvCJe/Kp4EGkpgYnWt2M9NhT7Rkl/EH8Nh7gtuMp8zzXBNneIq5lPF1WZx+y5gE+f320dhfuL1
ik6X1t1OJzrQYrf7QYs1IEr+oE4jjDrH4+Fy+NypcKODzn5cC9DoV4AB/2H+w+Y1F13qbyz7ZoDF
g0560nE8y+gL7qkKsoIBKKR9JuvGDAxUXjtEdRMy8V0cwfd007ApVj89ezm6Al/F9IdKdiNjIKtL
ENuCkhdjBHJ9Em3oQfLI+LEy/aNjT5l2En4Exxx77Xrl8VEtvbASOhyDL5JhIzVGbAtE6thHzhZ9
JBc0NkLgfiDcLgPfywyQmnfT3IA4RMP9p6IS22MiK40bjO/jLu/3Wo3lhwlxJ8Gyb7CpBHePEypS
nB85UZaKDL7jpwB/IMEt1vX0UtjYFBKG4DyKGp1/DPkU9jYLCfb9Z7x/1kZMVcVeBxQBCNUHnqUr
wVenU+4LIqmd93Nt5EkGV/68LlD3i0hTgXV65dtSYY3GoRhMhXrGcdkqCMOI6hu9aQkBvte1Su1y
2AQ9LKeWuwi0V4WWdhswVS3kUHNapwVIIt6+5x8VV9NajfGWlI6KJgR3s466iGJ0ZLW2LgGIbnn6
3/5pJOvjxzsstts9TvvQIr2P4GdoGbPYQEKQVHEsj0E0o6OHY17ncVHGKNoty6rFV9MfPcPGUi3X
IpdUZDvZIQpCymVOrmVeDj+LmOYONpT2qI16ZZZEAD1hlsTCXBy9++YQbb4qOG9X5+quBwcAMOtA
D6s1kaexZVj6BO4vJ8uu4/VXo53YGDBD0s2ym3QXCW3ZTVetpE43Rmnla+8GWL3n4XfvnKY7CPKk
N3oUzniXZ2vGwSnhoCRBrW4ZQRwaV1ChGe12c70vBInMg8HDu4FlCihLN8ZhZdYwZOa2rNBpjMkT
DDJPnRBzVtr4534FczoT8Yq+EDaXUKQRR4hgw90lR3+8fBecuuiz22fqj8RacssbQEucSZ9++3mK
f9gwic3VewGKQqRQTX7J394OZycYi9nPpMTc59NMefmDOzS7RPj05Jl3cLOIEACj0mBgnqs06P+f
IySf39RK3vy5cKCEBBRkZ5EWHc4E/cH8w4QCuc76uFUwLN1WQsrEmg11uPCms+bSwBhMrTHVxlzA
bkVwOx2u6c1FeXD3nAVC5buqgzuPojPtjdS5fflgytalVJQyRTVsJL5BmK6ppolLvC8NN3BS+cZT
JXyTIuy8w8qNxROz/veWNHipEvjEf1wt4S3pXCv2ZMHVAWrCHwuForM0yev1/ihdwOC3WVU868/y
OS7QuMPjCZ4LVE4Gzu+urJJL8bey7oxdKrEpYDy7yA0I0sZd6EGYCGHA4xVygBBgTQn4hjWbh+EY
/TlVdK2+dTl5/lSE4e5iX0e66Zb3f7yIrQes8DjzBhXa/MER5GWfxdNDyAPxSHqvdCu1glJo7SOA
8jwv1qQkLHTloo8Bexq5+W/HXNuk0dWdvJRJ4zqlEcBsh3yJySILs61mQ9snYhDCZNk/Bq4uf0lR
1HQRw451Bp2rvzGsk6kNgr35QtpbCNhWaO+OLgmhVUolnfdzBKcs6ucXQDfLrEpVHiinRs3JE1vB
beklVfPT7blEf2o3dPEfrMIrmcUll+iNFQWh9veInzgWpc2gaSTRVjmHlHBXXt9N/RxVt7LUinEW
V1tX/rXpbWbIHPLHL/hHXsT+6d8euVk1hGCYBMlY2UJuVYeO4K96ncdD1zItuJTb9bnf60NzhvEF
RkXWkCLr07JFp1+iHsxKnyKYR7r2k51Uaou4ZDOWF7b2Up5cELkbTtvzgQGiRV5/3ruExOn/dd+8
TD43VkxZ9+rZbMm7kbbPXcjKJ9Iv+O3A0cy8Q/4VE5UNfrp3hm+NnYajl8Xa6mhVIOvhSILc7nab
hxRjuo8t/ftYOmzCAI/3UpNRYUqHHEboh0DfdvQQIpgV1GGMPK/X+C03xAWcwQVTAqD7gBgDQ0NN
lON2i8w5RLxUzJ5NK/1ZcabAmP59XB9Ki76R6SR39bXWDE1UcfnF8WoVZPfqc1kRIaIefyDQVApI
8rERVrvdk+9HLoWTtIbzk6Ck0NlPfeqdld0zq6xIfarJ1strhwkSdCYqbN1c7mGEe0FqPMJFbWd1
HctuZPY1h8rm5H2IzZlMbHDfBvWv6fv0iHQ2OqEbyILPCKAfd9n1picbHzuZgYYVHHZ0iIKM/la/
OjOpMWHU/Wl18Rrlw+Ur+X5DKGFbYMqcWalEtWyHdVCLT3RiK0fP67II0eOIMsrGvp3PVwgJBVbV
AT9c353Lij4JYoJVgj78sTetaiCMmNG/fq0FqZy7RyMjfCVnpEuXUjqX0AqYw9ayJMmLGOLq9tsi
R39KVyxRXFu61YkPf5X3suYiCIi5weJVk93deylBIMRl1eU2aPZ0T8mVLgqgcjyAToRUxM39i/zl
5a3wacdb75yGX9b98YWOGWiz+KViG2DE5IqlacdsvCBGkAZOcAbjjxHfGgm4xp59NLZFNOkBHEBD
XXFjJCK1x+bqj3QkFPxWvwg8gddLQm+S6d/yyCdEc7I6MBHxnq4MCcHRyo1oWZ1VhACdLqujlcBe
KhW4u6kiXF6FpFJNEkGO52T1ZeBYHS1S6PMmbAONUhcYzN5vtTVolFzFsyK7Kl6agKIdRuHJwTxc
3Gd3VCBBQWLyVdqY2UDrBzdpIDoWDvXPohVOqanJyedvIiXTCnjiqqF1vJI7CGIeKQA2DblaQi2H
lh4YqgaeWEDnGxVCgHdKXyjgAc9iNeqptrx5Dky5zekEZKS6nwx1kium5TLMGRdy2593N+dFfRpD
Jkc1iYoQ4d3+Nfuzbs9KMKOvIfydiMLRG/m0kH2bsGLDf5aNyxlZl8vqxI1psS26dU9/VRyYVdN8
W1O/HK1M3vLKZ3/fAJ7Cc5MzxZ559UcZKOqLSxNiaZcKEiW2Alm8A9uaZ5UbAtDSgVZIfv6Lf/3W
FoBQtBZoVoulhAl2zDBNNZkDy3lmmUAt1VI7jZptqq4ZiSKcLvlf52+3cZLdQnV91furEv966v/R
TnLLgBAU/jW/XlWDwthZ48ot3fAujgiZkx3BuoOyAZTWBnb7RsHFZ9wALWy6k27OgL0TMKKMVIPQ
SbFsV67Hg1iOiJLz5oj2DAnhwc5cR2CuTCqXRe6lNmiuO+7zQ4pMWFHAwqFvoVQhfF3xc1ddaNww
OGw+DAg0gdA0z7prtNh/8f0XeZRs2m4dcRT45fAZDu2ciJCB64wlFln7MoASJW8hFURpdKYiZsAE
SWgNlpz6TGu4Kg4NDHfC4d+9FJx5JPgcDDCBqsvM6TSeErQq1VryRaWI29xG7mM+mNbhUO0TXvfK
ajjZrXFVjbzvy1k71ljfXMg17Usuy0HUt2SKimvP1mNiVw3j4VsRGUqzMjro5tyjnEGOsCIydi1a
eIDr+ICi5itIQT0NnOl7b9Nrs2JRELwHFQQTIAwXbgN/ATaUr8F+OSbFP7mgSKH0QsLFs3T4tpv3
715QMtooclWuFhlhPeAhuR9b3GfBqhqEe0r8+x5JDyDE71d4dWUcU37xB/WLH5DNJMaMuuFcdINl
so1XJhe3Qx1cjk7CLyFxll6TIX0kRZ3pwzTNJ88JEKtUDXQbWbRJEYyLgZVH7uIYQGQeYvvNJu/c
GoMITPcjnKbpQY1kOJQXqmZ79Hug151+VFfSeaCUI+cyLGxeMO92qGyKC2uSCgMMqf3KVsaerhCh
9yzCMiwyjqdkklCCFURH6zbY3chdze5hjhaCa/XuVGwf6SXQURfYQ8mP/2K6ODKufdEN1e38CtGU
smHMG0Y89pfMrvZOiupdgxmDzIx9apKSyXlTArrT2qW+UtV1oz7tS8SaCn4WX//kw4hPWIBUAM2O
B6cVEAQgua3l4Ea4UVSIv+SUzI+c41vQcmhs12ckTXFX82kB/YT2KNYn+3Ew6a9apXpYVbPyT+BW
JspK1PuisKJpZhKMQJpf3sNKKXdWkYku7ssBDBFNw+3/aAP28gah4KLxrgLGfqRqqJWM6mwKZwNF
LN4vknT0hu+aPjJqP3qb/Hec6sHVUJ6h/TGor1dzqMDVp4u8DFGYURvemU4CXeFg0SPVr1/X1YLl
ZUyaWyWrdzlH0CvCGIieyxit+qfGOzX0nvd5dcP1e/kNErqVunzl49vbl2NufyqDBbHhwAUNBYq1
WxLM7xLk/0bqbV4Gtq//AbdLgPGxfWLhk8qC4Fu/PXmHzTow2NWAK3Lb/tnq+od1RT2G//0t6rYO
PWk8xWd6z3bT6+cqC5sknx1j2IRFYIadfRfEsR6wkolIj41IzOYO3GDljrWNPJfvshjzCjhQNjIa
TKfjqsJZaLDmYpgxB0zaOF7lDeddur7b0U2fyZEmXk0wAoqC1bR23H0YSxY2XW08KpkpTStOJcn7
9BSPf86wB+I2l7L1bB4LhYlZoqszs/c3xiGI139dg8hjRWhoQx+3q2kAitjydmJ6Xw8x8dJZKNqD
+93h0KAW0BAB1QGVUnv8G1bjCM4bGfcsBbH5/qw+rujmq15ORl5TmVpKj/TOwl5YdoloMZMx94KW
nPZaeeZVuIBVkbZ1WTY3enGiiWXTcgusP0B8OBxkRpP/06L8RG7bgS5CuyUibSPNlpsI8Q6IAQvn
vX0jf9UgDHQcMzRkGbAeU0KIh/6wVwx8KrkjtqJ/+z1WkRtVHqHSvuPokU8OeyKbGOcWjz1wFDI2
EL1eSl+1JMMgqD3g9l1cpv5kmlnoEKusDS2Hy3sJhRj6E6qmN3tLUOAmd8hg+AT/EjCzA7ZcHTGy
W8++LBgB0EoOMEDaqS3CPuTN2aMEiD5htOVzdoliirBBVUYUz8WFH0gMLKATsyX3sh5/KeXCcIBW
VCIWD/U1j3/qoUGSEqABqRi3yaRq55Ak11JdxXyZXyJYLMK6rof10wHaJXA79F02/uTir4lth1DM
MwiiQu99qPjlj4NJXrdPYHuyWRpBqOX2/3U7yX/zXFv0sSHMm9vyGU9q557W/s8n4d0opzIcNUyz
7vTze2g6ElAfcQf0vu9841H7M+KK7k3khhXlChVkpFwj2qhkJOYVGRmZu5VWWVwFFOSZ1kiF1BEI
suVcDbIKoJ1Kg0zkzOl5CXONl7/3cyQDENUk/Sl0djY+pDL65rn/34snPUJBeXAr/FvUqd3Gplaj
q7VI1kHN47lqLloB8kDsz569asMfwpJGLYHbs5j1UJBVD7ywE/2qKiJjrjlleuhU7G8Dz9uKmwOE
tXTBstyrlQwSM9YowmiZ2VsJTbKv3bUVurC7SC/Vi4EGeukPKZVZipRqc1ZqkWWLvqgWCoEuuJAX
8OKyYZCBSdii31eKADDcDiSIllpoHX2NFT5nJGozTwQcgG1b7yxrKW98Elz4uwW2IH7yS9BYnYqp
ZFwKRVeWyc69R3a60CRS2rSAxu5ThE2yD42tSLdp9ll4GVZkWuhDpuf5mxeSql9Ovnb/a/6VUEnu
/0K3FfYO3cBcipQTyC74OCUsG/QC2lS+K1JJn/quyBZiHQNkmluuYytwYv4F/RcwWp8U2kEx7f3m
QcjGIkuIgufNung+JZ0Ky7FAQOP7sBbHUmCR3KaTU9w02RYIZaGPL4lx6myvOM6diFnzx/hub/iT
DFqRojCE3yu1fe6jjpqdODhldqP+XQokzRLHPbz+MJanXdAd5HrivZqcuSZMM2f6UvPguwR1tmSs
h0bEeasG3q1J5jmm8o2EMfo8BIl/A4oxprPuRPwZPq/LJ+PkRPfCvo6KQ4/OMitPb+DVuqfRTCPG
U0NYM1lT1xLtYLwbwxW7oPdV4GP8iD5dCQBHD9PEdoQGXeKfkbWX3057OXm3z6lfEq+hn0fyBkE+
LYgg9vcD5ZajeEmJBGZcpxJMoM9Mb+VlxKG1h4XVsvhYlgd2ydyM0lJBBu3AGwSB7unNOwWCMt17
AiTLk61a82MOqSlel+LjWN0xVu+geoEHlUfc88TbK7x7+2a0nfF5RBUAUyuXAJkczQse85UPUjWE
qvvKGJPU7xCVv1jit3Z8bazTJYAYkmJvjSG8JrQth8wyi8sDr/en9m0TxAGB6OPvsi9jo4ZgA4nH
B0aTCt5kc+xWA6jBNJphh+y8M7/CqN2OGpo5bfpwOOznTdqXnMrq/ts34ivVo7N4vxtKU3SPaedO
8r47PSHG5BpmC4MFEPbeN1UflFu9B4tuGZ76hDrzrn4ElnXoD/fyqAerbMZNZgroEvZyz5FSAgv7
O41214ZgxrBgZExKBU6ooG0SAttz9E85ifDru67JKLATNrdXgaR3xuCCG34njoJvWxaItcHsN+t9
rJAVIzy5ZvO1ajmn9+axKEZNzOD0Vce/xJtrax0Cw4J9rEQG2+6kTJ+rgncSjOKzj85YndDF84tu
hLELKSm4G5YInX/3R//ZGhNyNNmp58TVhKOnAN4N8q4ZulIQ6Zi9ZzThXvW6cuRn3nHommyDtPa3
K1V18d1YWRNKzzkoaCSg2nHcFzaTSBDdNcL9zsTfxsAtxmDRCxv1YXS0aK1L913+HHSTPECWp4ek
xM41UCttJJcHsySW/UXhIEmrpEzWflGActFBrOBhCbFUGn/vITJLHW5Yg+UFR2t12KTQjZZtejcI
/IF+PlkUv94MGAaxgEU0YIpGI4WHu+CgeJ2rigY3xm4SyGF3rfb2Q1qfy9+RzmoSRAmR46uxOQPF
QtBGBxmLXObQMRskSudv0s8HJqRi/YTc8++u4SwkziuOLywQAYW9GkWiTK/JvuZMRMbiycwyjMip
CGGth05DUxcUFZTLJ57wEqg27S3XCw7QV14mDkkI1/jVnswdDaZ3ibCMKd4XZH5ffkB8FZEdTnwK
w1LrVfm+YF2IMjzwBzs0jERGbJ1Vnwrc2PIDNwSnz/0hQD1E2Cvt3682nh61FjfNhtRgJEHYd71z
FKDLc6rRqdk6d/IgsB+p1vKyV6z5tHEVxo1kKHm0O6NaWnrLOXL8XIfl/D8WB57qLC/CajXyg6Kw
4AMt0wrXyqEPEvhUcvFjH+uNZTjx5R02nnIw0Ya0ixqZZGZDB1TPDWlq4Ecp4OfBJytzmKIXQ1fl
LWN7pVfVehvD/Wc3EOnsfJ43E0BsdBoRxFtC5IsutwHjfloCzTGsyu2J+pBAG4Jpk0EVBdVXDG5B
WDyN13ha/ZrQWa+Sjw+WulHkPKrwhtEQZRzO3Fvtr3Z6GnQpBzk7T10ZpzteePRms3OBhtSavPZE
myEduG3bKSh9/3tf+9cz+OglsziUJQ9vwbQwa0/7nE/1NVYCn5+I/DBy9u98qgDmpKwT59OehqhD
bFoF4AZ7aaqYCnWdDT2bNCc79/RAE9zfgJ/eY3thBVc/Nx88tVJN0KA8gjslE4uMXNxtuR9pwybj
64CDQCNfSQ3nNMpiORXSVj940INdr4YVNUbdrgz+GiCprFjwiFKFB+JMakZsM8BAlGQH51QFbkyc
mNcG0VDNns1zVJFNcC4mciGhoQv4GjqiFa3DsgEbTluOl5xM9QY737TotrBtuPMxtjmouoc2pnuj
CP9KgCmrTb00TrPdIJebbbRhP8ZvV2DpTzpBzoWXxqTeQk7Lk7o7DcKtXeHPWSZk6lB0FsS5b3Np
rpNkfhCDZN6scJHo68KY0qSxD8jBKJamsGzA4RpCiw7dVJS+Bj8TI/bS9yx0Oaf9/iDhvhL8tkh7
VkOMF5R1lJ8SN98w8JGRf3vBe33bcgKk5gBdk7F6tqqdy9yMNTij0Gbebe8fSymWtZ1B1I0SclnJ
Aqlwy43q1ZqbX3fqCnFV/tj9DlNtr3RgR8HVPMkSaRcpLVngB8Ed5L2Q1wVUOErJupBcb3yiTkNO
wqXpM/0vU5XsqRtwnKl7xe0uZmx/bA+BjJnmwDhS3BSb6icVpFCWzCON3T4mIg37asedUIx5e/3J
99uCtroKkon0nMZY7WCzl+hCG06101LVviNw6SPJQJX58lut3DPh5xYRKwuhJBWIJ8ATb0ISre7Z
Gx0KVgkZVjYk//h1F2+FSZptRx5D56VA/LdfID0C+06QuzGLoBH1mtnwQl57NG6XecJd6Ytvwbxx
u8o2gaH1Y/efPDVs9eQwps5798BI1YCmT0ghtaP9goHgEndrbySwxo6FdRHWDu3aprtrv7zJCrNY
TAv8JnKU7ImEo8q0Z2GhRZqBPydiu53MtPjX1R9BxwiHeVmu1Hx1S0l7/WgKbS6BnCR0FV7Z0qVM
g31RWSSNO9kQ8z9pvdbvr3xmzMx3AvJo5XcGvQOZH1gWp/S2aGjuKDkYx4emBbSzO49H17ClRZUb
CDSI8RbA84N+8Ty+fFYcMXRUDWXBbFazawYU3VjNcbrR906fNDV6xWz4eVOF2DWRGYAgipFlGA8t
Mu6mXdCOw8qCCoEGZMhugrPwahFidhgpudaUZeoS0cIkjRZ00ZGN1q6y/Os5yWzuk4obAhNkUFBe
k5ciSUnXIzCjOQwywb/MgBXCgNNKq6S2ixlXMwebv+IKFXnXa/snLq0sBUFXHvmDQkXIdSQSYhDk
VJe/eMSnZvbF9dYxIluzDB/JPe6ZVInU/rNnv4fAQLcgBWeWihZ/Qam4n4pGe2q7ibwp2t6Cmn5f
I8ZyL0m25Y9cfJ6wwdQ60U3Q8CFgyWgxc4iRyEmmIqe/YpTpGhiHfOi3ZVRsMrHNTPtAKbwQPPf4
mFMHBGvKs+fr07lYwL/wdKXGP+W9xW26XT/7fWYLta/iCoB6GaqeVfUybmOLxsFLkCCc10WknBHi
F+AGM2OMOUeVFgSi9M6Pc3EnFSKwX45Hsath4SACu/rGhzI6+D/wLaBkmOBwoQ+XiwTZ88a9bP2b
JnWhou0oK0Y/o3BWb14wwbfWwEu5axqF7eSC71JAtsh+f9tc9ZxKGU88Ec8xWZ7orlhHGJCsff7o
CFN7IBAFnO6JfBUJL6foawTNMGdlwNGD1xVJQYRhw1GHfP6V9y9AyL0LYFvFL5fvkIogs68Il8Ol
POPlmx5aLg4XsoG/R1CX/FAKGFj+8pQ1Ua/rZ9x+z3WTvQlM63/q1aK0m4T0E1u4p15AXpQ+z03v
mhw9oNxdR7+2wcIDUhHzoQeqq1XPySfseYMOV+HgGlxX0AHIz8GgVTqdpqHuUUzanefZ+YHw6iQP
XfFPZGtueMPf6rYdQbegcdxUMSt4WQhCPzHeZhvFerHmKTsuBqw3BpRh232K72uN+ruhcLtQCu2A
5/McVLYLT+6LsfotTd7cSdodt0pFmgp7aYuKm5ANvyWMN4H7Llu/Ch8il5HCQI5+1VaLuibSoP0Q
BZtHvWLuQsF7Xc+YT7R++PZ8vrudmqYlT21UeDj5L6Ny+qRL/LSx663JdexQsuPoMbXKzgFdJKNW
UQ3H05eAXSnerhSRwkb7P7vavA10Xp8eZdlLK7hVBWfafjmve/s6gnGObBcZRqD/nRuy8O/qajgg
yLHKBjQkZZyud7ivtudPrfbeGgR/37DRjG8VEpRtMWDxBmzaXNQiv2Di/hupl+2w0ospX32t72eN
v6NyYWgteSQiKS2g8uoBY9o4SZbyZZmd8BloRUQRPfrVlE690ZiY8nUkDyQWsSeIWZ1cnthG8/xE
rjlmRlHEWQNGQmM9RWnEaEB/YdKeIhgSH2ASrkbXtj/uO55FX/w0cnk8e2dtBuGb/ZvZ22MimiYk
CeVbSrHdJADqpqilVVgLZfNqDaj+L0xlhpHJKqf3E9ZslhsZj4IgPdgBnr5pVz9wblkRWUENNG7G
C5CCDhtYDP7E8mHfk9Ds+3YGSGDhbvK/riOFqB6N/zUQHBbD8gqNmokYORP8JnydbmEhUKlqVnWa
JJ6oFikHdP4xOQ03vpGRfRJPK2OcZIeFZVRxDBOdBBXNoRDMqL9fszntkSB5wOpv6tFpRL3WpcHC
PDjX45eveMr0p3cIgOlF1eV3zcMXIf+JymCb0sqMfj+Hqa5NKCACo44yOQjF/lReyA7llLR/oXHp
H5Ac74EcoLD8Pbo1RdBLxk8sn3iA+TsH2UNIWDHUZjiukuUdpgextthPuxN0xY6ovGTU1h1wtH8o
9w8qUjmdZBeAVIFQbD+6beLx9ouQhMPD7hgcP8NiuwSAVTtaY/wc8g4ENxQorMhbLF96qS0Za07y
ZX0nxVjCRVaYB8pJ4BciFMHiIAJGzQ4fulG4aaeDC6psqzPO+Nip5ts/dOQXvLSOfLV3uEj5kKnt
+b63y3ZbjW5+z67pktlsnLwRBqp5RQLtKTms1yaBG5/Ctedf1xNZZWxKuFPut4Dde+DsbuEWfBIq
0Hr6AylGTifDtOGJ6OcVfIO+0ayXPxnP5+cL/0FJsbCkdguyOgk8HbY374PNnjHrJqQ521u+LAJu
P8pl3ybCXWpH5wVqIpDFTX87Ta/PTFYMw4Xso+ZtIRXdj6bRcI2uLuOSp2eWYA5sxvhNVc2N0n/Q
gxNv19zcAV7vOBORLWUwIdXtYr3uxZGrxBApf+ujiS+yQFMC7LP5ftolUTKCUyG20IiKVP6Ir2Lj
JzuMtn0yoDe5f5pdm6R6/zjDpNkM3dlxWDKrG1MqOFkgS2hqaCRow8JoE6zrZGxnaLloPs+Sd8g5
UEMt8rx8DJLSEHEEa444ait9PEu924+XkFpfnmdC3v9Spv0Rhw2AZIcMw2qZRlzxyQRWN2waf82R
KxjkN39MkzkauIi/AsSIueWX9W2tnMRe1KUl7AWPdCARMqtHvPNg5mWJxJWw74bCF6+MOMEAUims
6slwxTo04w6nC1PUFXJak2me1Bp4ueKw4sHL3jbRNNbTQfMeuR0lKwXuLRxVqJ3MzPKtIf6UawyX
JO5BpUvJyr10z/O4pv3wK63a9QzLLgpFfuTraMuXdTTpgJXwBE9sFVbAl8/b5tAURSH4wwIck2PM
0HKjTgvA8CiYZ86dm8K2TUiPlgLapVrmkweRtFXKCQpz25Ynbh8ldUlJqkNF1p5/9kP9+2/vWgFa
Dtc2ecYhLliUWy89p9nfQrZjwYN/5FYi557AQAlOa8zg+22U4I8JW0qb1P6eZd2jnWn9qqGcwmqx
3aelO/0q/2QTqBozlZ5Z4aUif6VZgJg6O8RLF+b4m+uafmXohNxMv9BkhujUx61KgLLcQheiOoSR
trVWFp50uE/rmfRBtIh+k2DC/JjGesjLfV8LuBjUtE4cySXRBNoyf0VztpMRVvBK2kwCJMsuDtXx
0QSjw7FBsZppd/2I9I8kq4R2Jj4HLd/1uIcBVFIBzDQ45qv49sFpnfEzUaPDJU2Szgjbs/SXVF6Q
YMT0MEY03+wM7EA2HO1PcD4u2+DEgNtG23Q+97bW5nh+RBp+Jp/vkkMxJ5l2afqSuSjxZ+cPJOPa
qa5MVzhEOvyrODWECxtD3ZEwh7jR78YVdctAKGDIRNf1kj9JDIbbyIlxrKrh5VAK8ATBBkr02kQY
AoQvSN+OlQKT3IolSPCvYGRBrahUkCsGjUnXRMi7cOe+XlbJ4aiUJbPOM7Be/QXROR7ap/WyZab2
G7O/4g5Oj0Xm/T5YQhnmBoSrXHnvPvXAiva9BLvvW6k4xg6qAcuNgqPjslTI9RDFHqXX22pv97e8
nwrr4cF3AUM8J7fqSuB0hCNwoc3jRAgN5A65RrKDryaroLoEsPJtd9yKwRNtTztK5V6kjnC3Cpro
4oA+LrJjFt3NntmXs6gz5gptNMErLqkYPB/udcjZmj1SUI7uoX7W7tFzshfW8vKnJbmqf/yW0BQZ
2pV4TN+UezRZGqatjcqf2Gkz9NBQwGabpvEUvKcJfbUpzF0wK4lj8yHiajmO6Wz5xeL17SqY3Rn6
wKL0Qsfadb/7n5kGTwxVCGbs0slWXWzHY36WNoGXOfeVk7fgofmKneUrfaJZzu73zvH+3NYqTJ/s
gELPNMRDOez9XmWQbw1zDs2QoZEBHnyd0hsqrzHpzZ7m53Wi8/f3WW8Ziv+EXliifUr3B+a2MW0+
qgzoBylhJwMx4RdEio2pqeSHYNd71a8PhV/secMODXndd5hLL7zvEuMOwO23kVql1xMcdsRrCUZU
UdIHaVOspWt5HqULjDWCJTYxfXutqLiiUR/OB67NYyoFtJYy4NjcxaZzaonER5aIt1gTnkWeSLF4
CR4NCa1Zyz4q2s7f7asaKg3OUZKp7qR3jKCaOhwi2hpkJWVeaWM6cc7dmqzSdA9FyD8i2myyAEuS
Q+MvKuGelg5SztLeOIvVNdA3Klm8cOPZqc57CFcUeDjMckTORnlM+HiuNk/q+8XA6Y+RIPexTTDC
sqwCrtpo/SRiFnWzyqDmsUhJrjFWX2NaM1fvT8n3DDaBgn5IDT4JICvC+8ibShpeM2JGUxBYLqvE
e3GQr83ruAtNCjD+eWAiN8OvraXIg5ymw72vhygdMxOrjFXdE8br5Dr5NN4Gm6BYWuI62FbsP0tM
UTpxo1LS7Xs41vctC1vMmF5mBMA/l1dNGZIKAWiJJMeI4sohs9JOb/wz2w4cmxX7mfVDNCcF9RGj
iIaWPz/9ZGzYl3O1X+yHSDxIJM6cfCeuT88b+OdeJnhSGYBPiIFFe0tFOIgv8vK+O9T6PSG2eaoj
rkc22b2Hi1LTHmh4zjC0yobIoQ0XoXoKOHnoG/XxdPzQHwNLxU0adLza4eTIkuiHFTSi+VfAr1HN
gNaPRIa8KzYabgwXuvMeuBK/D4m6r7rpthapTAQoVoqPVE/Og3ZZgqsz6kwa7q9OaQ2UC3Ax1E0g
ocE/urbWVJLE2pIBwkB+16QUsgPu4c9+ZCsqvqos8Ny4E6ESSjYpYJXgroLPZ6a8BSBj8GkxWnJ2
HHN+2Dt1VChMjhbnU/2LBJx4gsPnJGoj6NAZKVZmpzGnZjTqYe1hwDQfd1GBTpe1UUsfferq43r4
IhwYodM30++SBuTb+yrFL+IyRwaIQTwGK8JB56IXLWlrU8bLiWQIT8NnKMBIIaR+BeLm58ykat39
PcKSqSMalyQKSFA0bdO7iVhGPaL9YhUdNBcx6ZOn5zRYDvqXgVodxE1Z2ExlkfF1V71Lpja8VrfV
OxzvOonOYb/ODKUVDCHn3qt3BZ1sCR7DLYV0Hl+XeYrIm+7QfbVJ/mTVnmu6EeVzfxumBoZXCYbj
95fCpe+Wl87pNZKRaQd6tJtp8Mxxe2wSbWUS1KaeilIfcKJMsgp6DZd9G8ywPhtUoT+TlSKN1OJa
f3EBLM4OlE21/PJc9/9QN1zeiodIrXQRTy/0Bi4C889MUneWSGOISlntgT4277UoRy4RV6xKzxel
ZosVzzAaTRvuSZBCzTjE7V8oZihDQrgpmfNOeC/Nq+JljTc+Kd+OyMQcfKIkwhCCN9yvk4BWsowX
5cS0ezqsK9YNot3ANrf/p+gf14USMa3kvE54Znt5TQJkHbZa2NeOfo45DvVEwIUaGuMM8W2oRdSG
sb8W7eD9NPIWpsjwsjx0x1LJ1Fhaojcc1i934VKPyOyXW1sE4QMXdIIZK0GQ1R65KysWiagEYe/T
4+nfK+j1j8lLPBSU2vsoT7B/k7hIwFVvBP4L/6Ll70ATYdu26lCSsAEV0h/eKkhF66BQfyBZPbKj
obyCmLsmZ4qml+rLpt6Clhwn42G+jrlqkq6ESvzI+X3+eMU+PAY48zlmi9D27YVVDsr31NI0fcXw
gqc97FU+gOMVX6G4L6/Hdy1w5rTSSdngpUg2K7f9biHj/BY/etrD38IMGgSlax5WF6SIRudUTJb5
u9OVaUl3deo7FgT2gC8MvL/agiqGS3eFQGBGjRr5ReAVlWu6lgCfgpN8hVgBXQTDncOz5wPHXiL1
aa6L/gV7FoZA2qLDp+Vd3+Pzm8uyK33pRSzXBOhoS3IXuD5m/2RZCfDqUA1FcAPjtcG7zmSqHe+I
1NnYvxMf2h1UfIxf0DTCFkYhku+4XbWZTh3+gNokButzFat04zXIgWg8fb0huOExQwB4dT4DAiYD
MWt74mMq8sq2RP9JSCGF8tKpxoyWU/HvB8xv9hZBeue54hix1oklRSK/DNGd+B81jBk67haE1uHt
L63ox8NKQrWoTVijdyPzsHfgBpknntB60CyueMIEm7GtRxdbNU08NJbnoXLcmjb3pOmiRWGbtMlL
dqRI0H7cUhzZC10tHzXPmch9BODqOhD/VIT4MsHeWZDjDkY8Ycu/Sbkch6MJ5L3z5KiBov/KUOWC
6s/+NY/r3qJVNAHUsgrSaH+nShRifiLv/OPi/bP85VYVZP1Dw7xYlZsS42JmmTOL1UKGf909SDU4
YbXQHj4wy6yY2yAIyhOKsQl1M3XZTHJKdtQH6Tr5hY0hL1cIlUZEHHHfyRFb/p7kud4p2r4P8dJ2
m2MokBkcIOhILuBDxXHL/tKl0fcatjdG7wEa0JhpfiORZL8+VNLKaggMi0S+ncsAPjlFYuIF1dLw
u89+xMPTT0n9pNOvxVjYt4KF+Rae7cRJGxo66ZE+cWlIkJWb9GRk/mTdJOGfM6eo4Na2W4MYarLJ
8VwKqQZId40PvhLVAd6P1W9MGPGbAcBnPy3U6KVER8Zke9Gb5LcXc3H58aHhePeFOowWjOYBNpr2
0PNE86y0SGs7fOMlePzttTW7nbHncCYsGOexJ1pKodQaJ4LogKp7bQrLqLVCFC+wMPjHRopsiML1
TlRJY+iG1Qtkwn7PmzS+VDebj4K0WQd3xufzWMhOxoVZA5s9h2CEPe1CNjJzMBh/HfZn8GoKJdVo
fw26Z6coH7OhccHWAP/6IT5bOukTizB4pa1kW01yapu6HHhj1vJfhp2KDYTpZfDTcKxcPUJXZAna
x1VztBl98SyC7hf3SfZICJFzJh+EvYNJqoEOIKWxb71J/or7bxk+d9PRvodal/s3eHoZrS6IvQjY
SqFEVtnv8Jp+E6oZBgHwsvWUXrMeaEKAVZFma/y9zOQtTwZ9RXKa9lZ2VohCwDmjdH8J53pf6x2d
fbJRJkPT2dBTrO2AT9A7adZ72jjFigBC+c1y7lVJf7BFyU+msac4iexL1KviZDj2RLngKiVcm2K2
GQHJkVTztPnccUHf11MGbR+PJ97ve+UBk7uNtE+A7ZTj4sCBlBuCPja/9EaQSVSux4Nb9IXxKCF4
/j2VolYoz2QSlH3KEXX+Y/GHJqTDH9t5UU4y1glO0mImVlFlZvc6zpzVvlauBnVsdZTAAPtDd9mR
EVfdf8BCJExrfVJMVF2VkCG5E/BaibgU4icYqaFSuBhxzomr/UQntlRZliX1atFuAqI/e8HMcYnh
uEyw5yAXaN0SfDRn4Ywpksl0vdZFcfhhozSdDa/MAPXX6bPb7YM9LBgug6puFEVItBNyAxKDv3gA
eTggaepnGawRNFByoRwJChjzx+KYwzMXNMI0bbFWj25wAKFHi0+BxaDX+ovxlWqFEvJiukOH940a
+ZkUgiQnQo9wFoQOANuTdK8Nm6QudYPhFnX6txVGrZuWYesn7jbJJOrNtqEViKB9SF442GVNV29I
zL8JpFVbVEM1OE7JpBxwOwVprxoEw2MV9z+XAxdHFwlT5mY1kNeYUKomz88oYmfyqbz7E/yC09Vj
BkNQYpqvVki4pRbydU3tlVxRoCtJ3ijAuVFAYPREHBvA7QyDFSPDaq9GqifHFKYzbFb2QXP5vQSE
gxJz8Qes4ta50wDOuk2WtUPikKQ1S/u1tw4aNA6sAav3rr+ifrQr5Emp9hBnpnfxMN5Z16BgBctB
GZauZf1W1bRP5zUcM46WYRVq2r9Nkd1RQvMh9pr5vq5UgzQoTf8MbZFhtoNB2qEKeAKDaLRT2Mm0
6l8cHgWeT/c1uHOseE7awNtzOlr0OKekFjO3A/KfIstHZoBluHcHM2TS4c3pfTPu2CMerO4Lk6bB
xBy066+mvg523wIVAxnDE1THf++w8+ErWUqRBvvxlebE/IT/kR2XANPCHPGK3PWIpWnmf2mfBioE
f3k+/MZTEQMhdGoqeRG2uTu3Vpw1UmW2dVehHjeJXOvBS7bMSuTbwPmyH1wBeqtoBlCHiCd+hhsU
r/xzhb51BwB8owk34WbAZvzZmlBPrcAbka5xup79BcSUhXL6mD3VBilr2U/4zjW+oSj2+Ai2ekx+
DNgmP1SfhEfUUtYavGlrQC8b0mblinFHg3ZfgpfKE55ALAKPpuxsdgONvHNi1MEOnK00gs+ZovkB
r95BB1pQeHtiWhiGn97r6UTSetec9IOxCQnMU4qgW2w6T+OhK2ft5lQoyyddQ80NVfEEFqjsckKN
nEYm4rK/IaJ6YVCV9VL4JX/IrnQJ1UbMNRvnodNMJm1YMEoaSoQb6eZ3/RQlbnpglYb37mBDzoSC
/RGK21j3WuO+0Dzx4vbYKWnvXoVNlPqRNQC9xaNK7QXzrC1L+CgjqsHz4JZrs1qfvYJMjXno/6Dz
Wb/FMflurZ0DKKr8MVdPc9iXUoqzHYHHkLQIscqKmFDUBkroLrkl5NmDtn1ueoXzcT6s9tKC1td5
L7FdyqGm4YpoSDouCUZwRrEOPPiZy2hWiytmC0sqo8pKqASxOXy38fJkx0kjMKxljQJISwRtyq+V
lAVW43Ube75jMEalJydJ0XPJwG/qy/HQ/3qmnduQP91lKhXPTZYzzcQfyKaTaBZiI050PmWEHf+k
RnPHhrpM/eZXikbnl2Sm3aedNQ3ear1mJJzbF/pVhH774NCOXg/k3oRamEsMe3jOk11f7qz6evWi
Pg62FEygfOoWBp4NO/edmYT9cMtqm+SqXh3WBcxLaDYPqq0wbB1gzFqFwjvthSU5YaoRLO958yiW
sCxkbRzVk7j76I8kEDMlF7o2qC5MvhV+b5BrmYyNgUlipMj0rlkn0bqvGBOABDwp4KQ9oNS+lWe4
aK5NWN/ukRrUdx7f/oRA0bhmcS7zDbHTisd1lEHM60R+vnZF7RAFAvrELm4zwMoZnSjbdk2YuHiu
EhutwAW5qnSCv7M4cGY7uXr8rfEtQvwZ9owPjNqLZqCpYZdJ2LXG5orZ1DgKPySg1HGzQw0MA+Sb
Fhlwe1IcfZ8wEyY2Q0BbSRS8+K/DrlFXQvD9gUuAvmsXnrYz1Np86XlyllUW2j+XzEJvhzCbtVzO
KaOIG0n4avyzjxOAf6gYvvuWavfw58d6FZALhzzhJ/rPxYrcnrs+sPIqky7VeT6DPJxYLqLzwStA
YKrTKvzCB973dhxLRuLqKeJk0jj6/+GnmxgzE2RktbB6Habh4D8/FixnHfTAA2++NWMGR8X4z7lu
f4bhgXnQuxvdexrYXfKbJDmwuK+J8koPdvmf5elVFByM85TYwftqDH72gI4/J+x4+K3DpgC7gVc5
05QFiF0pNnb5SFtUoZeSIviBnnSrTveeNuUKmlDtZxGG4ciy7fWn2RMdTerPWqyYCzP6hPWti45I
qvi41OCvBa4bBfMTHC/1uDIic8Rz1IpJFj07QrVPDW3cph3gnCzZIYUsOR5PiouULEfCy8Po7A/k
Zaz3wWKs/ijfW42xIlwpRUByfanFu81VGMw1DlBdfwxgzLdPaSak7zjwHytBj4wP+MF7rP/qfOuy
/3/4j8PpZhd3uCQEChtMwAlsQ2ZT1YaWk5WsegPitF/2nkMp1qEiaEmJIBsGETdF09qVjloPawG2
oqx+iNe8XCdR7q3bpQ6h46q9IO5txtxrZQmjGhdbL7BIIEtTZ3H3TyEmkY9GQtv1c/gRIzPHfian
t5CuA00352QTs0aZ3gg8jzEJhu5JxpfS7ckjBvgnX1Fh9V8T0U5BRD8GNdcToCLS3RbtEcwJuw5s
XBpGLCrP96IKeusmdnbZB9cu9VAZHSpEgugxvtPLfAOZU6iqOdDaTplzXX0jlD/pf1ptZ6sxAL+L
B5Esi9iuBvR9oM1MExnJwsqP1XuW8zjHMM7p3y9AZjjCSDRuDKXkay4Z1tF8nilqKanhyWnz8EbN
qEhVgbq8wPIiznb0+KFiNQFwIfPZZRW8hE2DHMC7Lh/rVChmQUviWKXDwelhUb2RO9yIAJeYNONs
pcIxkUvcbWgmTAMm5ra2ZhpG13VrIyR5pGgeNIONh+JrrEk/PtcebkdNFPk1CizNofZStau+bAEK
jl2GtaMrTzleXCjyZ3olXqIW80RYVx0yIKYInJEOxbNJ6nDvpG2lRX8BrZKYGVlPKZaSak8dyMpG
dfKx7MFkGSFqtJE3nIBtSQ1P6CeFLzT84CsO5YiQXdQspQgfo626FQJikMPm41HijWnYvUdrgGCU
KQQ6x0OFzhVyUlbTTyIaBayj/4mGXt2SNdpltsi7fsTxr3q6VLyNVHUyBqwPtweA938kjLCOYn2e
X1RVPWDF7YggKs/naSwfwz21Hn1kvHbHkjuBTSI9sxISYozt/zWyxKtnT7nd4HnG2Qj1A6xPK5JY
NHYBZwcW1Up2/dZkpaEuNoggwV2P3dqoNKVfujh8UyVatGLXQd56tttA1AAmsJk9ABK/ibLnuUVt
i3UqrH3TdlANCayFKDmGknPm3PLLj8PQbupvMuSw9zxCZWG5sb/jtGI/XKJBurCsok0f2q4850mw
cDhQ2h2xiq0HwKJwN8PfpF6snMmMOZ3M7e2QGfOLfxtb8p3osGREqdPis4zOiLVifHs0Cg/jNV5a
FT1mNik7vTxFKExc6kGTG+rY+IZRqY0cylZ/8//fIU2U8WJrD8HIf+sNiHdkOoOKaM2XU04N7WR/
hzubfb0B90NK/L7Clxsi6NdfgrOmJiwc8JqrCRIOcG3tZ25f5N0bGRS77cT0KXXUAk+iX3nmOh26
QW7uSmIF8j6rzYuUpTg3wogOKoyru67D3ktLq8yhgGKZ065swuIuWYDQnhKtBJ17l6X+BrQ7rUFj
g2W+wfROA84AnRKULikZIalHMDKetL/cBEiSKZCd23MzNr6Jka6UFmMy5yVD/bRLNk+/T7Hu/lx6
U7Gg11bXAtrlwLvi8iEf3H9eqCXdrv06D0viOgoIsC6Ok33gItW+x1A+gH/UXNqrohLkfVoR6Q9v
HIGOEoU2f84aJS2mTXpI6UtChRVa7DZrMfxw8MLB/srh2L82YHa+JUQ/dPaPCe5yQod4OW2MuuGh
9MS/icez4h/d1eGztIVKEbIXe2n3HclngjED8zVO7SmE1us2vQwd1N9p18dWIQVSu5ff1fuEG55q
lfkdd9pWR22nCpMD1oVkYPEbZL+HQPnj7igQXKh+xue+GanIWG0ijtKgtHebVYF7c9FOucNafS/F
es8hkCFVGfnnY2G8m1hIa2ZdS9Vyxt5YV51uQ+2CWmRYFpGeshEepJDofWPUJMlUswjYy6Xm2giq
f60GOql/ql5q4T1g8RvNdqv8ZAEzExWpRa5+Sz+HFrwuYgPX/BN/7uUCoPovmOg3TSrKqx7XZxrZ
pO2ajCTk6rH8LWfgmfcZux93HQfTFzKnV/q+dRo0GQGHSAvGC+Er9dkAsQHawVKHn1sUuY+BP5TA
jkUEzccTuxwuvRi3bDAuVpommeXuFKcfk2h1O9NHdf7P7RHszyoQJX5lwVbDaDj1w3WpGmtoJ7Yg
lj6odYf/tNY/5QGMV+LOE2qlnkEaoK651qXOUj107Atz8d1Ik0YQUxm9aaPYK+y1JIZBLAMKd+n7
RHV1hpkaEAXXEW3j1ihd83dqxBL+bra8JQdxqfWa8saLM08zXu+1Kj35mWAlCZm9oivWbIDGyw9p
SYgli8FrDanOVHUiIf8LCPvridzYBnitfv2qVcJpJ8kNYCVCelQB5Yep0p5MtESMY0TVwVwK1MDx
DskKZtk8FYcikMosdmmOyEiT8Rsxh/LCV+sKkxjuyit3oYPP6E/vo9MgV6900hbwzxW/gXESWssu
p5jGTfiHBoN3YJrlbTOXymawl2XDNw3jZ1FZrUC4o+c3bXoj/6CWV0iBnZjtxnZHQWmo1QBI4lG4
Q4fJ6I7tQHuQSOfPM2sBUJ7ViVqnhENR2oHOK769JEjKEf127cGByH48lnm+xziTva8LmiBnprIb
YjeBQzhK2TuCgjHjO6uKJiD5dcJKDudA73ft4L8fXau1bI58QIG8dyH7VVmsj2aaKVRpTVla1PFY
K597TJ/AxsHujx6CsESzWcgfFB/vD2Do5Wl2oEsJAidB11nO7FhpnEdc/afTaXcWKzFyTm/7lH6G
wZw3RNyv59alpabca/P3XEG1mfWUaY72zx/iCfGeMQjRDfhieTxNFZ/GU+Pw3fXzXijvAkUWa8mK
9MkVsIX+n5zhe/1MyFVzB9IPYj/EwFcS+ArT0iOxHz8r7gxTXDQC5BHkw3YWB6rJBlFseuoGeywn
WGPVtJLsvt5IwX3xZECnOnbZd0idI8bTx5UatvnSbtACUJTSjoFNGMzXDtZuFLdYMEKtnWKBWmeY
VpihYMl74XZMXO8l6eJjupkokaZp5T2MNpzu8gEMhsAyUrIT6HEVgemkpa2IErMq3JDqftw23D2A
s5jMISK9rgbI/54kTmPlDYFkhzqZJI+qfIUG8et41I3RW/1MymlEPEXHcBqxhbWDt9TTkDa8D/+z
gGEACb4dZxTC+0O2RD36C8yRRWj+dEo4kaVom04bH0sIDR/gHnv8mznLlMoHmiibRX144Zbe6Xzv
WKEWH/lT1v+7I7UDLEksQPkRBf29m34z3m07b6KqXm5unS447k2fLgPudQk1NPaPslgj8wy4HdUx
BjvhGPgS/NQzyWVmPnUHGtM6Fwj31sCYzbNRtJ1C4ZkpTrHMiBwJiAdPMCVmiT2YfX7GZL6W63sF
uRzkOgJk8nfXPxzcuR9zPnYqJpzIEKzhWMj8HE2oSdTE+jTODhaF14RcZOuHP+Z7WfVu+CT0w0P+
NbubWU6yiSzOgPul1kPDpl073W9V0PT64n1hhz2ViSGW5/yNvQpQixHa/yn3jiodyfUKBvn1ag3C
U5UL9FHbzHdVsf84OwJDSyBkMeaxYzntAusmpOpsLL/YHmAxO7bxi9g8FPM0hLHK8GmPvjvKcN7r
EVEpgECGzt6MSvfqzeSDFANHIssSjODZM7pXu4TV3vtYLcm+ReiLznW7tknfJNJt9xpUY9J+5f9e
MNmodi3t+8F7hhX9bQxO4LPEvOJUqvoDWjK6J8u4Y2fHWlBQkaVvC7WHcocdKmZndqyOZDyROmGf
P/ItTtyUZ5NfV9DPuqN44IKF+4nMvF6H4vN2xLOBoWXjO+37ggB4c9URUvwn7HRjQ8hIpW2tD666
TtrtHoG723b9JkgbioqLxXo58pyFYliMvbDs7OE8k74gJ7+/+u//SzsJD4w/9oXt+cofZV6kZS+L
+KzrEITX7RUS6yUSz2L7vBG1lBkB1FR6BcLtzBAJAr7DsRhiUgj091BHRImsc9Or7hQbbbjSx/4w
hJOm+XLYA1/Jra19Ic1ZUVLuxB9nRMCLR3w0HY6cwYEGeT+QCTLq/aUGJWZjk2u0vNCB/KCgffs9
qkgHbMPwx4UzdzepCA1p0lwhclNFaiDfu4CsXCqMknkyT7yGsh+qRBvYlXMkUuFqiE6o7/O3lSEs
0N4SkDkqsPlO7gMDidAHro66QP12ywDO+cU1MZQWkJaTsvLu0pzC+1L4AHn+kaHn6pQFpXbjhQOF
XSqrNQeyVaqQpnGR+yZxtsqe7COymOK9WHYWSTciZjHdj+60Rh9uD7T5Zqwu9WiKBYuKaNbsaBvl
CN7bGYEYRChQI26B3rMuM9G6f7hlJSE/QoQ9/LQeUx8aN60GPQ4EULfhjGCo04l8f9v2OPY3ffcD
YUmiCBiLK0VNL8zV3g95BVSb4vtDEibFa4D8T1LrTTelZNxglURmi9jaD1oA0TnorubJ6ZLsFteN
NRQ60ILph8V/vfxwTWUe+AqdXpvCqfEgS/+iotpQ0TEOOCICVHqNzEnWIKtZ1Z2zHjq+sN3dzN+b
VjJe4qybJQO/mJhlAFTXgtmTzqUlHbYVymscYsm+8xknkUFeGllAvMvGSDLgE012DcqHE7wrU7Kh
lCNPW2x70KXpr7llpgmx//yqFL3e8MsngTKgWftmUtZ7FC1Our/Er/QaUguz0Cs7QpXBKrY+JuoI
/dmgp/rCUPbdPf0Z0eK/N+7d7nodvMhbQ+2aKxTGZ3+qxTayYEAzHn4FgFko0edhpptWBzM0PMzO
nt7v9L0A4VxrFSOsg1JEmnJife4PvOSOITv2p5VtCXWd+dwRUHPhZkbhR7RljtDvGw/lxh+q+E8s
MwgccdZNT4/jmNmGuMzxlqXlX35ZmLyIkQ8uW1d76Vnha7ylfeeWzguiXMHf0PCUe7WK/izMYZ69
qDtO/VB4ba/BXm9ArzIRAaA3E+aFN94NfxBGUToGcmG72lT9DkTQ+HzsnC3bHRGjwK7/0/2KVq6u
NGSKO2jh98+69DIEMoG+R23t0dEr3eFVi0D/jo+wf5xLye77OjHYPrLXJYe+F9NdHiSc8SCxspxP
ptxy8fvo8WaD+Z+D2Wv6/eaXGPX4s3yUdn/pMMjpCHBdPkXrMFrBgwV7Y06ZDZFECOIZ74W1Ac3r
ST9pxWhc9yq0I3GY2LNV4bbxJIhF4hOZOP6o2Y3XuN2BoeuZzKqtkMzqSIvaEjpHeZWyqgJ16dMK
g8wl/Vjk6GPr4MvGk2g0DPGj6639UD3cAtQR7Grd355M2xZrWwXjfwzFdEMXSIQmMh7pQwJvcDIR
sXh8Ttj65HibZtNEIuNQyPoYcWL/rVaC9kO8fvyUgXZgu65/15TRl3qejGErE9zgnJkPtV7o8gb1
bqTyjOUHJg6HazuD3Ijob7al80OB2rCDDQLumQ10rGLlXSeseHMXhCaqnHSC8QB3t7FVpgHFeXCs
cqGtM5sEQfqEhhAX6RALGQm4fbImGDoNUm59hHquchFU7LmIIBvd2jWQ7vF17dNQVEpuXKAIfnPe
mGv2Xd7IXz6+w68ZbiXsaWKw52YzNlzS4JVuHMdf+nOYYhYPsEq7O9kpsKVuh5sQ1ABBKBA6MKdK
c9MxkN/io2iiHkqaZqIN/3XevyclYOoCRoOb9VmMr6HV/dtQhOksNtJw0DdQVF2bohw9SS4eofB5
oSMLG19doK2UdEvhRPD19Y9zzkvmQqrDttau5nPfZ7EiDlMxKDrgUkOp1+faxHzfpVGz5RJg3i+F
FRn0ocODGMvop+J3pnLVYxKM4nMzXjvrh8ssp5CVBOzemMuuVvkLRZXTDsbPWYszG2n8PXeBnGyf
d9N9a/XOdtquL2Yyvbhc72p4MhLH1iib5SIdGIpTPY0fDTYvEP+FpagS4gqp73EkX3HbHKT7QqBK
sBbo3C8+jsY9rSdMSM7nGrWUSfw8arNOGewTPWuoqogRYTSfyzUB21oEi8iocR2J2ffCDM/2HuaJ
ogq3VgMHQ+cCGiS1xyJkBogGrvjfvYiCOQQSyJkkFZZNCtJix1BQ9P5AAq69Ogptb8gVykSDEooA
8d4Cex6zNV3QXCrX3B0N2v3w9B+VXxudeJEFdUH0PywaabS7/P8uW+kFyH4Kfj5NY4qSa2EBXRut
tNBoPO9F4qBI7IwqXf1dOSQau+8Pp8HJNKPZjS0+Iwb7ZmejOexfghSojSNHrGbYSIPXl/CfCgVr
sZuUaQSVJtOgzD9Zs4B35iN9leyaHOhub8U9Utq73BGH3muIJPgvrK17TafuLASFYU6f55AYwlYP
7PiahcBBsjYHqU1B8d2sJGGQRVUfQnNgk5XLTnsv5OSdd2qqYkts9xqmV59TX9V/d9O0yxvSuyYT
LK1TQ8a7ArZNgb3kXiFpRUjtLEqd7YGdk2DKcATi274JcqRegAxDJyrVhQXJYirajFF5PMOP4swQ
OCU9+4NcmQUvmYDic2y6pwc6JqewJIUFvu5CvVImkU8ZPdu2WsK9SL9qGdZRs2Xr6WLjsEqEtQ05
SB+T5fKMFvQZud0TZVfvl3PPBPXNAZPA/1PJ18rmTF23/UHUwtU2ZTo3EK4uH1DL72x7l3eHQgIM
6lihGA7NkBBsgSsVnBAXqpqGCHYiySXndtvy79ldgYDbM/AS0Tw3eWTYUFZoZllLG30yUIgsfvPJ
mWR6cBZ5qqItzLDt2tMlYdHE2u28jBZFpYAgId6W4zB5U7SwJA5HsF5lvWYI5o6wNYhtoDNk6jOq
EAsS9V+PBCCJ4mTNZYjaEuHRAo9b5xpTEDHfZFnPe0fYs/5mqz+UIzTJ+hLgpgO/6ezOOw+KMySl
X2iy9Tayk3f9AYROthhRjLx0ZFOKw+RT9GfwzZNlEG5nkGHGCpD6LzGGwqCn4K3nfrULUj3vrg6c
dvqbkyuIiZoxx0B7zo09fEQ6cU32/btERUJvN/HdVFxmPjH33PX+2X19wXiE/CgTyS/aej0GZoki
X57O97ObVOWSQ/Rf7Yg6o38E2pCLcL8dCtJiRRTuBssAbGwX+rHn9bM79h3onTZ6SKEGpgUytk3e
3FsVhUcKpfArdzaLC69grx3rB0hkI3yQF0Yzd968cCQPf7Hh7q7RL8HJRmWXe1gc+V0lh4ZoXGw8
BllXfHKvppcoaws1NhiojinQVUBHJAcUz3dDzGuZERFeoYRCDYkwfizLvGA3RYRmZixpu2NYvA37
WoP8nysvFisSa0bh9sjwZ4BiJ/Wo6gu+PrnRBg/tsiW5aO77HZN7edYEy79Vo/r+zz9t41+9JcdY
GXkW0R1LXcrSCmAVnxwe7VNr5Tdpdx/AX30jhNfH77CyV/u/CUzsXRN+1R9cP3ZbVpfiWG86T+Sm
bSYl30BmbnVJ7/d0wCTKcA2lk0cEDDXnRPycw73ZD/TQAICSDl/A351KDFJiyY/Ge1YEpFsg6h65
5tYVxFlgCKA2infB0238FsYfoBQsnThJilg29O8/WjkqQnwyrjbWx4FE+z7nax9aW6+CFVD1dtFw
Fe7T1BX3EdLNDQ6IrPbDvMU8iD7pbWpKW6UHgJ0FXlZ1yrMfQhIpmFghLlqitwFLoIMXQ3bjMGux
gpV59Y+PtdlAgcCBpz3zQYQZWIDn4/kwJSX/5QrRLZP41omMy2jXHdeH5BCrm0Y+BGIQdeR5qZU0
m+eHZpgKFFzcwaXVrUh5MX0xDeb3WiLF6CcVPGI4a2ZsJjavMphGun6OZ2ExZ6HIog6/PMpNIWCO
qORCtdHxe4CiVbyrenRDQGeFDNpsJ5R7PHYcJzS7nqF2IDyqUIEDverN5RClzyGGDBZKaXF9YjvN
PoGX7uVLfiSrYnaq3ksOOuWp9MHI5NRCQCFKyrhpmieHmzVj9JpEnjuExS7iMvVKMiZkVy8v3nuz
q69enPnCa0MSgKeflnxsMKGz5BU/Sg7h36EBDmGlBW+b5NbSUQLi46HRJP9vKxBbN6tyB8Z59skt
PEbsE+I3NoLhOW+ptBVlEWEAHI9Rosx1U+LwvvKW3GctlmUH0FEc9EKuNqAkWwl+oju+A8wVqq2u
Jc16tuPygfT8E38mgcu30hNYizvfklp8n3ldFTDl0ky07Dy+OPCeGetLFSAU2hEv3IJzRJczWOH4
lnnRrs2CFTKtqbCP1H77Cq+gacqJA7DU9NjPmR0ALoiV2ODiJS+GzG7EUEmLxU+5e14MnA6O+dEB
wefYtP+5u19AZGSbb57PQBf924LywU64n38cRBixBM7zzHYAzo+vebPvUAX8NoIeeZSmVW5vmh2A
bqEgsDl0HP+aMlTOnatqceevn2F1pV/veyYskJ0x2N1WVQcCNVX5RkDdkdvwqm1BmRiYbOaqQ6Pw
ObmOaIpiP7iufRtpO3sMo1px3jtCc58rha4cIqRAltbx2LsZn2Ru+5EttkQiiWZyxJmrGOcjnRLe
tYdWO7OLBB2gao3f9XY84LaJRFikKRnSDWqN0r4D5NDyNF0PE8IenFvpyheGpPqNywrBirh8ntqU
VZ4vz/Yz3YN/O9mBcQYqv5GNk2LKxgQsXpAZgBvmR/bYkWzGcU7uD2MnM8brxNaL6DMveuACEQRg
UeeI2crHPynsOW+TTWBqghNKG9XkDPGVTfBBKCXkMmWQh6FaH8++W8P7K6zx8O+34/SXkpu/WUIr
/aeyND4a9LqqxEiPjS83wm8UJ5clbWOncQqzUoZNEglkttaKafDWIQ5xuVcfJyyJnnptyYQOWrog
38MHeDUpUjFHR6h9AxE863b6hDrxUABsT4wLxDGR38M8B7Mj4FQGi2j4vE8IWuq3A4VsWuOWjpgC
8hwJR6tRxxW6V1NDIiZJk5fJEMF8+1aVxkH7Oh9kH63tB/XBiFUzDor0PbwgpN/b+f8M+t0fZQnE
89B0B501NJso5gQ/duHP+vSimeLorznbNmsovx3FPvdXCLJoCPwMC8c60y/6ayb9GpiKYg+TjQV2
8GJj55QzS+qTHc5vQB6p8xB0v5qiWugY4hl9sNh6CGQXTM3KzbXbpZOcSN17u/uboczt4ur952J+
4agD1F82DJdF8QpSX8QjWQOdetVu+7UNDZ22ETpGoA33WkVMiIJ9VfW3khv05G8s1kgGLd1Xx/NF
NH5pS1SCUH5HhWx8R1p3WQb2Oed55/Tj1Ps1S8lbL88GjkhmAAX5vUcUkv1YbUAmBsKZ27tnHFpb
ygxwRCyHOOxOLr7cN6uTRwxxBLFkxNc3gsvXNFEVSvWbIY9VmaxIsaL8MXKXMaE9V5POgif2xwbN
SFbFD+zZ/yOxmJo8pzFZ9gGnVcITamtKcjRbvO3QBonDU6qqcE/kSZD6zJVPOd28l3dnUauyOZXS
+uGpro7eQDzLMYmM/kC82LMW4UI5gGbMcJXAnO2VbigrD9vTnQfMQ3TKGCxrxGBbpW6BuiCCYFU+
dloBnwkRPjANTOa9mzdH0KrhXl3ZGmNOFCvPoO46/deFRdXbzfIa+1OQg/OWoUxc8hEeLSLXtHng
N9Qk3Uuvpi3ClZcVRrz3Dcar1GpZczn3rnObkeI5cR2zD6KjW524YaxxTG255wJjZNMEztAjuYkU
Uu3JEcxLSoBkY8JA/FCVi4UI79MvysN+BWwqLDPDg4aZULHaxQhPSN7fH7LUHLOViNz4dVC/Dk4S
z0z/u2kv9rk0PR+F4TosmsGdJ5Ip1lOuzh6s87bCMjO6oadZgj9xAhZA306F7faoi3yhRzQ8PKoB
NzGwWmdni9cP6SsPXXhcL1jOW6RdB9meBZLtV0ZxzVg3Efp5kdV9S/Pz40VBMmBtgl+cCtAPZXlC
KPhA/j5j/I+VJvV4IFRxLHvKSCAVZJloM3sMD7AwMDZHe+akZYd/Ay/EurOsNahUB7TDCilD6yVm
BCFf6f+IpSH8+8rTcmbZ/cbAH9U+KtY7RtrnR0D1t1zzNsZyVRkpPAogZ2Pltv9sEUmRP1avXg35
VZ5Dk4DBb0gmHFc3aDnl9yVcIEqz58WzzRqkHaPMxWCaNFt0M2lXrOBJy/3pVi8ioJuUgtz38n2+
Zw4aih9zGCLFY8OwhN8wJVUijIgJRq+wx3PnBK7RU7L6QFZD/lek/kvXIOEdnpCRQRPwD6SpnT2s
ud/lLlwmlGQj0Y4eyO3yoVxxvfyHvYguSJ6L1zbLetv5csSdF3PiHtf3pIS8qgaohNUM8cE6Uquu
mDKZLVakvLKbKgMjmJljcqqeYhg/gcrrjkZuAwkkt5kq0t0aaBtfygZVodo0KyNK+uFNEqQA4tSv
pYhLw+CHOn3H9VNMT+YZK/5EuE0IQe0PjQhWacNvqpHZuZrkoSv2+TUDWxcIplRijBXfW0y1wWIS
oecwsZIc87jhO68Zp2bM0MKQ7AUIURCd2r5OZ6bV+OrF4FV/AYrl3HGHRkVtvIp8BKqIqRZLtt96
twziZh5khC/XDlah3Q27+86P6xwRx7iQkEwXEcumkynyEguH2cKUql0O8l9mGTVcHwAccJ/vw3+o
79L2RKB6axUvenmHNbXlMzL4BhkO9yPBS6tY8wFSH3sc0/vqi4SSUTN6tS2jySgoAmdI+dAM//kG
9bh/pS0kO5a3Of+LiE7rGmSxVCQozF2Fy3FuVKKJi/uHVLkFmxtbwoeuN8QgAv1qSBeL5n4tt04y
hUjgMeL5qr4OXcaquXzkWFT+TfRxzNLijTLLi4Os5rXMbapgZFYv6ITGgehj8Z1ygWJbnkI8JubT
dFhbz+PC/b7g7lPs3LrsVf5O2zQgirRgXMAdHfxslPqK0IsNOXAT32SgKPx86Gkn0eW8PVQZIMTL
nUAJYxDhiXzphzGraBVZaMLRogaBwqSZ6CMWz5CBNDWm6L1RijO4pd0/gpi2E23ijqN7XoUGaDWu
+6BtSFONMPVPnS/kFJB60gj71M0RyDZLHGiMniRhgTJp4yhH6UtKWaWcSxcwgn6+pAwaNy4xrQ2s
FNpQCrLWewyxMt5FsgcVeJW5wG0+r3WrwYwNXmDEmOIp/kgHxApGgPHiFLeKuuQtxxkXcjbE3/Yl
s9GuL7tz7MF7h8NBSPN4g43tZzSFTVQONG/Kclbrv9mEaE9cd39tj7Ua0A4TClEbddW0fzMP09GF
mt/qefNuh6p+T5bjWfRBiSy031HnwenqHyV7s5Kmb5zdoteQMbTLkczsUSGpjVU+s2bbOiHvJ8fD
/qxq8me9xMG/Eoeb6D9bYW2dzyQgpTmHc4l48rZjnFaUIvkzhwNdgxZKY9frIFXRb7Gg7tCgAsSm
rhd08Tqu8H8x7g4WgGWpAhe7rbMFNob2FVmCGWZq0iDeMSs+D6HKPjb7zFqYTeWe8QwAc0dCZ1CR
/oa6J8J9qNEqlSbeW1Ze+6BsNVmDVZ/sOt7dJ2Pi0AwQZ5BPZWDext4u3RFBNUazq0rvu7rAj1lB
jNMKECYSAHpKc682Rsd0nUYnO4mwHY8+9T9jfrTBsbMDmR1G28tQtdhErHIRUibXAYTVSvuPgfjt
EDDsZK/LR71PditGYC4g4dlH0+Hzsh/xh3c/T5Tmaldw++yMzMX6aUONGCbK4iWTiqL6rehjPgt0
R+Zbh3GrSBCD3sRGq95qryO63CZYAJ5QP0CW35/8R5HwtxouJivYpctV7vwbxvjrc8kv4zz4wrJY
JEh6MXLX4Sxu31QM1rc+e4al4txeutJojfFgf6W0ps6WDEJQlqdu91oZ3hxhLx99gNePLVjQr54D
6s/puuFP2WTaZ6h2YJwXClGj//uOheoJ+n4n7iRTdnuPwQdqkg6KXbiw94WRfCJbYhIO1sldfXq7
vX+HZ1MD96biYwqDDO3wFh/xw0a3PXhR7lwyDjqiG2uOtScP4K6lIkOKUA4zHHCnNG9qdpuwvep2
i2CYeRii3z/ZvR+5ibxqwXj2QpidtqnBMqwaKn0bd01Bg5Dy+EJvCUxn/r9CDJvG7vjpK4Fk+aCe
6aWkKCv86uK68pvXP+L++xkJvRwuecg+gf/8sTVS4ZJ8x6exM1yROcajeqdae1cGLfHGNuhUkkj3
MtTQxEpVgk6lzYVu8a2X9CApXzD1w3OvKMdhJOaSy3va+CVe2b6QGETAmcMEmz1Xa88VgMH3+xEx
O20gRxN/OXgLnz+hDRxsRvTDEErTjok2OWeRGIO33cyFMJm8nKRykaUltjnXHKLaVrHYSymT0AXn
xoGWJkMpxlqTwGPDa6rRoZfr0fIXLydQsQfRQ2voVNYyQXL+B87qUW5MgTk4CvCbonwQUqM+RzWX
K0lETOWf8Djp/ObXUDM0NTkw6952Mn1k/wct2eY/CZtfsR3qcNHnnMISy7sPpBMGgn3RdGZzVa2U
2pwjxnFNwJhEuVa2lHH7lxj8DWRVbVmC7E2OEuu6mxzJ7pAJ3FAvKslk0OLjmC+sDGovCf+zMnBT
rtlSD5dq8tW8axoLEXNYLD4VyMoqkyjl0r6RdXeC7kkzGKuIMrBOOS026JBJ+n2ENeltmGE3HI3G
8dEMi0GewQewyq3pVwQ7/pZv6Ju3Sy2LKfNBjjjaHZPCQG71CTD9G2nq4qRjXrqkEAq1tqn7hsx3
SAu+hsffk2goYbS+nrdJXNWbpR8t+UfNmFS+KyUXDVCSR0g5YBePsmZbIUuHD4zwqoBUzOvTTopE
32pAM/BeQwmZ8awqt7GuNnaPUydAmnfZ9efg1YnMMPrVcFl0lRo2VdOm/AfQSHwALli/UiEY9P21
V0KsfF9Xc95LcVvxF0SY5jCXjRK3SgOy8BoziffoVhwYUvsNxXMhWNw8vkvjTWbhbd6jamg40Jue
GuwvramHYNwapaSt/EazgWHKDIJwia7SMZ1hzHAS4f1IkJ2voclsDgd+iuOHrFm4lrJTTGnG2UH3
K8JJk4zfsVS2XHGVGBtPrenbLkP9GhHjFLsFY1xlgZE7nqbEfQmepT5gpyb9r27ezDRiY8MCiV84
kqVMHR/+uvfbSaACj6Ti7g/Jo5M3jb5+stLavp5BHQW9O4/4ysSdzfWkLA2SqtgtpLSCiyb5LaR2
LRqtsrUatT+jwwG217M/VWTj5vDtJ4E86O0G1EPtrVcKAiWr1NKVy6IRPlFGd8su30w3kPSRcXTw
QDGxkb27VQ0MmCep9klh4CtpcF0XsYbX71QUzzOgbrUatJJ5GMXQzL8ciB2YmkXPCT954tvlRUxI
QDYMPS4SjV5ipK/2CSIOYOCkSLwsFEVOycsh8rPKnpVL4ZRYQa/nKnBAPJwMuG2i95gkW+LNzaku
M+sTJj8AtqrNXjXuHURdXUj1DVxHK5JX5zVEapbEqW/6VJ3gIJPSxuOLqApsQ8U+9/EX8cLBQaaA
EwjlPcamsoxxhBZkaMOTsCfBSZnSBbvFGR7djMR2SmrG9l1yXZ1FlabkYjdOJWwrjYmu2QCMK8mh
Sja+Z7dIWPrmNawuoxXIjGJKEco+dAuEexk8/0iBEdmoa7dUHQL4T4VEcVPGzMi24CcnPxRlDCMI
frTZpeSMCS2EYWrkZHf8/Mpq1JFF9Gmg8BRXskL6qjkO68w2P23LV3Ybc0iCoTCBGxvCQKLKjPMk
8H/v3C1+km/jLw0Q6p909qqK0YUg1hBk8VI/tpCk8vc0cH7/DbOWLE2EN23GCk+fWJJTwSnkFk/h
6F0MtV8VqMDHwJrmcyiWb/QsGzFzR+0oXE/kSCJCCvff9DgD9/8wyzPcdV4n1I9cqNBSY5gTyoOv
xuYbmX5gfblMLA2BUlKNa3AeBkJaWfUKmuC1WtDTeyuHTzmfJ/wQc5+Io9FLXxhM3Km/KK1VFmnc
qSZAfcuX/wsX/NeVUu2TY4HphvOKbbAlZqHOYBWe0QFHjt349biSJTUJkg0FCpjNGnY4YtIvTJr8
Ysus/8vwuiCcutRm+HE6pfko1vWg7VT+VPKcDaEdLGdF97sWjzLOY2ZpMhoIBdcrGCwIjmUngQ98
wywW0xB5qJPDE2NhPtdQzScsQ4RPhOGr6BdXvWy/Oce+h5TAJN44ZqJ4czhZY2UC0//dekiDNJuK
uH/sJE2B3ydhct0nhsEw3qpUdemVBk76A/tSlPdbbXFBW9Gvf/ONCOut/EE36Rec8x1biaUYO/zp
H4WbkI/dLaR4rhtmFnGinywmFT8aee4PtZZdeeVaUEiQgAGF1tAcippq8LrYFhjqrLwK45AwA4mX
0mIBFri+AuvVrNjQ+vWS0foHAKzznh7JzJjknPATcEPgN716KHcgz2gccJolUET9MFzVv6K4am2R
4eUXj8ZVFm5QchcairX/3MGFda7sF7a2k9e6hCeOvzFP3xkzllpnjedX3Ud/Ii6r296ZINkZqB4h
8NT80tEGox7TM37jGkYYB9WQ3Ltqbsa9WFsbElNHeH/CJYeSCoiyqkPwziRxA9uMXBPsQLvRsgwt
DKPKvSYrehu167sUAZLOnMr2j4PkMlVnr1bwvBGp2smCrOKnUANamsbVNRzRsXWi+oenyiBRWi2c
mjctCAvqGtt8WJ7K/UEyMQjncO+0xidmiD/QPbt4IY2qx6iY9FO10lRxkwdMxPeVOXiXDZldUIw3
pbg+A/CDvQU/DX8Qlkg1q2g/oL4+PJiKy8iG0uMFKZ/w7sVHZU0dyJQ2SM44oho3dSKMINn4C0kK
juUJb/jKoUkHNXO2qWolHLvUvSidbdCRxGoNhm749LG6JxadubfWnmVCq09n+K2S8vD2IGaJcptQ
dwLAPwKDtca3tGO+4QDuhip0HaaGJ6x7CdJCxIcGPeFOpaGG9+IE3lB5pl0y6zkTuVuwMK+zYrj2
Jn3Pa2GX31nDtzJI5KKBEy2ZEC0ybacl8ka3SNz4cmUyXWLoYh2I0BzF9FfZg2fNTc2OEya/Es+m
WphwuUydYTm7RozIcmIMQXjGYqWO4XuV6eNdsaQhQQZrgkLwlO5hCus4+qX9g/T2w1Knxg3fxX57
fR2XiMfLyfUPOdTMz5zmzUD2BFoe9E7WVbM9zQIedIl35T7eiE3w1dF8Y8j8LgCTr0dU51o7pc4h
N9PD2Hv2+Y7/FLg6Lmte+fpCYywScR7HFS/EPoOltQkMbPKnQ/8kKqX34Grkb+c58HHN3iAT9DsE
vj2XGfIFNFVuKIkVdc2mloJaDqMnJILt6VD30DAw3kmfmeIPNIKVOg9xC5M0Qwpl2u8quzB42DKO
Y6EVgFpCcXFoN+yhs8wkVEcpbaH6j75KeEcnShosZlA8ieFBHG0oSjQZlujazj6IP7ymnD0vE7Ng
vFvvH6uKzwQs1aSt85lns0IGNBI09C5gaWfDgP3+6OB5FDb88biJ76LetpUExh0WMoZSukISXohw
ABWyqm58wY/IKA/ipheziMQzxDZTspFNEVB+rBId0rDugr8mwzfHehd6kxhQBhqSq+3hYNAUajmy
yHObl1d/5J1hvKH3h1yGbHRAf1ER6bt+UEQxEh+/MlMYtvVaStdf+0J5FTBtvF9z1SA1dGMaYEfu
vmQh3MxGxIy9T5mWqx+6R4AvAL+752/t0ZJ4tttKjpuUZff+wVxlPvcpqE/lpRuBMBAysREEMtgJ
hvukF3qgSULBapKxqQdIArb845GOiSr5dXtE8I2ly9TBNZa9eNstPPekO+G0nwYohv605umvofOl
4dX49zkghbab1etq9B1Xd03oJvZddBQWP2p8nT4REHPi3bfaJAxrjtkAHEflNF9WUChRwK6Y4tzJ
VTiWP7/vdWRnj8Qqi41kEt8tWThGYOldFKPRLMZu2iFUv8t4FGzt0jleO5F0lp6EIqG8OOdVycwz
NiX/P7zTTjdO3PA+ibt8mRDL6G1Qri2yiIFoBD/1H2xMfBukHYbJlmGyeoq0kORCm3zUex10ump0
6FnUuUwqfxQifrrnaJnEokesULi0kPa+8U2sYCn6mKJeQq9LLNJZ9DVopze4lT4P7ltQD0S/Vx+f
nq4TYTly5v49IL2kjprEzA/Isgs3EzXhQGACDTJCoA8cKyc4RFEjq1Pa7kyYjEQ+fG0y7k5lrhkD
TGWltlGhxJ61t0FKYv1VhRzOHUOtR9fTYFTiZN9GWwA20N0In8XRdHnz/inFvPaNCcGDcUt/kv1K
IyQ7pbOOt11UVjGMRRXbzLyVLe6zI3WYDhDxt/RnTmM7ZcYi34ruJ20FeVyeoy0HvDigF7gcWA06
W71a6ZfG0/IsV22mJsXrg21/nWnAVojG7OknS3VAqPoKxXu/Swresl9SMi4n88XblV5Xlsk3FL4Z
XpZodZeB0tdEo/BLMhKWTNLyLYmYSH9twrMlzpb7u/Xka6tU2ucMQnU81kNoWvB1ozBhD0bVWXq3
ivnv6DxBHcIAkXD518sA0GfHmhIRBfARt0kDyJ8KQ5KVN9OmJJe1b7iXKv+CH+plXoKwvTmNSPv6
CfnW+FrJ1ry9OLo4ByanidggJF+yLhgkloAsMg4qmxNm2bBuGvJS8YBI14iTCQ59YaOLt52kqeAL
5MAi8vC87nw/+UYWvpoCWD7H5/tlpO3clLUk5fgoX/SEiZ8ovEEm1QNQpYuWcC0SH73P5CsWJBL4
/QnnQ5aPBXz+BE4oi/wFSBgrbjGTi/b77+qn6YMrt7L0MgczBNNIA4pyvO1Rbiwac5DdEhXzLzJA
blTnnM2D9Lrnilvw+5nA3nFhAMm4epYGHUjMhxvXYpN1Q70RyP4BM1dPSa1bFpJlwkOVgaadRxTt
K6akSXV3839gdWG2GbhFomifeaEwQmYbYiQbhF9+jvDq7Hv89BSqTvPBeM94wQE1lAtVUL1h8SiL
+GuCnCjjgfoY5flCORZsxBKclOnO56gO0H+6e9J7lG9XnH5sONHqiVD/3rPAA0SVbVZJYDePFCj6
RcJgSHVd1CC8lbi3hykfi6RWWjQHwzCjSULHgsi9w37Mepq91dLEW//qqcOs8/8zlvYT/awKJDm+
K3QbvPJ2XisvG7+lx0CXq22x6HvVg/K+7h9eLEjVKA6tSonlkiZJCx7YWj5HUO0TIpdYapZKdDid
S9PV+3WGZV5LHlKi74O0vTca9T/ArAkxMCqeuVMoaqnYrmVX3loixqKprr5ZxQhfjob/LhTzJu1a
QQLNYEuEUJSpZYnNiwwj4ZMO6XvsmSggJQnz2YR4twJhz1sxiZn+nZ3jL6n4EpKwrNiD1ODyMcVH
vE8jFYqQNCkp3hF8KuZTsUlBV8Sm6VghQ9a2/Ac96+s3j88bbcz+wk0B9Nalzf2kFmOPy0f9BmfP
5gnnaFzbvrbm07smYoHNq770bf6zkUcJTnsT7+o0v6B1M2VFu/4e+RBe0mvmw/Mnmrdektiz7iVl
OT23vQs/dZ8e/O37YmuhZqSVTJoxAbmcc0kI3Dgp92UFEvom4iOorz3yoL1eujM7GnhqXIhTh0Ki
PVoR60XwXNEAwHX+zAE4j7LBNIC4q5uLKKXFBv4pPyXrDWLmoo9ErKoE0CRq3giZjzE8wCXlAwU+
rnhG93H+W3KKfih3mndeJPq9Ww1KtWIpkBbSSXRa3TaigHwx51HndsCPZ7U9w5NGF01g/KUi2ye1
N27/n5jF36WRZQHT+8wDCTZPy8NFPv9lXHUU2nCAVzQYrqAO0svk4n7LzQtNZWecC02ZOOq+9LFt
j6b0YeNNrfh5rVqhLfLVJORYXtjOezUwousZk43OGMEUPZ0kfj3EeMs8pAGuV25mK+fJIMeqg5YW
rLIMo4TKVLbqcRtrKfmwLAhmKVzE/vWhcHI+e2KaQJXTzQyGwtIandYOXsMWXcJdSmK4y98IUBZH
9x+RPiRjKehWomR4trGTKdlVBhjCYI2wMXWQOCh+5/7WRhBc0nOQKqA/Kai4DpcTZMSyJD89zh9z
S+7R3c2jNIqfU95bOBhbxX8am4bjvcmU51tiin1FMlfvbDH5ERip+VsWldJMpFtGbMZsFk344HBG
Twi01aQXQEgACB03t0ArHJMvhJuUMaFbkxQHyliRguuqh+vgnqXdcTlwwSmIpMw6G4uAHjo/zWDS
wRzGDgpIPjmwo4WfQ6axp+XZURTaP178vEEx17LgmGxiYpBca2HAVcdUi/ajzkf+ufBgXYMov3kR
OmrT6cYmOYq2vebLDjxEa6+HK6IHDM5/R45p/B4BECBikRq+3dltmIXrbvdlY9NYRPskhlvuAzdc
gN5XD4rKDKupCstUItvTtlP7pxf9Uzw4P+gYkSs2iNXpXXunDrWI5iikekRFiNwJ8ywsVzJOgpdm
BcWU7bUFoVYMlj8gvpVwfrK/yI6U+97vnXkwHwLwTxjAYQtgKrjJ5Vgtkxv11pWvrLhPTCsSBIQ7
n8MMrrn5MImbW7pmuBGQlVwJtmfyxVrEjsbtVhb3JTVEofXZIZwJyOxbik5K2U2BfijK9R6+wb58
gRpRMdVy2I3PiAG3CFr6kTO9zQsHuDDsi7qE79AuyIo25iQ9vkr+9nzgURavYUSssoLyMfwLSx2Z
3o9Km5m9mvQaq/47MrN92WmVO9P+bgXcKMOsue1DIz0WvUljlsKnagbU+EsCEgalo0j+t9SX1k1R
r3O8zP7a83XjdnV9VW32xAi3oAzmQO4NEnmzPZB0DqW90RZINLcT/SbEfkp3cArabGvUodi47fAJ
A05KBRKz3ttsmGc7wah+T274MUPN4/tAvAGUld4DrLN997m6cRodKdMxXAzoX/yqcQKHV4YdS1PU
BRpnKXmG34DAVzZPw5jD3mb16Cd6rHVXTy9pTlW2JlDvc3aznrgLeVBSqhSd7oFPW1+ZdWmQikON
0A/7ciBYmhSRCaUeftd0QQ9AU7jGfNaz186dhaqxUE7Y0KsWsbt8VE8LzJPbHnJXK/d2b1xtrSoq
cMw+/bVLs9mpJTKDNbv9aRY1B9ibR1O/aQzOPk1mncvZ/2cdFQKsF05EKJIXF+iWsrsnSpwGjnOB
Yf3i75DT8CFs/EK3LxPAVsfoPGXdsz8ktWwsOH5UpluhBm1uQrBU4k5OiOuwtfvynPRusuAm/Axs
N2uUxhIrnhHo06nY4SaW5b6t7P/VM/iHBwXZQjFELkQcsjjtx3eRZxHaTajmdUqPbBXyFCayANfv
/QD1mBF6buksbDmx1/+VOEWGKdCGJiNaMmfmWVHvRDuVrNkPgsvb6Zk0032GXmLPeQbFQ5iNxlMy
/XYLy1IdZ1Q+qSLRSGJ6tjopZmQlAMHUWhXXGjZK44U3QLfUfrZxbDueMCryBXJX51UMkrMaNUDL
HRKUzbFdVG2ymAZIYeKJUJQ9FAEWJauJsdunZyTaRDcBqAIImu8opf7Ax30gYi4MosoPttCB4PO8
i4q5t526hzT4M7zJv7ovtIa3TETuZEYX9MgS3yPNx0qnhDvBJ207Wwgj82+25rPBsO5epBdH5F4Y
RqH/u7+5zVPKUexbSGXmMiz9oH6WqX+eW8UPepG5LLeEhScOR35fV7JCa9ib8U70EeaYD+pdRHhE
ZEj3FZhReKfc/PN56vZOqXZaRCrZDiWQPyKhGUd4DBJp0zOfu9LKWK7YJCZ2gbhgR85egvdq3o1N
mgXQWi0htIon/G9qwBff+PwbU301UDzECB9qYRWcJLl6hGCV+8VMC5h26jhjPTjPiWoIv85dGfIp
46ahRlte3piF3EjQLja4NvlRA2LvN0SHLW3iwfRuFRNxqrTVyLZd/K6vws4s5/xYSLKf6HyDdVqx
rOGv56BZkI/W6WdqUniSKGElqcVFdp33vXU7arV+NvMJI84R2gQY9Ygsz06ZK4DCh09noB5bGKxy
SizkSLLU9hQoseGod1P5MrLCMyNtw7DfeMa29uNL1n958B/lRUUCCYt90+v6iURZp+5uqE2obqp4
Y2Zsj2wjUMh9muwq98C3qnDwdCqUasEB2VtlmrWzAy6yrDAsIPWDc9wYUc7U5qQM582Yu8pH59Qk
ARxmDiybpf+HZo0Xet48C2ESYgvrfaZPvzz7nBFNrQq9gcd75VmXQTh6O2ywOgklb4r6eA645E+T
ibcc1ntMpwiZYUfaH/9FnWnJkRq0d2F8/Sq7IC7FdQFmKH+xnwKzUO+Ok1XwRN6CAKNkJtd/Cwck
F+MnPYU/0hw6vTbWS2JgSYIQvaRGeRsyJCi2GZmXYCmccXSJFaNEkZENMDwRYKTYgEb8iuHPRD7w
iQhFywimCnKmHSRkaJff1A4Ao8PhvReV9/+WcVLudWPkaBergVontfbUIFeKruremLaE/6EX4cwZ
tD58ZldPAtI90uyAL0Rj4Ucj2XvAagv1th4x6IS3OYMbIPTaWqDnX6wvLFahdeesxqZOKvMz0mev
It3zsMM+/0di6lTYVXWBoTfZW3xrPnBaODB1rXd4vYAG1XYxpVojf6cFNoVbxhHOmBP+/aR1Cjrp
kixDFF3SZYDxIdyuXaJh6JNNbf93Kq3pji22IJe18x21l/+Ysza4SdY73DxXE4crZebojfk6ajta
9ESjUV5KXGXPremrr9Oy2MEVNaiOD8knQ6TtCYYFTKW6RQeVANJXYiGW+ZFHnpwpldlVuOlQkkiZ
1RoSxIS4ivqcQeDDlaQkjPdTmIhy3H81sDCXLFn+eIcbd4Aq5m3/LompbJFU7gWB2avC/QbEu4Hq
06qg1Yvk6PwUkJ09d93b9rQMHkwaqAFp83nHGemNxg/OqJ8AqZdgOeDedsUXbRJjmTz3EWS7fzE2
eJfBhUPqyVVILYmpEk1caWZ6em+NgxrDI/KJlIB/A8TaeG9Tjkf9D8+K2P9bmimgEQa4VU0rFbZv
NEuClSHAUY4g9gM8RTcoYkSqCW0DirUf6nAJg/5oFAiF3uhT/3hrHlOFwbUIs2XBpWIWY8f5jTWv
PYlxvxtYPrsac4j98zIHzuKUrtRo2B5SLdD7c80JuQZWWBiThR20Bo/oOhiZfI5ZvdKPBFEGcTMT
JP1lceBJNIoeq/SXv/TUyU0bBZ5Lk6mHwHnO3m6JLluHOmZAbRbmB3LaLXgaJxyuLUjoYZPo/rBt
LrsD6Rm3HiqQMrAQBrYZ7yakyt3iYug+utJwqOcm/XxB181PO9Fq/Q4tHjo3Rz30MrGmsm69lFDq
lN8FyIl31TNRIW8nVhgtTq64p9/ShDku+f8xYPi/fKMzomhzVShTYUhuRLwsP6WYKfiH+0DX/vkh
A0roF0sY6Fe/Y+Q6EcPYwGXNapA8ExsjHih6FjG6GdnM6M23QLcqb/Now3eIERaozFYV8loE9rfk
3NEE8/iieKVjKj5zbqxfNe+smaequLiNK7VjuP+RjnkgtmAD4vgra8aDe3uzMVKfNAzA0X6GaQpd
lhJj5zRsMJqBHbgZsRsuAu4xdDKXwmJ0XAh3wY+03IuvcfawAn+gzAY2vb8rz0F4jhFtlSqZjMFj
H2NU4i8dVaX4kvqEFKDt/H5fNjQpKFqFxZ4Fo2we04Gr75tnmr6JDbUtSauhorPjoFLkgpSNhbpV
xa0UVBlcHYYHLtygOrtGERbm4L+QLQaOIuAsUS9HNG0IfEl4Uv72Ns04uXBUSkVVR7gQvmnaEfYu
m2UgtXAyP0cdD4/4hK5Gf+waEaQUY83OVcU+d1kJBkWVNR8/+vvM1rVVsSUjyzXnwqKeT8VbTCI8
Hzv+T5PJ2a1sngzDHyEz5+sZmmsD6lgVsDM7LIbBmE2PZrpUe7s+SoiO3b4DJzqz+oBEsJHU4vve
+4Cu1EQ0oovwzIgsGZR4rIucW2R0B9gmOTN+8bWbKxzYZMvkB7rHR+YMg7inpUCwbh4AYM2DayVe
rmOfKeCdQ5g7htEiTRN0sXVuKWwZLRRkHlz8EByJr+gMTa9Ut7OeWf1OgJGlpZ8uqWj5bkgRM/4m
fV26mU7zsjqyeu4vUE07B8hWfphxuhJ0+N3vJYBg1cOFhZwQPvNoJNfcdF8lFftZNdJqj8bZH+KB
rERgLHFcu7xRWzv5FGpY7cDXgqGzkDacpiSwZZi91eiFh4kxVUDl+kAImRXk2tc7e+A6N7VPoupi
PsLy39PjTOwx2ymLCw49/oD7FMFV9Fv2dRSaZtkKEgE5GQbEuBS8fJaBNXtWp/PtDMcsBk7lxzTr
3hR6kjuKMykoQHUDG5zY1hXfmZz4l0LjznTyDXM8eo7VPXCK/v2FarG0TJPXEkxMxygm1Q889jCU
vLRDjdKSzg55wr0j9EOCxinSgmBXT/nv9QfMY/b9RuU2OUZw71O8E1SH/KZywZsdIKUrdbHOUOwM
6k6/Y95nElqxlnVBZqKdiN4qbAiCKTbgEORcou1fepkVjiDPhKquRzjeEhnL9pIhoYo2atdZec8q
9Ef6fxE11Go6+eh+HanCWl2xlxY1jiPo0e+Hw1esfvFzQWUHqw00rOvbhSX2g+Lvkaar4v23VkcA
h9q5mJErstB0R0DB8cLkaRwZTlT9KM46Pzk6/6wsQGD4guT303CgEdvDqdoPIOqdaxuyjaAW0swl
zfWTTPpOKkSrotnhRNkDrcF0FzQZnJKSCh2rzvhmN63yn7iQMWI2NerY5NcZXbUCOpwanl0prp3u
9DlCLUhawbQEVUvijEbF91nOHDGX2mmY6HSIevf/M+girYkCNofWNQ0myFGXyT4A8cBsNYAElDiR
b3hYuSsDkKje22ZYBeESvvDFGRJN9RuCuq9wOHj8lej/x8gT53MRFM0EPoSkWAsYm2PlZuN/LsQv
v2tLtbV+IqKTkhwuGWYCurhbX5pk9XlJbLm6bsKA3bltk7Fhzivh879z2eRHzzgqwcx0H3C1WYXj
QVG+bb+DgKTdPzp3u11tVPe9FxRpmJqlxnvZB2CIA5Y4XpTsmt0QdL04/KkzVpDHM8v0IV1gjors
tesdXVuL+n8MLi/0wl+OXOFrtL0iNlJT8xNfCdtImoeWw70iOdgjpviKlF4/AF6fbN72nKj7FZ3L
aOKMjBvxqCLQZiETrciAFepqs3pWqxYTHg/qrR7croczO5BL2FQ6sVsmegWm8odSvUyvuvVd+CQw
cU/jwfWsSthbMOlMUVUdvTX+mrAyOIX8EQ2cseWlXY+DoVCLlwAaBmqZWDslQfbshvudYs2FqH0l
S8mby8aixcicIeMCdsORWsqFiEqg1ca8SR+pubBqbIUiVxJ8xj9VXpS3vGvf6SeCq3EWyGEvEQpp
IVgJ/8hckWG7DXziAD+oYmAH9DswDGn1TfdAUQZIzbjMCid5WUDw9O4B3lyrSG00fCdaw3a7Etzo
4Xiqv5xzrc0ubmXUOzqOt/BLa/pYCwZtke5EBwRKu13FhOKUwmnp5xmVlKckYdbVCvb5U+2Gzdlg
ptbmTaAXMKRoPoZ5TRsJtBgZdxVHd0luEqEuHNWblPFRAhcRShRmBpCHHMJeEcOIkOB+vnbENDMX
SvpHZMJtfhAin+h8fRnSZn3eYvszrIcohj1YDMViYjwRF5/npG6afKYaf1862FPs34rK/Kaxi/U9
bPjEnxdCNCNu1lEevcuqmu25VEYl7WF9mEN11KR50VExZj3Gr86NOxhFpI2jRV1McZ37A/r/TOkq
fp0sjXmu6VUqWy8Ph6Od3y9o1qasChQf517snPMQLWgZ++QMkn4rPKpUqiSZKyM95OBxkdKsLKNr
ToRbYq9hdN2c05KarIcRZiwIMz/mbSiUrkW4nudQVD3PF2YfDuWx39w4XOndJma6JSxKzZmanEKJ
xawzoaXNwDI4l7Z+KGHmLZiCQe/Wcq2rY6l0uobfDv9cHSrA3kxA09CUbFHet0TJs6249iNiajPP
F/MhqSWI6vfAqmCds35tPRW+OGOgr/LTznQRAgp1/7JjgMuhYOi3Z3MsZyztxc3lLkWK27WC0QHC
DJxlRyyvwktnHYllxP6gJc6CDyv60ApXIoKQD1dELNMuMOuoaU6sxK8YCZhBJBW+Zc74rGqxSScB
bxpQEpCSN8uF8oOA0M6PBuxlauJoH+qIDlMrngig8/Z0KblFaFEg4DDH+9a5GUZI69d7uismGEiK
aFTG3SkyoTEaflNawq2UUaqE6FRpGS6FeYJn+YUVW/HzpzbKmkefT8MI4WVjRN8n0b4oAhM8Hc8b
omEjMwpRRC7ymJJ0MvLE4tuzzwJ7gUuBV+R+MXZ39q5scw7rZqolcQ7msMIs8+BN47BGaaABqzSn
mcIwgNNx0ONFwiOWe1pvSYlkYFl+mBzTznaOMbX04K8Gh92GQQbIm4MUtzdZjG1ip645CWanVRcB
UOJdC+/vgChHbMvjwQf03lwlgaWERcdkKjic71myf3yTNoUI+93/icWGeMBqwN1LMQdBA0ZSUdQH
GXdraZ3LBPGMjn24Tj680Lb5naRFoMf5Z3ltl5x9rjrP3ATll7CETUqUqdIM2YkrPTVsi3BwceLc
ytJTadftr1VozALIulx/lZz7g9bfNKKLlnGKxJ4i3ro7FQiF68l59IaRJ0gMTpWYLtq8LXRNGaZ/
t+GKbHzXhddN/4EVRZcWXa2PqXfNyKfO5IyNJvWlKggyd1JEso3QH3NB339mwOh6LnGgvN2L3UpW
+syyDX17BtjLDzhlF6MuZi7WL8ulz1tz2aRBlXaa+SXaA5RJUlhM57xVguxT+x+b+xsICbLxhcwQ
R+po18g+7aRcQC6vCv9kUI1hr2+NmEFlEhbMAx2e++IPc6j79SbPywTE0E3hFm0w+vqJm0Lvl+VC
Lj8KupttBTXiBLDm2BVM8mstnZFwZle8cKoc7RKmeUf6OG0S40SQVN28kyOQVA3DHpbXNYcleMKv
3+vf320L9+am7fmDODl2UAOs/NKn+AP4dTJGSUCaL2Pj5Eg9PXbclWWXS9jGqVwRWZ39tchqo+mV
ZRPqNlecOnXtAs15wFgKPa/pAxBiV7gXt7MRBVNefUCNzX49ULJbHxZ0x0yq4a7G1viIahugLP6N
QPOKaNvEhJogZFeY3aLuJX5Sb0S1ySaWdDyfsdNpdJJdXy2oWen1sqIk/zG30xHddlThKldTgqDw
W3PUfRhdYNMy5Hz6saYIK+HIZ1h3dTisUt0vFgyc2BylZfBX+V1+7EBipChvB4Z0rHVrgwxIzqIN
l10jK4qyMiA8Gs6L8kNMRPAVZkbQfasyWRmiaa7onG8I+DTVV/U+FEkyXvJv2qDHtquaoVkkgQz6
H5aZi36G+0gl8QprWgVb3nVyjbv+klqQLcm3UmKaq9sTSwJPN5yrLnu2/Bb9ZFQQPJXUdh/eCxbX
hCekanOqCXQPfUbZDZWgh3cRGogO5gQ+wNP+CbjuTpZO/5DNucdAi4GGlspIonQYGxYKPAThQIHN
qjzr7QRRIv59A9EmBAK4P2+1OLHm/i7bi0eODq5xt1BA6VwMda1S6kogSdSe9ZnoyOjcpOS9pHvm
HytmiKz1fJM0raQwDlJKza0K6+nanfPBoVBy8M8Wl2vC+Oymj2ndMSv3ijFPLRJtbHNtTaLOr09C
kFbAaxXivhr8NJ16T5QDkGNqZNtzvnjJvRcWcSEjLLWqLk6T/hHv498dlg+sl/iV5gNxkq+HVX2S
KwR4GS6zTynlDmJBXvlQCxJCnD5dx4Pdt8CQKZoG/MI4YKbEW+VN6fQtNwXwNhYpf83NfTLIA4nB
JvFagKEe0Ge+xqq2nEgX0U+SAD398dRORjdAhRMNDEuKMXW4fWceV5KjKEVcmxdwc7pFv5DxlTa1
2FuJV9g6V2n9VZqI2t2R29ApcK6qbbo2KbGpzgW7oeakj8A+j4szCjYmUQBFWEbcNLLokm5iQTxv
9QhzZuM9H/MdYs0uyNqB+NYezMiUFU0ZHwvilbIa3fv7WmuiPWu9H9H1Pps4qt7YC5MCpGlrgeWO
lkdEglOyUrgJ4bXjrMoY78HBggm3+ndwQX3i74gHDp7MUK1p1e0QheWkacz/eR9BxTitgLU+GcX8
w+Jv5PN/rYroUWQh2HsDWlf29Kmfsnx05QCzcypo3GhVqm82+CQ6STyKtzu4/w/jSBOon8HuTPph
cK54jueCA41sanLuvEfpf6ZjBqGl17efp+jipemGek5W4LAzOATI62Sh8ApwYwl+2D9vpLW1tya1
YrspmwQuGaNpWCXn/b1ppuxrehiWS6Hdmq+24Gux/tNRR/5sqK1/jV6UCiwBFNxYbOUcMloQ7pg3
yr7de8C1GZJyg83gbay2mL//1FT3bAiA3vtPwMgN2qu24B0Y2Nkw6h/3zUbDmXTkVdFzhmxnMvcx
PlJEP2y2Ao/R+H0CeJiV82M+YN6gtI0rhvs6Q5JakJGS0z6TT7nJHvoDtdNED8ayb0rYaGA1365A
m7yXlTQLdZ8zRDbDA4RMvAxcoqS0de2m+byXaxLc5dNC4/9eNC+Jc12wjd1zZXim0ZEOy59IYm57
Tp0yew0qU3oW0mXM0/JCFY6vw1aQlnAb7rFJOY4ZXu3J/phPKBMYinGh4noW4pDIboCpYI7R3vzX
2D7Grt0xuVT0lGmfh3/TnCHhElsiX9mg3A3FvFK9Xx/NmlfEbxGtsKZrKO7NMYQZ1fGS9Hk0pVkC
vxODRb39sekxXYrwBwK+zkVlGYV75lYDVPNt3v0cotQmO8YfYQDcUwbjdEMJCoKmK1ie2rYwF2Tc
U4R6iaKauV0Ls+oRPs/L6ewJRZTMxt6HzUTfWiv3mCFvyAFBO9w8w08NXZUHCANu0o/sp+ixq6su
vL+E/GJV4r2ljdKBphIi5qlNy+H3JT0ZoVeN38p2xYuW7gyuhAo2bTu8mMNY2xMsE/qXFgBuNgvg
9AmmtsUOONnQbx4ObMtrfp4g4iz/H/ElvDW5GM+uGAI4wyS7vzlSwNfEOVdwB/fuEgE+PyOCBRy5
dmPDVUM+m12XqJjpceGsBoedinp9jo4HkSycNA88FODdiS+jl7qGqAJ6K9eyaVUCYEyZIjkP6RCD
UXaLoaaAZh8logOmS8usXYqLb2wPP5UkGC/y8w==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
