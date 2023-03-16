
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
package display is
  type SEVEN_SEGMENT is array (natural range <>) of std_logic_vector(6 downto 0);
end package;
package body display is
end package body;
--------------------------------------------- Output type declarations
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
library work;
use work.display.all;

entity DOOR is
GENERIC(
S       : std_logic_vector(6 DOWNTO 0):= "1011010";
H       : std_logic_vector(6 DOWNTO 0):= "0010111";
U       : std_logic_vector(6 DOWNTO 0):= "0011100";
T       : std_logic_vector(6 DOWNTO 0):= "0001111";

O       : std_logic_vector(6 DOWNTO 0):= "1111110";
P       : std_logic_vector(6 DOWNTO 0):= "1100111";
E       : std_logic_vector(6 DOWNTO 0):= "1011111";
N       : std_logic_vector(6 DOWNTO 0):= "0010101";

PASSWORD : STD_LOGIC_VECTOR(5 DOWNTO 0):= "111111";
CLK_FREQ : INTEGER := 50_000_000);
PORT(
SWITCH   :  IN std_logic_vector(5 downto 0);
TRY,CLK  :  IN STD_LOGIC;
LEDs     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
SEGS     : OUT SEVEN_SEGMENT(0 TO 3));

end DOOR;

architecture Behavioral of DOOR is
TYPE STATE IS (LOCKED, UNLOCKED,WARNING);
SIGNAL SWITCH_DEB : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL TRY_DEB    : STD_LOGIC;
SIGNAL POSITION   : STATE := LOCKED;
SIGNAL LED_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0);


begin

DEB_GEN: FOR I IN 5 DOWNTO 0 GENERATE

DEB_ELEM : ENTITY WORK.DEBOUNCER 
PORT MAP(DIN => SWITCH(I),DOUT => SWITCH_DEB(I),CLK=>CLK);
END GENERATE;

PROCESS(CLK,TRY_DEB)
VARIABLE COUNT : INTEGER RANGE 0 TO CLK_FREQ*10:= 0;
VARIABLE BLINK : INTEGER RANGE 0 TO CLK_FREQ:= 0;

BEGIN

LEDs <= LED_SIGNAL;
------------------------------------------------
CASE (POSITION) IS 
------------------------------------------------
WHEN LOCKED =>
LED_SIGNAL <= (OTHERS => '0'); --LIGHTS OFF
                         
SEGS(0) <= S;  
SEGS(1) <= h;  
SEGS(2) <= u;  
SEGS(3) <= t; 
 
IF(RISING_EDGE(TRY_DEB)) THEN
IF (SWITCH_DEB = PASSWORD) THEN
COUNT := 0;
POSITION <= UNLOCKED;
ELSE
COUNT := 0;
POSITION <= WARNING;
END IF;
END IF;

------------------------------------------------
WHEN UNLOCKED =>

LED_SIGNAL <= (OTHERS => '0');
SEGS(0) <= O;  
SEGS(1) <= p; 
SEGS(2) <= e; 
SEGS(3) <= n; 

IF (RISING_EDGE(CLK)) THEN
IF (COUNT >= CLK_FREQ*10) THEN
COUNT := 0;
POSITION <= LOCKED;
ELSE 
COUNT := COUNT + 1;
END IF;
END IF;
------------------------------------------------
WHEN WARNING =>

SEGS(0) <= S;  
SEGS(1) <= h;  
SEGS(2) <= u;  
SEGS(3) <= t;

IF (RISING_EDGE(CLK)) THEN
IF (BLINK>= CLK_FREQ) THEN
LED_SIGNAL <= NOT(LED_SIGNAL);
BLINK := 0;
ELSE
BLINK := BLINK + 1;
END IF;


IF (COUNT >= CLK_FREQ*5) THEN
COUNT := 0;
POSITION <= LOCKED;
ELSE 
COUNT := COUNT + 1;
END IF;
END IF;

END CASE;
END PROCESS;
end Behavioral;
