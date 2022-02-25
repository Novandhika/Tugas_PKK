`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2022 12:23:56 AM
// Design Name: 
// Module Name: tb_mux32
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


module tb_mux32();
reg  [31:0] a;
reg  [31:0] b;
reg  [31:0] c;
reg  [31:0] d;
reg  ctr;
reg  [1:0] ctr1;
wire   [31:0] out;
wire   [31:0] out1;

mux2_32 MUXTEST2
                  (
                   .a(a),
                   .b(b),
                   .mux2_ctr(ctr),
                   .out(out)
                  );

mux4_32 MUXTEST4
                  (
                   .a(a),
                   .b(b),
                   .c(c),
                   .d(d),
                   .mux4_ctr(ctr1),
                   .out(out1)
                  );
initial
begin
   a = 32'd0;
   b = 32'd0;
   c = 32'd0;
   d = 32'd0;
   ctr = 1'd0;
   ctr1 = 2'd0;
end

initial 
begin
   #5 a = 32'd1;
   #5 b = 32'd2;
   #5 c = 32'd3;
   #5 d = 32'd4;
   #5 ctr1 = 2'd1;
   #5 ctr1 = 2'd2;
   #5 ctr1 = 2'd3;
end

initial 
begin
   #5 a = 32'd1;
   #5 b = 32'd2;
   #5 ctr = 1'd1;
end
endmodule
