LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ethernet_tb IS
END ethernet_tb;

ARCHITECTURE test OF ethernet_tb IS

    -- Parametrii
    CONSTANT payload_width : INTEGER := 16; -- trebuie sa corespunda cu generic-ul
    CONSTANT CLK_PERIOD    : TIME := 20 ns;

    -- Semnale pentru EthernetTx
    SIGNAL clk         : STD_LOGIC := '0';
    SIGNAL reset       : STD_LOGIC := '0';
    SIGNAL start       : STD_LOGIC := '0';
    SIGNAL dest_mac    : STD_LOGIC_VECTOR(47 DOWNTO 0) := (OTHERS => '0');
    SIGNAL src_mac     : STD_LOGIC_VECTOR(47 DOWNTO 0) := (OTHERS => '0');
    SIGNAL type_data   : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL payload     : STD_LOGIC_VECTOR(payload_width*8-1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Tx          : STD_LOGIC;
    SIGNAL busy        : STD_LOGIC;

    -- Semnale pentru EthernetRx
    SIGNAL Rx          : STD_LOGIC;
    SIGNAL dest_mac_rx : STD_LOGIC_VECTOR(47 DOWNTO 0);
    SIGNAL src_mac_rx  : STD_LOGIC_VECTOR(47 DOWNTO 0);
    SIGNAL type_data_rx: STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL payload_rx  : STD_LOGIC_VECTOR(payload_width*8-1 DOWNTO 0);
    SIGNAL valid_rx    : STD_LOGIC;

BEGIN

  
    EthernetTx_inst : ENTITY work.EthernetTx
    GENERIC MAP(
        payload_width => payload_width
    )
    PORT MAP(
        clk       => clk,
        reset     => reset,
        start     => start,
        dest_mac  => dest_mac,
        src_mac   => src_mac,
        type_data => type_data,
        payload   => payload,
        Tx        => Tx,
        busy      => busy
    );


    EthernetRx_inst : ENTITY work.EthernetRx
    GENERIC MAP(
        payload_width => payload_width
    )
    PORT MAP(
        clk       => clk,
        reset     => reset,
        Rx        => Rx,
        dest_mac  => dest_mac_rx,
        src_mac   => src_mac_rx,
        type_data => type_data_rx,
        payload   => payload_rx,
        valid     => valid_rx
    );

    -- Interconectez  Tx -> Rx
    Rx <= Tx;


    clk_gen : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR CLK_PERIOD/2;
        clk <= '1';
        WAIT FOR CLK_PERIOD/2;
    END PROCESS;

  
    stim_proc : PROCESS
    BEGIN
        -- Reset activ low
        reset <= '1';
        WAIT FOR 50 ns;
        reset <= '0';
        WAIT FOR 50 ns;
        reset <= '1';
        WAIT FOR 50 ns;

        -- Setare date de transmisie
        dest_mac  <= x"112233445566";
        src_mac   <= x"AABBCCDDEEFF";
        type_data <= x"0800";
        payload   <= x"1234567890ABCDEF1234567890ABCDEF"; 

        -- Pornim transmisia
        start <= '1';
        WAIT FOR (CLK_PERIOD*2);
        start <= '0';

        -- Asteptam pana se termina transmisia la Tx
        WAIT UNTIL busy = '0';
        -- Dupa ce Tx a terminat, toti bitii au fost trimisi.
        -- Rx va colecta datele si la final valid va fi '1'.

        -- Asteptam sa vedem cand valid devine '1'
        WAIT UNTIL valid_rx = '1';

        -- In acest moment:
        -- dest_mac_rx ar trebui sa fie x"112233445566"
        -- src_mac_rx  ar trebui sa fie x"AABBCCDDEEFF"
        -- type_data_rx = x"0800"
        -- payload_rx   = x"1234567890ABCDEF1234567890ABCDEF"

        WAIT FOR 100 ns; 

        WAIT;
    END PROCESS;

END test;
