`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:05:18 03/03/2016 
// Design Name: 
// Module Name:    signext 
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
module signext(inst, data);
	input [15:0] inst;
   output [31:0] data;
    
	reg [31:0] data;
	
	always @(inst)
	begin
		data = inst;
		if(data[15])
			data[31:16] = 16'b1111111111111111;
		else
			data[31:16] = 16'b0000000000000000;
	end
		
endmodule
