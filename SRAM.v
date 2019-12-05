module SRAM(Din, Dout, Address, WR_en, clk);
	input [4:0] Address;
	input[31:0] Din;
	input WR_en;
	input clk;
	output[31:0] Dout;
	wire[31:0] i, C;
	Decoder32 decoder1(Address,clk,i); //decoder(in,clk,out)
	genvar q;
	for(q = 0; q < 32; q = q + 1)
	begin
		assign C[q] = i[q] & WR_en;
	end
	genvar p,n;
	generate
		for(p = 0; p<32; p = p+1) //Branch
		begin
			for(n = 0; n<32; n= n+1) //dbus
			begin
				Dlatch L(Din[n],i[p],C[p],Dout[n]); //Dlatch(D,C,enable,Q)
			end
		end
	endgenerate
endmodule
module Decoder32(in,clk,out);
	input[4:0] in;
	input clk;
	output[31:0] out;
	reg[31:0] out;
	integer i;
	always @(posedge clk)
	for (i = 0; i<32; i = i+1)
		out[i] = (in == i);
	endmodule
module Dlatch(D,C,enable,Q);
	input D,C,enable;
	output Q;
	reg Q,S;
	always @(C or enable)
	begin
		if (C & enable)
		begin
			S <= D;
			Q <= 1'bz;
		end
		else if (C & ~enable)
			Q <= S;
		else
			Q <= 1'bz;
	end
endmodule