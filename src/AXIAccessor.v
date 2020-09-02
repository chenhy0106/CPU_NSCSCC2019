`timescale 1ns / 1ps

`define AXI_WAIT 4'b0001
`define SEND_W_ADDR 4'b0010
`define SEND_R_ADDR 4'b0100
`define RECEIVE_DATA 4'b1000
`define SEND_DATA 4'b1001
`define WAIT_RES 4'b1011

module AXIAccessor(
    input               clk,
    input               rstn,

    output [3:0]        arid,
    output [31:0]       araddr,
    output [3:0]        arlen,
    output [2:0]        arsize,
    output [1:0]        arburst,
    output [1:0]        arlock,
    output [1:0]        arcache,   
    output [2:0]        arprot,
    output              arvalid,
    input               arready,
              
    input [3:0]         rid,       
    input [31:0]        rdata,
    input [1:0]         rresp,
    input               rlast,
    input               rvalid,
    output              rready,
             
    output [3:0]        awid,
    output [31:0]       awaddr,
    output [3:0]        awlen,
    output [2:0]        awsize,
    output [1:0]        awburst,
    output [1:0]        awlock,
    output [3:0]        awcache,
    output [2:0]        awprot,
    output  reg            awvalid,
    input               awready,
  
    output [3:0]        wid,
    output [31:0]       wdata,
    output [3:0]        wstrb,
    output              wlast,
    output              wvalid,
    input               wready,
  
    input  [3:0]        bid,
    input  [1:0]        bresp,
    input               bvalid,
    output reg          bready,

/////////////////////////////////////////////////
    input               inst_req,
    input [31:0]        inst_addr,
    input [3:0]         inst_arlen,
    output wire[3:0]      cpu_rid_o,
    output wire [31:0]   inst_data,
    output              cpu_rlast_o,
    output                cpu_rvalid_o,
    output reg             write_begin,
    
    input               data_reqr,
    input [3:0]          data_reqw,
    input [3:0]          data_arlen,
    input [3:0]          data_awlen,
    input [31:0]        data_din,
    
    input[2:0]          data_r_size,
    input[2:0]          data_w_size,
    input [31:0]        data_addr,
    input               data_wlast,
    input               data_wvalid,
    output wire[31:0]   data_dout,
    output              data_bvalid,
    output              data_wready
    );
    
    reg             data_rready;
    reg             data_arvalid;
//    reg             inst_rready;
    reg             inst_arvalid;
    
//    wire[2:0]           inst_addr_temp = (inst_addr[31:30]==2'b10) ? 3'b000 : inst_addr[31:29];
//    wire[2:0]           data_addr_temp = (data_addr[31:30]==2'b10) ? 3'b000 : data_addr[31:29];
    
    assign arid                 = data_arvalid ? 4'b0001 : 4'b0000;
    assign arvalid              = inst_arvalid | data_arvalid;
    assign araddr               = data_arvalid? data_addr : inst_addr;
    assign arlen                = data_arvalid ? data_arlen : inst_arlen;
    assign arsize               = data_arvalid ? data_r_size : 3'b010;
    assign arburst              = 2'b01;
    assign arlock               = 2'b0;
    assign arcache              = 4'b0;
    assign arprot               = 3'b0;

    assign rready               = data_rready;

    assign awid = 4'b0000;
    assign awaddr =  data_addr;
    assign awlen = data_awlen;
    assign awsize = data_w_size;
     assign awburst              = 2'b01;
    assign awlock               = 2'b0;
    assign awcache              = 4'b0;
    assign awprot               = 3'b0;
    assign wid                  = 4'b0;
    
    assign wdata                = data_din;
    assign wstrb                = data_reqw;
    assign wlast                = data_wlast;
    assign wvalid               = data_wvalid;
    
    assign data_dout            = rdata;
    assign inst_data            = rdata;
    assign cpu_rid_o            = rid;
    assign cpu_rlast_o          = rlast;
    assign cpu_rvalid_o         = rvalid;
    assign data_bvalid          = bvalid;
    assign data_wready          = wready;


///////////////////read and write data/////////////////////////
    reg[3:0] cur_state;
    reg[3:0] next_state;

    always@(posedge clk)
    begin
        if(!rstn)
            cur_state <= `AXI_WAIT;
        else
            cur_state <= next_state;
    end
    
    always@(*)
    begin
        next_state = `AXI_WAIT;
        case(cur_state)
            `AXI_WAIT:
            begin
                if(data_reqw)//write data request
                    next_state = `SEND_W_ADDR;
                else if(data_reqr|inst_req)//read data request
                    next_state = `SEND_R_ADDR;
                else 
                    next_state = `AXI_WAIT;
            end
            `SEND_W_ADDR://send write data address
            begin
                if(awready)
                    next_state = `SEND_DATA;
                else//wait awready
                    next_state = `SEND_W_ADDR;
            end
            `SEND_DATA://send data to ram
            begin
                if(wlast)//writing finished
                    next_state = `WAIT_RES;
                else
                    next_state = `SEND_DATA;
            end
            `WAIT_RES://wait write respond
            begin
                if(bvalid)
                    next_state = `AXI_WAIT;
                else
                    next_state = `WAIT_RES;
            end
            `SEND_R_ADDR://send read data address
            begin
                if(arready)
                    next_state = `RECEIVE_DATA;
                else 
                    next_state = `SEND_R_ADDR;
            end
            `RECEIVE_DATA://receive 4 words from ram
            begin
                if(rlast && rvalid)
                    next_state = `AXI_WAIT;
                else
                    next_state = `RECEIVE_DATA;
            end
            default:begin end
        endcase
    end
    
    always@(*)
    begin
        data_rready = 1'b0;
        awvalid = 1'b0;
        data_arvalid = 1'b0;
        inst_arvalid = 1'b0;
        bready = 1'b0;
        write_begin = 1'b0;
        case(cur_state)
        `SEND_W_ADDR:
        begin
            awvalid = 1'b1;
        end
        `SEND_DATA:
            write_begin = 1'b1;
        `SEND_R_ADDR:begin
            if(data_reqr)
                data_arvalid = 1'b1;
            else
                inst_arvalid = 1'b1;
        end
        `RECEIVE_DATA:
            data_rready = 1'b1;
        `WAIT_RES:
            bready = 1'b1;
        default:begin
        end
        endcase
    end        

 //////////////read instruction///////////////
// `define INST_WAIT 4'b0001
// `define INST_ADDR 4'b0010
// `define RD_INST 4'b0100
 
// reg[3:0] inst_cur_state;
// reg[3:0] inst_next_state;

 
//    always@(posedge clk)
//    begin
//        if(!rstn)
//            inst_cur_state <= `INST_WAIT;
//        else
//            inst_cur_state <= inst_next_state;
//    end
 
//    always@(*)
//    begin
//        inst_next_state = `INST_WAIT;
//        case(inst_cur_state)
//        `INST_WAIT:
//        begin
//            if(data_reqr)//reading data is prior 
//                inst_next_state = `INST_WAIT;
//            else if(inst_req)
//                inst_next_state = `INST_ADDR;
//            else
//                inst_next_state = `INST_WAIT;
//       end
//       `INST_ADDR:
//       begin
//            if(arready & inst_req & !data_reqr)//in this case, inst_req can send address
//                inst_next_state = `RD_INST;
//            else if(!inst_req)
//                inst_next_state = `INST_WAIT;
//            else//wait data_reqr finish sending addr
//                inst_next_state = `INST_ADDR;
//       end
//       `RD_INST:
//       begin
//            if((rid==4'b0000) && rvalid && rlast)//finish receive 4 words
//                inst_next_state = `INST_WAIT;
//            else
//                inst_next_state = `RD_INST;
//        end
//        default:begin
//        end
//        endcase
//    end
    
//    always@(*)
//    begin
//        inst_arvalid = 1'b0;
//        inst_rready = 1'b0;
//        case(inst_cur_state)
//            `INST_ADDR:
//            begin
//                if(inst_req & !data_reqr )
//                    inst_arvalid = 1'b1;
//                else
//                    inst_arvalid = 1'b0;
//            end
//            `RD_INST:
//                inst_rready = 1'b1;
//            default:begin
//            end
//         endcase
//    end
 
endmodule