`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Author: 		Brandon Torres
//	Email:  		Brandon0torres@gmail.com
//	Filename:	reg8.v
//	
//	Notes:		An 8-bit loadable register.
//////////////////////////////////////////////////////////////////////////////////
module reg8(clk,reset,ld,Din,Dout);
	input clk, reset, ld;
	input [7:0] Din;
	output reg [7:0] Dout;
	
	//behaviorial section for writing to the register
	always @(posedge clk, negedge reset)
		if (!reset)
			Dout <= 16'b0;
		else if(ld)
			Dout <= Din;
		else
			Dout <= Dout;

endmodule
