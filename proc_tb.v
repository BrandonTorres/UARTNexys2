`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:24:48 03/16/2015
// Design Name:   embedded_kcpsm3
// Module Name:   C:/Users/009749907/Desktop/New/lab3/proc_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: embedded_kcpsm3
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module proc_tb;

	// Inputs
	reg [7:0] in_port;
	reg interrupt;
	reg reset;
	reg clk;

	// Outputs
	wire [7:0] port_id;
	wire write_strobe;
	wire read_strobe;
	wire [7:0] out_port;
	wire interrupt_ack;

	// Instantiate the Unit Under Test (UUT)
	embedded_kcpsm3 uut (
		.port_id(port_id), 
		.write_strobe(write_strobe), 
		.read_strobe(read_strobe), 
		.out_port(out_port), 
		.in_port(in_port), 
		.interrupt(interrupt), 
		.interrupt_ack(interrupt_ack), 
		.reset(reset), 
		.clk(clk)
	);
	always #10 clk =~clk;
	initial begin
		// Initialize Inputs
		in_port = 0;
		interrupt = 0;
		reset = 1;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#60;
      reset=0;
		// Add stimulus here
		#60 
		interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200
		interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#200 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#100 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#100 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#100 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#100 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#100 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		#100 interrupt=1;
		@(interrupt_ack)
		interrupt=0;
		
	end
      
endmodule

