
module  ram_1024_8_8
(
	input  I_CLKA,I_CLKB,
	input  [9:0]I_ADDRA,I_ADDRB,
	input  [7:0]I_DA,I_DB,
	input  I_CEA,I_CEB,
	input  I_WEA,I_WEB,
	output [7:0]O_DA,O_DB
);

wire   [7:0]W_DOA,W_DOB;
assign O_DA = I_CEA ? W_DOA : 8'h00;
assign O_DB = I_CEB ? W_DOB : 8'h00;

//dpram #(10,8) ram_1024_8_8
//(
//	.clock_a(I_CLKA),
//	.address_a(I_ADDRA),
//	.data_a(I_DA),
//	.enable_a(I_CEA),	
//	.wren_a(I_WEA),
//	.q_a(W_DOA),

//	.clock_b(I_CLKB),
//	.address_b(I_ADDRB),
//	.data_b(I_DB),
//	.enable_b(I_CEB),
//	.wren_b(I_WEB),
//	.q_b(W_DOB)
//);

    Gowin_DPB1 ram_1024_8_8(
        .douta(W_DOA), //output [7:0] douta
        .doutb(W_DOB), //output [7:0] doutb
        .clka(I_CLKA), //input clka
        .ocea(1'b1), //input ocea
        .cea(I_CEA), //input cea
        .reseta(1'b0), //input reseta
        .wrea(I_WEA), //input wrea
        .clkb(I_CLKB), //input clkb
        .oceb(1'b1), //input oceb
        .ceb(I_CEB), //input ceb
        .resetb(1'b0), //input resetb
        .wreb(I_WEB), //input wreb
        .ada(I_ADDRA), //input [9:0] ada
        .dina(I_DA), //input [7:0] dina
        .adb(I_ADDRB), //input [9:0] adb
        .dinb(I_DB) //input [7:0] dinb
    );

endmodule

/////////////////////////////////////////////////////////////////////

module  ram_1024_8
(
	input  I_CLK,
	input  [9:0]I_ADDR,
	input  [7:0]I_D,
	input  I_CE,
	input  I_WE,
	output [7:0]O_D
);

wire   [7:0]W_DO;
assign O_D = I_CE ? W_DO : 8'h00;

//dpram #(10,8) ram_1024_8
//(
//	.clock_a(I_CLK),
//	.address_a(I_ADDR),
//	.data_a(I_D),
//	.wren_a(I_WE),
//	.enable_a(I_CE),
//	.q_a(W_DO),

//	.clock_b(I_CLK)
//);

    Gowin_SP2 ram_1024_8(
        .dout(W_DO), //output [7:0] dout
        .clk(I_CLK), //input clk
        .oce(1'b1), //input oce
        .ce(I_CE), //input ce
        .reset(1'b0), //input reset
        .wre(I_WE), //input wre
        .ad(I_ADDR), //input [9:0] ad
        .din(I_D) //input [7:0] din
    );

endmodule

/////////////////////////////////////////////////////////////////////

module  ram_2N
(
	input  I_CLK,
	input  [7:0]I_ADDR,
	input  [3:0]I_D,
	input  I_CE,
	input  I_WE,
	output [3:0]O_D
);

//dpram #(8,4) ram_256_4
//(
//	.clock_a(I_CLK),
//	.address_a(I_ADDR),
//	.data_a(I_D),
//	.wren_a(I_WE),
//	.enable_a(I_CE),
//	.q_a(O_D),

//	.clock_b(I_CLK)
//);

    Gowin_SP5 ram_256_4(
        .dout(O_D), //output [3:0] dout
        .clk(I_CLK), //input clk
        .oce(1'b1), //input oce
        .ce(I_CE), //input ce
        .reset(1'b0), //input reset
        .wre(I_WE), //input wre
        .ad(I_ADDR), //input [7:0] ad
        .din(I_D) //input [3:0] din
    );

endmodule

/////////////////////////////////////////////////////////////////////

module  ram_2EH7M
(
	input  I_CLKA,I_CLKB,
	input  [7:0]I_ADDRA,
	input  [5:0]I_ADDRB,
	input  [5:0]I_DA,
	input  [8:0]I_DB,
	input  I_CEA,I_CEB,
	input  I_WEA,I_WEB,
	output [5:0]O_DA,
	output [8:0]O_DB
);

//dpram #(8,6) ram_256_6
//(
//	.clock_a(I_CLKA),
//	.address_a(I_ADDRA),
//	.data_a(I_DA),
//	.enable_a(I_CEA),	
//	.wren_a(I_WEA),
//	.q_a(O_DA),

//	.clock_b(I_CLKA)
//);

    Gowin_SP3 ram_256_6(
        .dout(O_DA), //output [5:0] dout
        .clk(I_CLKA), //input clk
        .oce(1'b1), //input oce
        .ce(I_CEA), //input ce
        .reset(1'b0), //input reset
        .wre(I_WEA), //input wre
        .ad(I_ADDRA), //input [7:0] ad
        .din(I_DA) //input [5:0] din
    );

//dpram #(6,9) ram_64_9
//(
//	.clock_a(I_CLKB),
//	.address_a(I_ADDRB),
//	.data_a(I_DB),
//	.enable_a(I_CEB),
//	.wren_a(I_WEB),
//	.q_a(O_DB),

//	.clock_b(I_CLKB)
//);

    Gowin_SP4 ram_64_9(
        .dout(O_DB), //output [8:0] dout
        .clk(I_CLKB), //input clk
        .oce(1'b1), //input oce
        .ce(I_CEB), //input ce
        .reset(1'b0), //input reset
        .wre(I_WEB), //input wre
        .ad(I_ADDRB), //input [5:0] ad
        .din(I_DB) //input [8:0] din
    );

endmodule

/////////////////////////////////////////////////////////////////////
/*
module  ram_2EF
(
	input  I_CLKA,I_CLKB,
	input  [7:0]I_ADDRA,I_ADDRB,
	input  [7:0]I_DA,I_DB,
	input  I_CEA,I_CEB,
	input  I_WEA,I_WEB,
	output [7:0]O_DA,O_DB
);

dpram #(9,8) ram_512_8
(
	.clock_a(I_CLKA),
	.address_a({1'b0,I_ADDRA}),
	.data_a(I_DA),
	.enable_a(I_CEA),	
	.wren_a(I_WEA),
	.q_a(O_DA),

	.clock_b(I_CLKB),
	.address_b({1'b1,I_ADDRB}),
	.data_b(I_DB),
	.enable_b(I_CEB),
	.wren_b(I_WEB),
	.q_b(O_DB)
);

endmodule

/////////////////////////////////////////////////////////////////////

module  double_scan
(
	input  I_CLKA,I_CLKB,
	input  [8:0]I_ADDRA,I_ADDRB,
	input  [7:0]I_DA,I_DB,
	input  I_CEA,I_CEB,
	input  I_WEA,I_WEB,
	output [7:0]O_DA,O_DB
);

dpram #(9,8) ram_512_8
(
	.clock_a(I_CLKA),
	.address_a(I_ADDRA),
	.data_a(I_DA),
	.enable_a(I_CEA),	
	.wren_a(I_WEA),
	.q_a(O_DA),

	.clock_b(I_CLKB),
	.address_b(I_ADDRB),
	.data_b(I_DB),
	.enable_b(I_CEB),
	.wren_b(I_WEB),
	.q_b(O_DB)
);

endmodule
*/
/////////////////////////////////////////////////////////////////////
/*
module  ram_64_8
(
	input  I_CLK,
	input  [5:0]I_ADDR,
	input  [7:0]I_D,
	input  I_CE,
	input  I_WE,
	output [7:0]O_D
);

dpram #(6,8) ram_64_8
(
	.clock_a(I_CLK),
	.address_a(I_ADDR),
	.data_a(I_D),
	.wren_a(I_WE),
	.enable_a(I_CE),
	.q_a(O_D),
	
	.clock_b(I_CLK)
);

endmodule

/////////////////////////////////////////////////////////////////////

module  ram_2048_8
(
	input  I_CLK,
	input  [10:0]I_ADDR,
	input  [7:0]I_D,
	input  I_CE,
	input  I_WE,
	output [7:0]O_D
);

dpram #(11,8) ram_2048_8
(
	.clock_a(I_CLK),
	.address_a(I_ADDR),
	.data_a(I_D),
	.wren_a(I_WE),
	.enable_a(I_CE),
	.q_a(O_D),

	.clock_b(I_CLK)
);

endmodule

/////////////////////////////////////////////////////////////////////

module  ram_4096_8
(
	input  I_CLK,
	input  [11:0]I_ADDR,
	input  [7:0]I_D,
	input  I_CE,
	input  I_WE,
	output [7:0]O_D
);


dpram #(12,8) ram_4096_8
(
	.clock_a(I_CLK),
	.address_a(I_ADDR),
	.data_a(I_D),
	.wren_a(I_WE),
	.enable_a(I_CE),
	.q_a(O_D),

	.clock_b(I_CLK)
);

endmodule
*/
