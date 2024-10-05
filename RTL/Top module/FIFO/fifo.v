module fifo #(parameter data_width = 8 ,addr_width = 7  ) (

	input clk,reset,
	input wr,rd,
	input [data_width-1:0] w_data,
	output [data_width-1:0] r_data,
	output full,empty

);

wire [addr_width -1 :0] w_address,r_address;

fifo_ctrl #(.addr_width (addr_width)) ctrl (

	.clk(clk),.reset(reset),
	.wr(wr),.rd(rd),
	.full(full),.empty(empty),
	.w_addr(w_address),.r_addr(r_address)

);
reg_file #(.data_width(data_width) ,.addr_width (addr_width)  ) my_reg (

	.clk(clk),
	.we(wr&~full),
	.w_addr(w_address),.r_addr(r_address),
	.w_data(w_data),.r_data(r_data) 

);
endmodule