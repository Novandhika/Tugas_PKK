`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2022 12:02:59 AM
// Design Name: 
// Module Name: mux4_32
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


module mux4_32(
    input[31:0] a,
    input[31:0] b,
    input[31:0] c,
    input[31:0] d,
    input[1:0]  mux4_ctr,
    output[31:0]   out
    );
    
    assign out =    (mux4_ctr == 2'd0) ? a  :
                    (mux4_ctr == 2'd1) ? b  :
                    (mux4_ctr == 2'd2) ? c  :
                    d;
endmodule
