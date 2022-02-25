`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2022 12:13:01 PM
// Design Name: 
// Module Name: tb_regfile
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


module tb_regfile();
    
    reg         clk, rst, en;
    reg[31:0]   pc_inin;
    wire[31:0]  pc_out, pc_in;
    
    regfile     REGFILE
    (
        .clk(clk),
        .rst(rst),
        .en(en),
        .data_in(pc_out),
        .data_out(pc_in)
    );
    
    program_counter PCTESTCOBA //Program Counter
    (
        .clk(clk),
        .rst(rst),
        .pc_in(pc_inin),
        .pc_out(pc_out)
    );
    
    initial
    begin
       clk = 1'd0;
       rst = 1'd1;
       en = 1'd0;
       pc_inin = 32'd0;
      
    end
    
    
    always
        #2 clk = !clk;
    
    always
        #10 en = !en;
    
    initial
    begin
        #5 pc_inin = 32'd5;
        #5 rst = 1'd0;
        #5 pc_inin = 32'd15;
        #5 pc_inin = 32'd25;
        #5 pc_inin = 32'd35;
        #5 pc_inin = 32'd45;
        #5 pc_inin = 32'd55;
        #5 pc_inin = 32'd65;
        #5 pc_inin = 32'd15;
        #5 pc_inin = 32'd25;
        #5 rst = 1'd1; pc_inin = 32'd65;
        #5 pc_inin = 32'd35; rst = 1'd0;
        #5 pc_inin = 32'd45;
        #5 pc_inin = 32'd55;
        #5 pc_inin = 32'd65;
        
        
    end
    
endmodule
