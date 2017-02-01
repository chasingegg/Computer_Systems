`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:33:57 03/02/2016
// Design Name:   alu
// Module Name:   G:/ceshi/lab3.3/test_for_alu.v
// Project Name:  lab3.3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_alu;

	// Inputs
	reg [31:0] input1;
	reg [31:0] input2;
	reg [3:0] aluCtr;

	// Outputs
	wire zero;
	wire [31:0] aluRes;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.zero(zero), 
		.aluRes(aluRes), 
		.input1(input1), 
		.input2(input2), 
		.aluCtr(aluCtr)
	);

	initial begin
		// Initialize Inputs
		input1 = 0;
		input2 = 0;
		aluCtr = 0;

		// Wait 100 ns for global reset to finish
		#100;
      #100 input1 = 0; input2 = 0; aluCtr = 4'b0000;
		#100 input1 = 0; input2 = 0; aluCtr = 4'b0000;
		#100 input1 = 255; input2 = 170; aluCtr = 4'b0000;
		#100 input1 = 255; input2 = 170; aluCtr = 4'b0001;
		#100 input1 = 1; input2 = 1; aluCtr = 4'b0010;
		#100 input1 = 255; input2 = 170; aluCtr = 4'b0110;
		#100 input1 = 1; input2 = 1; aluCtr = 4'b0110;
		#100 input1 = 255; input2 = 170; aluCtr = 4'b0111;
		#100 input1 = 170; input2 = 255; aluCtr = 4'b0111;
		#100 input1 = 0; input2 = 1; aluCtr = 4'b1100;
		 //Add stimulus here

	end
      
endmodule

