
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

entity main is
GENERIC(
S       : std_logic_vector:= "1011010";
H       : std_logic_vector:= "0010111";
U       : std_logic_vector:= "0011100";
T       : std_logic_vector:= "0001111";

CLK_FREQ : INTEGER := 50_000_000);
PORT(
SWITCH   :  IN std_logic_vector(5 downto 0);
TRY,CLK  :  IN STD_LOGIC;
LEDs     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
SEGS     : OUT SEVEN_SEGMENT(0 TO 3));

end main;

architecture Behavioral of main is
TYPE STATE IS (LOCKED, UNLOCKED,WARNING);
SIGNAL SWITCH_DEB : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL TRY_DEB : STD_LOGIC;
SIGNAL POSITION : STATE := LOCKED;


begin

DEB_GEN: FOR I IN 5 DOWNTO 0 GENERATE

DEB_ELEM : ENTITY WORK.DEBOUNCER 
PORT MAP(DIN => SWITCH(I),DOUT => SWITCH_DEB(I),CLK=>CLK);
END GENERATE;

PROCESS(CLK)
BEGIN
------------------------------------------------
CASE (POSITION) IS 

WHEN LOCKED =>
LEDS <= (OTHERS => '0'); --LIGHTS OFF
                         -- DOOR READS "LOCK"
SEGS(0) <= S;  
SEGS(1) <= h;  
SEGS(2) <= u;  
SEGS(3) <= t; 
            
------------------------------------------------
WHEN UNLOCKED =>

LEDS <= (OTHERS => '0');
SEGS(0) <= O;  
SEGS(1) <= p; 
SEGS(2) <= e; 
SEGS(3) <= n; 
------------------------------------------------
WHEN WARNING =>



END CASE;
END PROCESS;
end Behavioral;
