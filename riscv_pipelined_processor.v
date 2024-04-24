`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 08:46:34 AM
// Design Name: 
// Module Name: riscvPipelinedProcessor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module riscvPipelinedProcessor(
    input clk,
    input reset
    );
    
wire [63:0] PC_in;
// reg b = 64'h4;

wire [31:0] Instruction;
wire [6:0] opcode; 
wire [6:0] funct7;
wire [4:0] rd;
wire [4:0] rs1;
wire [4:0] rs2;
wire [2:0] funct3;   

wire [63:0] ALU_op2; // used for 2nd input to ALU
wire [3:0] Operation; // passed to ALU

wire [63:0] branch_pc;
wire [63:0] writeData;

// pipelined registers

// IF/ID pipelined registers
wire [31:0] IFID_Instruction; 
wire [63:0] IFID_PC_next, IFID_PC_out; 
// PC_next used for next instruction pc while pc out used for calculating branch pc

// ID/EX pipelined registers
wire [31:0] IDEX_Instruction;
wire [63:0] IDEX_readData1, IDEX_readData2, IDEX_PC_next, IDEX_PC_out, IDEX_imm_data; 

// EX/MEM pipelined registers
wire [63:0] EXMEM_ALU_Result, EXMEM_PC_next, EXMEM_PC_out, EXMEM_imm_data;
wire EXMEM_Zero;
// EXMEM_imm_data will be used to calculate branchOffset for use in MEM

// MEM/WB pipelined registers
wire [63:0] MEMWB_ALU_Result, MEMWB_MemData;

// pipeline control signals
wire [1:0] IDEX_ALUOp;
wire IDEX_Branch, IDEX_MemRead, IDEX_MemToReg, IDEX_MemWrite, IDEX_ALUSrc, IDEX_RegWrite; // to be used in EX + carried forward
wire EXMEM_Branch, EXMEM_MemRead, EXMEM_MemToReg, EXMEM_MemWrite, EXMEM_RegWrite; // to be used in MEM + carried forward
wire MEMWB_MemToReg, MEMWB_RegWrite; // to be used in WB
 
// IF stage
Program_Counter pc(clk, reset, PC_in, IFID_PC_out);
Adder adder1(IFID_PC_out, 64'h4, IFID_PC_next); // this PC_next goes to pc_mux in mem stage and compared with branch_pc
Instruction_Memory im(IFID_PC_out, IFID_Instruction);

// ID stage
Rtype_parser instParser(IFID_Instruction, opcode, funct7, rd, rs1, rs2, funct3);
imm_data_gen immgen(IFID_Instruction, IDEX_imm_data);
Control_Unit cu(opcode, IDEX_Branch, IDEX_MemRead, IDEX_MemToReg, IDEX_ALUOp, IDEX_MemWrite, IDEX_ALUSrc, IDEX_RegWrite);
registerFile rf(writeData, rs1, rs2, rd, EXMEM_RegWrite, clk, reset, IDEX_readData1, IDEX_readData2); 

// carry forward values from prev register
assign IDEX_PC_out = IFID_PC_out;
assign IDEX_PC_next = IFID_PC_next;
assign IDEX_Instruction = IFID_Instruction;

// EX stage
mux2to1 alu_mux(IDEX_readData2, IDEX_imm_data, IDEX_ALUSrc, ALU_op2);
// reg [3:0] Funct = {Instruction[20], Instruction[14:12]}; // used below
ALU_Control au(IDEX_ALUOp, {IDEX_Instruction[30], IDEX_Instruction[14:12]}, Operation);
ALU_64_bit ALU(IDEX_readData1, ALU_op2, Operation, EXMEM_ALU_Result, EXMEM_Zero);

// carry forward values from prev register
assign EXMEM_PC_out = IDEX_PC_out;
assign EXMEM_PC_next = IDEX_PC_next;
assign EXMEM_imm_data = IDEX_imm_data;

assign EXMEM_Branch = IDEX_Branch;
assign EXMEM_MemRead = IDEX_MemRead;
assign EXMEM_MemWrite = IDEX_MemWrite;
assign EXMEM_RegWrite = IDEX_RegWrite;
assign EXMEM_MemToReg = IDEX_MemToReg;

// MEM stage;
wire [63:0] branchOffset = {EXMEM_imm_data[62:0], 1'b0};

Adder adder2(EXMEM_PC_out, branchOffset, branch_pc);
mux2to1 pc_mux(EXMEM_PC_next, branch_pc, (EXMEM_Branch & EXMEM_Zero) , PC_in); // may need new input name for pc_in
Data_Memory dm(EXMEM_ALU_Result, readData2, clk, EXMEM_MemWrite, EXMEM_MemRead, MEMWB_MemData);
    
// carry forward values from prev register
assign MEMWB_RegWrite = EXMEM_RegWrite;
assign MEMWB_MemToReg = EXMEM_MemToReg;
assign MEMWB_ALU_Result = EXMEM_ALU_Result;

// WB stage
mux2to1 reg_mux(MEMWB_ALU_Result, MEMWB_MemData, MEMWB_MemToReg, writeData);
    
endmodule
