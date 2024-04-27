module mux3to1 (
    input [63:0] a,
    input [63:0] b,
    input [63:0] c,
    input [1:0] sel,
    output reg [63:0] data_out
    );
    
always @(*)
begin
    data_out = (sel == 00) ? a : (sel == 01) ? b : c ;
end
    

endmodule