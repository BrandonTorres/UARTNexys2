//////////////////////////////////////////////////////////////////////////////////
//	Author: 		Brandon Torres
//	Email:  		Brandon0torres@gmail.com
//	Filename:	Baud_Counter.v
//	
//	Notes:		The Baud rate is only set on reset and cannot be changed during run.
//					The module sets the Baud rate for the UART depending on the user 
//					input. Once the Baud time has passed then BTU is set for one clock.
//////////////////////////////////////////////////////////////////////////////////
module Baud_Delay(clk,reset,Start,Baud_Val,BTU);
	 input clk,reset,Start;
	 input [3:0] Baud_Val;
	 output wire BTU;
	 
	 reg [17:0] count_val;
	 reg [17:0] q_reg;
	 wire[17:0] q_next;
	 
	 always @(posedge clk, negedge reset)
		if(!reset)begin
			q_reg<=0;
			 case(Baud_Val)
				4'b0000: count_val<=166666/2; //300 Baud
				4'b0001: count_val<=83332/2;  //600 Baud
				4'b0010: count_val<=41666/2;  //1200 Baud
				4'b0011: count_val<=20832/2;  //2400 Baud
				4'b0100: count_val<=10416/2;  //4800 Baud
				4'b0101: count_val<=5207/2;   //9600 Baud
				4'b0110: count_val<=2603/2;   //19200 Baud
				4'b0111: count_val<=1760/2;   //28400 Baud
				4'b1000: count_val<=867/2;    //57600 Baud
				4'b1001: count_val<=433/2;    //115200 Baud
				4'b1010: count_val<=216/2;    //230400 Baud
				4'b1011: count_val<=108/2;    //460800 Baud
				4'b1100: count_val<=53/2;     //921600 Baud
				default: count_val<=166666/2; //Default is 300 Baud
			endcase
		end
		else if(!Start)
			q_reg<=0;
		else if(BTU)
			q_reg<=q_reg;
		else
			q_reg<=q_next;
		
	assign q_next=q_reg+1;
	//set tick when after each BTU 
	assign BTU= (q_reg==count_val) ? 1'b1 : 1'b0;


endmodule
