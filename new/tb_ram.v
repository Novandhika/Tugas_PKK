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


module tb_ram();
    
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
    
    
    initial
    begin
       clk = 1'd0;
       we = 1'd0; 
       din = 32'd0;
       adr = 5'd0;
       start = 1'd1;
    end
    
    always
    #3 clk = !clk;
   
   always
   #8 we = !we;
   
   initial
   begin
       #5 start = 1'd0;
       #5 adr = 8'd1; din = 32'd50;
       #20 adr = 8'd2; din = 32'd2;
       #10 adr = 8'd3; din = 32'd7;
       #10 adr = 8'd4; din = 32'd9;
       
       
    
    end
    
endmodule
