//////////////////////////////////////////////
// Project Name:     DDFS verilog
//                   
// Group:            
// Author(s):        Francesco Urbani
// 
// Create Date:      Sat Jan 12 19:19:30 CET 2019
// Design Name: 
// Module Name:      phase accumulator
// Target Devices:   Intel MAX10 10M50DAF484C7G
// Tool versions: 
// Description:      
//
//
// Revision:
//////////////////////////////////////////////
module pa
#(
    parameter               NBIT = 4
)
(
    input  wire             clk,
    input  wire             rst_n,
    input  wire [NBIT-1:0]  pa_in,
    output reg  [NBIT-1:0]  pa_out = 0
);

always @(posedge clk or negedge rst_n) 
begin
    pa_out <= ~rst_n ? pa_out : pa_out + pa_in;
end

endmodule