//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/15 20:10:54
// Design Name: 
// Module Name: cmpt_addr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cmpt_addr(
   input rstn,
   input [3 : 0]in_c_idx,
   input [9 : 0]in_attri_idx,
   input [0 : 783] test_vector,
   
   output reg ena_pxc,
   output reg [13 : 0]addr_pxc,
   output reg [3 : 0] out_c_idx,
   output reg [9 : 0] out_attri_idx
    );
      
    always@( * )
    begin
       if (rstn == 0)
       begin
          ena_pxc = 0;
          addr_pxc = 0;
          
          out_c_idx = in_c_idx;
          out_attri_idx = in_attri_idx;
       end
       else
       begin
          out_c_idx = in_c_idx;
          out_attri_idx = in_attri_idx;
          if ( in_attri_idx == 784 )
          begin
             ena_pxc = 0;
             addr_pxc = 0;
          end
          else
          begin
          
             if (test_vector[in_attri_idx] == 1)
             begin
                addr_pxc = 7840 + 784 * in_c_idx + in_attri_idx;
             end
             else
             begin
                addr_pxc = 784 * in_c_idx + in_attri_idx;   
             end
             
             if (in_c_idx <= 9)
             begin
                ena_pxc = 1;   
             end
             else
             begin
                ena_pxc = 0;
             end
          end
       end
       
    end
        
endmodule
