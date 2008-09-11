//
// Created by         :Marvell(Shanghai)Ltd.
// Filename           :ahb_arbiter.v
// Author             :xge(RDC)
// Created On         :2008-09-09 02:50
// Last Modified      : 
// Update Count       :2008-09-09 02:50
// Description        :The module name must be the same as the file name
//                     
//                     
//=======================================================================
module ahb_arbiter(
input           ahbm_arb_HBUSREQ,
input           ahbm_arb_HLOCK,
input [31:0]    ahbm_HADDR,
input [15:0]    ahbs_arb_HSPLIT,
input [1:0]     ahbm_HTRANS,
input [2:0]     ahbm_HBURST,
input [1:0]     ahbs_HRESP,
input           ahbs_HREADY,
input           HRESETn,                // reset
input           HCLK,                   // clock
output reg      arb_ahbm_HGRANT,
output reg [3:0]arb_ahbs_HMASTER,
output          arb_ahbs_HMASTERLOCK);

endmodule







