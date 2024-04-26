`timescale 1ns / 1ps


module ALU_64_bit(
    input [63:0] a,
    input [63:0] b,
    input [3:0] ALUOp,
    output reg [63:0] Result,
    output wire zero,
    output reg lt
);

//initial
//begin
    assign zero = ~(|Result) ; // take bitwise or all values in result and invert it
//    assign lt = (a < b);       // if a < b, lt = 1

always @(*)
begin
    if (a[63] == 1'b1 && b[63] == 1'b0)
    begin
         lt <= 1'b1;
    end
    else if (a[63] == 1'b0 && b[63] == 1'b1)
    begin
        lt <= 1'b0;
    end
    else if (a[63] == 1'b1 && b[63] == 1'b1)
    begin
        lt <= (a > b);
    end
    else 
    begin
        lt <= (a < b);
    end

end

//end
always @(*)
begin
    case(ALUOp)
        4'b0000: // AND
        begin
            Result = a & b ;
        end
        
        4'b0001: // OR
        begin 
            Result = a | b ;
        end
        
        4'b0010: // add
        begin
            Result = a + b;
        end
        
        4'b0110: // subtract
        begin
            Result = a - b;
        end
        
        4'b1100: // nor
        begin
            Result = ~a & ~b ;
        end
        
        4'b1111: // shift left
        begin
            Result = a << b;
        end
    endcase
    
//    // calculation for zero
//    zero = ~(|Result) ; // take bitwise or all values in result and invert it
//    lt = (a < b);       // if a < b, lt = 1
    
end


endmodule
