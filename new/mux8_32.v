`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 06:36:04 PM
// Design Name: 
// Module Name: mux8_32
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


module mux8_32(
    input [31:0]    a, b, c, d, e, f, g, h,
    input [2:0]     mux8_ctr,
    output[31:0]    out
    );
    
    assign  out = (mux8_ctr == 3'd0) ? a  :
            (mux8_ctr == 3'd1) ? b  :
            (mux8_ctr == 3'd2) ? c  :
            (mux8_ctr == 3'd3) ? d  :
            (mux8_ctr == 3'd4) ? e  :
            (mux8_ctr == 3'd5) ? f  :
            (mux8_ctr == 3'd6) ? g  :
            h;
    
endmodule
