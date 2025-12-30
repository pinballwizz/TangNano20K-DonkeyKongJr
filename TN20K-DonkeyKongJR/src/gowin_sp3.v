//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//Tool Version: V1.9.10 (64-bit)
//Part Number: GW2AR-LV18QN88C8/I7
//Device: GW2AR-18
//Device Version: C
//Created Time: Sun Dec 28 17:02:25 2025

module Gowin_SP3 (dout, clk, oce, ce, reset, wre, ad, din);

output [5:0] dout;
input clk;
input oce;
input ce;
input reset;
input wre;
input [7:0] ad;
input [5:0] din;

wire [25:0] sp_inst_0_dout_w;
wire gw_gnd;

assign gw_gnd = 1'b0;

SP sp_inst_0 (
    .DO({sp_inst_0_dout_w[25:0],dout[5:0]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .WRE(wre),
    .BLKSEL({gw_gnd,gw_gnd,gw_gnd}),
    .AD({gw_gnd,gw_gnd,gw_gnd,ad[7:0],gw_gnd,gw_gnd,gw_gnd}),
    .DI({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,din[5:0]})
);

defparam sp_inst_0.READ_MODE = 1'b0;
defparam sp_inst_0.WRITE_MODE = 2'b00;
defparam sp_inst_0.BIT_WIDTH = 8;
defparam sp_inst_0.BLK_SEL = 3'b000;
defparam sp_inst_0.RESET_MODE = "SYNC";

endmodule //Gowin_SP3
