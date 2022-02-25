`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2022 11:00:24 PM
// Design Name: 
// Module Name: tb_sign_extend
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


module tb_sign_extend();

reg  [15:0] extend;
wire   [31:0] extended;

sign_extend TBSIGNEXT
                  (
                   .extend(extend),
                   .extended(extended)
                  );

initial
begin
   extend = 16'd0;
end


initial 
begin
   #10 extend = 16'b0000_0000_1111_1111;
   #20 extend = 16'b1000_0000_1111_1111;
end

endmodule

