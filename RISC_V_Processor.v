`timescale 1ns / 1ps


module RISC_V_Processor(
    input clk,
    input reset
    );
    
wire [63:0] PC_out; 
wire [63:0] PC_in;
wire [63:0] PC_next;
// reg b = 64'h4;

wire [31:0] Instruction;
wire [6:0] opcode; 
wire [6:0] funct7;
wire [4:0] rd;
wire [4:0] rs1;
wire [4:0] rs2;
wire [2:0] funct3;   

wire [63:0] readData1;
wire [63:0] readData2;
wire [63:0] imm_data;

wire Branch;
wire MemRead;
wire MemToReg;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire [1:0] ALUOp;    

wire [63:0] ALU_op2; // used for 2nd input to ALU
wire [3:0] Operation; // passed to ALU
wire Zero;
wire [63:0] Result;

wire [63:0] branchOffset = {imm_data[62:0], 1'b0};
wire [63:0] branch_pc;
wire pc_sel = Branch & Zero; // used as selection to pc mux

wire [63:0] MemData; // data received from read data in mem

wire [63:0] writeData;

// IF stage
Program_Counter pc(clk, reset, PC_in, PC_out);
Adder adder1(PC_out, 64'h4, PC_next); // this PC_next goes to pc_mux in mem stage and compared with branch_pc
Instruction_Memory im(PC_out, Instruction);

// ID stage
Rtype_parser instParser(Instruction, opcode, funct7, rd, rs1, rs2, funct3);
imm_data_gen immgen(Instruction, imm_data);
Control_Unit cu(opcode, Branch, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite);
registerFile rf(writeData, rs1, rs2, rd, RegWrite, clk, reset, readData1, readData2); // writeData missing

// EX stage
mux2to1 alu_mux(readData2, imm_data, ALUSrc, ALU_op2);
// reg [3:0] Funct = {Instruction[20], Instruction[14:12]}; // used below
ALU_Control au(ALUOp, {Instruction[30], Instruction[14:12]}, Operation);
ALU_64_bit ALU(readData1, ALU_op2, Operation, Result, Zero);

// MEM stage;
Adder adder2(PC_out, branchOffset, branch_pc);
mux2to1 pc_mux(PC_next, branch_pc, (Branch & Zero) , PC_in); // may need new input name for pc_in
Data_Memory dm(Result, readData2, clk, MemWrite, MemRead, MemData);
    
// WB stage
mux2to1 reg_mux(Result, MemData, MemToReg, writeData);
    
endmodule
