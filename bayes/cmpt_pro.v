//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/15 20:51:40
// Design Name: 
// Module Name: cmpt_pro
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


module cmpt_pro(
   input clk,
   input rstn,
   input [9 : 0]data_pxc,
   input [3 : 0]in_c_idx,
   input [9 : 0]in_attri_idx,
   
   output reg label_valid,
   output reg [3 : 0] label
    );
    
    reg [3 : 0] min_label = 0;
    reg [15 : 0] min_pro = 16'b1111_1111_1111_1111;
    reg [16 : 0] tmp_pro = 0;
    
    always@( posedge clk )
    begin
       if ( rstn == 0 )
       begin 
          
          label_valid = 0;
          label = 10;
          
          min_label = 0;
          min_pro = 15'b11111_11111_11111;
          tmp_pro = 0;
       end
       
       else
       begin
	   
          if (in_attri_idx <= 783)
          begin
             tmp_pro = (in_attri_idx == 0) ? { 7'b000000, data_pxc} : tmp_pro + { 7'b000000, data_pxc};
             
             label_valid = 0;
             label = label;
          end
       
          else
          begin
             if (in_c_idx >= 10 )
             begin 
                label_valid = 1;
                label = min_label;
             end
             else
             begin
                label_valid = 0;
                label = label;

                case(in_c_idx)
                    0: tmp_pro = tmp_pro + 17'b0000000_0011010101; 
                    1: tmp_pro = tmp_pro + 17'b0000000_0011001001;   
                    2: tmp_pro = tmp_pro + 17'b0000000_0011010101;
                    3: tmp_pro = tmp_pro + 17'b0000000_0011010010;
                    4: tmp_pro = tmp_pro + 17'b0000000_0011010111;
                    5: tmp_pro = tmp_pro + 17'b0000000_0011011101;
                    6: tmp_pro = tmp_pro + 17'b0000000_0011010101;
                    7: tmp_pro = tmp_pro + 17'b0000000_0011010000;
                    8: tmp_pro = tmp_pro + 17'b0000000_0011010110;
                    9: tmp_pro = tmp_pro + 17'b0000000_0011010101;
                    default: tmp_pro = tmp_pro;
                endcase
                if (tmp_pro < min_pro)
                begin
                   min_pro = tmp_pro;
                   min_label = in_c_idx;
                end
             
             end
          end
       end   
    end
    
endmodule
