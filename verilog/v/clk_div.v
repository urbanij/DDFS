//////////////////////////////////////////////
// Project Name:     DDFS verilog
//                   
// Group:            
// Author(s):        Francesco Urbani
// 
// Create Date:      Sat Jan 12 19:19:30 CET 2019
// Design Name: 
// Module Name:      ddfs
// Target Devices:   Intel MAX10 10M50DAF484C7G
// Tool versions: 
// Description:      
//
//
// Revision:
//////////////////////////////////////////////

// synopsys translate_off
`include "pa.v"
`include "lut_clk.v"
// synopsys translate_on


module clk_div
#(
    parameter      N = 10,
    parameter      M = 4
)
(
    input [N-1:0]  fw,
    input          clk,
    input          rst_n,
    output [M-1:0] sine
);


// intermediate wires //
wire  [N-1:0]     pa_to_lut_wire;

// instances //

pa  #(
        .NBIT(N)
    )
    phase_acc_clk
    (
        .clk    (clk),
        .rst_n  (rst_n),
        .pa_in  (fw),
        .pa_out (pa_to_lut_wire)
    );



lut_clk #(
        .N(N),
        .M(M)
    )
    mylut_clk
    (
        .lut_line (pa_to_lut_wire),
        .lut_data (sine)
    );

endmodule