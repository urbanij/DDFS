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
`include "ddfs.v"
// synopsys translate_on


module ddfs_tb();

    parameter      BIT_COUNT = 2;
    parameter      N = 8;
    parameter      M = 4;

    reg [N-1:0]  fw;
    reg          clk;
    reg          rst_n;
    wire [M-1:0] sine;
    wire         led;


ddfs #(
    .BIT_COUNT(BIT_COUNT),
    .M(M),
    .N(N)
)
ddfs
(
    .fw (fw),
    .clk (clk),
    .rst_n(rst_n),
    .sine(sine),
    .led (led)
);


always 
    begin
        clk = 1;
        #1;
        clk=0;
        #1;
    end




    initial begin
        fw = 5;
        rst_n = 0;
        repeat(9) #4;        
        rst_n = 1;
        
        repeat(9) #4;        
        repeat(9) #434;        
        fw = 2;
        repeat(9) #43;        
        rst_n = 0;
        repeat(9) #43;       
        rst_n = 1;
        repeat(9) #543;       
        fw = 1;
    end
        


    integer k;
    localparam integer kmax = 6000; // enough to see a full screen refresh cycle
    // localparam integer kmax = 300000;

    initial begin

        $dumpfile("ddfs_tb.vcd");
        $dumpvars(0, ddfs_tb);

        for (k=0; k<kmax; k=k+1)
            #10 $display("done testing case %d", k);

        $finish;

    end 


endmodule