`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2022 12:07:55 PM
// Design Name: 
// Module Name: regfile
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


module regfile(
    input           clk, rst, en,
    input[31:0]     data_in,
    output[31:0]    data_out
    );
    
    reg[31:0]   out;
    
    always@(posedge clk or negedge rst)
    begin
        if(rst==1'd1)
            out <= 32'd0;
        else
        begin
            if(en==1'd1)
                out <= data_in;
            else
                out <= out;
        end
    end
    
    assign data_out = out;
    
endmodule
