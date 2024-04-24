`timescale 1ns / 1ps


module ALU_Control(
    input [1:0] ALUOp,
    input [3:0] Funct,
    output reg [3:0] Operation
    );
    

always@(*)
begin
    case (ALUOp)
        2'b00: // ld/sd
            Operation <= 4'b0010;
        
        2'b01: // beq
            Operation <= 4'b0110;
        
        2'b10: // r type
            begin
                case (Funct)
                    4'b0000:
                        Operation <= 4'b0010;
                    
                    4'b1000:
                        Operation <= 4'b0110;
                    
                    4'b0111:
                        Operation <= 4'b0000;
                    
                    4'b0110:
                        Operation <= 4'b0001;
                        
                    default:
                        Operation <= 4'bxxxx;
                endcase
            end
        
        default:
            Operation <= 4'bxxxx;
    endcase
    
end    
    
endmodule
