`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Author: 		Brandon Torres
//	Email:  		Brandon0torres@gmail.com
//	Filename:	AISO.v
//	
//	Notes:		The module has two flip flops that are connected to the same clock 
//					as the rest of the modules. This module will take an asynchronous 
//					signal in and then output a synchronous signal.
//////////////////////////////////////////////////////////////////////////////////
module AISO(clk,async_in,sync_out);
	input clk,async_in;
	output wire sync_out;
	reg inreg,outreg;
	
	always @(posedge clk, posedge async_in)begin
		if(async_in)
			inreg<=0;
		else
			inreg<=1;
	
	end
	
	always @(posedge clk)
		outreg<=inreg;
		
	assign sync_out=outreg;		


endmodule
