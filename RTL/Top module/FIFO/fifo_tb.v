`timescale 1ns / 1ps

module fifo_tb (
);

localparam data_width = 8;
localparam addr_width = 3;

reg clk,reset_n,wr,rd;
reg [data_width-1:0] w_data;
wire [data_width-1:0] r_data;
wire full,empty;


fifo #(.data_width(data_width) ,.addr_width (addr_width)  ) uut(

	.clk(clk),.reset_n(reset_n),
	.wr(wr),.rd(rd),
	.full(full),.empty(empty),
	.w_data(w_data),.r_data(r_data) 


);

localparam T=10;
always 
begin
	clk = 1'b0;
	#(T/2); 
	clk = 1'b1;
	#(T/2) ;
end



initial 
begin
	reset_n = 1'b1;
	wr=1'b0;
	rd=1'b0;
	@ (negedge clk)
		reset_n = 1'b0;
end

initial
begin
@(negedge clk);

        w_data = 8'd5;
        wr = 1'b1;     
        @(negedge clk);
        wr = 1'b0;
        
        // write
        repeat(1) @(negedge clk);
        w_data = 8'd8;
        wr = 1'b1;
        @(negedge clk)
        wr = 1'b0;
        
        // write
        repeat(1) @(negedge clk);
        w_data = 8'd2;
        wr = 1'b1;
        @(negedge clk)
        wr = 1'b0;        
        
        // read
        repeat(1) @(negedge clk);
        rd = 1'b1;
        @(negedge clk)
        rd = 1'b0;        
        
        // write
        repeat(1) @(negedge clk);
        w_data = 8'd0;
        wr = 1'b1;
        @(negedge clk)
        wr = 1'b0;        
        
        // write
        repeat(1) @(negedge clk);
        w_data = 8'd9;
        wr = 1'b1;
        @(negedge clk)
        wr = 1'b0;        
        
        // write
        repeat(1) @(negedge clk);
        w_data = 8'd3;
        wr = 1'b1;
        @(negedge clk)
        wr = 1'b0;        
        
        // write
        repeat(1) @(negedge clk);
        w_data = 8'd6;
        wr = 1'b1;
        @(negedge clk)
        wr = 1'b0;        
        
        // write
        repeat(1) @(negedge clk);
        w_data = 8'd1;
        wr = 1'b1;
        @(negedge clk)
        wr = 1'b0;        
        
        // write
        repeat(1) @(negedge clk);
        w_data = 8'd3;
        wr = 1'b1;
        @(negedge clk)
        wr = 1'b0;        
        
        // ----------------FULL-----------------------
        // read
        repeat(1) @(negedge clk);
        rd = 1'b1;
        @(negedge clk)
        rd = 1'b0;
        
        // read
        repeat(1) @(negedge clk);
        rd = 1'b1;
        @(negedge clk)
        rd = 1'b0;
        
        // read
        repeat(1) @(negedge clk);
        rd = 1'b1;
        @(negedge clk)
        rd = 1'b0;
        
        // read
        repeat(1) @(negedge clk);
        rd = 1'b1;
        @(negedge clk)
        rd = 1'b0;
        
        // read
        repeat(1) @(negedge clk);
        rd = 1'b1;
        @(negedge clk)
        rd = 1'b0;
        
        // read
        repeat(1) @(negedge clk);
        rd = 1'b1;
        @(negedge clk)
        rd = 1'b0;
        
        // read
        repeat(1) @(negedge clk);
        rd = 1'b1;
        @(negedge clk)
        rd = 1'b0;
        
        // read
        repeat(1) @(negedge clk);
        rd = 1'b1;
        @(negedge clk)
        rd = 1'b0;
        
        // ----------------EMPTY-----------------------
        
        // read & write at the same time
        repeat(1) @(negedge clk);
        w_data = 8'd7;
        wr = 1'b1;
        rd = 1'b1;
        @(negedge clk)
        wr = 1'b0;
        rd = 1'b0;
        
        // read while empty
        repeat(1) @(negedge clk);
        rd = 1'b1;
        @(negedge clk)
        rd = 1'b0;

        // ----------------NOT EMPTY-----------------------
        repeat(1) @(negedge clk);
        w_data = 8'd4;
        wr = 1'b1;
        @(negedge clk)
        wr = 1'b0;
        
        repeat(1) @(negedge clk);
        w_data = 8'd5;
        wr = 1'b1;
        @(negedge clk)
        wr = 1'b0;
        
        repeat(1) @(negedge clk);
        w_data = 8'd6;
        wr = 1'b1;
        @(negedge clk)
        wr = 1'b0;
        
        // read & write at the same time
        repeat(1) @(negedge clk);
        w_data = 8'd7;
        wr = 1'b1;
        rd = 1'b1;
        @(negedge clk)
        wr = 1'b0;
        rd = 1'b0;
        
        repeat(3) @(negedge clk);
        $stop;
end


endmodule