module regis
	( input clk,
	input rst,
	// write port
	input reg_write_en,
	input [4:0] reg_write_dest,
	input [31:0] reg_write_data,
	//read port 1
	input [4:0] reg_read_addr_1,
	output [31:0] reg_read_data_1,
	//read port 2
	input [4:0] reg_read_addr_2,
	output [31:0] reg_read_data_2
	);
	reg [31:0] reg_array [31:0];
	reg [5:0] k;
	initial begin
		for (k = 0; k <32; k = k + 1) begin
			reg_array[k] = 32'd0;
			end
		end
	assign reg_read_data_1 = ( reg_read_addr_1 == 0)? 32'd0 : reg_array[reg_read_addr_1];
	assign reg_read_data_2 = ( reg_read_addr_2 == 0)? 32'd0 : reg_array[reg_read_addr_2];
	always @ (posedge clk) begin
		if(reg_write_en) begin
			reg_array[reg_write_dest] <= reg_write_data;
			end
		end
endmodule