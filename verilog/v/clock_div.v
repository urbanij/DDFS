//////////////////////////////////////////////
// Project Name:     DDFS verilog
//                   
// Group:            
// Author(s):        Francesco Urbani
// 
// Create Date:      Sun Jan 13 15:50:59 CET 2019
// Design Name: 
// Module Name:      lut
// Target Devices:   Intel MAX10 10M50DAF484C7G
// Tool versions: 
// Description:      
//
//
// Revision:
//////////////////////////////////////////////

module clock_div
#(
    parameter           BIT_COUNT = 4
)
(
    input               i_clk_sys,  // input clock (reference)
    input               i_rst_n,    //
    output reg          o_clk1  =0  // output divided signal
);


reg [BIT_COUNT-1:0] counter1 = 0;

always @(posedge i_clk_sys, negedge i_rst_n)
begin
    if (~i_rst_n)
        counter1 <= 0;
    else
        // {o_clk1, counter1} <= counter1 + div1;
        counter1 <= counter1 + 1;
end
		  
		  
always @(posedge i_clk_sys, negedge i_rst_n)
begin
    if (counter1 == {BIT_COUNT{1'b1}})
    begin
        o_clk1 <= ~o_clk1;
    end
    else begin
       o_clk1 <= o_clk1; 
    end
end

endmodule
