module reg_file #(parameter data_width = 8 ,addr_width = 7  ) (

	input clk,
	input we,
	input [addr_width-1:0] w_addr,r_addr,
	input [data_width-1:0] w_data,
	output [data_width-1:0] r_data

);
reg [data_width-1:0] mem [0:2**addr_width-1];

always @(posedge clk)
begin
	
	if (we)
		mem[w_addr] <= w_data;
end

assign r_data = mem [r_addr];

endmodule 