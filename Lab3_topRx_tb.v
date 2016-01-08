`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:04:35 04/15/2015
// Design Name:   Lab3_top
// Module Name:   C:/Users/009749907/Desktop/Lab/lab3/Lab3_topRx_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Lab3_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Lab3_topRx_tb;

	// Inputs
	reg clk;
	reg reset;
	reg RxLineIn;
	reg ParityEn;
	reg [3:0] Baud_Val;
	reg ParityOE;
	reg Bit78;

	// Outputs
	wire TX;

	// Instantiate the Unit Under Test (UUT)
	Lab3_top uut (
		.clk(clk), 
		.reset(reset), 
		.RxLineIn(RxLineIn), 
		.ParityEn(ParityEn), 
		.Baud_Val(Baud_Val), 
		.ParityOE(ParityOE), 
		.Bit78(Bit78), 
		.TX(TX)
	);
	always #10 clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		RxLineIn = 1;
		ParityEn = 0;
		Baud_Val = 12;
		ParityOE = 0;
		Bit78 = 1;

		// Wait 100 ns for global reset to finish
		#100
		reset = 0;
		#100000
		RxLineIn=0;
		
		#1080
		RxLineIn=0;
		#1080
		RxLineIn=0;
		#1080
		RxLineIn=0;
		#1080
		RxLineIn=1;
		#1080
		RxLineIn=0;
		#1080
		RxLineIn=0;
		#1080
		RxLineIn=0;
		#1080
		RxLineIn=0;
		#1080
		RxLineIn=1;
		
		
		
        
		// Add stimulus here

	end
      
endmodule

