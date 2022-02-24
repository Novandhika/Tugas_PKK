`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2022 09:19:19 PM
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input   clk, rst,
    input[31:0] pc_in,
    output[31:0]    pc_out
    );
    reg[31:0]   out;
    
    always@(posedge clk or negedge rst)
    begin
        if (rst==1'd1)
            out <= 32'd0;
        else
            out <= pc_in;
    end
    assign pc_out = out;
endmodule
