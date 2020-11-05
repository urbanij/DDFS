//////////////////////////////////////////////
// Project Name:     DDFS verilog
//                   
// Group:            
// Author(s):        Francesco Urbani
// 
// Create Date:      Sat Jan 12 19:19:30 CET 2019
// Design Name: 
// Module Name:      lut
// Target Devices:   Intel MAX10 10M50DAF484C7G
// Tool versions: 
// Description:      
//
//
// Revision:
//////////////////////////////////////////////

module dff
#(
    parameter               NBIT = 4
)
(
    input  wire             clk,
    input  wire             rst_n,
    input  wire [NBIT-1:0]  d,
    output reg  [NBIT-1:0]  q
);

always @(posedge clk or negedge rst_n) 
begin
    q <= rst_n ? {NBIT{1'd0}} : d;
end

endmodule