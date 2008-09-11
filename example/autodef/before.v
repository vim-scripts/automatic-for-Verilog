//
// Created by         :Marvell(Shanghai)Ltd.
// Filename           :before.v
// Author             :xge(RDC)
// Created On         :2008-09-10 18:03
// Last Modified      : 
// Update Count       :2008-09-10 18:03
// Description        :
//                     
//                     
//=======================================================================
// Instance:    clk_gate_ran.v
// Instance:    ahb/ahb_slave.v
module example(
    input       clk,
    output reg  dff_reg0);

/*autodefine*/

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        dff_reg0 <= #`FFD 0;
        dff_reg1 <= 1'd0;
        dff_reg2 <= #1 0;
    end
    else if (express1 <= condition1) begin
        // make the pair of () and the same line
        dff_reg2 <= (express1 <= condition2)? 3'b000 : condition3? 
                    ((express <= condition4)? 3'b101 : 3'b010) : 3'b111;
        dff_reg3[`DATA_WIDTH-1:0] <= din0;
    end
    else begin
        dff_reg1 <= 2'b01;
        dff_reg2 <= din2;
    end
end
wire signed [7:0] wire_7;
assign wire_7[7:0] = din1 * din2;
assign wire_1 = (express2 == condition3)? 2'd0 : 
                (express2 == condition4)? 2'd1 : 2'd2;
always @(*) begin
    cmb_reg0 = 0;
    cmb_reg1 = (express3 == condition5)? 2'b01 :
               (express4 == condition6)? din2[1:0] : din3[1:0];
    case(express5)
    0 : cmb_reg3[3] = 1'b1;
    1, 2, 3, 4 : cmb_reg2[1:0] = din2[2:0];
    `DEF0, PAR0 : begin
        cmb_reg2[2:0] = din3;
        cmb_reg4 = 5'h0;
    end
    default : begin
        cmb_reg5[`DATA_WIDTH : 0] = 0;
        cmb_reg6[DATA_WIDTH] = 1'b1;
    end
    endcase
end

clk_gate_ran u_gate(.clk(clk), .genp (clk_en), .testmodep(1'b0), .gclk(dff_clk));

always @(posedge clk) begin
    casez(express3)
    0 : dff_reg4[3:0] <= 0;
    1, 2, 3, 4 : begin
        dff_reg4 <= 5'b1_1100;
        dff_reg5[5:0] <= din3;
    end
    PAR0, PAR1, 5 : dff_reg6[2*DATA_WIDTH:0] <= din4;
    4'b??01 : dff_reg7[`DATA_WIDTH - 3] <= din5;
    endcase
end

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

// All signals in a function will be ignored
function comp;
input [7:0] a;
input [7:0] b;
output[7:0] c;
begin
    c = (a > b)? a : b;
end
endfunction
endmodule
