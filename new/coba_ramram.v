`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2022 02:05:42 PM
// Design Name: 
// Module Name: tb_ram
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


module coba_ramram(

    );
    
     reg         clk, we, start;
    reg[31:0]   din;
    reg[7:0]    adr;
    wire[31:0]  dout;
    
    ram RAMTEST
    (
        .clk(clk),
        .we(we),
        .start(start),
        .adr(adr),
        .din(din),
        .dout(dout)
    );
    
    
       
    

endmodule
