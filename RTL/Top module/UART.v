module UART #(
        parameter DBIT = 8,     // # data bits
                  SB_TICK = 16  // # stop bit ticks                  
						)  ( 
	input clk,reset_n,
	
	input [10:0] final_value, //baud_rate
	
	output tx, //tx
	input [7:0] w_data,//data to be shifted from tx to rx
	input wr_uart, //wr_en
	output tx_full, //fifo is full
	
	input rx, // data recieved
	output [7:0] r_data, // recieved data
	input rd_uart, //read en
	output rx_empty // fifo is empty

);

wire s_tick;
wire [DBIT-1:0] rx_dout ;
wire  rx_done_tick ;

wire [DBIT-1:0] tx_din ;
wire  tx_done_tick ;
wire  tx_empty ;

timer_input
    #(.FINAL_VALUE(650) ) baud_rate_Gen(
    .clk(clk),
    .reset_n(reset_n),
    .enable(1'b1),
    .done(s_tick)
    );
	 
uart_tx #(.DBIT (DBIT),.SB_TICK(SB_TICK)) transmitter (

	.clk(clk),
   .reset_n(reset_n),
	.tx(tx),
	.s_tick(s_tick),
	.tx_din(tx_din),
	.tx_start(~tx_empty),
	.tx_done_tick(tx_done_tick)
);

uart_rx #(.DBIT (DBIT),.SB_TICK(SB_TICK) ) receiver (

	.clk(clk),
   .reset_n(reset_n),
	.rx(rx),
	.s_tick(s_tick),
	.rx_dout(rx_dout),
	.rx_done_tick(rx_done_tick)

);

fifo #(.data_width (8) ,.addr_width (8) )fifo_rx  (

	.clk(clk),.reset(~reset_n),
	.wr(rx_done_tick),.rd(rd_uart),
	.w_data(rx_dout),
	.r_data(r_data),
	.full(),.empty(rx_empty)

);
				
fifo  #(.data_width (8) ,.addr_width (8) ) fifo_tx(

	.clk(clk),.reset(~reset_n),
	.wr(wr_uart),.rd(tx_done_tick),
	.w_data(w_data),
	.r_data(tx_din),
	.full(tx_full),.empty(tx_empty)

);

endmodule