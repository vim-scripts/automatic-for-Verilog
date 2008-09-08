//
// Created by         :Marvell(Shanghai)Ltd.
// Filename           :top.v
// Author             :xge(RDC)
// Created On         :2008-09-07 23:41
// Last Modified      : 
// Update Count       :2008-09-07 23:41
// Description        :
//                     
//                     
//=======================================================================
module example(/*autoarg*/
    //Inputs
    in_0, in_bus0, in_bus1, in_1, in_bus2, in_0_n, in_1_p, example_clk, example_rst_n, 
    //Outputs
    out_bus0, out_bus1, out_0, out_1, out_0_n, out_0_p, out_bus2, out_bus3, out_bus4);

parameter PAR0 = 16,
          PAR1 = 32;
// comment
input                   in_0;     //comment
input [PAR0-1:0]        in_bus0;  //comment
input [3:0]             in_bus1;  //comment
input                   in_1;     //comment
input [PAR1-1:0]        in_bus2;  //comment
input                   in_0_n;   //comment
input                   in_1_p;   //comment
/* comment */
input                   example_clk;    // clock
input                   example_rst_n;  // reset
// comment
output [PAR0-1:0]       out_bus0;
output [PAR1-1:0]       out_bus1;
output                  out_0;
output                  out_1;
output                  out_0_n;
output                  out_0_p;
output [31:0]           out_bus2;
output [15:0]           out_bus3;
output [7:0]            out_bus4;

/*autodefine*/
// Define flip-flop registers here
reg                      out_0;    //
reg                      out_1;    //
reg  [PAR0-1:0]          out_bus0;    //
reg  [PAR0-1:0]          out_bus1;    //
reg  [31:0]              out_bus2;    //
reg  [15:0]              out_bus3;    //
reg  [7:0]               out_bus4;    //
reg  [2:0]               reg0;    //
// Define combination registers here
reg  [PAR0:0]            comb_reg0;    //
reg  [11:0]              comb_reg1;    //
reg  [PAR0-1:0]          comb_reg2;    //
reg  [2:0]               comb_reg3;    //
reg                      comb_reg4;    //
reg                      comb_reg5;    //
reg                      comb_reg6;    //
// Define wires here
wire                     out0;    //
wire                     out0_n;    //
wire                     out0_p;    //
wire                     out1;    //
wire [2*PAR1-PAR0:0]     w0;    //
wire [31:0]              w1;    //
wire [35:0]              w2;    //
// Define instances' ouput wires here
wire [7:0]               dout;    //
wire                     dout_valid;    //
wire [WIDTH-1:0]         rdata;    //
// End of automatic define

//sequential assignment
always @(posedge example_clk or negedge example_rst_n)
    if (~example_rst_n) begin
        out_bus0[PAR0-1:0] <= #1 {PAR0{1'b0}};
        out_bus1[0] <= #`RD 1'b0;
    end
    else if (condtion == express) begin
        out_bus0 <= ~out_bus0;
        out_bus1[PAR0-1:0] <= # `RD out_bus1[PAR1-1:0];
    end
end
always @(posedge example_clk or negedge example_rst_n) begin
    if (!example_rst_n) begin
        reg0 <= #1 0;
    end
    else begin
        if (conditon <= express) reg0 <= #1 3'd3;
        else reg0 <= #1 0;
    end
end
always @(negedge example_clk or negedge example_rst_n)
    if (~example_rst_n) begin
        out_bus2 <= #1 32'hffff_0000;
        out_bus3[7:0] <= #1 8'h55;
        out_bus4[5] <= #1 1;
    end
    else if (condition <= express) begin
        case (express)
            4'd0 : out_bus4[7] <= #1 0;
            1    : out_bus4[3] <= #1 1;
            2, 3, 4 : begin
                if (condition == express) begin
                    out_bus4[2:0] <= #1 3'd3;
                end
                else if (condition == express1) begin
                    out_bus4[2:0] <= #1 (condition <= express)? 3'd0 :
                                        (condition <= express)? 3'd1 : (condtion <= express)? 3'd2 :
                                        express? 3'd4 : 3'd5;
                end
                out_0 <= #1 0;
                out_1 <= #1 1'b1;
            end
            default : begin
                out_bus4[6] <= #1 1'b1;
                out_bus4[4] <= #1 1'b0;
            end
        endcase
    end
    else
        out_bus3[15:8] <= #1 8'haa;
end
// combination assignment
always @(*) begin
    comb_reg0 = 6'b00_0001;
    comb_reg1[7:0] = 0;
    comb_reg2[PAR0-1:0] = 0;
    if (condition == express)
        comb_reg1[11:8] = 4'ha;
    else begin
        case (express)
            PAR0 : comb_reg0 = 6'd5;
            PAR1 : comb_reg3 = (condition == express)? 3'd1 : (condition == express)? 3'd2
                                    : (condition == express)? 3'd3 : 3'd4;
            PAR2, PAR3, PAR4 : comb_reg2[0] = 1;
            PAR5 : begin
                comb_reg0[PAR0:0] = 0;
                comb_reg5 = 1'b0;
                comb_reg6 = 1;
            end
            default : comb_reg4 = 0;
        endcase
    end
end

assign w0[2*PAR1-PAR0:0] = {2*PAR1-PAR0+1{1'b1}};
assign w1[31:4] = (condtion == express)? 28'h0 : (condtion == express)? 28'h1 :
                  condtion? 28'h2 : 28'h3;
assign w1[3:0] = w0*w1[31:4];
assign w2 = 36'd0;
assign out0 = w1[0];
assign out1 = ~out0;
assign out0_n = ~out0;
assign out0_p = out0;

inst0 u0(/*autoinst*/
        //Inputs
        .clk        (clk),
        .rst_n      (rst_n),
        .din_valid  (din_valid),
        .din        (din[7:0]),
        //Outputs
        .dout_valid (dout_valid),
        .dout       (dout[7:0]));
inst1 u1(/*autoinst*/
        //Inputs
        .clk   (clk),
        .rst_n (rst_n),
        .addr  (addr[31:0]),
        .wdata (wdata[WIDTH-1:0]),
        //Outputs
        .rdata (rdata[WIDTH-1:0]));

endmodule