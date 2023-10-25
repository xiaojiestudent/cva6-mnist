module bayes_axi_full #(
		parameter integer C_AXI_ID_WIDTH	= 2,
		parameter integer C_AXI_DATA_WIDTH	= 32,
		parameter integer C_AXI_ADDR_WIDTH	= 6
	) (
		input	wire								S_AXI_ACLK,
		input	wire								S_AXI_ARESETN,
		input	wire								S_AXI_AWVALID,
		output	wire								S_AXI_AWREADY,
		input	wire	[C_AXI_ID_WIDTH-1:0]		S_AXI_AWID,
		input	wire	[C_AXI_ADDR_WIDTH-1:0]		S_AXI_AWADDR,
		input	wire	[7:0]						S_AXI_AWLEN,
		input	wire	[2:0]						S_AXI_AWSIZE,
		input	wire	[1:0]						S_AXI_AWBURST,
		input	wire								S_AXI_AWLOCK,
		input	wire	[3:0]						S_AXI_AWCACHE,
		input	wire	[2:0]						S_AXI_AWPROT,
		input	wire	[3:0]						S_AXI_AWQOS,
		input	wire								S_AXI_WVALID,
		output	wire								S_AXI_WREADY,
		input	wire	[C_AXI_DATA_WIDTH-1:0]		S_AXI_WDATA,
		input	wire	[(C_AXI_DATA_WIDTH/8)-1:0]	S_AXI_WSTRB,
		input	wire								S_AXI_WLAST,
		output	wire								S_AXI_BVALID,
		input	wire								S_AXI_BREADY,
		output	wire	[C_AXI_ID_WIDTH-1:0]		S_AXI_BID,
		output	wire	[1:0]						S_AXI_BRESP,
		input	wire								S_AXI_ARVALID,
		output	wire								S_AXI_ARREADY,
		input	wire	[C_AXI_ID_WIDTH-1:0]		S_AXI_ARID,
		input	wire	[C_AXI_ADDR_WIDTH-1:0]		S_AXI_ARADDR,
		input	wire	[7:0]						S_AXI_ARLEN,
		input	wire	[2:0]						S_AXI_ARSIZE,
		input	wire	[1:0]						S_AXI_ARBURST,
		input	wire								S_AXI_ARLOCK,
		input	wire	[3:0]						S_AXI_ARCACHE,
		input	wire	[2:0]						S_AXI_ARPROT,
		input	wire	[3:0]						S_AXI_ARQOS,
		output	wire								S_AXI_RVALID,
		input	wire								S_AXI_RREADY,
		output	wire	[C_AXI_ID_WIDTH-1:0]		S_AXI_RID,
		output	wire	[C_AXI_DATA_WIDTH-1:0]		S_AXI_RDATA,
		output	wire	[1:0]						S_AXI_RRESP,
		output	wire								S_AXI_RLAST
	);

	assign S_AXI_BID = S_AXI_AWID;
	assign S_AXI_RID = S_AXI_ARID;
	assign S_AXI_RLAST = 1;

	AXI_Bayes_v1_0_S_AXI #(
		.C_S_AXI_DATA_WIDTH(C_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_AXI_ADDR_WIDTH)
	) i_AXI_Bayes_v1_0_S_AXI (
		.S_AXI_ACLK									(S_AXI_ACLK),
		.S_AXI_ARESETN								(S_AXI_ARESETN),
		.S_AXI_AWADDR								(S_AXI_AWADDR),
		.S_AXI_AWPROT								(S_AXI_AWPROT),
		.S_AXI_AWVALID								(S_AXI_AWVALID),
		.S_AXI_AWREADY								(S_AXI_AWREADY),
		.S_AXI_WDATA								(S_AXI_WDATA),
		.S_AXI_WSTRB								(S_AXI_WSTRB),
		.S_AXI_WVALID								(S_AXI_WVALID),
		.S_AXI_WREADY								(S_AXI_WREADY),
		.S_AXI_BRESP								(S_AXI_BRESP),
		.S_AXI_BVALID								(S_AXI_BVALID),
		.S_AXI_BREADY								(S_AXI_BREADY),
		.S_AXI_ARADDR								(S_AXI_ARADDR),
		.S_AXI_ARPROT								(S_AXI_ARPROT),
		.S_AXI_ARVALID								(S_AXI_ARVALID),
		.S_AXI_ARREADY								(S_AXI_ARREADY),
		.S_AXI_RDATA								(S_AXI_RDATA),
		.S_AXI_RRESP								(S_AXI_RRESP),
		.S_AXI_RVALID								(S_AXI_RVALID),
		.S_AXI_RREADY								(S_AXI_RREADY)
	);
	
endmodule
