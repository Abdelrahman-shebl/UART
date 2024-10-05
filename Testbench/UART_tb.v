`timescale 1ns / 1ps

module UART_tb(
    );
    // Parameters
    parameter DBIT = 8;
    parameter SB_TICK = 16;
    
    // Testbench signals
    reg clk;
    reg reset_n;
    
    wire serial_data;
    
    // Rx signals
    reg rd_uart;
    wire [DBIT-1:0] r_data;
    wire rx_empty;
    
    // Tx signals
    reg wr_uart;
    reg [DBIT-1:0] w_data;
    wire tx_full;
    
    // Baud rate generator
    reg [10:0] TIMER_FINAL_VALUE;
    
    
    // Instantiate the UART module
    UART #(DBIT, SB_TICK) uut (
        .clk(clk),
        .reset_n(reset_n),
        .rx(serial_data),
        .rd_uart(rd_uart),
        .r_data(r_data),
        .rx_empty(rx_empty),
        .tx(serial_data),
        .wr_uart(wr_uart),
        .w_data(w_data),
        .tx_full(tx_full),
        .final_value(TIMER_FINAL_VALUE)
    );
    
    // Clock generation
    always begin
        #5 clk = ~clk; // 200 MHz clock
    end
    

    // Initialize inputs and stimulus
    initial 
    begin
        // Initialize signals
        clk = 0;
        TIMER_FINAL_VALUE = 650;
        reset_n = 0;
        wr_uart = 0;
        rd_uart = 0;
       // TIMER_FINAL_VALUE = 11'b1; // Example value
        
        // Apply reset
        #2.5 reset_n = 1;
        rd_uart = 1;
        
        #2.5;
        // Write data to FIFO
        w_data = 8'b10101010; // Example data
        wr_uart = 1;
        #5;
        wr_uart = 0;
        #5;
        
        w_data = 8'b11001100; // Example data
        wr_uart = 1;
        #5;
        wr_uart = 0;
        #5;

        w_data = 8'b10111000; // Example data
        wr_uart = 1;
        #5;
        wr_uart = 0;
        #5;        
        
        w_data = 8'b11110000; // Example data
        wr_uart = 1;
        #5;
        wr_uart = 0;
        #5; 
                
     end
     
     initial
     begin   
        #5000000
        // Check received data
        if (r_data !== 8'b11110000) begin
            $display("Error: Received data is correct! %b", r_data);
				$stop;
        end else begin
            $display("Received data is correct");
				$stop;
        end
    end
    
endmodule
