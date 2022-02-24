`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2022 09:15:16 AM
// Design Name: 
// Module Name: cobaaaaaa
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


module cobaaaaaa(
    input       clk, start, rst,
    input[31:0] ram_out,
    output [31:0]out_ALU, instuk, out1, out2,
    output       ctr
    );
    
    reg[31:0]   wrt, inin, instruk;
    reg         cOrI, wreg_en, ALU_inctr;
    reg[2:0]    state;
    wire[31:0]  reg_out1, reg_out2, ins, in1, out_pc;
    
    program_counter PCTEST
    (
        .clk(clk),
        .pc_in(ram_out),
        .pc_out(out_pc)
    );
    
    instr_mem   INSTRTEST
    (
        .clk(clk),
        .addr(inin),
        .instr(ins)
    );
    
    register REGISTER
    (
        .clk(clk),
        .start(start),
        .wrt_en(wreg_en),
        .rst(rst),
        .a1(instruk[19:15]), 
        .a2(instruk[24:20]), 
        .a3(instruk[11:7]),
        .wrt(write_toreg),
        .rd1(reg_out1),
        .rd2(reg_out2)
    );
    
    mux2_32  ALUIN
    (
        .a({20'd0,ins[31:20]}),
        .b(reg_out1),
        .mux2_ctr(ALU_inctr),
        .out(in1)
    );
    
     ALU_32  ALU1(in1, reg_out2, ins[14:12], ins[30], ins[5], cOrI, out_ALU);
    
    
    assign ctr = wreg_en;
    assign instuk = ins;
    assign out1 = reg_out1;
    assign out2 = reg_out2;
    
    always@(posedge clk)
    begin
        state = out_pc[2:0];
        wrt = wrt + 32'd1;
        begin
            case(state)
            3'b000 : 
                begin
                    cOrI = 1'd0;
                    ALU_inctr = 1'd0;
                    wreg_en = 1'd0;
                end
            3'b001 : 
                begin
                    cOrI = 1'd0;
                    ALU_inctr = 1'd0;
                    wreg_en = 1'd1;
                end
            3'b010 : 
                begin
                    cOrI = 1'd0;
                    ALU_inctr = 1'd1;
                    wreg_en = 1'd0;
                end
            3'b011 : 
                begin
                    cOrI = 1'd0;
                    ALU_inctr = 1'd1;
                    wreg_en = 1'd1;
                end
            3'b100 : 
                begin
                    cOrI = 1'd1;
                    ALU_inctr = 1'd0;
                    wreg_en = 1'd0;
                end
            3'b101 : 
                begin
                    cOrI = 1'd1;
                    ALU_inctr = 1'd0;
                    wreg_en = 1'd1;
                end
            3'b110 : 
                begin
                    cOrI = 1'd1;
                    ALU_inctr = 1'd1;
                    wreg_en = 1'd0;
                end
            3'b111 : 
                begin
                    cOrI = 1'd1;
                    ALU_inctr = 1'd1;
                    wreg_en = 1'd1;
                end
            endcase
        end
    end
    
    always@(*)
    begin
        instruk <= ins;
        inin    <= out_pc;
    end
    
endmodule
