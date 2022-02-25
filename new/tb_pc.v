`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2022 03:01:47 PM
// Design Name: 
// Module Name: tb_pc
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


module tb_pc();

    reg   clk;
    reg [31:0] pc_in;
    wire [31:0]    pc_out;


program_counter PCTEST
                  (
                   .clk(clk),
                   .pc_in(pc_in),
                   .pc_out(pc_out)
                  );

initial
begin
   clk = 1'd0;
   pc_in = 32'd0;
  
end


always
    #2 clk = !clk;
    
initial
begin
    #10 pc_in = 32'd5;
    #10 pc_in = 32'd15;
    #10 pc_in = 32'd25;
    #10 pc_in = 32'd35;
    #10 pc_in = 32'd45;
    #10 pc_in = 32'd55;
    #10 pc_in = 32'd65;
    
    
end
initial 
     #100  $stop; 

 
endmodule
