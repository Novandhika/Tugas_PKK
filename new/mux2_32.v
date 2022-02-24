`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2022 09:15:33 PM
// Design Name: 
// Module Name: mux2_32
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


module mux2_32(
    input[31:0] a,
    input[31:0] b,
    
    input       mux2_ctr,
    output[31:0]   out
    );
    
    assign out =    (mux2_ctr == 1'd0) ? a  :
                    b;
endmodule
