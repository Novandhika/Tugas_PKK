`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 11:47:08 PM
// Design Name: 
// Module Name: tb_pro
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


module tb_pro(

    );
    
    reg             clk, rst, start;
    wire[31:0]      out1, out2;
    wire[31:0]    pc_output, pc_input, ram_input, ram_output;
    wire[31:0]    instruction, ALU_OUT;
    wire[5:0]       state;
    
    processor_1 RISC_COBA
    (
    .clk(clk), 
    .rst(rst), 
    .start(start),
    .out1(out1), 
    .out2(out2),
    .pc_output(pc_output),
    .pc_input(pc_input),
    .ram_input(ram_input), 
    .ram_output(ram_output),
    .instruction(instruction), 
    .ALU_OUT(ALU_OUT),
    .state(state)
    );
    
    initial
    begin
       clk = 1'd0; 
       rst = 1'd0;
       start = 1'd1;
    end
    
    always
    #2 clk = !clk;
   
   initial
   begin
    #5 rst = !rst;
    #5 rst = !rst;
       #10 start = !start;
       
   end
    
endmodule
