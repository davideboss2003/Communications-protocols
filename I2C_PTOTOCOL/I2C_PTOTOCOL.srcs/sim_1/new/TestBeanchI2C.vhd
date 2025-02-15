LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY i2c_tb IS
END i2c_tb;

ARCHITECTURE test OF i2c_tb IS
    -- Parametri
    CONSTANT CLK_PERIOD : TIME := 10 ns;

    SIGNAL clk         : STD_LOGIC := '0';
    SIGNAL reset       : STD_LOGIC := '0';

    -- Semnale Master
    SIGNAL start_m     : STD_LOGIC := '0';
    SIGNAL rw_m        : STD_LOGIC := '0'; -- 0 = write, 1 = read
    SIGNAL address_m   : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1010101"; -- Adresa slave
    SIGNAL data_in_m   : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data_out_m  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL busy_m      : STD_LOGIC;
    SIGNAL scl_m       : STD_LOGIC;
    SIGNAL SdaIn_m     : STD_LOGIC;
    SIGNAL SdaOut_m    : STD_LOGIC;

    -- Semnale Slave
    SIGNAL scl_s       : STD_LOGIC;
    SIGNAL SdaIn_s     : STD_LOGIC;
    SIGNAL SdaOut_s    : STD_LOGIC;
    SIGNAL data_out_s  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL data_in_s   : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"43"; -- 'C' = 0x43

    -- Linia SDA combinata (simplificare)
    SIGNAL SDA_line    : STD_LOGIC;

BEGIN


    Master_inst : ENTITY work.I2C_Master
    GENERIC MAP(
        clock_frequency => 100000000, -- 100 MHz
        i2c_frequency   => 100000     -- 100 kHz
    )
    PORT MAP(
        clk       => clk,
        reset     => reset,
        start     => start_m,
        rw        => rw_m,
        address   => address_m,
        data_in   => data_in_m,
        data_out  => data_out_m,
        busy      => busy_m,
        scl       => scl_m,
        SdaIn     => SdaIn_m,
        SdaOut    => SdaOut_m
    );


    Slave_inst : ENTITY work.I2C_Slave
    GENERIC MAP(
        slave_address => "1010101"
    )
    PORT MAP(
        clk       => clk,
        reset     => reset,
        scl       => scl_s,
        SdaIn     => SdaIn_s,
        SdaOut    => SdaOut_s,
        data_out  => data_out_s,
        data_in   => data_in_s
    );


    scl_s <= scl_m;

    -- SDA_line: în I2C reală ar fi o linie cu pull-up și open-drain.
    -- Aici simplificăm: Dacă unul dintre SdaOut e '0', atunci SDA_line e '0'.
    -- Dacă ambele sunt '1', linia e '1'.
    SDA_line <= SdaOut_m AND SdaOut_s;

    SdaIn_m <= SDA_line;
    SdaIn_s <= SDA_line;


    clk_gen: PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR CLK_PERIOD/2;
        clk <= '1';
        WAIT FOR CLK_PERIOD/2;
    END PROCESS;


    stim_proc: PROCESS
    BEGIN
        -- Reset activ
        reset <= '1';
        WAIT FOR 50 ns;
        reset <= '0';
        WAIT FOR 100 ns;

        -- 1) Transmisie 'A' (0x41) catre slave
        data_in_m <= x"41";   -- 'A'
        rw_m <= '0';          -- scriere
        start_m <= '1';
        WAIT FOR (CLK_PERIOD*10);
        start_m <= '0';

        -- Asteptam pana se termina
        WAIT UNTIL busy_m = '0';
        WAIT FOR 200 ns;
        -- Slave ar trebui sa aiba data_out_s = 'A' (0x41)

        -- 2) Transmisie 'B' (0x42) catre slave
        data_in_m <= x"42";   -- 'B'
        rw_m <= '0';          -- scriere
        start_m <= '1';
        WAIT FOR (CLK_PERIOD*10);
        start_m <= '0';

        WAIT UNTIL busy_m = '0';
        WAIT FOR 200 ns;
        -- Slave ar trebui sa aiba data_out_s = 'B' (0x42) la finalul acestei transmisii

        -- 3) Citire din slave, care are data_in_s = 'C' (0x43)
        rw_m <= '1';  -- citire
        -- data_in_m nu conteaza la citire
        start_m <= '1';
        WAIT FOR (CLK_PERIOD*10);
        start_m <= '0';

        WAIT UNTIL busy_m = '0';
        WAIT FOR 200 ns;
        -- Acum data_out_m ar trebui sa fie 'C' (0x43)

        -- Stop simulare
        WAIT FOR 1000 ns;
        WAIT;
    END PROCESS;

END test;
