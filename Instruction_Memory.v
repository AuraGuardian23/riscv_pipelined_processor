`timescale 1ns / 1ps

module Instruction_Memory(
    input [63:0] Inst_Address,
    output reg [31:0] Instruction 
    );
    
reg [7:0] Memory [15:0];

initial
     begin
        Memory[0] <= 8'h83;
        Memory[1] <= 8'h34;
        Memory[2] <= 8'h85;
        Memory[3] <= 8'h02;
        Memory[4] <= 8'hb3;
        Memory[5] <= 8'h84;
        Memory[6] <= 8'h9a;
        Memory[7] <= 8'h0;
        Memory[8] <= 8'h93;
        Memory[9] <= 8'h84;
        Memory[10] <= 8'h14;
        Memory[11] <= 8'h0;
        Memory[12] <= 8'h23;
        Memory[13] <= 8'h34;
        Memory[14] <= 8'h95;
        Memory[15] <= 8'h02;
     end
    
always @(Inst_Address)
    begin
        Instruction[31:24] <= Memory[Inst_Address + 3];
        Instruction[23:16] <= Memory[Inst_Address + 2];
        Instruction[15:8] <= Memory[Inst_Address + 1];
        Instruction[7:0] <= Memory[Inst_Address];
    end
        
endmodule
