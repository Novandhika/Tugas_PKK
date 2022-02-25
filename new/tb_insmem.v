`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2022 01:32:21 AM
// Design Name: 
// Module Name: tb_insmem
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


module tb_insmem(

    );
    
    reg clk;
    reg[31:0] ram_out;
    wire[31:0] ins;
    
    instr_mem AYAYAYA
    (
        .clk(clk),
        .addr(ram_out),
        .instr(ins)
    );
    
    initial
    begin
       clk = 1'd0; 
       ram_out = 32'd0;
    end
    
    always
    #5 clk = !clk;
   
   initial
   begin
       #10 ram_out = 32'd1;
       #20 ram_out = 32'd2;
       #10 ram_out = 32'd3;
       #20 ram_out = 32'd4;
       #10 ram_out = 32'd8;
       
   end
    
endmodule
