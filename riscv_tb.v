`timescale 1ns / 1ps


module riscv_tb();
reg clk;
reg reset;

RISC_V_Processor riscv_proc(clk, reset);

initial begin
    clk = 0;
    reset = 1'b1;
    #5; 
    
    reset = 1'b0;
    
end

always
#10 clk=~clk;

endmodule
