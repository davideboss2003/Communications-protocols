In this project, I implemented three communication protocols (Ethernet, I2C, and SPI) using VHDL. These protocols are widely used for data transfer between devices. The project was developed as part of my university coursework, focusing on the design, simulation, and validation of these protocols using hardware description languages (HDLs).

Key Features:
I2C Protocol: A two-wire, multi-master, multi-slave communication protocol used for connecting low-speed peripherals like sensors and EEPROMs. The implementation includes both Master and Slave components, with a finite state machine (FSM) to handle communication steps such as START, STOP, address transmission, and data transfer.

SPI Protocol: A high-speed, full-duplex serial communication protocol designed for short-distance communication between integrated circuits. The implementation supports Master-Slave communication, with configurable clock polarity (CPOL) and phase (CPHA).

Ethernet Protocol: A packet-based communication protocol used in local area networks (LANs). The implementation includes both transmission (EthernetTx) and reception (EthernetRx) components, capable of handling MAC addresses, data types, and payloads.

Testbenches:
Moreover, for each module (I2C Master/Slave, SPI Master/Slave, EthernetTx/Rx), a comprehensive testbench was developed to validate the functionality and to simulate real-world communication, including data transmission, reception, and error handling.
