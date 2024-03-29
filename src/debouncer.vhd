LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;      --- basic logic implementation
USE IEEE.NUMERIC_STD.ALL;         --- converts and adds different types
USE IEEE.MATH_REAL.ALL;
use ieee.std_logic_unsigned.all;

ENTITY DEBOUNCER IS 
GENERIC(
CLK_FREQ    : INTEGER := 100_000_000;
STABLE_TIME : INTEGER := 100);
PORT(
 DIN,CLK :  IN STD_LOGIC;
 DOUT    : OUT STD_LOGIC);
 END DEBOUNCER;
 
 ARCHITECTURE LOGIC OF DEBOUNCER IS 
 SIGNAL FF1,FF2 : STD_LOGIC := '0'; --INPUT FLIP FLOPS (DOUBLE FLOPPING).
 SIGNAL RESET   : STD_LOGIC := '1'; -- RESET THE STABLE-TIME COUNTER.
 SIGNAL ENABLE  : STD_LOGIC :='0';  -- ENABLES THE OUTPUT FLIP-FLOP.
 BEGIN
 
 RESET <= FF2 XOR FF1; -- RESET GOES HIGH IF THE INPUT CHANGES (I.E., SERIAL FLIP FLOPS HAVE DIFFERENT OUTPUTS).
 
 PROCESS(CLK) -- CLOCK FLIP FLOPS.
 BEGIN
 IF RISING_EDGE(CLK) THEN
 FF2 <= FF1; -- double -flopped
 FF1 <= DIN; -- shift register
 END IF;     -- prevents metasability
 END PROCESS;
 
 PROCESS(CLK,RESET)
 VARIABLE COUNT : INTEGER RANGE 0 TO (CLK_FREQ / STABLE_TIME); -- INPUT MUST BE STABLE FOR COUNTER TO REACH 0.1S.
 BEGIN
 IF (RESET = '1') THEN
 COUNT := 0;
 ELSIF (RISING_EDGE(CLK)) THEN
 IF (COUNT >= CLK_FREQ/STABLE_TIME) THEN
 ENABLE <= '1';
 ELSE
 COUNT := COUNT +1;
 END IF;
END IF;
 END PROCESS;
 
 PROCESS(CLK)
 BEGIN
 IF (RISING_EDGE(CLK)) THEN
 IF ENABLE = '1' THEN
 DOUT <= FF2;
 END IF;
 END IF;
 END PROCESS;

 END LOGIC;
 



