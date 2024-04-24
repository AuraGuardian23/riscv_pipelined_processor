module imm_data_gen (
    input [31:0] instruction,
    output reg [63:0] imm_data
    );
    
reg [11:0] imm_12;

always @(*) begin

// instruction[6:5], 00 = load, 01 = store, 1x = conditional branches
case (instruction[6:5])
    2'b00: 
    begin // 31:20 for load instructions,
        imm_12 = instruction[31:20] ;
    end
    
    2'b01: // bits 31:25 and 11:7 for store instructions,
    begin
        imm_12[11:5] = instruction[31:25] ;
        imm_12[4:0] = instruction[11:7] ;
    end
    
    default: // bits 31,7, 30:25, and 11:8 for the conditional branch
    begin
        imm_12[11] = instruction[31] ;
        imm_12[10] = instruction[7] ;
        imm_12[9:4] = instruction[30:25] ;
        imm_12[3:0] = instruction[11:8] ;
    end
endcase

// extend to 64 bits, see msb
case (imm_12[11])
    1'b0: // assign 0 to all 52 bits on left
        imm_data[63:12] = 52'h0;
    
    1'b1: // assign 1 to all 52 bits on left
        imm_data[63:12] = 52'hfffffffffffff ; 
endcase    

imm_data[11:0] = imm_12 ;

end
endmodule