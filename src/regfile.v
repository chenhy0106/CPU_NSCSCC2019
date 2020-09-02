`include "defines.v"

module regfile(
	input wire					clk,
	input wire					rst,
	
	//write channel
	input wire			we,
	input wire[31:0]			waddr,
	input wire[31:0]			wdata,
	
	//read channel 1
	input wire					re1,
	input wire[31:0]			raddr1,
	output reg[31:0]         	rdata1,
	
	//read channel 2
	input wire					re2,
	input wire[31:0]			raddr2,
	output reg[31:0]         	rdata2
	
);
    integer i;
	reg[31:0]  regs[0:31];

	//write reg
	always @ (posedge clk) begin
		if (!rst)
		  	for(i=0;i<32;i=i+1)
		    	regs[i] <= 32'b0;
		else if(we & (waddr != 5'h00))
				regs[waddr] <= wdata;
	end
	
	//read reg1
	always @ (*) begin
	 	if(!rst)
	 		rdata1 = `zero32;
	    else if(raddr1 == 5'h00)
	   		rdata1 = `zero32;
	    else if((raddr1 == waddr) & we & re1)
	   	  	rdata1 = wdata;
	    else if(re1)
	       	rdata1 = regs[raddr1];
	    else
	       	rdata1 = `zero32;
	end

	//read reg2
	always @ (*) begin
	 	if(!rst)
	 		rdata2 = `zero32;
	    else if(raddr2 == 5'h00)
	   		rdata2 = `zero32;
	    else if((raddr2 == waddr) & we & re2)
	   	  	rdata2 = wdata;
	    else if(re2)
	       rdata2 = regs[raddr2];
	    else
	       rdata2 = `zero32;
	end

endmodule