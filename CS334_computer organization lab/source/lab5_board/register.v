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
module register(clock_in, readReg1,readReg2, writeReg,writeData,regWrite, rst,readData1,readData2, led, switch, PC);
    input clock_in;
    input [25:21] readReg1;
    input [20:16] readReg2;
    input [4:0] writeReg;
    input [31:0] writeData;
    input regWrite;
	 input rst;
	 input [31:0] PC;
	 input [1:0] switch;
	 
    output [31:0] readData1;
    output [31:0] readData2;
	 output reg[7:0] led;
	
	 reg[31:0] regFile[31:0];
	 reg[31:0] readData1;
	 reg[31:0] readData2;
	 
	 integer i;
	 
	 initial 
	 begin
		regFile[0] = 32'h00000000;
		regFile[1] = 32'h00000001;
		regFile[2] = 32'h00000002;
		regFile[3] = 32'h00000003;
		regFile[4] = 32'h00000004;
		regFile[5] = 32'h00000005;
		regFile[6] = 32'h00000006;
		regFile[7] = 32'h00000007;
		regFile[8] = 32'h00000008;
		regFile[9] = 32'h00000009;
		regFile[10] = 32'h0000000a;
		regFile[11] = 32'h0000000b;
		regFile[12] = 32'h0000000c;
		regFile[13] = 32'h0000000d;
		regFile[14] = 32'h0000000e;
		regFile[15] = 32'h0000000f;
		regFile[16] = 32'h00000010;
		regFile[17] = 32'h00000011;
		regFile[18] = 32'h00000012;
		regFile[19] = 32'h00000013;	
		regFile[20] = 32'h00000014;
		regFile[21] = 32'h00000015;
		regFile[22] = 32'h00000016;
		regFile[23] = 32'h00000017;
		regFile[24] = 32'h00000018;
		regFile[25] = 32'h00000019;
		regFile[26] = 32'h0000001a;
		regFile[27] = 32'h0000001b;
		regFile[28] = 32'h0000001c;
		regFile[29] = 32'h0000001d;
		regFile[30] = 32'h0000001e;
		regFile[31] = 32'h0000001f;
		
	 end
	 
	 always @ (readReg1 or readReg2 or regWrite or writeReg or switch)
	 begin
		readData1 = regFile[readReg1];  //读数据
		readData2 = regFile[readReg2]; 
		
		//开关控制led灯显示寄存器或PC的值
		case(switch)             
		0: led[7:0] = PC[7:0];
		1: led[7:0] = regFile[1][7:0];
		2: led[7:0] = regFile[2][7:0];
		3: led[7:0] = regFile[3][7:0];
		//led[7:4] = {regFile[2][3:0]};
		endcase
    end
	 
	 always @ (negedge clock_in)
	 begin
		if(rst)
			begin
			for(i = 0; i < 32; i = i + 1)
				regFile[i] = 0;      //reset将寄存器清零
			end
		else if(regWrite)
			regFile[writeReg] = writeData; //写数据
	 end


endmodule