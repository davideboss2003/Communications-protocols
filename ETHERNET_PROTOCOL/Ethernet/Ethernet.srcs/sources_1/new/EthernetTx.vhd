LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EthernetTx IS
  GENERIC(
    payload_width : INTEGER := 16 -- latimea payload-ului (16 octeti)
  );
  PORT(
    clk         : IN  STD_LOGIC;                     
    reset       : IN  STD_LOGIC;                      
    start       : IN  STD_LOGIC;                      
    dest_mac    : IN  STD_LOGIC_VECTOR(47 DOWNTO 0);  -- adresa MAC de destinatie (6 octeti)
    src_mac     : IN  STD_LOGIC_VECTOR(47 DOWNTO 0);  -- adresa mac sursa (6 octeti)
    type_data  : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);  -- type (2 octeti)
    payload     : IN  STD_LOGIC_VECTOR(payload_width*8-1 DOWNTO 0); -- Payload-ul
    Tx          : OUT STD_LOGIC;                      
    busy        : OUT STD_LOGIC                       
  );
END EthernetTx;

ARCHITECTURE Behavioral OF EthernetTx IS
  CONSTANT total_bits : INTEGER := 112 + payload_width*8; -- total biti (6+6+2 octeti + payload)
  SIGNAL bit_counter  : INTEGER RANGE 0 TO total_bits := 0; -- Contor 
  SIGNAL tx_data      : STD_LOGIC_VECTOR(total_bits-1 DOWNTO 0); -- bitii totali ai pachetului
  
  SIGNAL tx_internal  : STD_LOGIC := '1'; 
  
  SIGNAL busy_internal : STD_LOGIC := '0';

BEGIN


--proces princilal
  PROCESS(dest_mac, src_mac, type_data, payload)
  BEGIN
    tx_data <= dest_mac & src_mac & type_data & payload; -- concat
  END PROCESS;

  -- Procesul principal pentru transmiterea datelor
  PROCESS(clk, reset)
  BEGIN
    IF reset = '1' THEN
      bit_counter <= 0;
      tx_internal <= '1';
      busy_internal <= '0';
    ELSIF rising_edge(clk) THEN
      IF start = '1' AND busy_internal = '0' THEN
        busy_internal <= '1'; -- incep transmisia
        bit_counter <= 0;
        tx_internal <= tx_data(total_bits-1); -- transmit primul bit
      ELSIF busy_internal = '1' THEN
        IF bit_counter < total_bits-1 THEN
          bit_counter <= bit_counter + 1;
          tx_internal <= tx_data(total_bits-1-bit_counter); -- transmit urmatorul bit
        ELSE
          tx_internal <= '1'; -- dezactiv
          busy_internal <= '0'; -- gata transmisia
        END IF;
      END IF;
    END IF;
  END PROCESS;
  
  
  
  Tx <= tx_internal;       
  busy <= busy_internal;   


END Behavioral;
