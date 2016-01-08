`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Author: 		Brandon Torres
//	Email:  		Brandon0torres@gmail.com
//	Filename:	dec8to255.v
//	
//	Notes:	   A basic decoder that takes in 8 bits and selects the appropriate 
//					output.
//////////////////////////////////////////////////////////////////////////////////
module dec8to255(in,en,out);
	input [7:0] in;
	input       en;
	output wire [255:0] out;
	
	assign out = (en)?(1<< in):255'b0;
	
endmodule
