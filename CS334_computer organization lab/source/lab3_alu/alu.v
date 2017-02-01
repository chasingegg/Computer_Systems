`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:20:54 03/02/2016 
// Design Name: 
// Module Name:    alu 
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
module alu(
    output zero,
    output [31:0] aluRes,
    input [31:0] input1,
    input [31:0] input2,
    input [3:0] aluCtr
    );
	reg zero;
	reg [31:0] aluRes;
	
	always @ (input1 or input2 or aluCtr)
	begin
		if(aluCtr == 4'b0010) //+
			aluRes = input1 + input2;
		else if(aluCtr == 4'b0110) //-
		begin
			aluRes = input1 - input2;
			if(aluRes == 0)
				zero = 1;
			else
				zero = 0;
		end
		else if(aluCtr == 4'b0000) //&
		begin
			aluRes = input1 & input2;
			if(aluRes == 0)
				zero = 1;
			else
				zero = 0;
		end
		else if(aluCtr == 4'b0001) //|
		begin
			aluRes = input1 | input2;
			if(aluRes == 0)
				zero = 1;
			else
				zero = 0;
		end
		else if(aluCtr == 4'b0111) //slt
		begin
			if(input1 < input2)
				begin
				zero = 0;
				aluRes = 1;
				end
			else
				begin
				zero = 1;
				aluRes = 0;
				end
		end
		else if(aluCtr == 4'b1100) //NOR
		begin
			aluRes = ~(input1 | input2);
			if(aluRes == 0)
				zero = 1;
			else
				zero = 0;
		end
	end

endmodule
