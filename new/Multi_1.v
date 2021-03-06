`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2022 01:40:26 AM
// Design Name: 
// Module Name: Multi_1
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


module Multi_1(
    input           clk, rst, start,
    input[31:0]     data,
    output[31:0]    data_out
    );
    
    reg[31:0]       data1, ram_out1;
    wire[31:0]      PC_out1, instuk1, out1, ram_in1;
    wire[14:0]      Kontrol1;
    wire            ram_en1;
    wire[7:0]       addr1;
    
    reg[31:0]       data2, ram_out2;
    wire[31:0]      PC_out2, instuk2, out2, ram_in2;
    wire[14:0]      Kontrol2;
    wire            ram_en2;
    wire[7:0]       addr2;
    
    Coba_Multi1     Pro_1
    (
    .clk(clk), 
    .rst(rst), 
    .start(start),
    .data(data1), 
    .ram_out(ram_out1),
    .PC_out(PC_out1),
    .instuk(instuk1), 
    .out(out1), 
    .ram_in(ram_in1),
    .Kontrol(Kontrol1),
    .ram_en(ram_en1),
    .addr(addr1)
    );
    
    Coba_Multi1     Pro_2
    (
    .clk(clk), 
    .rst(rst), 
    .start(start),
    .data(data2), 
    .ram_out(ram_out2),
    .PC_out(PC_out2),
    .instuk(instuk2), 
    .out(out2), 
    .ram_in(ram_in2),
    .Kontrol(Kontrol2),
    .ram_en(ram_en2),
    .addr(addr2)
    );
    
    Multi_RAM   RAMRAM
    (
    .clk(clk),
    .en1(ram_en1), 
    .en2(ram_en2),
    .start(start),
    .addr1(addr1), 
    .addr2(addr2),
    .din1(ram_in1), 
    .din2(ram_in2),
    .dout1(ram_out1), 
    .dout2(ram_out2)
    );
    
    
    
endmodule
