

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use work.display.all;






ENTITY DOOR_TB IS 
END DOOR_TB;



ARCHITECTURE LOGIC OF DOOR_TB IS

SIGNAL SWITCH   :   std_logic_vector(5 downto 0) := (OTHERS => '0');
SIGNAL TRY,CLK  :  STD_LOGIC := '0';
SIGNAL LEDs     : STD_LOGIC_VECTOR(15 DOWNTO 0)  := (OTHERS => '0');
SIGNAL SEGS     : SEVEN_SEGMENT(0 TO 3)  := (OTHERS =>(OTHERS => '0'));
SIGNAL UNLCK    :  STD_LOGIC;

BEGIN
DOOR_ELEM: ENTITY WORK.DOOR 
PORT MAP(SWITCH => SWITCH,TRY => TRY,CLK=>CLK,LEDs => LEDs,SEGS=>SEGS,UNLCK=>UNLCK);


PROCESS
BEGIN
SWITCH <= "000000"; TRY<= '0'; WAIT FOR 10e6 NS;
SWITCH <= "100101"; TRY<= '1'; WAIT FOR 10e6 NS;
TRY <= '0'; WAIT FOR 10e6 NS;
SWITCH <= "111111"; TRY<= '1'; WAIT FOR 10e6 NS;
TRY <= '0'; wait for 10e6 ns;
WAIT;
END PROCESS;


PROCESS
BEGIN
WHILE (NOW < 40e6 NS) LOOP

CLK <= '1'; WAIT FOR 5NS;
CLK <= '0'; WAIT FOR 5NS;
END LOOP;


END PROCESS;
END LOGIC;