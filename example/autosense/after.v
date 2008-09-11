
//
// Created by         :Marvell(Shanghai)Ltd.
// Filename           :before.v
// Author             :xge(RDC)
// Created On         :2008-09-11 02:04
// Last Modified      : 
// Update Count       :2008-09-11 02:04
// Description        :
//                     
//                     
//=======================================================================
module example;
parameter PAR0 = 11,
          PAR1 = 12,
          PAR2 = 13;
/*autodefine*/
// Define flip-flop registers here
// Define combination registers here
reg            cmb_reg0;    //
reg  [1:0]     cmb_reg1;    //
reg            cmb_reg2;    //
reg            cmb_reg3;    //
reg            cmb_reg4;    //
reg            cmb_reg5;    //
// Define wires here
// Define instances' ouput wires here
// End of automatic define
always @(/*autosense*/din1 or din2 or express or din3 or din4
         or din5 or condition1 or din6 or condition2 or din7
                 or din8 or din9 or din10)
    cmb_reg0 = 1'b1;
    cmb_reg1[1:0] = din1[1:0];
    if (din2 == express)
        cmb_reg2 = (din3 == 4'd5)? din3 : din4? din5;
    else begin
        cmb_reg2 = (express == condition1)?
                   ((din6 == condition2)? din7 : 16) : PAR0 * din8;
        cmb_reg3 = (express == PAR1)? `DEFINE0 + (din9 + din10) :
                   (express < PAR2)? 32'habcd_fef0 : 32'd1234;
    end

always @(/*autosense*/express or din1 or din2 or din3 or din4
         or din5 or din6 or din7 or din8 or condition1 or din9 or condition2
         or din10 or condition3 or condition4 or din11 or din12
         or condition5 or condition6 or din13 or din14 or din15
                 or din16) begin
    case (express)
        0 : cmb_reg4 = {4{din1[0]}};
        4'b0001 : cmb_reg4 = {din2[3:2], din3[1:0]};
        2, 3, 4 : cmb_reg4 = {din4, {4{din5[1]}}} * (din6 + din7);
        4'h5 : begin
            if (din8 == condition1)
                cmb_reg4 = 5;
            else if (din9 == condition2) begin
                cmb_reg4 = din2[1:0];
                cmb_reg5 = {{PAR0(din10 == condition3)}};
            end
        end
        4'b1??? : cmb_reg5 = (condition4 == 0)? (din11 + din12) :
            (condition5 <= condition6)? din13 : din14;
        default : begin
            cmb_reg4 = din15;
            cmb_reg5 = din16;
        end
    endcase
end

endmodule
