`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:31:20 03/17/2016 
// Design Name: 
// Module Name:    Top 
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
module Top(clk,reset);
    input clk;
    input reset;
    
	 reg [31:0] PC;
	 reg [31:0] INST;
	 reg [31:0] IM[0:255];
	 
	 

initial 
begin
  $readmemb("inst.txt",IM, 32'b0);
  PC = 0;
end

always @(PC)
	INST = IM[PC >> 2];

	wire REG_DST,
	      JUMP,
			BRANCH,
			MEM_READ,
			MEM_TO_REG;
	wire [1:0] ALUOP;
	wire MEM_WRITE,
         ALUSRC,
         REG_WRITE;
		
	wire [4:0] WRITEREG;
   wire [31:0]	WRITEDATA;
   wire [31:0] READDATA1;
   wire [31:0] READDATA2;
	
	wire [31:0] DATA;
	wire [3:0] ALUCTR;
	wire [31:0] INPUT2;
	wire ZERO;
	wire [31:0] ALURES;
	wire[31:0] READDATA;


   wire [31:0] pcPlus;
   assign pcPlus = PC + 4;

   wire [31:0] instshift;
   assign instshift = INST[25:0] << 2;
	
	wire [31:0] JumpAddr;
	assign JumpAddr = {pcPlus[31:28],instshift[27:0]};
	
	wire [31:0] addshift;
	assign addshift = DATA << 2;
	
	wire [31:0] ADDRES;
	assign ADDRES = pcPlus + addshift;
	
	wire AND;
	assign AND = BRANCH & ZERO;
	
	wire [31:0] MUXOUT;
	assign MUXOUT = AND?ADDRES:pcPlus;
	
	wire [31:0] nextPC;
   assign nextPC = JUMP?JumpAddr:MUXOUT;
	
	assign WRITEREG = REG_DST?INST[15:11]:INST[20:16];
	assign INPUT2 = ALUSRC?DATA:READDATA2;
   assign WRITEDATA = MEM_TO_REG?READDATA:ALURES;
    
	always @(posedge clk)
		if(reset == 0)
			PC = nextPC;
		else
		 PC = 0;
	Ctr mainCtr(
				.opCode(INST[31:26]),
	         .regDst(REG_DST),
				.aluSrc(ALUSRC),
				.memToReg(MEM_TO_REG),
				.regWrite(REG_WRITE),
				.memRead(MEM_READ),
				.memWrite(MEM_WRITE),
				.branch(BRANCH),
				.aluOp(ALUOP),
				.jump(JUMP)
				);	

	register mainregister(
							.clock_in(clk),
							.readReg1(INST[25:21]),
							.readReg2(INST[20:16]),
							.writeReg(WRITEREG),
							.writeData(WRITEDATA),
							.regWrite(REG_WRITE),
							.readData1(READDATA1),
							.readData2(READDATA2),
							.rst(reset)
							);
	
	aluCtr mainAluCtr(
						.aluOp(ALUOP),
						.funct(INST[5:0]),
						.aluCtr(ALUCTR)
						);

	alu mainAlu(
				.input1(READDATA1),
            .input2(INPUT2),
				.aluCtr(ALUCTR),
				.zero(ZERO),
				.aluRes(ALURES)
				);	
	
	data_memory mainmemory(
							.clock_in(clk),
	                  .address(ALURES),
							.writeData(READDATA2),
							.memWrite(MEM_WRITE),
							.memRead(MEM_READ),
							.readData(READDATA));
							
	signext mainsignext(
							.inst(INST[15:0]),
	                  .data(DATA));
  

  
endmodule
