LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY spi_tb IS
END spi_tb;

ARCHITECTURE testbench OF spi_tb IS
    -- Generic parameters
    CONSTANT lungime_data : INTEGER := 32;

    -- Clock and Reset
    SIGNAL clk      : STD_LOGIC := '0';
    SIGNAL reset    : STD_LOGIC := '0';
    SIGNAL enable   : STD_LOGIC := '0';
    
    -- Master signals
    SIGNAL cpol     : STD_LOGIC := '0';
    SIGNAL cpha     : STD_LOGIC := '0';
    SIGNAL miso     : STD_LOGIC := '0';
    SIGNAL mosi     : STD_LOGIC;
    SIGNAL sclk     : STD_LOGIC;
    SIGNAL ss       : STD_LOGIC;
    SIGNAL busy_m   : STD_LOGIC;
    SIGNAL tx_m     : STD_LOGIC_VECTOR(lungime_data-1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rx_m     : STD_LOGIC_VECTOR(lungime_data-1 DOWNTO 0);

    -- Slave signals
    SIGNAL rx_enable: STD_LOGIC := '1';
    SIGNAL busy_s   : STD_LOGIC;
    SIGNAL tx_s     : STD_LOGIC_VECTOR(lungime_data-1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rx_s     : STD_LOGIC_VECTOR(lungime_data-1 DOWNTO 0);

    -- Clock period
    CONSTANT clk_period : TIME := 10 ns;

BEGIN
    -- Clock process
    clk_process : PROCESS
    BEGIN
        WHILE true LOOP
            clk <= '0';
            WAIT FOR clk_period / 2;
            clk <= '1';
            WAIT FOR clk_period / 2;
        END LOOP;
    END PROCESS;

    -- Master instance
    UUT_MASTER: ENTITY work.SPI_MASTER
    GENERIC MAP (lungime_data => lungime_data)
    PORT MAP (
        clk     => clk,
        reset   => reset,
        enable  => enable,
        cpol    => cpol,
        cpha    => cpha,
        MISO    => miso,
        sclk    => sclk,
        ss      => ss,
        MOSI    => mosi,
        busy    => busy_m,
        tx      => tx_m,
        rx      => rx_m
    );

    -- Slave instance
    UUT_SLAVE: ENTITY work.SPI_SLAVE
    GENERIC MAP (lungime_data => lungime_data)
    PORT MAP (
        reset       => reset,
        cpol        => cpol,
        cpha        => cpha,
        sclk        => sclk,
        ss          => ss,
        mosi        => mosi,
        miso        => miso,
        rx_enable   => rx_enable,
        tx          => tx_s,
        rx          => rx_s,
        busy        => busy_s
    );

    -- Stimulus process
    STIMULUS : PROCESS
    BEGIN
        -- Faza 1: Resetare inițială
        reset <= '0';
        tx_m <= X"12345678"; -- Date transmise de Master
        tx_s <= X"87654321"; -- Date transmise de Slave
        WAIT FOR clk_period * 5;
        
        -- Faza 2: Activare reset
        reset <= '1';
        WAIT FOR clk_period * 2;

        -- Faza 3: Inițiere transmisie SPI
        enable <= '1';
        WAIT FOR clk_period;
        enable <= '0';

        -- Așteptare finalizare transmisie
        WAIT UNTIL busy_m = '0';
        WAIT FOR clk_period * 10;

        -- Faza 4: Observarea rezultatelor
        -- În simulator, vei putea vedea semnalele rx_m și rx_s pentru verificare

        WAIT; -- Finalul simulării
    END PROCESS;

END testbench;
