`timescale 1ns / 1ps

module LCD_Ctrl(
    input clk, //100MHz
    input resetn,
    input [7:0]  aflag,
    input [7:0]  dflag,
    input [15:0] din,
    input [31:0] addrC,
    input [31:0] addrR,
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
    wire busyP;
    reg [16:0] data;
    reg flag;
    reg [3:0] state;
    reg dflagR;
    reg aflagR;
    `define INIT        4'b0000
    `define SLPOUT      4'b0001
    `define NORON       4'b0010
    `define FREE        4'b0011
    `define ALLPON      4'b0100
    `define DISPON      4'b0101
    `define RAMWRC      4'b0110
    `define RAMWRD      4'b0111
    `define CASET       4'b1000
    `define RASET       4'b1001
    `define MADCTLC     4'b1010
    `define MADCTLD     4'b1011
    `define COLMODC     4'b1100
    `define COLMODD     4'b1101
    reg [2:0] AS_state;
    always @(posedge clk)
        if(~resetn)
            aflagR <= 1'b0;
        else if(~busyP)
            aflagR <= aflag[0];
            
    always @(posedge clk)
        if(~resetn)
            AS_state <= 3'b000;
        else if(~busyP)
        begin
            if(state == `CASET || state == `RASET || state == `INIT)
                AS_state <= AS_state + 3'b1;
        end
            
            
    always @(posedge clk)
        if(~resetn)
            dflagR <= 1'b0;
        else if(~busyP)
            dflagR <= dflag[0];
            
    
    assign busy = (state != `FREE) | aflag[0] != aflagR | dflag[0] != dflagR;
    always @(*)
        case(state)
        `SLPOUT: data = {1'b0,16'h1100};
        `NORON:  data = {1'b0,16'h1300};
        `ALLPON: data = {1'b0,16'h2300};
        `DISPON: data = {1'b0,16'h2900};
        `MADCTLC:data = {1'b0,16'h3600};
        `MADCTLD:data = {1'b1,16'h0000};
        `RAMWRC: data = {1'b0,16'h2C00};
        `RAMWRD: data = {1'b1,din};
        `COLMODC:data = {1'b0,16'h3A00};
        `COLMODD:data = {1'b1,16'h0005};
        `CASET:  
            case(AS_state)
            3'b000: data = {1'b0,16'h2A00};
            3'b001: data = {1'b1,8'h00,addrC[31:24]};
            3'b010: data = {1'b0,16'h2A01};
            3'b011: data = {1'b1,8'h00,addrC[23:16]};
            3'b100: data = {1'b0,16'h2A02};
            3'b101: data = {1'b1,8'h00,addrC[15:8]};
            3'b110: data = {1'b0,16'h2A03};
            3'b111: data = {1'b1,8'h00,addrC[7:0]};
            endcase
        `RASET:
            case(AS_state)
            3'b000: data = {1'b0,16'h2B00};
            3'b001: data = {1'b1,8'h00,addrR[31:24]};
            3'b010: data = {1'b0,16'h2B01};
            3'b011: data = {1'b1,8'h00,addrR[23:16]};
            3'b100: data = {1'b0,16'h2B02};
            3'b101: data = {1'b1,8'h00,addrR[15:8]};
            3'b110: data = {1'b0,16'h2B03};
            3'b111: data = {1'b1,8'h00,addrR[7:0]};
            endcase
        default: data = {1'b0,16'h0000};
        endcase
        
    always @(posedge clk)
        if(~resetn)
            state <= `INIT;
        else if(~busyP)
            case(state)
            `INIT:      state <= (&AS_state) ? `SLPOUT : `INIT;
            `SLPOUT:    state <= `ALLPON;
            `NORON:     state <= `DISPON;
            `ALLPON:    state <= `NORON;
            `DISPON:    state <= `COLMODC;
            `MADCTLC:   state <= `MADCTLD;
            `MADCTLD:   state <= `FREE;
            `COLMODC:   state <= `COLMODD;
            `COLMODD:   state <= `MADCTLC;
            `FREE:
            if(aflagR != aflag[0])
                state <= `CASET;
            else if(dflagR != dflag[0])
                state <= `RAMWRD;
            `CASET:     state <= (&AS_state) ? `RASET : `CASET;
            `RASET:     state <= (&AS_state) ? `RAMWRC: `RASET;
            `RAMWRC:    state <= `FREE;
            `RAMWRD:    state <= `FREE;
            default:    state <= `FREE;
            endcase
    
    always @(posedge clk)
        if(~resetn)
            flag <= 1'b0;
        else if(~busyP)
            case(state)
            `SLPOUT,`NORON,`ALLPON,`DISPON,`MADCTLC,`COLMODD,`COLMODC,`CASET,`RASET:
                flag <= ~flag;
            `INIT:
                if(&AS_state)
                    flag <= ~flag;
            `FREE: 
                if(aflagR != aflag[0] || dflagR != dflag[0])
                    flag <= ~flag;
                else
                    flag <= flag;
            default:    flag <= flag;
            endcase

            
    LCDPoster poster0(
        .clk(clk),
        .resetn(resetn),
        .busy(busyP),
        .data(data),
        .flag(flag),
        .lcd_rst(lcd_rst),
        .lcd_cs(lcd_cs),
        .lcd_rs(lcd_rs),
        .lcd_wr(lcd_wr),
        .lcd_rd(lcd_rd),
        .lcd_data_io(lcd_data_io),
        .lcd_bl_ctr(lcd_bl_ctr),
        .ct_int(ct_int),
        .ct_sda(ct_sda),
        .ct_scl(ct_scl),
        .ct_rstn(ct_rstn)
    );
endmodule
