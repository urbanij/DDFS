module ddfs_top
(
    //////////// CLOCK //////////
    input                       ADC_CLK_10,
    input                       MAX10_CLK1_50,
    input                       MAX10_CLK2_50,

    //////////// SDRAM //////////
    output          [12:0]      DRAM_ADDR,
    output           [1:0]      DRAM_BA,
    output                      DRAM_CAS_N,
    output                      DRAM_CKE,
    output                      DRAM_CLK,
    output                      DRAM_CS_N,
    inout           [15:0]      DRAM_DQ,
    output                      DRAM_LDQM,
    output                      DRAM_RAS_N,
    output                      DRAM_UDQM,
    output                      DRAM_WE_N,

    //////////// SEG7 //////////
    output           [7:0]      HEX0,
    output           [7:0]      HEX1,
    output           [7:0]      HEX2,
    output           [7:0]      HEX3,
    output           [7:0]      HEX4,
    output           [7:0]      HEX5,

    //////////// KEY //////////
    input            [1:0]      KEY,

    //////////// LED //////////
    output           [9:0]      LEDR,

    //////////// SW //////////
    input            [9:0]      SW,

    //////////// VGA //////////
    output           [3:0]      VGA_B,
    output           [3:0]      VGA_G,
    output                      VGA_HS,
    output           [3:0]      VGA_R,
    output                      VGA_VS,

    //////////// Accelerometer //////////
    output                      GSENSOR_CS_N,
    input            [2:1]      GSENSOR_INT,
    output                      GSENSOR_SCLK,
    inout                       GSENSOR_SDI,
    inout                       GSENSOR_SDO,

    //////////// Arduino //////////
    inout           [15:0]      ARDUINO_IO,
    inout                       ARDUINO_RESET_N,
   //////////// GPIO, GPIO connect to GPIO Default //////////
    inout           [35:0]      GPIO
);

parameter M = 4; // on-board DAC is only 4 bits.


wire clk_wire = MAX10_CLK1_50;
assign GPIO[35] = clk_wire;




wire [2:1]  gsensor_int_wire  = GSENSOR_INT;
wire        gsensor_sdi_wire  = GSENSOR_SDI;
wire        gsensor_sdo_wire  = GSENSOR_SDO;
wire        gsensor_sclk_wire = GSENSOR_SCLK;
wire        gsensor_cs_n_wire = GSENSOR_CS_N;



// inputs / io
assign GPIO[4:3] = gsensor_int_wire;
assign GPIO[1]   = gsensor_sdi_wire;
assign GPIO[0]   = gsensor_sdo_wire;


// outputs
assign GSENSOR_SCLK = GPIO[2];
assign GSENSOR_CS_N = GPIO[5];



assign HEX0 = 8'b101000000;
assign HEX1 = 8'b101000000;
assign HEX2 = 8'b101000000;
assign HEX3 = 8'b101000000;
assign HEX4 = 8'b101000000;
assign HEX5 = 8'b101000000;

ddfs #(
    .BIT_COUNT(20),
    .N        (8),
    .M        (M)
)
ddfs
(
    .fw       (SW[9:0]),
    .clk      (MAX10_CLK1_50),
    .rst_n    (KEY[0]),
    .sine     (VGA_B),
    .led      (LEDR[0])
);


endmodule
