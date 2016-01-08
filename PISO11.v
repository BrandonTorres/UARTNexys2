`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Author: 		Brandon Torres
//	Email:  		Brandon0torres@gmail.com
//	Filename:	PISO11.v
//	
//	Notes:		The register is an eleven bit register that can be loaded with
//					serial in and parallel in. The LSB of the data is the output of the 
//					register.
//////////////////////////////////////////////////////////////////////////////////
 module PISO11(clk,reset,shift,ld,Din,SDI,SDO,Data);
	input clk, reset, shift, ld, SDI;
	input [10:0] Din;
	output wire SDO;
	output reg [10:0] Data;
	
	//Register that holds 11bits and shifts left in SDI when shift is enabled
	always @(posedge clk, negedge reset)
		if (!reset)
			Data <= 10'b1111111111;
		else if(ld)
			Data <= Din;
		else if(shift)
			Data <= {SDI,Data[10:1]};
		else 
			Data <= Data;
			
	assign SDO = Data[0];
		
	


endmodule
