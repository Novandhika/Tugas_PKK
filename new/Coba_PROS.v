`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2022 12:23:32 AM
// Design Name: 
// Module Name: Coba_PROS
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


module Coba_PROS(
    input           clk, rst, start,
    input[31:0]     data,
    output[31:0]    PC_out, instuk, out,
    output[14:0]    Kontrol
    );
    
    wire[31:0]  pc_in; //Variabel PC dan regfile
    wire[31:0]  pc_out;
    reg         pcin_en;//Variabel Regfile
    
    reg         jal;    //Variabel JAL
    reg[31:0]   ALU_out_shift;
    wire[31:0]  out_jal;
    
    reg         imm;    // Variabel IMM PC
    reg[31:0]   imm_in;
    wire[31:0]  imm_out;
    
    reg[1:0]         to_in;  //Variabel PCCON
    wire[31:0]  in_PC;
    
    wire[31:0]   write_toreg;
    //wire[31:0]  in_PC;
    reg[31:0]   wrt, inin, instruk;
    reg         cOrI, wreg_en, ALU_inctr;
    wire[31:0]  reg_out1, reg_out2, ins, in1, out_ALU;  //VAriabel Coba
    
    wire[31:0]  ram_out; //Variabel RAM
    reg [7:0]   load_addr, store_addr;
    wire [7:0]   pc_addr, addr;
    wire [31:0]  ram_in;
    wire [31:0]  to_ramout;
    wire [31:0] form_ram;
    reg [1:0]   RAM_form, alurampc;
    reg         we;
    
    reg       AUIPC_en; //Variabel AUIPC
    reg[31:0]   pc_shift;
    reg[31:0]   pc_out1;
    wire [31:0]  aui_pc; 
    
    reg         addCon, L_S;//Variabel kontrol address ram
    wire [3:0]  state;
    reg [3:0]   next_state = 4'd0;
    reg [14:0]  control;
    
    program_counter PCTESTCOBA //Program Counter
    (
        .clk(clk),
        .rst(rst),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );
    
    mux2_32  JAL_PC //JAL/JALR
    (
        .a(32'd16),
        .b(ALU_out_shift),
        .mux2_ctr(jal),
        .out(out_jal)
    );
    
    mux2_32  PC_IMM_1 //+1 or IMM
    (
        .a(32'd1),
        .b({{20{ins[32]}}, ins[7], ins[30:25], ins[11:8], 1'd0}),//imm_in),
        .mux2_ctr(imm),
        .out(out_imm)
    );
    
    mux4_32 PCCON //+1 or IMM or JAL
    (
        .a(pc_out + 32'd1),
        .b(pc_out + out_imm),
        .c(pc_out + out_jal),
        .d(32'd0),
        .mux4_ctr(to_in),
        .out(in_PC)
    );
    
    regfile     REGFILE //Regfile di depan PC
    (
        .clk(clk),
        .rst(rst),
        .en(pcin_en),
        .data_in(in_PC),
        .data_out(pc_in)
    );
    
    instr_mem INSTRUCTION_MEMORY //INSMEM setelah PC
    (
        .clk(clk),
        .addr(pc_out),
        .instr(ins)
    );
    
    register REGISTER       //Register setelah INSMEM
    (
        .clk(clk),
        .start(start),
        .wrt_en(wreg_en),
        .rst(rst),
        .a1(ins[19:15]), 
        .a2(ins[24:20]), 
        .a3(ins[11:7]),
        .wrt(write_toreg),
        .rd1(reg_out1),
        .rd2(reg_out2)
    );
    
    mux2_32  ALUIN          // ALUIN sebelum ALU milih reg_out1 or Immediate
    (
        .a({20'd0,ins[31:20]}),
        .b(reg_out1),
        .mux2_ctr(ALU_inctr),
        .out(in1)
    );
    
    ALU_32  ALU1(in1, reg_out2, ins[14:12], ins[30], ins[5], cOrI, out_ALU);
    
    mux2_32  AUIPC1
    (
        .a(pc_shift),
        .b(pc_out1),
        .mux2_ctr(AUIPC_en),
        .out(aui_pc)
    );
    
    mux4_32 RAMIN
    (
        .a({24'd0,reg_out2[7:0]}),
        .b({16'd0,reg_out2[15:0]}),
        .c(reg_out2),
        .d(32'd0),
        .mux4_ctr(ins[14:12]),
        .out(ram_in)
    );
    
    mux2_8  load_save
    (
        .a(load_addr),
        .b(store_addr),
        .mux2_ctr(L_S),
        .out(pc_addr)
    );
    
    mux2_8  RAM_ADDRESS
    (
        .a(pc_addr),
        .b(pc_out[7:0]),
        .mux2_ctr(addCon),
        .out(addr)
    );
    
    mux8_32 MUXRAMFORM
    (
        .d({24'd0, ram_out[7:0]}),
        .e({16'd0, ram_out[15:0]}),
        .c(ram_out),
        .a({{24{ram_out[7]}}, ram_out[7:0]}),
        .b({{16{ram_out[15]}}, ram_out[15:0]}),
        .mux8_ctr(ins[14:12]),
        .out(to_ramout)
    );
    
    mux4_32 RAMFORM
    (
        .a(ins),
        .b({ins[31:12], 12'd0}),
        .c(to_ramout),
        .d(32'd0),
        .mux4_ctr(RAM_form),
        .out(form_ram)
    );
    
    ram RAM
    (
        .clk(clk),
        .we(we),
        .adr(addr),
        .din(ram_in),
        .dout(ram_out)
    );
    
    mux4_32 WHATBLOCK
    (
        .a(form_ram),
        .b(aui_pc),
        .c(out_ALU),
        .d(32'd0),
        .mux4_ctr(alurampc),
        .out(write_toreg)
    );
    
    always@(posedge clk or negedge rst)
    begin
        case(state)
        4'd0    :       //Start
            begin
                if (start==1'd1)
                    next_state = 4'd1;
                else
                    next_state = 4'd0;
            end
        4'd1    :       //Fetch
            begin
                control <= 15'b0_0_0_1_10_0_00_0_00_1_0_1;
                next_state = 4'd2;
            end
        4'd2    :       //Decode
            begin
                control <= 15'b0_0_0_1_10_0_00_0_00_1_0_0;
                case(ins[6:0]) 
                    7'b0010011 : next_state = 4'd3;//NS = INT_IMM;	// integer immediate instructions
				    7'b0110011 : next_state = 4'd4;//NS = INT_REG;	// integer register instructions
					7'b0110111 : next_state = 4'd7;//NS = LUI;
					7'b0010111 : next_state = 4'd8;//NS = AUIPC;
					7'b1101111 : next_state = 4'd5;//NS = JAL;
					7'b1100111 : next_state = 4'd6;//NS = JALR;
					7'b0000011 : next_state = 4'd9;//NS = LOADS1;
					7'b0100011 : next_state = 4'd10;//NS = STORES;
					7'b1100011 : next_state = 4'd11;//NS = BRANCHES;
					default    : next_state = 4'd2;
                endcase
            end
        4'd3    :       //INT_IMM
            begin
                control <= 15'b0_0_1_1_10_0_00_0_00_1_0_0;
                next_state = 4'd12;
            end
        4'd4    :       //INT_REG
            begin
                control <= 15'b0_0_1_1_10_1_00_0_00_1_0_0;
                next_state = 4'd12;
            end
        4'd5    :       //JAL
            begin
                control <= 15'b0_0_1_1_01_0_10_0_00_1_0_0;
                next_state = 4'd1;
            end
        4'd6    :       //JALR
            begin
                control <= 15'b0_0_1_1_01_0_00_1_00_1_0_0;
                next_state = 4'd1;
            end
        4'd7    :       //LUI
            begin
                control <= 15'b0_0_1_1_00_0_00_0_01_1_0_0;
                next_state = 4'd12;
            end
        4'd8    :       //AUIPC
            begin
                control <= 15'b0_0_1_1_01_0_00_0_00_0_0_0;
                next_state = 4'd12;
            end
        4'd9    :       //Load
            begin
                control <= 15'b0_0_1_0_00_0_00_0_10_1_1_0;
                next_state = 4'd12;
            end
        4'd10   :       //Store
            begin
                control <= 15'b1_0_0_0_10_0_00_0_00_1_0_0;
                next_state = 4'd12;
            end
        4'd11   :       //Branch
            begin
                control <= 15'b0_1_0_1_10_1_01_0_00_1_0_0;
                next_state = 4'd1;
            end
        4'd12   :       //PC update
            begin
                control <= 15'b0_0_0_1_10_0_00_0_00_1_0_1;
                next_state = 4'd2;
            end
        default    :       //Default Error
            begin
                control <= 15'b0_0_0_1_10_0_00_0_00_1_0_0;
                next_state = 4'd2;
            end
        
        endcase
    end
    
    always@(*)
    begin
        pcin_en     <= control[0];
        jal         <= control[5];
        imm         <= out_ALU[0];
        to_in       <= control[7:6];
        cOrI        <= control[13];
        wreg_en     <= control[12];
        ALU_inctr   <= control[8];
        RAM_form    <= control[4:3];
        alurampc    <= control[10:9];
        AUIPC_en    <= control[2];
        addCon      <= control[11];
        L_S         <= control[1];
        we          <= control[14];
    end
    
    
    
    //assign ctr = wreg_en;
    assign instuk = ins;
    assign PC_out = pc_out;
    assign Kontrol = control;
    assign state = next_state;
    assign out = out_ALU;
    
    
    
endmodule
