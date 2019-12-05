module ALUcontrol(clk,reset,instruction1,ALUop,ALUCon);
	input [5:0] instruction1;
	input [1:0]ALUop;
	input reset, clk;
	output reg [3:0] ALUCon;
	wire [7:0] ALUControlIn;
	assign ALUControlIn = {ALUop,instruction1};
	always@(ALUControlIn)
	begin
		if(reset)
		begin
			ALUCon=0;
		end
		else begin
			casex(ALUControlIn)
				8'b00100000: ALUCon=4'b1010;//ADD
				8'b00100010: ALUCon=4'b1110;//SUB
				8'b00100100: ALUCon=4'b0000;//AND
				8'b00100101: ALUCon=4'b0001;//OR
				8'b00101010: ALUCon=4'b0101;//SLT
				8'b00101111: ALUCon=4'b0011;//NOR
				8'b01xxxxxx: ALUCon=4'b1110;//BEQ & BNE
				8'b10xxxxxx: ALUCon=4'b1010;//lw sw jmp addi
				default: ALUCon=4'b1010;
			endcase
		end
	end
endmodule