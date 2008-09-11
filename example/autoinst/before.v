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

ahb_slave u_slave(/*autoinst*/);

ahb_master u_master(/*autoinst*/);

ahb_arbiter u_arbiter(/*autoinst*/);

endmodule
