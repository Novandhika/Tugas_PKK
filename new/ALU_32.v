`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 08:49:13 PM
// Design Name: 
// Module Name: ALU_32
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


module ALU_32(in1, b, funct3, upperBit, lowerBit, cOrI, out1);
	input signed [31:0] in1, b;	// in1/a will be the imm value or the value at rs2 or shamt
								// in2/b will be the rs1 value
								// remember that no matter what (except for shamt), both 32 bits have
								// been sign extended and are signed
								
	reg [31:0] a;
		
	
	input [2:0] funct3;	// this is the funct3 in the risc manual
	input upperBit;	// this is the upper control bit in the funct7 spot to differentiate
							// between ADD/SUB and and the different kinds of right shifts 
							// (bit 30 of total 32 bits)
							
	input lowerBit;	// this is another control bit (bit 5), it is part of the opcode and
							// differentiates between immediate and register operations
							// this bit only really decides whether or not the upperBit will
							// change anything, as the upperBit does nothing for when you have ADDI
							// as opposed to ADD
							
	input cOrI;	// this is to decide if the integer instructions or conditionals 
					// for branch instructions are to be executed
	output[31:0] out1;						
	reg [31:0] out;
	
	reg  [4:0] shamt;
	reg  [31:0] aUns;
	reg  [31:0] bUns;
	
	// sign extends the immediate value (when lowerBit == 1'b0)
	wire signed [31:0] aImm = {in1[11], in1[11], in1[11], in1[11], in1[11], in1[11], 
		in1[11], in1[11], in1[11], in1[11], in1[11], in1[11], in1[11], in1[11], in1[11],
		in1[11], in1[11], in1[11], in1[11], in1[11], in1[11:0]};
	
	assign out1 = out;
	
	always @ (*)
		case(cOrI)
			1'b0:	// INTEGER INSTRUCTIONS
				begin
					if (lowerBit == 1'b0)
						a = aImm;
					else
						a = in1;
				
					// this is so aImm can be sign extended and then treated as unsigned
					shamt = a[4:0];
					aUns = a[31:0];
					bUns = b[31:0];
					
					case(funct3)
						3'b000:					// ADD/ADDI/SUB
							begin
								case(lowerBit)
									1'b0: out = a + b;	// ADDI
									1'b1:
										begin
										case(upperBit)
											1'b0:	out = a + b;	// ADD
											1'b1: out = b - a;	// SUB, not sure which way subtraction should be
										endcase
										end
								endcase			
							end		
						3'b001: out = b << shamt;	// SLL/SLLI; the same operation but shamt is either 
															// shamt or the value in rs2
						3'b010:					// SLT/SLTI
							begin
								if (b[31] == a[31] && a[31] == 1'b0)
								begin
									if (b < a)
										out = 32'd1;
									else 
										out = 32'd0;
								end
								else if (b[31] == 1'b1 && a[31] == 1'b0)
									out = 32'd1;
								else if (a[31] == 1'b1 && b[31] == 1'b0)
									out = 32'd0;
								else if (b[31] == a[31] && a[31] == 1'b1)
								begin
									if (b[30:0] < a[30:0])
										out = 32'd1;
									else 
										out = 32'd0;
								end
								else
										out = 32'd0;
							end
						3'b011: 					// SLTIU/SLTU
							begin
								if (bUns < aUns)
									out = 32'd1;
								else 
									out = 32'd0;
							end
						3'b100: out = a ^ b;	// XOR/XORI
						3'b101: 		// SR--; the same operation but shamt is either 
										// shamt or the value in rs2
							case(upperBit)
								1'b0: out = b >> shamt;		// SRL/I
								1'b1: out = b >>> shamt;	// SRA/I
							endcase
						3'b110: out = b | a;	// OR/I
						3'b111: out = b & a;	// AND/I
					endcase
				end
			1'b1:	// CONDITIONALS FOR BRANCH INSTRUCTIONS, 1 for true, 0 for false
				begin
					a = in1;
					
					// this is so aImm can be sign extended and then treated as unsigned
					shamt = a[4:0];
					aUns = a[31:0];
					bUns = b[31:0];
				
					case(funct3)
						3'b000:
							begin
								if (b == a)
									out = 32'd1;
								else 
									out = 32'd0;
							end
						3'b001:
							begin
								if (b != a)
									out = 32'd1;
								else 
									out = 32'd0;
							end
						3'b100:
							begin
								if (b[31] == a[31] && a[31] == 1'b0)
								begin
									if (b < a)
										out = 32'd1;
									else 
										out = 32'd0;
								end
								else if (b[31] == 1'b1 && a[31] == 1'b0)
									out = 32'd1;
								else if (a[31] == 1'b1 && b[31] == 1'b0)
									out = 32'd0;
								else if (b[31] == a[31] && a[31] == 1'b1)
								begin
									if (b[30:0] < a[30:0])
										out = 32'd1;
									else 
										out = 32'd0;
								end
								else
										out = 32'd0;
							end
						3'b101:
							begin
								if (b[31] == a[31] && a[31] == 1'b0)
								begin
									if (b >= a)
										out = 32'd1;
									else 
										out = 32'd0;
								end
								else if (b[31] == 1'b1 && a[31] == 1'b0)
									out = 32'd0;
								else if (a[31] == 1'b1 && b[31] == 1'b0)
									out = 32'd1;
								else if (b[31] == a[31] && a[31] == 1'b1)
								begin
									if (b[30:0] >= a[30:0])
										out = 32'd1;
									else 
										out = 32'd0;
								end
								else
										out = 32'd0;
							end
						3'b110:
							begin
								if (bUns < aUns)
									out = 32'd1;
								else 
									out = 32'd0;
							end
						3'b111:
							begin
								if (bUns >= aUns)
									out = 32'd1;
								else 
									out = 32'd0;
							end
							
						default: out = 32'd0;
					endcase
				end
		endcase
	
endmodule

