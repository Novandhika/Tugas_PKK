`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2022 11:25:39 PM
// Design Name: 
// Module Name: Multi_RAM
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


module Multi_RAM(
    input   clk,
    input   en1, en2,
    input   start,
    input[7:0] addr1, addr2,
    input[31:0] din1, din2,
    output[31:0] dout1, dout2);
    
    reg [1:0]   enable;
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
            enable <= {en1,en2};
            case(enable)
            2'd1 :
                begin
                    mem [addr2] <= din2;
                end
            2'd2 :
                begin
                    mem [addr1] <= din1;
                end
            2'd3 :
                begin
                    mem [addr1] <= din1;
                    mem [addr2] <= din2;
                end
            endcase
        end
    end
    assign dout1 = mem[addr1];
    assign dout2 = mem[addr2];
endmodule
