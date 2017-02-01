`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:16:03 03/03/2016 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory( clock_in,address,writeData,memWrite,memRead,readData);

    input clock_in;
    input [31:0] address;
    input [31:0] writeData;
    input memWrite;
    input memRead;
    output [31:0] readData;
   

	reg [31:0] memFile[0:127];
	reg [31:0] readData;
	integer i;
	
	initial
		begin
			for(i = 0; i < 32; i = i + 1)
				memFile[i] = 0;
			readData = 0;
		end
	always @ (memRead or address) //向存储器中读数据
	begin
		readData = memFile[address];
	end
	
	always @ (negedge clock_in) //向存储器中写数据
	begin
		if(memWrite)
			memFile[address] = writeData;
	end
endmodule
