module MIPS(reset, clk, O);
	input reset, clk;
	output [31:0] O;
	wire [31:0] pcIn, pcIn0, pcOut, ins, a0, a1, shftO, Wr_data, dt1, dt2, dt3, sign_ext, alu_a, slt2O, alu_b, result, mx3O, read_dt;
	wire [27:0] sh1O;
	wire [4:0] Wr_reg, rd_dt1, rd_dt2;
	wire [3:0] ALUcontrol;
	wire RegDst, Brnch, jmp, MR, M2R, MW, ASrc, RegWr, BT, br, zero, band;
	wire [1:0] AOp;
	reg [31:0] four = 4;
	pc PC(pcIn, pcOut, clk);
	INSTR I(pcOut, ins);
	SRAM s(dt2, read_dt,result[4:0], MW, clk); //SRAM(Din, Dout, Address, WR_en, clk);
	ALUcontrol ac(clk,reset,ins[5:0],AOp,ALUcontrol);
	control c(clk, reset, ins[31:26], RegDst, Brnch,jmp,MR, M2R, AOp, MW, ASrc, RegWr, BT);
	//control(clk,reset,instruction,RegDst,Branch,Jump,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite,BT);
	alu a(clk, reset, alu_a, alu_b, ALUcontrol, result, zero);
	//regi r(clk, reset, RegWr, Wr_reg, Wr_data, ins[25:21], dt1, ins[20:16], dt2);(
	//input clk,//input rst,reg_write_en,reg_write_dest,reg_write_data,reg_read_addr_1,reg_read_data_1,reg_read_addr_2,reg_read_data_2)
	assign rd_dt1 = ins[25:21];
	assign rd_dt2 = ins[20:16];
	//regi r(rd_dt1, rd_dt2,Wr_reg, Wr_data, RegWr, dt1, dt2, clk);
	//regi(Read1,Read2,WriteReg,WriteData,RegWrite,Data1,Data2,Data3,clk);
	regis r(clk,reset,RegWr,Wr_reg,Wr_data,rd_dt1,dt1,rd_dt2,dt2);
	assign alu_a = dt1;
	//if(reset) assign pcIn = 4;
	adder adder0(pcOut,four, a0); // Next Address
	adder adder1(a0, slt2O, a1); // Address for Branching
	shlft28 sh1(ins[27:0], sh1O); //Multiplying JMP address by 4
	mux5 mx0(ins[20:16],ins[15:11],Wr_reg, RegDst); //Instruction memory 2 register mux
	shlft sh2(sign_ext, slt2O); // Multiplying Branch address by 4
	sgnext signExt(ins[15:0], sign_ext); // coverting 16bit address 2 32 bit
	mux32 mx1(dt2, sign_ext, alu_b, ASrc); // Immidiate calculation [alu_b]
	mux32 mx2(result, read_dt, Wr_data, M2R); // Load data path
	mux1 mx6(zero, ~zero, br ,BT); // BNE BE function
	and2 and2and(br, BT, band);
	mux32 mx3(a0, a1, mx3O, band); // branching function
	mux32 mx4(mx3O,{a0[31:28],sh1O},pcIn0, jmp); // Jump address Mux
	mux32 mx5(pcIn0, four, pcIn, reset); // Reset operation
	assign O = result;
endmodule