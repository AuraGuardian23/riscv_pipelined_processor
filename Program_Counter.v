`timescale 1ns / 1ps

module Program_Counter(
    input clk,
    input reset,
    input [63:0] PC_In,
    output reg [63:0] PC_Out
    );

always @(posedge clk)
begin
        PC_Out <= PC_In;
end    

always @(*)
begin
    if (reset == 1'b1)
        PC_Out <= 64'h0;
end

endmodule
