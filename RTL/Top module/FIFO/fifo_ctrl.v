module fifo_ctrl #(parameter addr_width = 7) (

	input clk,reset,
	input wr,rd,
	output full,empty,
	output  [addr_width -1 :0] w_addr,r_addr

);

reg [addr_width -1:0] w_ptr_reg,w_ptr_next;
reg [addr_width-1:0]  r_ptr_reg,r_ptr_next;

reg full_next,full_reg;
reg empty_next,empty_reg;

always @(posedge clk,posedge reset )
begin
	if (reset)
		begin
			w_ptr_reg <= 0;
			r_ptr_reg <= 0;
			full_reg <= 1'b0;
			empty_reg <= 1'b1;
			
		end
	else	
		begin
			w_ptr_reg <= w_ptr_next;
			r_ptr_reg <= r_ptr_next;
			full_reg <= full_next;
			empty_reg <= empty_next;
		end

end

always @ (*)
begin
		w_ptr_next = w_ptr_reg;
		r_ptr_next = r_ptr_reg;
		full_next  = full_reg;
		empty_next = empty_reg;
			
		case ({wr,rd})
		2'b01:
		begin
			if (~empty)
			begin
				r_ptr_next = r_ptr_reg+1;
				full_next = 1'b0;
				if (r_ptr_next == w_ptr_reg)
					empty_next = 1'b1;
			end
		end
		
		2'b10:
		begin
			if (~full)
			begin
				w_ptr_next = w_ptr_reg+1;
				empty_next = 1'b0;
				if (w_ptr_next == r_ptr_reg)
					full_next = 1'b1;
			end
		end
		
		2'b11:
		begin
			if (empty)
			begin
				r_ptr_next = r_ptr_reg;
				w_ptr_next = w_ptr_reg;
			end
			else
			begin
				r_ptr_next = r_ptr_reg+1;
				w_ptr_next = w_ptr_reg+1;
			end
		end
		
		default : ;
		endcase	

end

assign full = full_reg;
assign empty = empty_reg;
assign w_addr = w_ptr_reg;
assign r_addr = r_ptr_reg;
endmodule