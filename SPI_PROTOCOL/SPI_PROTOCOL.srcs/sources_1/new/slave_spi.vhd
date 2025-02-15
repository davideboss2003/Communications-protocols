LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


entity slave_spi IS
GENERIC(
    lungime_data : INTEGER := 32);     
  PORT(
    reset     : IN     STD_LOGIC;  																	 --asynchronous active low reset
	 cpol    	  : IN 	  STD_LOGIC;  																	 --clock polarity mode
    cpha    	  : IN 	  STD_LOGIC;  																	 --clock phase mode
    sclk         : IN     STD_LOGIC;  																	 --spi clk
	 ss        : IN     STD_LOGIC;  																	 --slave select
    mosi         : IN     STD_LOGIC;  																	 --master out slave in
    miso         : OUT    STD_LOGIC;  																	 --master in slave out
	 rx_enable    : IN     STD_LOGIC;  	--pt a controla datele din rxBuffer																 --enable signal to wire rxBuffer to outside 
    tx			  : IN     STD_LOGIC_VECTOR(lungime_data -1 DOWNTO 0);  						 --data to transmit
    rx		     : OUT    STD_LOGIC_VECTOR(lungime_data -1 DOWNTO 0) := (OTHERS => '0');  --data received
    busy         : OUT    STD_LOGIC := '0');  		
end slave_spi;

architecture Behavioral of slave_spi is

  SIGNAL modul    : STD_LOGIC;  -- determina modul SPI în funcție de CPOL și CPHA
  SIGNAL clk     : STD_LOGIC; 
  SIGNAL bit_counter : STD_LOGIC_VECTOR(lungime_data DOWNTO 0); --imi indica bitul activ
  SIGNAL rxBuffer: STD_LOGIC_VECTOR(lungime_data - 1 DOWNTO 0) :=(OTHERS => '0');
  SIGNAL txBuffer: STD_LOGIC_VECTOR(lungime_data - 1 DOWNTO 0) :=(OTHERS => '0');
  
  BEGIN 
    busy <= NOT ss; --slavul este ocupat cand ss e activ ('0') 
    --busy devine 1 cand ss e activ adica slaveul e conectat si comunica
   
    modul <= cpol XOR cpha; --imi zice modul de lucru in fct de cpol si cpha
    
    --PROCESS pt generarea semnalului clk local pt slave
    
  PROCESS(modul, ss, sclk)
        BEGIN
         IF(ss = '1') then
          clk <= '0';
        
        ELSE 
          IF(modul = '1') then
             clk <= sclk;
           else
             clk <= NOT sclk;
          END IF;   
    END IF;
  END PROCESS;
  
  
  
    ---PROCESS pt biti activi 
    --semnalul bit_counter monitorizeaza progresul prin datele transmise/receptionate
      PROCESS(ss, clk)
  BEGIN
    IF(ss = '1' OR reset = '0') THEN
       bit_counter <= (conv_integer(NOT cpha) => '1', OTHERS => '0'); -- resetez contorul
    ELSE
      IF(rising_edge(clk)) THEN                                  
        bit_counter <= bit_counter(lungime_data - 1 DOWNTO 0) & '0';  --bit_counter se deplasez la stg pt a gasi bitul activ
      END IF;
    END IF;
  END PROCESS;


    -----PROCESUL MARE DE TRANSMITERE/RECEPTIE
    
    PROCESS(ss, clk, rx_enable, reset)
  BEGIN
  
  --PRIMESC bit MOSI
   IF(cpha = '0') THEN     --cpha 0 bitul e capturat pe frontul descendent daca e 1 e pe frontul ascendent
       IF(reset = '0') THEN
            rxBuffer <= (OTHERS => '0'); --daca toti bitii sunt setati la 0 reset buffer
       ELSIF(bit_counter /= "00000000000000010" AND falling_edge(clk)) THEN
   rxBuffer(lungime_data - 1 DOWNTO 0) <= rxBuffer(lungime_data - 2 DOWNTO 0) & mosi;
---                        rxBuffer(lungime_data - 2 DOWNTO 0) --> toti bitii din rxBuffer sunt deplasati la stg cu o poz

      END IF;
     ELSE --adica cand am cpha 1
		 IF(reset = '0') THEN       --reset the buffer
			rxBuffer <= (OTHERS => '0');
		 ELSIF(bit_counter /= "00000000000000001" and falling_edge(clk)) THEN
			rxBuffer(lungime_data - 1 DOWNTO 0) <= rxBuffer(lungime_data - 2 DOWNTO 0) & mosi;  --shift dreapta 
		 END IF;
	 END IF;
	 
	 --acum extrag datele receptionate
	 
	 IF(reset = '0') THEN
  rx <= (OTHERS => '0'); --daca resetu e activ iesirea rx e resetata la 0
  
  --actualizez iesirea rx
  ELSIF(ss = '1' AND rx_enable = '1') THEN  --ss e 1 inseamna ca masterul a terminat transmisia deci selectia slave dezactivata
    rx <= rxBuffer;          --rx_enable e 1 pt a face transferul de la rxBUffer la iesirea rx
END IF;


--PARTEA de transmisie a MISO
IF(reset = '0') THEN
  txBuffer <= (OTHERS => '0'); --toti bitii din buffer sunt setati la 0
  
 ELSIF(ss = '1') THEN  
  txBuffer <= tx;  --incarc datele in bufferul de transmisie
  
  ELSIF(bit_counter(lungime_data) = '0' AND rising_edge(clk)) THEN  --transferul registrilor 
  txBuffer(lungime_data - 1 DOWNTO 0) <= txBuffer(lungime_data - 2 DOWNTO 0) & txBuffer(lungime_data - 1);
  END IF;


 ---bit_counter(lungime_data) = '0 verifica daca am date in txBuffer
 --txBuffer(lungime_data - 2 DOWNTO 0) toti bitii sunt deplasati la stanga cu o poz
  -- txBuffer(lungime_data - 1) adaug bitul MSB la pozitia LSB

  --transmitrea bit cu bit pe linia MISO
  IF(ss = '1' OR reset = '0') THEN     --daca slavul nu e selectat '1'      
  miso <= 'Z';
    ELSIF(rising_edge(clk)) THEN
         miso <= txBuffer(lungime_data - 1);               
  END IF; 
  
 
 END PROCESS;
END Behavioral;
