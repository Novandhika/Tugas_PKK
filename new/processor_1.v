`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 11:04:32 PM
// Design Name: 
// Module Name: processor_1
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


module processor_1(
    input clk, rst, start,
    output[31:0]    out1, out2,
    output[31:0]    pc_output, pc_input, ram_input, ram_output,
    output[31:0]    instruction, ALU_OUT,
    output[5:0]     state
    );

    
    wire[31:0]  pc_in, pc_conout, aui_pc;
    wire[31:0]  pc_out, out_jal, ALU_out_SLO, ram_form;
    reg [31:0]  jal_off, pc_ininin;
    reg [31:0]  pc_out1, pc_imm, pc_shift;
    reg [31:0]  LB_val, LH_val, ins_shifted;
    
    reg [7:0]   load_addr, store_addr;
    wire [7:0]   pc_addr, addr;
    wire [31:0]  ram_in;
    wire [31:0]  ins, ram_out, to_ramout;
    
    reg [4:0]   rd1, rd2, wreg;
    reg [31:0]  wr_data, in_ALU;
    wire[31:0]  reg_out1, reg_out2, out_ALU, in1, write_toreg;
    
    reg         Jal_jalr, L_S, addCon, ALU_inctr, wreg_en, ram_en, AUIPC_en, cOrI, PC_ALU;
    reg [1:0]   alurampc, pc_con, RAM_form;
     
    reg [6:0] opcode;
    
    
    
    program_counter PC_COUNT
    (
        .clk(clk),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );
    ram RAM
    (
        .clk(clk),
        .we(we),
        .adr(addr),
        .din(ram_in),
        .dout(ram_out)
    );
    ALU_32  ALU1(in1, reg_out2, ins[14:12], ins[30], ins[5], cOrI, out_ALU);
    
    mux4_32 WHATBLOCK
    (
        .a(ram_form),
        .b(aui_pc),
        .c(out_ALU),
        .d(32'd0),
        .mux4_ctr(alurampc),
        .out(write_toreg)
    );
    
    instr_mem   INSTR_MEM1
    (
        .clk(clk),
        .addr(out_pc),
        .instr(ins)
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
        .a(LB_val),
        .b(LH_val),
        .mux8_ctr(ins[4:0]),
        .out(to_ramout)
    );
    
    mux4_32 RAMFORM
    (
        .a(ins),
        .b({ins[31:12], 12'd0}),
        .c(to_ramout),
        .d(32'd0),
        .mux4_ctr(RAM_form),
        .out(ram_form)
    );
    
    mux4_32 RAMIN
    (
        .a({24'd0,reg_out2[7:0]}),
        .b({16'd0,reg_out2[15:0]}),
        .c(reg_out2),
        .d(32'd0),
        .mux4_ctr(RAM_form),
        .out(ram_form)
    );
    
    mux2_32  JAL_PC
    (
        .a(jal_off),
        .b({out_ALU[31:1], 1'b0}),
        .mux2_ctr(Jal_jalr),
        .out(out_jal)
    );
    
    mux2_32  PC_IMM_1
    (
        .a(pc_out1),
        .b(pc_imm),
        .mux2_ctr(PC_ALU),
        .out(ALU_out_SLO)
    );
    
    mux4_32 PCCON
    (
        .a(pc_out1),
        .b(ALU_out_SLO),
        .c(out_jal),
        .d(32'd0),
        .mux4_ctr(pc_con),
        .out(pc_conout)
    );
    
    mux2_32  AUIPC1
    (
        .a(pc_shift),
        .b(pc_out1),
        .mux2_ctr(AUIPC_en),
        .out(aui_pc)
    );
    
    mux2_32  ALUIN
    (
        .a({20'd0,ins[31:20]}),
        .b(reg_out1),
        .mux2_ctr(ALU_inctr),
        .out(in1)
    );
    
      register REGISTER
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
    
    
    
	// parameters for states
	reg [5:0] S; 
	reg [5:0] NS;
	
	parameter	ST = 6'd0,			// RENUMBER WHEN DONE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
					FETCH1 = 6'd1,
					FETCH2 = 6'd2,
					FETCH3 = 6'd3,
					DONE = 6'd59,
					DECODE = 6'd4,
					
					INT_IMM = 6'd5,
					INT_REG = 6'd6,
					
					JAL = 6'd7,
					JALR = 6'd8,

					LUI = 6'd11,
					AUIPC = 6'd12,
					
					LOADS1 = 6'd13,
					LOADS2 = 6'd14,
					LOADS3 = 6'd15,
					
					STORES = 6'd16,
					
					BRANCHES = 6'd17,
					
					PCUPDATE = 6'd40,
					
					OTHERERROR = 6'd60,
					PCERROR = 6'd61,
					FUNCT3ERROR = 6'd62,
					OPCERROR = 6'd63;
					
	
	
    assign pc_in = pc_ininin;
    assign state = S;
	// sets it to next state
	always @ (posedge clk or negedge rst)
	begin
	   opcode = ins[6:0];
		if (rst == 1'b1)
		begin
			S <= ST;
			pc_ininin <= 32'd0;
		end
		else
		begin
			S <= NS;
			pc_ininin <= pc_conout + pc_out;
		end
	end
	
	
	
	// state changing logic
	always @ (*)
	begin
		case(S)
			ST:
				begin
					if (start == 1'b1)
						NS = FETCH3;//FETCH1;
					else
						NS = ST;
				end
			//FETCH1: NS = FETCH2;
			//FETCH2: NS = FETCH3;
			FETCH3: NS = DECODE;
			DONE: NS = DONE;
			DECODE:
				begin
					case(opcode)
						7'b0010011: NS = INT_IMM;	// integer immediate instructions
						7'b0110011: NS = INT_REG;	// integer register instructions
						
						7'b0110111: NS = LUI;
						7'b0010111: NS = AUIPC;
						
						7'b1101111: NS = JAL;
						
						7'b1100111: NS = JALR;
						
						7'b0000011: NS = LOADS1;
						
						7'b0100011: NS = STORES;
						
						7'b1100011: NS = BRANCHES;
						
						7'd0: NS = DONE;
						default: NS = OPCERROR;
					endcase
				end
				
			INT_IMM: NS = PCUPDATE;
			INT_REG: NS = PCUPDATE;
			
			LUI: NS = PCUPDATE;
			AUIPC: NS = PCUPDATE;
			
			JAL: NS = FETCH3; //1 jadi 3
			JALR: NS = FETCH3;
			
			LOADS1: NS = LOADS2;
			LOADS2: NS = LOADS3;
			LOADS3: NS = PCUPDATE;
			
			STORES: NS = PCUPDATE;
			
			BRANCHES: NS = FETCH3; //1 jadi 3
			
			PCUPDATE: NS = FETCH3;

			OTHERERROR: NS = OTHERERROR;
			PCERROR: NS = PCERROR;
			FUNCT3ERROR: NS = FUNCT3ERROR;
			OPCERROR: NS = OPCERROR;
			default: NS = OTHERERROR;
		endcase
	end
	
	
	// based on state control signals are set combinationally
	always @ (*)
	begin
		case(S)
					ST: 
						begin
							// reset control signals
							ram_en = 1'b0;
							cOrI = 1'b0;
							wreg_en = 1'b0;
							addCon = 1'b1;
							alurampc = 2'd2;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							AUIPC_en = 1'b1;
							L_S = 1'b0;
						end
					FETCH1: 
						begin
							// reset control signals
							ram_en = 1'b0;
							cOrI = 1'b0;
							wreg_en = 1'b0;
							addCon = 1'b1;
							alurampc = 2'd2;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							AUIPC_en = 1'b1;
							L_S = 1'b0;
						end
					FETCH2: 
						begin
							// reset control signals
							ram_en = 1'b0;
							cOrI = 1'b0;
							wreg_en = 1'b0;
							addCon = 1'b1;
							alurampc = 2'd2;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							AUIPC_en = 1'b1;
							L_S = 1'b0;
						end
					FETCH3:
						begin
							// reset control signals
							ram_en = 1'b0;
							cOrI = 1'b0;
							wreg_en = 1'b0;
							addCon = 1'b1;
							alurampc = 2'd2;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							AUIPC_en = 1'b1;
							L_S = 1'b0;
						end
					DECODE:
						begin
							// reset control signals
							ram_en = 1'b0;
							cOrI = 1'b0;
							wreg_en = 1'b0;
							addCon = 1'b1;
							alurampc = 2'd2;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							AUIPC_en = 1'b1;
							L_S = 1'b0;
						end
					
					INT_IMM:
						begin
							cOrI = 1'b0;	// we want int operations
							ALU_inctr = 1'b0;	// we are using an immediate
							alurampc = 2'd2; 	// want regfile to write data from ALU not RAM
							wreg_en = 1'b1;	// enable writing to register
							pc_con = 2'd0;
							
							ram_en = 1'b0;
							addCon = 1'b1;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							AUIPC_en = 1'b1;
							L_S = 1'b0;
						end
					INT_REG:
						begin
							cOrI = 1'b0;
							ALU_inctr = 1'b1;
							alurampc = 2'd2;
							wreg_en = 1'b1;
							pc_con = 2'd0;
							
							ram_en = 1'b0;
							addCon = 1'b1;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							AUIPC_en = 1'b1;
							L_S = 1'b0;
						end
						
					JAL:
						begin
							wreg_en = 1'b1;
							alurampc = 2'd1;	// writes PC+1 to register
							AUIPC_en = 1'b1;
							
							Jal_jalr = 1'b0;
							pc_con = 2'd2;
							
							ram_en = 1'b0;
							cOrI = 1'b0;
							addCon = 1'b1;
							ALU_inctr = 1'b0;
							RAM_form = 2'd0;
							L_S = 1'b0;
						end
					JALR:
						begin
							wreg_en = 1'b1;
							alurampc = 2'd1;	// writes PC+1 to register
							AUIPC_en = 1'b1;
							
							Jal_jalr = 1'b1;
							cOrI = 1'b0;	// allows for adding of register and imm. in the ALU
							pc_con = 2'd2;
							
							ram_en = 1'b0;
							addCon = 1'b1;
							ALU_inctr = 1'b0;
							RAM_form = 2'd0;
							L_S = 1'b0;
						end
						
					LUI:
						begin
							wreg_en = 1'b1;
							alurampc = 2'd0; // writeReg already set to bits 11 to 7
							RAM_form = 2'd1;
							
							ram_en = 1'b0;
							cOrI = 1'b0;
							addCon = 1'b1;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							AUIPC_en = 1'b1;
							L_S = 1'b0;
						end
					AUIPC:
						begin
							wreg_en = 1'b1;
							AUIPC_en = 1'b0;
							alurampc = 2'd1; // writeReg already set to bits 11 to 7
							
							ram_en = 1'b0;
							cOrI = 1'b0;
							addCon = 1'b1;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							L_S = 1'b0;
						end
						
					LOADS1:
						begin
							L_S = 1'b1;
							addCon = 1'b0;
							alurampc = 2'd0;
							RAM_form = 2'd2;
							wreg_en = 1'b1;
							
							ram_en = 1'b0;
							cOrI = 1'b0;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							AUIPC_en = 1'b1;
						end
					LOADS2:
						begin
							L_S = 1'b1;
							addCon = 1'b0;
							alurampc = 2'd0;
							RAM_form = 2'd2;
							wreg_en = 1'b1;
							
							ram_en = 1'b0;
							cOrI = 1'b0;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							AUIPC_en = 1'b1;
						end
					LOADS3:
						begin
							L_S = 1'b1;
							addCon = 1'b0;
							alurampc = 2'd0;
							RAM_form = 2'd2;
							wreg_en = 1'b1;
							
							ram_en = 1'b0;
							cOrI = 1'b0;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							AUIPC_en = 1'b1;
						end
						
					STORES:
						begin
							wreg_en = 1'b0;
							ram_en = 1'b1;
							L_S = 1'b0;
							addCon = 1'b0;
							
							cOrI = 1'b0;
							alurampc = 2'd2;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							AUIPC_en = 1'b1;
						end
						
					BRANCHES:
						begin
							cOrI = 1'b1;
							pc_con = 2'd1;
							ALU_inctr = 1'b1;
							
							ram_en = 1'b0;
							wreg_en = 1'b0;
							addCon = 1'b1;
							alurampc = 2'd2;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							AUIPC_en = 1'b1;
							L_S = 1'b0;
						end
					
					PCUPDATE:
						begin
							ram_en = 1'b0;
							cOrI = 1'b0;
							wreg_en = 1'b0;
							addCon = 1'b1;
							alurampc = 2'd2;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							AUIPC_en = 1'b1;
							L_S = 1'b0;
						end
					
					DONE:
						begin
							ram_en = 1'b0;
							cOrI = 1'b0;
							wreg_en = 1'b0;
							addCon = 1'b1;
							alurampc = 2'd2;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							AUIPC_en = 1'b1;
							L_S = 1'b0;
						end
						
					default:
						begin
							// reset control signals
							ram_en = 1'b0;
							cOrI = 1'b0;
							wreg_en = 1'b0;
							addCon = 1'b1;
							alurampc = 2'd2;
							ALU_inctr = 1'b0;
							pc_con = 2'd0;
							Jal_jalr = 1'b0;
							RAM_form = 2'd0;
							AUIPC_en = 1'b1;
							L_S = 1'b0;
						end
				
		endcase
	end
	
    always@(*)
    begin
        jal_off = {{12{ins[31]}}, ins[19:12], ins[20], ins[30:21], 1'b0};
        pc_shift= pc_out + {ins[31:12], 12'd0};
        pc_imm  = {{20{ins[31]}}, ins[7], ins[30:25], ins[11:8], 1'b0};
		pc_out1 = 32'd1;
		LB_val = {{24{ram_out[7]}}, ram_out[7:0]};
		LH_val = {{16{ram_out[15]}}, ram_out[15:0]};
	   begin
			if (out_ALU == 32'd1)
				PC_ALU = 1'd1;
		    else
		        PC_ALU = 1'd0;
		end
    end
    
    assign out1 = reg_out1;
    assign out2 = reg_out2;
    assign pc_output = pc_out;
    assign pc_input = pc_in;
    assign ram_input = ram_in;
    assign ram_output= ram_out;
    
    assign instruction = ins;
    assign ALU_OUT = out_ALU;
    
    
endmodule
