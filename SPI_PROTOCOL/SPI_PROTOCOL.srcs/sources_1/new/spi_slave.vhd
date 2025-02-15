LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY spi_slave IS
  GENERIC(
    data_length : INTEGER := 16);     --data length in bits
  PORT(
    reset     : IN     STD_LOGIC;  																	 --asynchronous active low reset
	cpol    	  : IN 	  STD_LOGIC;  																	 --clock polarity mode
    cpha    	  : IN 	  STD_LOGIC;  																	 --clock phase mode
    sclk         : IN     STD_LOGIC;  																	 --spi clk
	 ss         : IN     STD_LOGIC;  																	 --slave select
    MOSI         : IN     STD_LOGIC;  																	 --master out slave in
    MISO         : OUT    STD_LOGIC;  																	 --master in slave out
	rx_enable    : IN     STD_LOGIC;  																	 --enable signal to wire rxBuffer to outside 
    tx			  : IN     STD_LOGIC_VECTOR(data_length-1 DOWNTO 0);  						 --data to transmit
    rx		     : OUT    STD_LOGIC_VECTOR(data_length-1 DOWNTO 0) := (OTHERS => '0');  --data received
    busy         : OUT    STD_LOGIC := '0');  														 --slave busy signal	 
END spi_slave;