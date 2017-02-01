`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:18:40 03/03/2016 
// Design Name: 
// Module Name:    register 
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
module register(clock_in, readReg1,readReg2, writeReg,writeData,regWrite,readData1,readData2);
    input clock_in;
    input [25:21] readReg1;
    input [20:16] readReg2;
    input [4:0] writeReg;
    input [31:0] writeData;
    input regWrite;
    output [31:0] readData1;
    output [31:0] readData2;
	
	 reg[31:0] regFile[31:0];
	 reg[31:0] readData1;
	 reg[31:0] readData2;
	 integer i;
	 
	 initial //��ʼ��
		begin
			for(i = 0; i < 32; i = i + 1)
				regFile[i] = 0;
			readData1 = 0;
			readData2 = 0;
		end
	 
	 always @ (readReg1 or readReg2) //��Ĵ���������
	 begin
		readData1 = regFile[readReg1];
		readData2 = regFile[readReg2];
    end
	 
	 always @ (negedge clock_in) //��Ĵ���д����
	 begin
		if(regWrite)
			regFile[writeReg] = writeData;
	 end


endmodule
