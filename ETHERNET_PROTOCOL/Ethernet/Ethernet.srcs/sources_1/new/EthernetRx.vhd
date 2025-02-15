LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EthernetRx IS
  GENERIC(
    payload_width : INTEGER := 16 
  );
  PORT(
    clk         : IN  STD_LOGIC;                     
    reset       : IN  STD_LOGIC;                      
    Rx          : IN  STD_LOGIC;                     
    dest_mac    : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);  
    src_mac     : OUT STD_LOGIC_VECTOR(47 DOWNTO 0); 
    type_data   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); 
    payload     : OUT STD_LOGIC_VECTOR(payload_width*8-1 DOWNTO 0); 
    valid       : OUT STD_LOGIC                       --indica daca e valid
  );
END EthernetRx;

ARCHITECTURE Behavioral OF EthernetRx IS
  CONSTANT total_bits : INTEGER := 112 + payload_width*8; -- Total biți (6+6+2 octeti + payload)
  SIGNAL bit_counter  : INTEGER RANGE 0 TO total_bits := 0; 
  SIGNAL rx_buffer    : STD_LOGIC_VECTOR(total_bits-1 DOWNTO 0) := (OTHERS => '0'); 
  SIGNAL valid_internal : STD_LOGIC := '0'; -- semnal intern pot validare
BEGIN

--proces principal
  PROCESS(clk, reset)
  BEGIN
    IF reset = '1' THEN
      bit_counter <= 0;
      rx_buffer <= (OTHERS => '0');
      valid_internal <= '0';
    ELSIF rising_edge(clk) THEN
      -- recep bit cu bit
      IF Rx = '0' OR Rx = '1' THEN -- verific daca bitu e valid
        rx_buffer(total_bits-1 DOWNTO 1) <= rx_buffer(total_bits-2 DOWNTO 0);
        rx_buffer(0) <= Rx; -- Adaugă bitul recepționat în buffer
        
        -- actualizez contorul  verific daca contorul a ajuns la val max totalbits-1
        IF bit_counter < total_bits-1 THEN
          bit_counter <= bit_counter + 1;
        ELSE
          -- pachet complet receptionat
          dest_mac <= rx_buffer(total_bits-1 DOWNTO total_bits-48); -- extrag primii 48
          src_mac <= rx_buffer(total_bits-49 DOWNTO total_bits-96); -- apoi urmatorii 48
          type_data <= rx_buffer(total_bits-97 DOWNTO total_bits-112); --apoi 16
          payload <= rx_buffer(total_bits-113 DOWNTO 0);  --apoi cati mai raman
          valid_internal <= '1'; 
          bit_counter <= 0; --resetez pt urmatorul pachet
        END IF;
      END IF;
    END IF;
  END PROCESS;


  valid <= valid_internal;

END Behavioral;
