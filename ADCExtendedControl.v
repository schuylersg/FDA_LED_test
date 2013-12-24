`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:38:12 12/23/2013 
// Design Name: 
// Module Name:    ADCExtendedControl 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ADCExtendedControl(
	input clk,
	
	output sclk,
	output sdata,
	output select
    );
	
	wire [19:0] ROMData;
	wire [3:0] ROMAddress;
	
	wire [3:0] SClkOut;
	
	wire EnAddrCount, EnBitCount;
	wire ClrBitCount;
	wire [4:0] BitNumber;
	
	assign select = 1'b0;

	Counter_4Bit SClkCounter (
	  .clk(clk), // input clk
	  .ce(1'b1),
	  .sclr(sclr), // input sclr
	  .q(SClkOut) // output [3 : 0] q
	);
	
	Counter_4Bit AddressCounter (
	  .clk(clk), // input clk
	  .ce(EnAddrCount),
	  .sclr(sclr), // input sclr
	  .q(ROMAddress) // output [3 : 0] q
	);
	
	Counter_5Bit BitCounter(
	  .clk(clk), // input clk
	  .ce(EnBitCount), // input ce
	  .sclr(ClrBitCount), // input sclr
	  .q(BitNumber) // output [4 : 0] q
	);
	
	ADC_ROM ADCRegisterValues (
		.a(ROMAddress), // input [3 : 0] a
		.spo(ROMData) // output [19 : 0] spo
	);

	assign EnBitCount = (SClkOut == 4'd15);	//increment the bit every negative transition on clk
	assign EnAddrCount = (BitNumber == 5'd20); //increment the address after 20 bits
	assign ClrBitCount = EnAddrCount;
	
	assign sclk = SClkOut[3];
	assign sdata = ROMData[BitNumber];
	
	
	//The state machine
	reg [1:0] CurrentState;
	reg [1:0] NextState;
	
	
endmodule
