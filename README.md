# UART (Universal Asynchronous Receiver-Transmitter)

This project implements a UART (Universal Asynchronous Receiver-Transmitter) in Verilog. UART is a hardware communication protocol used for serial communication between two devices. It allows data to be transmitted and received asynchronously, meaning that the data is sent without a clock signal, relying instead on agreed-upon timing for data synchronization.

## Overview
UART is commonly used for serial communication between computers, microcontrollers, and various hardware devices. This project implements a UART system with both **transmitter** and **receiver** modules, which can be synthesized onto an FPGA or tested using a Verilog simulator.

The UART protocol typically involves two signals:
1. **Tx (Transmit):** Serial data is sent bit-by-bit from the transmitter to the receiver.
2. **Rx (Receive):** Serial data is received bit-by-bit.

The transmitter sends data over a single wire, and the receiver reads the incoming serial data. The transmitter and receiver operate based on the same communication settings, including the baud rate, data size, and stop bits.

## Features
- **Configurable Baud Rate:** Set the baud rate to control data transmission speed.
- **Full-Duplex Communication:** Supports simultaneous data transmission and reception.
- **Transmitter and Receiver Modules:** Separate modules for sending and receiving data.
- **Parameterizable Data Width:** Configure data width for different applications.

## Baud Rate and Communication Settings
The **baud rate** determines how fast data is transmitted over the UART interface. The baud rate generator is implemented to create a clock signal based on the desired baud rate.

### Typical UART Settings:
- **Baud Rate:** Configurable (e.g., 9600, 115200 bps)
- **Data Bits:** 8 bits per frame
- **Stop Bits:** 1 stop bit
You can configure these parameters in the Verilog modules.


