`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 09:09:52 PM
// Design Name: 
// Module Name: ram
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


module ram(
    input   clk,
    input   we,
    input   start,
    input[7:0] adr,
    input[31:0] din,
    output[31:0] dout);
    
    reg [31:0] mem [255:0];
    
    always@(posedge clk)
    begin
		if ((start==1'b1))
		begin
			mem[0] <= 32'd0;		
			mem[1] <= 32'd0;
			mem[2] <= 32'd0;
			mem[3] <= 32'd0;
			mem[4] <= 32'd0;
			mem[5] <= 32'd0;
			mem[6] <= 32'd0;
			mem[7] <= 32'd0;
			mem[8] <= 32'd0;
			mem[9] <= 32'd0;
			mem[10] <= 32'd0;
			mem[11] <= 32'd0;
			mem[12] <= 32'd0;
			mem[13] <= 32'd0;
			mem[14] <= 32'd0;
			mem[15] <= 32'd0;
			mem[16] <= 32'd0;
			mem[17] <= 32'd0;
			mem[18] <= 32'd0;
			mem[19] <= 32'd0;
			mem[20] <= 32'd0;
			mem[21] <= 32'd0;
			mem[22] <= 32'd0;
			mem[23] <= 32'd0;
			mem[24] <= 32'd0;
			mem[25] <= 32'd0;
			mem[26] <= 32'd0;
			mem[27] <= 32'd0;
			mem[28] <= 32'd0;
			mem[29] <= 32'd0;
			mem[30] <= 32'd0;
			mem[31] <= 32'd0;
		end
	
		else 
		begin
			mem[0] <= mem[0] + 32'd0;		
			mem[1] <= mem[1] + 32'd0;
			mem[2] <= mem[2] + 32'd0;
			mem[3] <= mem[3] + 32'd0;
			mem[4] <= mem[4] + 32'd0;
			mem[5] <= mem[5] + 32'd0;
			mem[6] <= mem[6] + 32'd0;
			mem[7] <= mem[7] + 32'd0;
			mem[8] <= mem[8] + 32'd0;
			mem[9] <= mem[9] + 32'd0;
			mem[10] <= mem[10] + 32'd0;
			mem[11] <= mem[11] + 32'd0;
			mem[12] <= mem[12] + 32'd0;
			mem[13] <= mem[13] + 32'd0;
			mem[14] <= mem[14] + 32'd0;
			mem[15] <= mem[15] + 32'd0;
			mem[16] <= mem[16] + 32'd0;
			mem[17] <= mem[17] + 32'd0;
			mem[18] <= mem[18] + 32'd0;
			mem[19] <= mem[19] + 32'd0;
			mem[20] <= mem[20] + 32'd0;
			mem[21] <= mem[21] + 32'd0;
			mem[22] <= mem[22] + 32'd0;
			mem[23] <= mem[23] + 32'd0;
			mem[24] <= mem[24] + 32'd0;
			mem[25] <= mem[25] + 32'd0;
			mem[26] <= mem[26] + 32'd0;
			mem[27] <= mem[27] + 32'd0;
			mem[28] <= mem[28] + 32'd0;
			mem[29] <= mem[29] + 32'd0;
			mem[30] <= mem[30] + 32'd0;
			mem[31] <= mem[31] + 32'd0;
		end
        begin
        if (we == 1'b1)
            mem [adr] = din;
        end
    end
    assign dout = mem[adr];
endmodule
