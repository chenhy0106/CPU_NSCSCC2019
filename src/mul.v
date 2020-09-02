`timescale 1ns / 1ps

module mul(
        input wire 				clk,
        input wire 				rst,
        input wire[31:0] 		mul_A,
        input wire[31:0] 		mul_B,
        input wire          	mul_sel,
        output wire[63:0]   	mul_result,
        output reg         		mul_ready
    );
    
	mult_gen_0 mult(
		.CLK(clk),
		.A(mul_A),
		.B(mul_B),
		.CE(mul_sel),
		.P(mul_result)
	);
	
	reg [2:0] counter;
	always @(posedge clk)
	begin
		if(~rst)
			counter <= 3'b0;
		else if(mul_sel & ~counter[2])
			counter <= counter + 3'b1;
		else
			counter <= 1'b0;
	end

	always @(posedge clk)
	begin
		if(~rst)
			mul_ready <= 1'b0;
		else 
			mul_ready <= (mul_sel & counter[2]);
	end
    
endmodule
