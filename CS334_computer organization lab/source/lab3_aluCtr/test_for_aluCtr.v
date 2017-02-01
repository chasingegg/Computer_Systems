`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:58:51 03/02/2016
// Design Name:   aluCtr
// Module Name:   G:/ceshi/lab3.2/test_for_aluCtr.v
// Project Name:  lab3.2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: aluCtr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_aluCtr;

	// Inputs
	reg [1:0] aluOp;
	reg [5:0] funct;

	// Outputs
	wire [3:0] aluCtr;

	// Instantiate the Unit Under Test (UUT)
	aluCtr uut (
		.aluOp(aluOp), 
		.funct(funct), 
		.aluCtr(aluCtr)
	);

	initial begin
		// Initialize Inputs
		aluOp = 0;
		funct = 0;

		// Wait 100 ns for global reset to finish
		#100;
      #100 aluOp = 2'b00; 
      #100 aluOp = 2'b01;
      #100 aluOp = 2'b10; funct = 6'b000000;
		#100 aluOp = 2'b10; funct = 6'b000010;
		#100 aluOp = 2'b10; funct = 6'b000010;
		#100 aluOp = 2'b10; funct = 6'b000100;
		#100 aluOp = 2'b10; funct = 6'b000101;
		#100 aluOp = 2'b10; funct = 6'b001010;
		// Add stimulus here

	end
      
endmodule

