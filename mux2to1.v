module mux2to1 (
    input [63:0] a,
    input [63:0] b,
    input sel,
    output reg [63:0] data_out
    );
    
always @(*)
begin
    data_out = (sel == 0) ? a : b ;
end
    

endmodule