//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/16 18:32:32
// Design Name: 
// Module Name: cmpt_idx
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


module cmpt_idx(
   input clk,
   input rstn,
   
   output reg [3 : 0]out_c_idx,
   output reg [9 : 0]out_attri_idx   
    );
    
    reg [3 : 0] tmp_c_idx = 0;
    reg [9 : 0] tmp_attri_idx = 0;
    
    always@(posedge clk)
    begin
       if (rstn == 0)
       begin
          out_c_idx = 0;
          out_attri_idx = 0;
          tmp_c_idx = 0;
          tmp_attri_idx = 0;
       end
       
       else
       begin
          out_c_idx = tmp_c_idx;
          out_attri_idx = tmp_attri_idx;
          
          if (tmp_attri_idx <= 783)
          begin
             tmp_c_idx = tmp_c_idx;
             tmp_attri_idx = tmp_attri_idx + 1;   
          end
          
          else
          begin
             if (tmp_c_idx >= 10)
             begin
                tmp_c_idx = tmp_c_idx;
                tmp_attri_idx = 800;
             end
             else
             begin
                tmp_c_idx = tmp_c_idx + 1;
                tmp_attri_idx = (tmp_c_idx <= 9) ? 0 : 800;
             end
          end
          
       end
    end
endmodule
