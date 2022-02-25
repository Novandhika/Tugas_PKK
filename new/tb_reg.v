`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2022 04:01:10 AM
// Design Name: 
// Module Name: tb_reg
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


module tb_reg(

    );
    
    reg         clk, wreg_en, rst, start;
    reg[31:0]   write_toreg;
    reg[4:0]    a1, a2, a3;
    wire[31:0]  reg_out1, reg_out2, ins;
    
    register REGISTER
    (
        .clk(clk),
        .start(start),
        .wrt_en(wreg_en),
        .rst(rst),
        .ins(ins),
        .a1(a1), 
        .a2(a2), 
        .a3(a3),
        .wrt(write_toreg),
        .rd1(reg_out1),
        .rd2(reg_out2)
    );
    
    
    initial
    begin
       clk = 1'd0;
       start = 1'd1;
       wreg_en = 1'd0; 
       write_toreg = 32'd0;
       rst = 1'd0;
       a1 = 5'd0;
       a2 = 5'd0;
       a3 = 5'd0;
    end
    
    always
    #1 clk = !clk;
   
   always
   #8 wreg_en = !wreg_en;
   
   initial
   begin
       #2 rst = 1'd1;
       #1 rst = 1'd0;
       #5 start = 1'd0;
       #7 a1 = 5'd1; a2 = 5'd3; a3 = 5'd6; write_toreg = 32'd50;
       #20 a1 = 5'd6; a2 = 5'd1; a3 = 5'd5; write_toreg = 32'd2;
       #10 a1 = 5'd7; a2 = 5'd5; a3 = 5'd4; write_toreg = 32'd7;
       #20 rst = 1'd1;
       #1 rst = 1'd0;
       #10 a1 = 5'd6; a2 = 5'd4; a3 = 5'd9; write_toreg = 32'd9;
       
       
    
    end
endmodule
