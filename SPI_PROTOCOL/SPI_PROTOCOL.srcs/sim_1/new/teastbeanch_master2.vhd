LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL; 
USE ieee.numeric_std.ALL;
 
ENTITY SPI_TB IS
END SPI_TB;
 
ARCHITECTURE behavior OF SPI_TB IS 
   
    COMPONENT spi_master
    PORT(
         clk       : IN  STD_LOGIC;
         reset   : IN  STD_LOGIC;
         enable    : IN  STD_LOGIC;
         cpol      : IN  STD_LOGIC;
         cpha      : IN  STD_LOGIC;
         miso      : IN  STD_LOGIC;
         sclk      : OUT STD_LOGIC;
         ss     : OUT STD_LOGIC;
         mosi      : OUT STD_LOGIC;
         busy      : OUT STD_LOGIC;
         tx        : IN  STD_LOGIC_VECTOR(15 downto 0);
         rx        : OUT STD_LOGIC_VECTOR(15 downto 0)
        );
    END COMPONENT;
  
    COMPONENT clk_gen IS
         PORT ( 
            clk    : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL clk, miso, mosi, sclk, ss, busy_master, reset : STD_LOGIC;
    SIGNAL start : STD_LOGIC := '0';
    SIGNAL enable : STD_LOGIC := '1';
    SIGNAL rx_master : STD_LOGIC_VECTOR(15 downto 0);

    -- data transf de master
    SIGNAL tx_master : STD_LOGIC_VECTOR(15 downto 0) := "1100010001110011";
    
    --am conffig semnalele
    SIGNAL cpha : STD_LOGIC := '0';
    SIGNAL cpol : STD_LOGIC := '0';

BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    uut1: spi_master PORT MAP (
          clk => clk,
          reset => reset,
          enable => enable,
          cpol => cpol,
          cpha => cpha,
          miso => miso,
          sclk => sclk,
          ss=> ss,
          mosi => mosi,
          busy => busy_master,
          tx => tx_master,
          rx => rx_master
        );
          
    uut3: clk_gen PORT MAP (
          clk => clk 
    );
             
    PROCESS(clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (start = '0') THEN        
                start <= '1';
                reset <= '0';   -- innitial low
            ELSIF (start = '1') THEN
                start <= '1';
                reset <= '1';   -- Release reset
            END IF;

            -- simulam sa primeasaca masterul pe MISO info
            IF (sclk = '1' AND busy_master = '1') THEN
                miso <= '1';       -- MISO  '1' ca exemplu
            ELSE
                miso <= '0';       --sau setat pe  '0' depinde de scenariu
            END IF;
        END IF;
    END PROCESS;

END behavior;
