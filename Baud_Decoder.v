`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Author: 		Brandon Torres
//	Email:  		Brandon0torres@gmail.com
//	Filename:	Baud_Decoder.v
//	
//	Notes:		The module interconnects Baud_Counter and Bit_Counter. Bit_Counter 
//					counts every BTU and sets Done once 11 BTU have occurred.
//////////////////////////////////////////////////////////////////////////////////
module Baud_Decoder(clk,reset,Start,Done,Baud_Val,BTU);
	input clk,reset,Start;
	input[3:0] Baud_Val;
	output wire Done,BTU;
	
	Baud_Counter bc(.clk(clk),.reset(reset),.Start(Start),.Baud_Val(Baud_Val),
						 .BTU(BTU));
	
	Bit_Counter bitc(.clk(clk),.reset(reset),.BTU(BTU),.Done(Done));


endmodule
