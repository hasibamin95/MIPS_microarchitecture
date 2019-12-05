module control(clk,reset,instruction,RegDst,Branch,Jump,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite,BT);
	input clk,reset;
	input [5:0] instruction;
	output reg RegDst,Branch,BT,MemRead,Jump,MemtoReg,MemWrite,ALUSrc,RegWrite;
	output reg [1:0] ALUOp;
	always@(*)
	begin
		if(reset == 1'b1) begin
			RegDst=0;
			Branch=0;
			Jump=0;
			BT=0;
			MemRead=0;
			MemtoReg=0;
			ALUOp=0;
			MemWrite=0;
			ALUSrc=0;
			RegWrite=0;
		end
		else begin
			case(instruction)
				6'b000000:begin//instruction for R-format instruction opcode 000000
					RegDst=1;
					Branch=0;
					Jump=0;
					BT=0;
					MemRead=0;
					MemtoReg=0;
					ALUOp=2'b00;
					MemWrite=0;
					ALUSrc=0;
					RegWrite=1;
				end
				6'b000100:begin//instruction for Beq
					RegDst=0;
					Branch=1;
					Jump=0;
					BT=0;
					MemRead=0;
					MemtoReg=0;
					ALUOp=2'b01;
					MemWrite=0;
					ALUSrc=0;
					RegWrite=0;
				end
				6'b000110:begin//instruction for Bne
					RegDst=0;
					Branch=1;
					Jump=0;
					BT=1;
					MemRead=0;
					MemtoReg=0;
					ALUOp=2'b01;
					MemWrite=0;
					ALUSrc=0;
					RegWrite=0;
				end
				6'b100011:begin//instruction for lw
					RegDst=0;
					Branch=0;
					Jump=0;
					BT=0;
					MemRead=1;
					MemtoReg=1;
					ALUOp=2'b10;
					MemWrite=0;
					ALUSrc=1;
					RegWrite=1;
				end
				6'b101011:begin//instruction for sw
					RegDst=0;
					Branch=0;
					Jump=0;
					BT=0;
					MemRead=0;
					MemtoReg=0;
					ALUOp=2'b10;
					MemWrite=1;
					ALUSrc=1;
					RegWrite=0;
				end
				6'b100110:begin//instruction for
					jump
					RegDst=0;
					Branch=0;
					Jump=1;
					BT=0;
					MemRead=0;
					MemtoReg=0;
					ALUOp=2'b10;
					MemWrite=0;
					ALUSrc=0;
					RegWrite=0;
				end
				6'b101000:begin//instruction for addi
					RegDst=0;
					Branch=0;
					Jump=0;
					BT=0;
					MemRead=0;
					MemtoReg=0;
					ALUOp=2'b10;
					MemWrite=0;
					ALUSrc=1;
					RegWrite=1;
				end
				default :
				begin
					RegDst=0;
					Branch=0;
					Jump=0;
					MemRead=0;
					MemtoReg=0;
					ALUOp=0;
					MemWrite=0;
					ALUSrc=0;
					RegWrite=0;
				end
			endcase
		end
	end
endmodule