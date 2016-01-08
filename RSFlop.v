`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Author: 		Brandon Torres
//	Email:  		Brandon0torres@gmail.com
//	Filename:	RSFlop.v
//	
//	Notes:		RSFlop
//					R S | Q
//					0 0   Q
//             0 1   1
//				   1 0   0
//             1 1   0
//////////////////////////////////////////////////////////////////////////////////
module RSFlop(clk,reset,R,S,Out);
	 input reset, clk, R, S;
	 output Out;
	 reg   dataVal;
	 
	 always @(posedge clk, negedge reset)
		if(!reset)
			dataVal<=0;
		else if(R)
			dataVal<=0;
		else if(S)
			dataVal<=1;
		else 
			dataVal<=dataVal;
		
		assign Out=dataVal;
	 
	 endmodule
