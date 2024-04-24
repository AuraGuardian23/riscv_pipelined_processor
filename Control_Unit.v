`timescale 1ns / 1ps


module Control_Unit(
    input [6:0] Opcode,
    output reg Branch,
    output reg MemRead,
    output reg MemToReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
    );
    
always@(*)
begin
    case (Opcode[6:4])
        3'b011: // r type
            begin
                ALUSrc <= 1'b0;
                MemToReg <= 1'b0;
                MemRead <= 1'b0;
                MemWrite <= 1'b0;
                RegWrite <= 1'b1;
                ALUOp <= 2'b10;
                Branch <= 1'b0;
            end
        
        3'b000: // ld
            begin
                ALUSrc <= 1'b1;
                MemToReg <= 1'b1;
                MemRead <= 1'b1;
                MemWrite <= 1'b0;
                RegWrite <= 1'b1;
                ALUOp <= 2'd0;
                Branch <= 1'b0;
            end
        3'b010: // sd
            begin
                ALUSrc <= 1'b1;
                MemToReg <= 1'bx;
                MemRead <= 1'b0;
                MemWrite <= 1'b1;
                RegWrite <= 1'b0;
                ALUOp <= 2'd0;
                Branch <= 1'b0;
            end
        3'b110: // beq
            begin
                MemToReg <= 1'bx;
                MemRead <= 1'b0;
                MemWrite <= 1'b0;
                ALUSrc <= 1'b0;
                RegWrite <= 1'b0;
                ALUOp <= 2'b01;
                Branch <= 1'b1;
            end
        3'b001: // addi & slli
            begin
                MemToReg <= 1'b0;
                MemRead <= 1'b0;
                MemWrite <= 1'b0;
                ALUSrc <= 1'b1;
                RegWrite <= 1'b1;
                ALUOp <= 2'd0;
                Branch <= 1'b0;
            end
        default:
            begin
                ALUSrc <= 1'b0;
                MemToReg <= 1'b0;
                MemRead <= 1'b0;
                MemWrite <= 1'b0;
                ALUSrc <= 1'b0;
                RegWrite <= 1'b0;
                ALUOp <= 2'd0;
            end
            
    
    endcase
end    
    
endmodule
