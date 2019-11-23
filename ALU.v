module alu(
	input clk, reset,
	input [31:0] a, //src1
	input [31:0] b, //src2
	input [3:0] alu_control, //function sel
	output reg [31:0] result, //result
	output reg zero
);

always @(*)
	begin
		case(alu_control)
		4'b1010: result = a + b; // add
		4'b1110: result = a - b; // sub
		4'b0000: result = a & b; // and
		4'b0001: result = a | b; // or
		4'b0011: result =~(a|b); // nor
		//4'b1110: result = result; // bne or beq
		4'b0101: begin if (a<b) result = 32'd1;
			else result = 32'd0;
			end
		default: result = 0; // add
		endcase
		zero = (result==32'd0) ? 1'b1: 1'b0;
	end
endmodule
