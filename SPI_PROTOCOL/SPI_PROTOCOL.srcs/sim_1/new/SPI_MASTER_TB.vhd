LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY spi_master_tb IS
END spi_master_tb;

ARCHITECTURE behavior OF spi_master_tb IS 

    
    COMPONENT spi_master
    GENERIC (
        lungime_data : INTEGER := 32
    );
    PORT(
        clk     : IN std_logic;
        reset   : IN std_logic;
        enable  : IN std_logic;
        cpol    : IN std_logic;
        cpha    : IN std_logic;
        MISO    : IN std_logic;
        sclk    : OUT std_logic;
        ss      : OUT std_logic;
        MOSI    : OUT std_logic;
        busy    : OUT std_logic;
        tx      : IN std_logic_vector(lungime_data-1 DOWNTO 0);
        rx      : OUT std_logic_vector(lungime_data-1 DOWNTO 0)
    );
    END COMPONENT;
    
    -- Semnalele interne de test
    SIGNAL clk        : std_logic := '0';
    SIGNAL reset      : std_logic := '1';
    SIGNAL enable     : std_logic := '0';
    SIGNAL cpol       : std_logic := '0';
    SIGNAL cpha       : std_logic := '0';
    SIGNAL MISO       : std_logic := '0';
    SIGNAL sclk       : std_logic;
    SIGNAL ss         : std_logic;
    SIGNAL MOSI       : std_logic;
    SIGNAL busy       : std_logic;
    SIGNAL tx         : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rx         : std_logic_vector(31 DOWNTO 0);

    --generez ceas
    CONSTANT clk_period : time := 100 ns;
    
BEGIN

    -- Instanțierea SPI Master-ului
    uut: spi_master 
        GENERIC MAP (
            lungime_data => 32
        )
        PORT MAP (
            clk => clk,
            reset => reset,
            enable => enable,
            cpol => cpol,
            cpha => cpha,
            MISO => MISO,
            sclk => sclk,
            ss => ss,
            MOSI => MOSI,
            busy => busy,
            tx => tx,
            rx => rx
        );

    -- Proces de generare a ceasului
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    -- Proces de testare
    stimulus: process
    begin
        -- Inițializare semnale
        reset <= '1';
        wait for 20 ns;
        
        reset <= '0';              -- Ieșire din reset
        enable <= '1';             -- Inițiere comunicare
        tx <= X"AAAA_AAAA";        -- Date de transmis
        
        wait for 100 ns;           -- Așteptare finalizare transmisie
        
        -- Setare date pentru primire simulată de la Slave
        MISO <= '1';               -- Trimitem un bit "1" către Master prin MISO
        wait for clk_period * 4;   -- Așteptăm câteva cicluri de ceas
        
        MISO <= '0';               -- Trimitem un bit "0" catre Master
        wait for clk_period * 4;
        
        
        enable <= '0';             -- Dezactivare comunicare
        wait for 100 ns;

        
        wait;
    end process;

END;
