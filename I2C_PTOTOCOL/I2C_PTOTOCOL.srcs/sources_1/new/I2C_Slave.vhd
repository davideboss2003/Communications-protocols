LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY I2C_Slave IS
  GENERIC(
    slave_address : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1010101" -- Adresa Slave-ului
  );
  PORT(
    clk       : IN  STD_LOGIC;       -- Ceasul sistemului
    reset     : IN  STD_LOGIC;       -- Semnal de resetare
    scl       : IN  STD_LOGIC;       -- Linia SCL
    SdaIn     : IN  STD_LOGIC;       -- Semnalul de intrare SDA
    SdaOut    : OUT STD_LOGIC;       -- Semnalul de ieșire SDA
    data_out  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Datele recepționate
    data_in   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) -- Datele de transmis
  );
END I2C_Slave;

ARCHITECTURE Behavioral OF I2C_Slave IS
  SIGNAL state       : INTEGER RANGE 0 TO 7 := 0; -- Starea FSM
  SIGNAL bit_index   : INTEGER RANGE 0 TO 7 := 0; -- Contor biți
  SIGNAL sda_internal: STD_LOGIC := '1';         -- Semnal intern SDA
BEGIN

  -- FSM pentru Slave
  PROCESS(clk, reset)
  BEGIN
    IF reset = '1' THEN
      state <= 0;
      sda_internal <= '1';
    ELSIF rising_edge(scl) THEN
      CASE state IS
        WHEN 0 => -- Așteptare Start
          IF SdaIn = '0' THEN
            state <= 1;
          END IF;

        WHEN 1 => -- Primire Adresă
          data_out(bit_index) <= SdaIn;
          IF bit_index = 6 THEN
            state <= 2;
            bit_index <= 0;
          ELSE
            bit_index <= bit_index + 1;
          END IF;

        WHEN 2 => -- Confirmare ACK (1 fix)
          sda_internal <= '1'; -- Răspunsul este implicit `1`
          state <= 3;

        WHEN 3 => -- Primire Date
          data_out(bit_index) <= SdaIn;
          IF bit_index = 7 THEN
            state <= 4;
            bit_index <= 0;
          ELSE
            bit_index <= bit_index + 1;
          END IF;

        WHEN 4 => -- Finalizare transmisie
          sda_internal <= '1'; -- Pregătit pentru oprire
          state <= 0;

        WHEN OTHERS =>
          state <= 0;
      END CASE;
    END IF;
  END PROCESS;

  SdaOut <= sda_internal; -- Ieșirea SDA
END Behavioral;
