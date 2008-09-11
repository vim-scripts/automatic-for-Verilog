//
// Created by         :Marvell(Shanghai)Ltd.
// Filename           :before.v
// Author             :xge(RDC)
// Created On         :2008-09-09 01:14
// Last Modified      : 
// Update Count       :2008-09-09 01:14
// Description        :This is an example case for autoarg
//                     Adjust the value of b:vlog_max_col untill the 
//                     automatic lines matches the window's width
//=======================================================================
module example(/*autoarg*/
    //Inputs
    HCLK, HRESETn, HSELn, HBURST, HWDATA, HWRITE, HTRANS, 
    HMASTER, HMASTLOCK, din, din_valid, testmodep, 

    //Outputs
    HREADY, HRESEP, HRDATA, HSPLITn, dout, dout_valid);
//AHB INF
input           HCLK;           // clock
input           HRESETn;        // reset
input           HSELn;
input [2:0]     HBURST;
input [31:0]    HWDATA;
input           HWRITE;
input [1:0]     HTRANS;
input [3:0]     HMASTER;
input           HMASTLOCK;
output          HREADY;
output [1:0]    HRESEP;
output [31:0]   HRDATA;
output [15:0]   HSPLITn;
//Moudle INF
input [DATA_WIDTH-1:0]  din;
input                   din_valid;
output [DATA_WIDTH-1:0] dout;
output                  dout_valid;
//Test Mode INF
input           testmodep;

parameter DATA_WIDTH = 16;

endmodule
