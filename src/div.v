`timescale 1ns / 1ps
`include "defines.v"

module div(
        input wire          clk,
        input wire          sel_div,
        
        input wire          sign,
        input wire[31:0]    divisor_i,
        input wire[31:0]    dividend_i,
        
        output wire[63:0]   result,
        output reg         out_valid
    );
    
    wire[31:0] q, r;
    wire[63:0] dout;
    wire          dout_valid;
    
    wire[31:0] divisor, dividend;
    assign divisor = (sign&divisor_i[31]) ? ~divisor_i+1 : divisor_i;
    assign dividend = (sign&dividend_i[31]) ? ~dividend_i+1 : dividend_i;
    assign result = (dividend==`zero32) ? 63'b0 : {q, r};
    
    assign q = ((dividend_i[31]^divisor_i[31]) & sign) ? ~dout[63:32]+1 : dout[63:32];
    assign r = (dividend_i[31] & sign) ? ~dout[31:0]+1 : dout[31:0];
    
//    wire divisor_ready, dividend_ready;
    reg in_flag;
    wire in_valid;
    assign in_valid = sel_div & !in_flag;
    always@(posedge clk) begin
        if(sel_div)
            in_flag <= 1'b1;
        else 
            in_flag <= 1'b0;
   end
 
   always@(posedge clk) begin
        if(sel_div & dout_valid)
            out_valid <= 1'b1;
        else if(!sel_div)
            out_valid <= 1'b0;
   end
        
    div_gen_0 divider(
        .aclk(clk),
        .s_axis_divisor_tdata(divisor),
//        .s_axis_divisor_tready(divisor_ready),
        .s_axis_divisor_tvalid(in_valid),
        
        .s_axis_dividend_tdata(dividend),
//        .s_axis_dividend_tready(dividend_ready),
        .s_axis_dividend_tvalid(in_valid),
        
        .m_axis_dout_tdata(dout),
        .m_axis_dout_tvalid(dout_valid)
        );
        
        
        
        
endmodule
