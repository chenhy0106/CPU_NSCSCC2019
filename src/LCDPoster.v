`timescale 1ns / 1ps

module LCDPoster(
    input clk,
    input resetn,
    
    input [16:0] data,
    input  flag,
    output busy,
    output lcd_rst,
    output lcd_cs,
    output lcd_rs,
    output lcd_wr,
    output lcd_rd,
    inout [15:0] lcd_data_io,
    output lcd_bl_ctr,
    inout ct_int,
    inout ct_sda,
    output ct_scl,
    output ct_rstn
    );
    reg [2:0] state;
    reg flagR;
`define POST_IDLE   3'b111
`define POST_I      3'b000
`define POST_II     3'b001
`define POST_III    3'b010
`define POST_IV     3'b011
`define POST_V      3'b100
`define POST_VI     3'b101
`define POST_VII    3'b110
 
`define SEND    1'b1

    assign lcd_rst = resetn;
    assign lcd_cs  = 1'b0;
    always @(posedge clk)
        if(~resetn)
            flagR <= 1'b0;
        else 
            flagR <= flag;
            
    always @(posedge clk)
        if(~resetn)
            state <= `POST_IDLE;
        else
            case(state)
            `POST_IDLE: state <= (flagR != flag) ? `POST_I:`POST_IDLE;
            `POST_I:    state <= `POST_II;
            `POST_II:   state <= `POST_III;
            `POST_III:  state <= `POST_IV;
            `POST_IV:   state <= `POST_V;
            `POST_V:    state <= `POST_VI;
            `POST_VI:   state <= `POST_VII;
            `POST_VII:  state <= `POST_IDLE;
            endcase
            
    assign busy = (flagR != flag) | (state != `POST_IDLE);
    assign lcd_wr = state[2];
    assign lcd_rs = data[16];
    assign lcd_data_io = data[15:0];
    assign lcd_rd = 1'b1;
    assign lcd_bl_ctr = 1'b1;
    assign ct_int = 1'b0;
    assign ct_sda = 1'b0;
    assign ct_scl = 1'b0;
    assign ct_rstn = 1'b0;
endmodule
