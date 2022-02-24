`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 02:05:48 PM
// Design Name: 
// Module Name: mux2_8
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


module mux2_8(
    input[7:0] a,
    input[7:0] b,
    
    input       mux2_ctr,
    output[7:0]   out
    );
    
    assign out =    (mux2_ctr == 1'd0) ? a  :
                    b;
    
endmodule
