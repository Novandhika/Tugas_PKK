`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2022 11:04:35 PM
// Design Name: 
// Module Name: coba_pc
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


module coba_pc(
    input       clk,  rst,
    input[31:0] ALU_out, ins,
    output [31:0] out_PC, IN_PC,
    output [2:0] out_state
    );
    
    reg[31:0]   PC_in, inin, instruk, imm_in;
    reg         jal, imm;
    reg[1:0]    to_in;
    reg[2:0]    state;
    wire[31:0]  out_pc, in_PC, out_jal, out_imm;
    
    program_counter PCTEST
                  (
                   .clk(clk),
                   .pc_in(PC_in),
                   .pc_out(out_pc)
                  );
    
    
    mux2_32  JAL_PC
    (
        .a(32'd16),
        .b(ALU_out),
        .mux2_ctr(jal),
        .out(out_jal)
    );
    
    mux2_32  PC_IMM_1
    (
        .a(out_pc + 32'd1),
        .b(imm_in),
        .mux2_ctr(imm),
        .out(out_imm)
    );
    
    mux4_32 PCCON
    (
        .a(out_pc + 32'd1),
        .b(out_imm),
        .c(out_jal),
        .d(32'd0),
        .mux4_ctr(to_in),
        .out(in_PC)
    );
    
    assign instuk = ins;
    assign out_PC = out_pc;
    assign IN_PC = in_PC;
    assign out_state = state;
    
    always@(posedge clk)
    begin
        state = ins[2:0];
        PC_in = in_PC;
        begin
            case(state)
            3'b000 : 
                begin
                    to_in = 2'd0;
                    jal = 1'd0;
                    imm = 1'd0;
                end
            3'b001 : 
                begin
                    to_in = 2'd0;
                    jal = 1'd0;
                    imm = 1'd1;
                end
            3'b010 : 
                begin
                    to_in = 2'd0;
                    jal = 1'd1;
                    imm = 1'd0;
                end
            3'b011 : 
                begin
                    to_in = 2'd0;
                    jal = 1'd1;
                    imm = 1'd1;
                end
            3'b100 : 
                begin
                    to_in = 2'd1;
                    jal = 1'd0;
                    imm = 1'd0;
                end
            3'b101 : 
                begin
                    to_in = 2'd1;
                    jal = 1'd0;
                    imm = 1'd1;
                end
            3'b110 : 
                begin
                    to_in = 2'd1;
                    jal = 1'd1;
                    imm = 1'd0;
                end
            3'b111 : 
                begin
                    to_in = 2'd1;
                    jal = 1'd1;
                    imm = 1'd1;
                end
            endcase
        end
    end
    
    always@(*)
    begin
        imm_in <= 32'd6;
        
        case (rst)
        1'd0 :
        begin
            PC_in <= in_PC;
        end
        1'd1 :
        begin
            PC_in = 32'd0;
        end
        endcase
    end
    

endmodule
