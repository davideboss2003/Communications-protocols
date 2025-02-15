LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY spi_tb IS
END spi_tb;

ARCHITECTURE test OF spi_tb IS
    -- Parametri
    CONSTANT lungime_data : INTEGER := 32;
    
    -- Semnale interne pt Master
    SIGNAL clk         : STD_LOGIC := '0';
    SIGNAL reset       : STD_LOGIC := '0';
    SIGNAL enable      : STD_LOGIC := '0';
    SIGNAL cpol        : STD_LOGIC := '0';
    SIGNAL cpha        : STD_LOGIC := '0';
    SIGNAL MISO        : STD_LOGIC;
    SIGNAL sclk        : STD_LOGIC;
    SIGNAL ss          : STD_LOGIC;
    SIGNAL MOSI        : STD_LOGIC;
    SIGNAL busy_master : STD_LOGIC;
    SIGNAL tx_master   : STD_LOGIC_VECTOR(lungime_data-1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rx_master   : STD_LOGIC_VECTOR(lungime_data-1 DOWNTO 0);
    
    -- Semnale interne pt Slave
    SIGNAL reset_slave : STD_LOGIC := '0';
    SIGNAL busy_slave  : STD_LOGIC;
    SIGNAL rx_slave    : STD_LOGIC_VECTOR(lungime_data-1 DOWNTO 0);
    SIGNAL tx_slave    : STD_LOGIC_VECTOR(lungime_data-1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rx_enable   : STD_LOGIC := '0';

BEGIN
  
    master_inst : entity work.spi_master
    generic map(
        lungime_data => lungime_data
    )
    port map(
        clk     => clk,
        reset   => reset,
        enable  => enable,
        cpol    => cpol,
        cpha    => cpha,
        MISO    => MISO,
        sclk    => sclk,
        ss      => ss,
        MOSI    => MOSI,
        busy    => busy_master,
        tx      => tx_master,
        rx      => rx_master
    );

    
    slave_inst : entity work.slave_spi
    generic map(
        lungime_data => lungime_data
    )
    port map(
        reset       => reset_slave,
        cpol        => cpol,
        cpha        => cpha,
        sclk        => sclk,
        ss          => ss,
        mosi        => MOSI,
        miso        => MISO,
        rx_enable   => rx_enable,
        tx          => tx_slave,
        rx          => rx_slave,
        busy        => busy_slave
    );

   
    clk_gen : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        WAIT FOR 10 ns;
    END PROCESS;

   
    stim_proc : PROCESS
    BEGIN
        -- Reset activ
        reset <= '0';
        reset_slave <= '0';
        WAIT FOR 50 ns;
        reset <= '1';
        reset_slave <= '1';
        WAIT FOR 50 ns;

      
        -- Date Master: 0x12345678
        -- Date Slave:  0x87654321
        tx_master <= X"12345678";
        tx_slave  <= X"87654321";

        -- Activez transferul
        enable <= '1';
        WAIT FOR 20 ns;
        enable <= '0';  -- Odată dat enable-ul, master-ul va începe transferul

        -- Aștept până master-ul nu mai e busy (se termină transferul)
        WAIT UNTIL busy_master = '0' AND ss = '1';
        WAIT FOR 50 ns; -- un mic delay pentru stabilizarea datelor
        
        -- Acum datele primite de Slave ar trebui să fie 0x12345678
        -- Datele primite de Master ar trebui să fie 0x87654321
        -- Pentru a "lăsa" datele în rx la Slave, setăm rx_enable='1'
        rx_enable <= '1';
        WAIT FOR 40 ns;
        rx_enable <= '0';

        -- În acest moment rx_slave ar trebui să conțină 0x12345678
        -- iar rx_master ar trebui să conțină 0x87654321

        -- Simulare suficient de lungă pentru a vedea waveform-ul
        WAIT FOR 200 ns;

        -- Final simulare
        WAIT;
    END PROCESS;

END test;
