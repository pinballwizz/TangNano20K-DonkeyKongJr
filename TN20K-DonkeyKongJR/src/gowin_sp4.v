//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//Tool Version: V1.9.10 (64-bit)
//Part Number: GW2AR-LV18QN88C8/I7
//Device: GW2AR-18
//Device Version: C
//Created Time: Sun Dec 28 17:04:27 2025

module Gowin_SP4 (dout, clk, oce, ce, reset, wre, ad, din);

output [8:0] dout;
input clk;
input oce;
input ce;
input reset;
input wre;
input [5:0] ad;
input [8:0] din;

wire [26:0] spx9_inst_0_dout_w;
wire gw_gnd;

assign gw_gnd = 1'b0;

SPX9 spx9_inst_0 (
    .DO({spx9_inst_0_dout_w[26:0],dout[8:0]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .WRE(wre),
    .BLKSEL({gw_gnd,gw_gnd,gw_gnd}),
    .AD({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,ad[5:0],gw_gnd,gw_gnd,gw_gnd}),
    .DI({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,din[8:0]})
);

defparam spx9_inst_0.READ_MODE = 1'b0;
defparam spx9_inst_0.WRITE_MODE = 2'b00;
defparam spx9_inst_0.BIT_WIDTH = 9;
defparam spx9_inst_0.BLK_SEL = 3'b000;
defparam spx9_inst_0.RESET_MODE = "SYNC";

endmodule //Gowin_SP4
