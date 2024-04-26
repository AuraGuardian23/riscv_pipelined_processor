`timescale 1ns / 1ps

module Instruction_Memory(
    input [63:0] Inst_Address,
    output reg [31:0] Instruction 
    );
    
reg [7:0] Memory [79:0];

initial
     begin
        Memory[0] <= 8'h13; // addi x10, x0, 0
        Memory[1] <= 8'h05;
        Memory[2] <= 8'h00;
        Memory[3] <= 8'h00;
        Memory[4] <= 8'h93; // addi x11, x0, 4
        Memory[5] <= 8'h05;
        Memory[6] <= 8'h40;
        Memory[7] <= 8'h00;
        Memory[8] <= 8'h93; // addi x21, x10, 0
        Memory[9] <= 8'h0a;
        Memory[10] <= 8'h05;
        Memory[11] <= 8'h00;
        Memory[12] <= 8'h13; // addi x22, x11, 0
        Memory[13] <= 8'h8b;
        Memory[14] <= 8'h05;
        Memory[15] <= 8'h00;
        Memory[16] <= 8'h93; // addi x19, x0, 0
        Memory[17] <= 8'h09;
        Memory[18] <= 8'h00;
        Memory[19] <= 8'h00;
        Memory[20] <= 8'h63; // blt x19, x22, 8 (continue)
        Memory[21] <= 8'hc4;
        Memory[22] <= 8'h69;
        Memory[23] <= 8'h01;
        Memory[24] <= 8'h63; // beq x0, x0, 56 (finish) 
        Memory[25] <= 8'h0c;
        Memory[26] <= 8'h00;
        Memory[27] <= 8'h02;
        Memory[28] <= 8'h13; // addi x20, x19, -1 # continue
        Memory[29] <= 8'h8a;
        Memory[30] <= 8'hf9;
        Memory[31] <= 8'hff;
        Memory[32] <= 8'h63; // blt x20, x0, 40 (exit2)
        Memory[33] <= 8'h44;
        Memory[34] <= 8'h0a;
        Memory[35] <= 8'h02;
        Memory[36] <= 8'h93; // slli
        Memory[37] <= 8'h12;
        Memory[38] <= 8'h3a;
        Memory[39] <= 8'h00;
        Memory[40] <= 8'hb3;  
        Memory[41] <= 8'h82;
        Memory[42] <= 8'h5a;
        Memory[43] <= 8'h00;
        Memory[44] <= 8'h03; // ld x6, 0(x5)
        Memory[45] <= 8'hb3;
        Memory[46] <= 8'h02;
        Memory[47] <= 8'h00;
        Memory[48] <= 8'h83; // ld x7, 8(x5)
        Memory[49] <= 8'hb3;
        Memory[50] <= 8'h82;
        Memory[51] <= 8'h00;
        Memory[52] <= 8'h63; // blt x6, x7, exit2
        Memory[53] <= 8'h4a;
        Memory[54] <= 8'h73;
        Memory[55] <= 8'h00;
        Memory[56] <= 8'h23; // sd x7, 0(x5)  
        Memory[57] <= 8'hb0;
        Memory[58] <= 8'h72;
        Memory[59] <= 8'h00;
        Memory[60] <= 8'h23; // sd x6, 8(x5)
        Memory[61] <= 8'hb4;
        Memory[62] <= 8'h62;
        Memory[63] <= 8'h00;
        Memory[64] <= 8'h13; // addi x20, x20, -1
        Memory[65] <= 8'h0a;
        Memory[66] <= 8'hfa;
        Memory[67] <= 8'hff;
        Memory[68] <= 8'he3; // beq x0, x0, for2
        Memory[69] <= 8'h0e;
        Memory[70] <= 8'h00;
        Memory[71] <= 8'hfc;
        Memory[72] <= 8'h93; // addi x19, x19, 1
        Memory[73] <= 8'h89;
        Memory[74] <= 8'h19;
        Memory[75] <= 8'h00;
        Memory[76] <= 8'he3; // beq x0, x0, For1
        Memory[77] <= 8'h04;
        Memory[78] <= 8'h00;
        Memory[79] <= 8'hfc;
//        Memory[80] <= 8'h00;
//        Memory[81] <= 8'h00;
//        Memory[82] <= 8'h00;
//        Memory[83] <= 8'h00;
//        Memory[84] <= 8'h00;
//        Memory[85] <= 8'h00;
//        Memory[86] <= 8'h00;
//        Memory[87] <= 8'h00;
//        Memory[88] <= 8'h00;
//        Memory[89] <= 8'h00;
//        Memory[90] <= 8'h00;
//        Memory[91] <= 8'h00;
//        Memory[92] <= 8'h00;
//        Memory[93] <= 8'h00;
//        Memory[94] <= 8'h00;
//        Memory[95] <= 8'h00;
//        Memory[96] <= 8'h00;
//        Memory[97] <= 8'h00;
//        Memory[98] <= 8'h00;
//        Memory[99] <= 8'h00;
//        Memory[100] <= 8'h00;
//        Memory[101] <= 8'h00;
//        Memory[102] <= 8'h00;
//        Memory[103] <= 8'h00;
//        Memory[104] <= 8'h00;
//        Memory[105] <= 8'h00;
//        Memory[106] <= 8'h00;
//        Memory[107] <= 8'h00;
//        Memory[108] <= 8'h00;
//        Memory[109] <= 8'h00;
//        Memory[110] <= 8'h00;
//        Memory[111] <= 8'h00;
//        Memory[112] <= 8'h00;
//        Memory[113] <= 8'h00;
//        Memory[114] <= 8'h00;
//        Memory[115] <= 8'h00;
//        Memory[116] <= 8'h00;
//        Memory[117] <= 8'h00;
//        Memory[118] <= 8'h00;
//        Memory[119] <= 8'h00;
//        Memory[120] <= 8'h00;
                    
     end
    
always @(Inst_Address)
    begin
        Instruction[31:24] <= Memory[Inst_Address + 3];
        Instruction[23:16] <= Memory[Inst_Address + 2];
        Instruction[15:8] <= Memory[Inst_Address + 1];
        Instruction[7:0] <= Memory[Inst_Address];
    end
        
endmodule
