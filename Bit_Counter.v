`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Author: 		Brandon Torres
//	Email:  		Brandon0torres@gmail.com
//	Filename:	Bit_Counter.v
//	
//	Notes:		The module is a simple counter that increments every time it
//					receives BTU. Once eleven BTU have occurred then the Done signal is
//					set.
//////////////////////////////////////////////////////////////////////////////////
module Bit_Counter(clk,reset,BTU,Done);
	input clk,reset,BTU;
	output wire Done;
	reg [3:0] q_reg;
	
	always @(posedge clk, negedge reset)
		if(!reset)
			q_reg<=4'b0;
		else if(BTU)
			q_reg<=q_reg+1;
		else if(q_reg==11)
			q_reg<=4'b0;
		else
			q_reg<=q_reg;
	assign Done=(q_reg==11) ? 1'b1 : 1'b0;	

endmodule
