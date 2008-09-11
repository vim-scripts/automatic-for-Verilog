//
// Created by         :Marvell(Shanghai)Ltd.
// Filename           :ahb_master.v
// Author             :xge(RDC)
// Created On         :2008-09-09 02:26
// Last Modified      : 
// Update Count       :2008-09-09 02:26
// Description        :The module name must be the same with the file name
//                     
//                     
//=======================================================================
module ahb_master(/*autoarg*/
    //Inputs
    arb_ahbm_HGRANT, ahbs_HREADY, ahbs_HRESP, HRESETn, 
    HCLK, ahbs_ahbm_HRDATA, 

    //Outputs
    ahbm_arb_HBUSREQ, ahbm_arb_HLOCK, ahbm_HTRANS, 
    ahbm_HADDR, ahbm_ahbs_HWRITE, ahbm_ahbs_HSIZE, 
    ahbm_HBURST, ahbm_HPROT, ahbm_ahbs_HWDATA);

input           arb_ahbm_HGRANT;
input           ahbs_HREADY;
input [1:0]     ahbs_HRESP;
input           HRESETn;        // reset
input           HCLK;           // clock
input [31:0]    ahbs_ahbm_HRDATA;
output          ahbm_arb_HBUSREQ;
output          ahbm_arb_HLOCK;
output [1:0]    ahbm_HTRANS;
output [31:0]   ahbm_HADDR;
output          ahbm_ahbs_HWRITE;
output [2:0]    ahbm_ahbs_HSIZE;
output [2:0]    ahbm_HBURST;
output [3:0]    ahbm_HPROT;
output [31:0]   ahbm_ahbs_HWDATA;


endmodule
