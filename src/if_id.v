`include "defines.v"

module if_id(
	input wire								clk,
	input wire								rst,
	input wire[5:0]               			pause,	
	input wire                    			clear,

    input wire                  			branch,		//actual branch
(*mark_debug = "true"*)	input wire[31:0]						if2_pc,
(*mark_debug = "true"*)	input wire[31:0]          				if2_inst,
	output reg[31:0]      					id_pc,
	output reg[31:0]          				id_inst,
	input wire                             if_inst_found,
	output reg                             id_inst_found,
	input wire                             if_inst_v,
	output reg                             id_inst_v  				
);
	always @ (posedge clk) begin
		if (!rst) begin
			id_pc <= `zero32;
			id_inst <= `zero32;
			id_inst_found <= 1'b1;
			id_inst_v <= 1'b1;
		end else if(clear) begin
			id_pc <= `zero32;
			id_inst <= `zero32;				
			id_inst_found <= 1'b1;	
			id_inst_v <= 1'b1;
	  	end else if(!pause[1]) begin
	       	if(branch)//when branch, clear if2
	       	begin
            	id_pc <= `zero32;
                id_inst <= `zero32;				
                id_inst_found <= 1'b1;	
                id_inst_v <= 1'b1;
          	end
          	else begin
				id_pc <= if2_pc;
				id_inst <= if2_inst;
				id_inst_found <= if_inst_found;
				id_inst_v <= if_inst_v;
		  	end
		end
	end

endmodule