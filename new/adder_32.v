`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2022 09:50:03 PM
// Design Name: 
// Module Name: adder_32
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


module adder_32(
    input   ctr,
    input[31:0] a,
    input[31:0] b,
    output[31:0]    out
    );
    
    assign  out = a + b;
    
endmodule
