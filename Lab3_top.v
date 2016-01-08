`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Author: 		Brandon Torres
//	Email:  		Brandon0torres@gmail.com
//	Filename:	Lab3_top.v
//	
//	Notes:		Top level of Lab 3. The Picoblaze provides the data that is to 
//					be transmitted.
//////////////////////////////////////////////////////////////////////////////////
module Lab3_top(clk,reset,RxLineIn,ParityEn,Baud_Val,ParityOE,Bit78,TX);
	input clk,reset,RxLineIn,ParityEn,ParityOE,Bit78;
	input[3:0] Baud_Val;
	output TX;
	
	wire sync_reset,Done,Start,TXRDY,readStrobe,writeStrobe,BTU,A,B,C,D,int_ack,
		  RxDone,RxStart,RxStartDelay,RxBTU,RxRdy;
	wire[255:0] portStrobe;
	wire[7:0] portID,picoOut,holdOut;
	wire[10:0]transmitData,RxData;
	wire[7:0] status;
	reg [20:0] count_val;
	reg [7:0] PicoIn;
	reg [2:0] mode;
	reg delayReg;
	
	
	AISO sync(.clk(clk),.async_in(reset),.sync_out(sync_reset));
	dec8to255 portad(.in(portID),.en(eventStrobe),.out(portStrobe));
	
	embedded_kcpsm3 proc(
						      .port_id(portID),
								.write_strobe(writeStrobe),
								.read_strobe(readStrobe),
								.out_port(picoOut),
								.in_port(PicoIn),
								.interrupt(RxRdy),
								.interrupt_ack(int_ack),
								.reset(~sync_reset),
								.clk(clk));	
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Tx Engine
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Baud_Decoder baud(.clk(clk),.reset(sync_reset),.Start(Start),.Done(Done),.Baud_Val(Baud_Val),.BTU(BTU)); //Baud decoder for tx engine
	reg8 pico_hold(.clk(clk),.reset(sync_reset),.ld(portStrobe[1]),.Din(picoOut),.Dout(holdOut));
	PISO11 transmit(.clk(clk),.reset(sync_reset),.shift(BTU),.ld(delayReg),.Din(transmitData),.SDI(1'b1),.SDO(TX),.Data());
	
	RSFlop TransmitStart(.clk(clk),.reset(sync_reset),.R(Done),.S(delayReg),.Out(Start));		// Signals start of transmit
	RSFlop TXReady(.clk(clk),.reset(sync_reset),.R(writeStrobe),.S(Done),.Out(TXRDY));				// Signals that Tx engine is ready to transmit
			
	//Delay register that sends ld command to Baud decoder and PISO11
	always @(posedge clk, negedge sync_reset)
		if(!sync_reset)
			delayReg<=1'b0;
		else
			delayReg<=portStrobe[1];
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//End Tx Engine
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Rx Engine
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Baud_Delay Delay(.clk(clk),.reset(sync_reset),.Start(RxStart),.Baud_Val(Baud_Val),.BTU(RxStartDelay));
	Baud_Decoder Receivebaud(.clk(clk),.reset(sync_reset),.Start(RxStartDelay),.Done(RxDone),.Baud_Val(Baud_Val),.BTU(RxBTU)); //Baud decoder for rx engine
	PISO11 Receive(.clk(clk),.reset(sync_reset),.shift(RxBTU),.ld(1'b0),.Din(11'b0),.SDI(RxLineIn),.SDO(),.Data(RxData));
	
	RSFlop ReceiveStart(.clk(clk),.reset(sync_reset),.R(RxDone),.S(~RxLineIn),.Out(RxStart)); // Signals the start of receive 
	RSFlop ReceiveRdy(.clk(clk),.reset(sync_reset),.R(int_ack),.S(RxDone),.Out(RxRdy)); // Signals the start of receive 
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//End Rx Engine
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/*
	//Status Register
	always @(posedge clk,negedge sync_reset)
		if(!sync_reset)
			StatusRegister <=0;
		else if(TXRDY)
			StatusRegister <= StatusRegister | 8'b00000010;
		else if(RxDone)
			StatusRegister <= StatusRegister | 8'b00000001;
		else if(P_Error)
			StatusRegister <= StatusRegister | 8'b00010000;
		else if(Over_Error)
			StatusRegister <= StatusRegister | 8'b00100000;
			*/
	//PicoBlaze input selector
	always @(portStrobe)
	/*
		if(!sync_reset)
			PicoIn<=0;
		else
			PicoIn<={6'b0,TXRDY,1'b0}; 
	*/
			case(portStrobe)
				256'b01: PicoIn<=status;                
				256'b100: PicoIn<=RxData[7:0];    
				default: PicoIn<=PicoIn;
			endcase
		
	//Sets the bits according to parity and 7/8
	always @(posedge clk,negedge sync_reset)
		if(!sync_reset)
			case({Bit78,ParityEn,ParityOE})
				3'b000: mode<=2'b11;                //7N1
				3'b001: mode<=2'b11;                //7N1
				3'b010: mode<={1'b1,A};             //7E1
				3'b011: mode<={1'b1,B};             //7O1
				3'b100: mode<={1'b1,holdOut[7]};    //8N1
				3'b101: mode<={1'b1,holdOut[7]};    //8N1
				3'b110: mode<={C,holdOut[7]};       //8E1
				3'b111: mode<={D,holdOut[7]};       //8O1
				default:mode<={1'b1,holdOut[7]};
			endcase
		else
			mode<=mode;
	//PicoBlaze want to read or right
	assign eventStrobe = readStrobe | writeStrobe;
	
	//Sets data to be sent to PISO11		
	assign transmitData= {mode,holdOut[6:0],2'b01};
	//Status
	assign status={6'b0,TXRDY,1'b0};
	
	//Parity assignments
   assign A=^holdOut[6:0];  //Even parity 7-bit
	assign B=~^holdOut[6:0]; //Odd  parity 7-bit
	assign C=^holdOut[7:0];  //Even parity 8-bit
	assign D=~^holdOut[7:0]; //Odd  parity 8-bit
endmodule
