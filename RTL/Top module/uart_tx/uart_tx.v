module uart_tx #(parameter DBIT = 8 ,SB_TICK = 16 ) (

	input clk,reset_n,
	output tx,
	input s_tick,
	input [DBIT-1:0] tx_din,
	input tx_start,
	output reg tx_done_tick


);

localparam idle=0,start=1,data=2,stop=3;

reg [1:0] state_reg,state_next;
reg [$clog2(SB_TICK)-1:0] s_reg,s_next;
reg [DBIT-1:0] b_reg,b_next;
reg  [$clog2(DBIT)-1:0]n_reg,n_next;
reg tx_reg,tx_next;

always @(posedge clk,negedge reset_n)
begin

	if(~reset_n)
	begin
		state_reg<=idle;
		s_reg <= 0;
		n_reg <= 0;
		b_reg <= 0;
		tx_reg <= 1'b1;
	end	
	else
	begin
		state_reg<= state_next;
		s_reg <= s_next;
		n_reg <= n_next;
		b_reg <= b_next;
		tx_reg <= tx_next;
	end
end
		
always @ (*)
begin
	
	s_next = s_reg;
	n_next = n_reg;
	b_next = b_reg;
	state_next = state_reg;
	tx_done_tick = 1'b0;
	case(state_reg)
	
	idle:
		begin
			tx_next = 1'b1;
		if(tx_start)
			begin
			b_next = tx_din;
			s_next = 0;
			state_next=start;
			end
		end

			
	start: 
			begin
			tx_next = 0;
			if(s_tick)
				if (s_reg == 15)
				begin
				state_next = data;
				s_next = 0;
				n_next = 0;							
				end
				
				else
				s_next = s_reg+1;
			end

	
	data:
			begin
			tx_next = b_reg[0];
			if(s_tick)
					if (s_reg == 15)
					begin
					s_next = 0;
					b_next = {1'b0,b_reg[DBIT-1:1]};							
					
						if(n_reg == DBIT-1)
							state_next = stop;
						else
							n_next = n_reg +1;
					end
					else
					s_next = s_reg+1;
			end
	stop:
			begin
			tx_next = 1;
				if(s_tick)
						if (s_reg == SB_TICK-1)
						begin
						state_next = idle;
						tx_done_tick = 1'b1;
						end
						
						else
						s_next = s_reg+1;
			end

				
			
	default : state_next = idle;
	endcase
	

end

assign tx= tx_reg;


endmodule