LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY I2C_Master IS
  GENERIC(
    clock_frequency : INTEGER := 100000000; -- frec sistemului (100 MHz)
    i2c_frequency   : INTEGER := 100000);   -- frec I2C (100 kHz)
  PORT(
    clk       : IN  STD_LOGIC;       
    reset     : IN  STD_LOGIC;     
    start     : IN  STD_LOGIC;       
    rw        : IN  STD_LOGIC;       --  R/W (0 = scriere, 1 = citire)
    address   : IN  STD_LOGIC_VECTOR(6 DOWNTO 0); -- adresa Slave-ului (7 biți)
    data_in   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Datele de transmis
    data_out  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Datele receptionate
    busy      : OUT STD_LOGIC;       -- Semnal de ocupat
    scl       : OUT STD_LOGIC;       -- Linia SCL
    SdaIn     : IN  STD_LOGIC;       -- Semnalul de intrare SDA
    SdaOut    : OUT STD_LOGIC        -- Semnalul de iesire SDA
  );
END I2C_Master;

architecture Behavioral of I2C_Master is


  CONSTANT clk_divider : INTEGER := clock_frequency / (i2c_frequency * 4); -- Divizor ceas
  SIGNAL clk_count     : INTEGER RANGE 0 TO clk_divider := 0; -- Contor pentru divizare ceas
  SIGNAL scl_internal  : STD_LOGIC := '1'; -- Semnal intern SCL
  SIGNAL sda_internal  : STD_LOGIC := '1'; -- Semnal intern SDA
  SIGNAL state         : INTEGER RANGE 0 TO 15 := 0; -- Starea FSM
  SIGNAL bit_index     : INTEGER RANGE 0 TO 7 := 0; -- Contor biți


begin

-- Generarea semnalului SCL
  PROCESS(clk, reset)
  BEGIN
    IF reset = '1' THEN
      clk_count <= 0;
      scl_internal <= '1';
    ELSIF rising_edge(clk) THEN
      IF clk_count = clk_divider THEN
        clk_count <= 0;
        scl_internal <= NOT scl_internal; -- Inversează SCL
      ELSE
        clk_count <= clk_count + 1;
      END IF;
    END IF;
  END PROCESS;

  scl <= scl_internal; -- Ieșirea SCL
  
  
-- FSM pentru operațiile I2C
  PROCESS(clk, reset)
  BEGIN
    IF reset = '1' THEN --aici e numai un reset la fsm
      state <= 0;
      busy <= '0';
      sda_internal <= '1';
    ELSIF rising_edge(clk) THEN
      CASE state IS
        WHEN 0 =>   --starea idle
          busy <= '0';
          IF start = '1' THEN
            state <= 1; -- conditie  Start
          END IF;

        WHEN 1 => -- Generare Start
          sda_internal <= '0';
          busy <= '1';
          state <= 2;

        WHEN 2 => -- transmit adresa
          IF scl_internal = '1' THEN
            sda_internal <= address(6 - bit_index); -- trimit bitii adresei
            IF bit_index = 6 THEN
              state <= 3; -- trimit bit R/W
              bit_index <= 0;
            ELSE
              bit_index <= bit_index + 1;
            END IF;
          END IF;

        WHEN 3 => -- transmit R/W
          IF scl_internal = '1' THEN
            sda_internal <= rw;
            state <= 4;
          END IF;

        WHEN 4 => -- Așteptare ACK dar ignor
          state <= 5;

        WHEN 5 => -- transmit date
          IF scl_internal = '1' THEN
            sda_internal <= data_in(7 - bit_index);
            IF bit_index = 7 THEN
              state <= 6; -- finalizez transmisia
              bit_index <= 0;
            ELSE
              bit_index <= bit_index + 1;
            END IF;
          END IF;

        WHEN 6 => -- conditie  Stop
          sda_internal <= '1';
          state <= 0;

        WHEN OTHERS =>
          state <= 0;
      END CASE;
    END IF;
  END PROCESS;

  SdaOut <= sda_internal; -- Ieșirea SDA
END Behavioral;
