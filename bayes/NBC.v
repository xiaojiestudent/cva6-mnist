module NBC (
	input 				clk, 
	input 				rstn,
	input	[0 : 783]	test_vector,
	
	output			 	test_label_valid,
    output 	[3 :   0] 	test_out_label
	
);

	// cmpt_idx and cmpt_addr
    wire [3 : 0]c_idx_idx_addr;
    wire [9 : 0]attri_idx_idx_addr;
    
    // cmpt_addr and cmpt_pro
    wire [3 : 0] c_idx_addr_pro;
    wire [9 : 0] attri_idx_addr_pro;
    
    // cmpt_addr and bram
    wire ena_pxc_addr_bram;
    wire [13 : 0]addr_pxc_addr_bram;     
    
    // bram and cmpt_pro
    wire [9 : 0]data_pxc_bram_pro;

	cmpt_idx Cmpt_idx(
       .clk(clk),
       .rstn(rstn),
       
       .out_c_idx(c_idx_idx_addr),
       .out_attri_idx(attri_idx_idx_addr)   
    );
    
    cmpt_addr Cmpt_addr(
	
       .rstn(rstn),
       .in_c_idx(c_idx_idx_addr),
       .in_attri_idx(attri_idx_idx_addr),
       .test_vector(test_vector),
       
       .ena_pxc(ena_pxc_addr_bram),
       .addr_pxc(addr_pxc_addr_bram),
       .out_c_idx(c_idx_addr_pro),
       .out_attri_idx(attri_idx_addr_pro)
    );
    cmpt_pro Cmpt_pro(
       .clk(clk),
       .rstn(rstn),
       .data_pxc(data_pxc_bram_pro),
       .in_c_idx(c_idx_addr_pro),
       .in_attri_idx(attri_idx_addr_pro),
       
       .label(test_out_label),
       .label_valid(test_label_valid)
    );
      
    rom_pxc Rom_pxc(
       .clk(clk),
       .ena(ena_pxc_addr_bram),
       .addr(addr_pxc_addr_bram),
       .dout(data_pxc_bram_pro)
    );

endmodule