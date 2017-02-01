`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:34:12 03/17/2016
// Design Name:   Top
// Module Name:   G:/ceshi/lab5.0/test_for_top.v
// Project Name:  lab5.0
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

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.reset(reset)
	);
    
	always #50 clk = ~clk; 
	
	initial 
	begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		//#100;
      //reset = 0;  
		// Add stimulus here
      //#25 reset = 1;
		#75 reset = 0;
  
	end
      
endmodule

