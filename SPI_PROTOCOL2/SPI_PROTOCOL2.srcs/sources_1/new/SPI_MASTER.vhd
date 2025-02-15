LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity SPI_MASTER is
 GENERIC(
    lungime_data: INTEGER := 32);     --lungimea in biti
    PORT(
    clk     : IN std_logic;
    reset   : IN std_logic;
    enable  : IN std_logic;
    cpol    : IN  STD_LOGIC;                             -- clock polarity mode
    cpha    : IN  STD_LOGIC;                             -- clock phase mode
    MISO    : IN     STD_LOGIC;                             --master in slave out
    sclk    : OUT    STD_LOGIC;                             --spi clock
    ss    : OUT    STD_LOGIC;                             --slave select
    MOSI    : OUT    STD_LOGIC;                             --master out slave in
    busy    : OUT    STD_LOGIC;  
    tx		: IN     STD_LOGIC_VECTOR(lungime_data-1 DOWNTO 0);  --data to transmit
    rx	    : OUT    STD_LOGIC_VECTOR(lungime_data-1 DOWNTO 0)); --data received
end SPI_MASTER;

architecture Behavioral of SPI_MASTER is

 TYPE FSM IS(init, execute);                           		--state machine
  SIGNAL state       : FSM;                             
  SIGNAL receive_transmit : STD_LOGIC;                      --'1' pt tx, '0' pt rx 
  SIGNAL alternanta_clk : INTEGER RANGE 0 TO lungime_data*2 + 1;    --alteernanta clock counter
  SIGNAL last_bit		: INTEGER RANGE 0 TO lungime_data*2;        --ultimul bit
  SIGNAL rxBuffer    : STD_LOGIC_VECTOR(lungime_data- 1 DOWNTO 0) := (OTHERS => '0'); 
  SIGNAL txBuffer    : STD_LOGIC_VECTOR(lungime_data- 1 DOWNTO 0) := (OTHERS => '0'); 
  SIGNAL INT_ss    : STD_LOGIC;                            --Internal register for ss_n 
  SIGNAL INT_sclk    : STD_LOGIC;                            --Internal register for sclk 


begin

ss <=INT_ss;
sclk <= INT_sclk;


--procesul principal
PROCESS(clk, reset) --clk pt sincron int si reset pt resetare asincrona
  BEGIN

    IF(reset= '0') THEN        --daca reset e 0 toate semnalele vor fi initializate la val initiale
      busy <= '1';              --e ocupat   
      INT_ss <= '1';            
      MOSI <= 'Z';               --setat la inalta impedanta adica MOSI nu comunica
      rx <= (OTHERS => '0');      --si bufferul rx e golit
      state <= init;     
    
    ELSIF(falling_edge(clk)) then
        CASE state is 
        
        WHEN init =>                                            ------starea init
            busy <= '0';
            INT_ss <= '1';
            MOSI <= 'Z';
         
    IF(enable= '1') then  ------se produce comunicarea
    busy <= '1';
    
    INT_sclk <= cpol;    
             
    receive_transmit <= NOT cpha;  
    
    txBuffer <= tx;
    
    alternanta_clk <= 0; --alternanta_clk nr alternantele de ceas fiecare alternanta a lui sclk il incrementeaza
    last_bit <= lungime_data*2 + conv_integer(cpha) - 1;
    state <= execute;
    
    ELSE
    state <= init;
    END IF;
    
    
        WHEN execute =>                                                    ------starea execute
    busy <= '1';
    INT_ss <= '0';
    receive_transmit <= NOT receive_transmit;
    
                ---fac counterul la alternantele de clk
               IF(alternanta_clk = lungime_data*2 + 1) THEN
               alternanta_clk <= 0;  --resetez counterul
               ELSE
               alternanta_clk <= alternanta_clk + 1;  --incrementez counterul
               END IF;
    
    IF(alternanta_clk <= lungime_data*2 AND INT_ss = '0') THEN 
            INT_sclk <= NOT INT_sclk; --inversez spi clock
          END IF;
    
    --primesc bitul miso
    IF(receive_transmit = '0' AND alternanta_clk < last_bit + 1 AND INT_ss = '0') THEN 
         rxBuffer <= rxBuffer(lungime_data - 2 DOWNTO 0) & MISO; --preia un bit de la miso si il adaufa in rxbuffer
         --si muta toti bitii cu o poz la stg    <- 7 6 5 4 3 2 1 0
    END IF;  
    
    
    --transmit bitul mosi
      IF(receive_transmit = '1' AND alternanta_clk < last_bit) THEN 
            MOSI <= txBuffer(lungime_data - 1);                    
            txBuffer <= txBuffer(lungime_data - 2 DOWNTO 0) & '0'; 
          END IF;
          
      --cand contorul ajunge la val maxima trece in starea init
      
      IF(alternanta_clk = lungime_data*2 +1) then 
      busy <= '0';
      INT_ss <= '1';      
      MOSI <= 'Z';
      rx<= rxBuffer;
      state <= init;
      
      ELSE
        state <= execute;
      END IF; 
      
    
      
END CASE;      
END IF;
END PROCESS; 
END Behavioral;