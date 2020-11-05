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
// synopsys translate_on


module pa_tb();

    parameter      N = 12;


    reg [N-1:0]  pa_in;
    reg          clk;
    reg          rst_n;
    wire [N-1:0] pa_out;


pa #(
    .NBIT(N)
)
pa
(
    .pa_in(pa_in),
    .clk (clk),
    .rst_n(rst_n),
    .pa_out(pa_out)
);


always 
    begin
        clk = 1;
        #1;
        clk=0;
        #1;
    end




    initial begin
        pa_in = 2;
        rst_n = 0;
        repeat(9) #4;        
        rst_n = 1;
        repeat(9) #4;        
        
        repeat(9) #4;        

    end
        


    integer k;
    localparam integer kmax = 190; // enough to see a full screen refresh cycle
    // localparam integer kmax = 300000;

    initial begin

        $dumpfile("pa_tb.vcd");
        $dumpvars(0, pa_tb);

        for (k=0; k<kmax; k=k+1)
            #10 $display("done testing case %d", k);

        $finish;

    end 


endmodule