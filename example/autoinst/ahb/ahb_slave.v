//
// Created by         :Marvell(Shanghai)Ltd.
// Filename           :ahb_slave.v
// Author             :xge(RDC)
// Created On         :2008-09-09 02:42
// Last Modified      : 
// Update Count       :2008-09-09 02:42
// Description        :The module name must be the same as the file name
//                     
//                     
//=======================================================================
module ahb_slave(/*autoarg*/
    //Inputs
    HSEL, ahbm_HADDR, ahbm_ahbs_HWRITE, ahbm_HTRANS, 
    ahbm_ahbs_HSIZE, ahbm_HBURST, ahbm_ahbs_HWDATA, 
    HRESETn, HCLK, arb_ahbs_HMASTER, arb_ahbs_HMASTLOCK, 

    //Outputs
    ahbs_HREADY, ahbs_HRESP, ahbs_ahbm_HRDATA, ahbs_arb_HSPLIT);

input           HSEL;
input [31:0]    ahbm_HADDR;
input           ahbm_ahbs_HWRITE;
input [1:0]     ahbm_HTRANS;
input [2:0]     ahbm_ahbs_HSIZE;
input [2:0]     ahbm_HBURST;
input [31:0]    ahbm_ahbs_HWDATA;
input           HRESETn;
input           HCLK;
input [3:0]     arb_ahbs_HMASTER;
input           arb_ahbs_HMASTLOCK;
output          ahbs_HREADY;
output [1:0]    ahbs_HRESP;
output [31:0]   ahbs_ahbm_HRDATA;
output [15:0]   ahbs_arb_HSPLIT;

endmodule
