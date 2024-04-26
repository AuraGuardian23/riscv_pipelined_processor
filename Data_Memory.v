`timescale 1ns / 1ps

module Data_Memory(
input [63:0] Mem_Addr,
input [63:0] WriteData,
input clk,
input MemWrite,
input MemRead,
output reg [63:0] ReadData
);

//reg [7:0] Memory [15:0]; 
reg [7:0] Memory [63:0]; 

initial
     begin
    Memory[0] <= 8'd9;
    Memory[1] <= 8'd8;
    Memory[2] <= 8'd7;
    Memory[3] <= 8'd6;
    Memory[4] <= 8'd5;
    Memory[5] <= 8'd6;
    Memory[6] <= 8'd7;
    Memory[7] <= 8'd8;
    Memory[8] <= 8'd9;
    Memory[9] <= 8'd10;
    Memory[10] <= 8'd11;
    Memory[11] <= 8'd12;
    Memory[12] <= 8'd13;
    Memory[13] <= 8'd14;
    Memory[14] <= 8'd15;
    Memory[15] <= 8'd16;
    Memory[16] <= 8'd17;
    Memory[17] <= 8'd18;
    Memory[18] <= 8'd19;
    Memory[19] <= 8'd20;
    Memory[20] <= 8'd21;
    Memory[21] <= 8'd22;
    Memory[22] <= 8'd23;
    Memory[23] <= 8'd24;
    Memory[24] <= 8'd25;
    Memory[25] <= 8'd26;
    Memory[26] <= 8'd27;
    Memory[27] <= 8'd28;
    Memory[28] <= 8'd29;
    Memory[29] <= 8'd30;
    Memory[30] <= 8'd31;
    Memory[31] <= 8'd32;
    Memory[32] <= 8'd33;
    Memory[33] <= 8'd34;
    Memory[34] <= 8'd35;
    Memory[35] <= 8'd36;
    Memory[36] <= 8'd37;
    Memory[37] <= 8'd38;
    Memory[38] <= 8'd39;
    Memory[39] <= 8'd40;
    Memory[40] <= 8'd41;
    Memory[41] <= 8'd42;
    Memory[42] <= 8'd43;
    Memory[43] <= 8'd44;
    Memory[44] <= 8'd45;
    Memory[45] <= 8'd46;
    Memory[46] <= 8'd47;
    Memory[47] <= 8'd48;
    Memory[48] <= 8'd49;
    Memory[49] <= 8'd50;
    Memory[50] <= 8'd51;
    Memory[51] <= 8'd52;
    Memory[52] <= 8'd53;
    Memory[53] <= 8'd54;
    Memory[54] <= 8'd55;
    Memory[55] <= 8'd56;
    Memory[56] <= 8'd57;
    Memory[57] <= 8'd58;
    Memory[58] <= 8'd59;
    Memory[59] <= 8'd60;
    Memory[60] <= 8'd61;
    Memory[61] <= 8'd62;
    Memory[62] <= 8'd63;
    Memory[63] <= 8'd64;

     end

//always@ (Mem_Addr, MemRead)
//    begin
//        if (MemRead == 1'b1)
        
//            begin
//                ReadData[7:0] <= Memory[Mem_Addr+0];
//                ReadData[15:8] <= Memory[Mem_Addr+1];
//                ReadData[23:16] <= Memory[Mem_Addr+2];
//                ReadData[31:24] <= Memory[Mem_Addr+3];
//                ReadData[39:32] <= Memory[Mem_Addr+4];
//                ReadData[47:40] <= Memory[Mem_Addr+5];
//                ReadData[55:48] <= Memory[Mem_Addr+6];
//                ReadData[63:56] <= Memory[Mem_Addr+7];
//            end

//end

always@ (*)
    begin
        if (MemWrite == 1'b1)
            begin
                Memory[Mem_Addr+7] <= WriteData[63:56];
                Memory[Mem_Addr+6] <= WriteData[55:48];
                Memory[Mem_Addr+5] <= WriteData[47:40];
                Memory[Mem_Addr+4] <= WriteData[39:32];
                Memory[Mem_Addr+3] <= WriteData[31:24];
                Memory[Mem_Addr+2] <= WriteData[23:16];
                Memory[Mem_Addr+1] <= WriteData[15:8];
                Memory[Mem_Addr] <= WriteData[7:0];
            end
            
        if (MemRead == 1'b1)
    
        begin
            ReadData[7:0] <= Memory[Mem_Addr+0];
            ReadData[15:8] <= Memory[Mem_Addr+1];
            ReadData[23:16] <= Memory[Mem_Addr+2];
            ReadData[31:24] <= Memory[Mem_Addr+3];
            ReadData[39:32] <= Memory[Mem_Addr+4];
            ReadData[47:40] <= Memory[Mem_Addr+5];
            ReadData[55:48] <= Memory[Mem_Addr+6];
            ReadData[63:56] <= Memory[Mem_Addr+7];
        end
    end

endmodule
