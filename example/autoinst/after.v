//
// Created by         :Marvell(Shanghai)Ltd.
// Filename           :before.v
// Author             :xge(RDC)
// Created On         :2008-09-09 22:05
// Last Modified      : 
// Update Count       :2008-09-09 22:05
// Description        :
//                     
//                     
//=======================================================================
// Instance:    ahb/ahb_slave.v
// Instance:    ahb/ahb_master.v
// Instance:    ahb/ahb_arbiter.v
module example;

ahb_slave u_slave(/*autoinst*/
        //Inputs
        .ahbm_ahbs_HWDATA   (ahbm_ahbs_HWDATA[31:0] ),
        .arb_ahbs_HMASTLOCK (arb_ahbs_HMASTLOCK     ),
        .ahbm_ahbs_HWRITE   (ahbm_ahbs_HWRITE       ),
        .ahbm_HBURST        (ahbm_HBURST[2:0]       ),
        .ahbm_HADDR         (ahbm_HADDR[31:0]       ),
        .ahbm_ahbs_HSIZE    (ahbm_ahbs_HSIZE[2:0]   ),
        .HSEL               (HSEL                   ),
        .HCLK               (HCLK                   ),
        .ahbm_HTRANS        (ahbm_HTRANS[1:0]       ),
        .HRESETn            (HRESETn                ),
        .arb_ahbs_HMASTER   (arb_ahbs_HMASTER[3:0]  ),
        //Outputs
        .ahbs_arb_HSPLIT    (ahbs_arb_HSPLIT[15:0]  ),
        .ahbs_HREADY        (ahbs_HREADY            ),
        .ahbs_ahbm_HRDATA   (ahbs_ahbm_HRDATA[31:0] ),
        .ahbs_HRESP         (ahbs_HRESP[1:0]        ));

ahb_master u_master(/*autoinst*/
        //Inputs
        .ahbs_HREADY      (ahbs_HREADY            ),
        .ahbs_ahbm_HRDATA (ahbs_ahbm_HRDATA[31:0] ),
        .arb_ahbm_HGRANT  (arb_ahbm_HGRANT        ),
        .HCLK             (HCLK                   ),
        .ahbs_HRESP       (ahbs_HRESP[1:0]        ),
        .HRESETn          (HRESETn                ),
        //Outputs
        .ahbm_HPROT       (ahbm_HPROT[3:0]        ),
        .ahbm_arb_HBUSREQ (ahbm_arb_HBUSREQ       ),
        .ahbm_ahbs_HWRITE (ahbm_ahbs_HWRITE       ),
        .ahbm_arb_HLOCK   (ahbm_arb_HLOCK         ),
        .ahbm_HADDR       (ahbm_HADDR[31:0]       ),
        .ahbm_ahbs_HSIZE  (ahbm_ahbs_HSIZE[2:0]   ),
        .ahbm_HBURST      (ahbm_HBURST[2:0]       ),
        .ahbm_ahbs_HWDATA (ahbm_ahbs_HWDATA[31:0] ),
        .ahbm_HTRANS      (ahbm_HTRANS[1:0]       ));

ahb_arbiter u_arbiter(/*autoinst*/
        //Inputs
        .ahbm_arb_HBUSREQ     (ahbm_arb_HBUSREQ      ),
        .ahbs_HREADY          (ahbs_HREADY           ),
        .ahbm_HBURST          (ahbm_HBURST[2:0]      ),
        .ahbm_arb_HLOCK       (ahbm_arb_HLOCK        ),
        .ahbm_HADDR           (ahbm_HADDR[31:0]      ),
        .ahbs_arb_HSPLIT      (ahbs_arb_HSPLIT[15:0] ),
        .HCLK                 (HCLK                  ),
        .ahbm_HTRANS          (ahbm_HTRANS[1:0]      ),
        .ahbs_HRESP           (ahbs_HRESP[1:0]       ),
        .HRESETn              (HRESETn               ),
        //Outputs
        .arb_ahbm_HGRANT      (arb_ahbm_HGRANT       ),
        .arb_ahbs_HMASTERLOCK (arb_ahbs_HMASTERLOCK  ),
        .arb_ahbs_HMASTER     (arb_ahbs_HMASTER[3:0] ));

endmodule
