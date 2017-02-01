`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:16:31 03/03/2016
// Design Name:   signext
// Module Name:   G:/ceshi/lab4.3/test_for_signext.v
// Project Name:  lab4.3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: signext
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_signext;

	// Inputs
	reg [15:0] inst;

	// Outputs
	wire [31:0] data;

	// Instantiate the Unit Under Test (UUT)
	signext uut (
		.inst(inst), 
		.data(data)
	);

	initial begin
		// Initialize Inputs
		inst = 0;

		// Wait 100 ns for global reset to finish
		#100;
      #100 inst = 16'b1111111100000000;
		#100 inst = 16'b0000000000111111;
		// Add stimulus here

	end
      
endmodule

