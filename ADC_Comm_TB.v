`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:00:30 12/23/2013 
// Design Name: 
// Module Name:    ADC_Comm_TB 
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
module ADC_Comm_TB(
    );

reg clk;

wire sclk, sdata, select;

ADCExtendedControl DUT (
    .clk(clk), 
    .sclk(sclk), 
    .sdata(sdata), 
    .select(select)
    );
	
	initial
	begin
		clk = 0;
	end

	always
		#5 clk = !clk;

endmodule
