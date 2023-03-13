
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
library work;
use work.display.all;

entity main is
GENERIC(
CLK_FREQ : INTEGER := 50_000_000);
PORT(
SWITCH   :  IN std_logic_vector(5 downto 0);
TRY,CLK  :  IN STD_LOGIC_VECTOR;
LEDs     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
SEGS     : OUT SEVEN_SEGMENT(0 TO 3));

end main;

architecture Behavioral of main is
TYPE STATE IS (LOCKED, UNLOCKED,WARNING);
SIGNAL SWITCH_DEB : STD_LOGIC_VECTOR(5 DOWNTO 0):
SIGNAL TRY_DEB : STD_LOGIC;


END COMPONENT

begin

DEB_GEN: FOR I IN 5 DOWNTO 0 GENERATE

DEB_ELEM : ENTITY WORK.DEBOUNCER
PORT MAP(DIN => SWITCH(I),DOUT => SWITCH_DEB(I),CLK=>CLK);
END GENERATE;

CASE STATE IS 

WHEN LOCKED =>

WHEN UNLOCKED =>

WHEN WARNING =>

END CASE;

end Behavioral;
