`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:59:34 03/30/2016
// Design Name:   Top
// Module Name:   G:/ceshi/lab6.0/test_for_top.v
// Project Name:  lab6.0
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_top;

	// Outputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk),
		.reset(reset)
	);

	always #15 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		// Wait 100 ns for global reset to finish
		#20;
		reset = 0;
        
		// Add stimulus here

	end
      
endmodule

