library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
package SEGMENTS is
  type SEVEN_SEGMENT is array (natural range <>) of std_logic_vector(7 downto 0);
end package;
package body SEGMENTS is --create new type to store vectors
end package body;

----------------------------------------------------


Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
library work;
use work.SEGMENTS.all;

entity DISPLAY is
GENERIC(
CLK_FREQ : INTEGER := 100_000_000);
PORT(
SEGS : IN SEVEN_SEGMENT(3 DOWNTO 0);
CLK  : IN STD_LOGIC;
SEG  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
AN   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END DISPLAY;

ARCHITECTURE LOGIC OF DISPLAY IS 
SIGNAL CLK_1MS : STD_LOGIC:= '0';
BEGIN


PROCESS(CLK) -- generate 1ms clock
VARIABLE COUNT : INTEGER RANGE 0 TO CLK_FREQ := 0;
BEGIN
IF (RISING_EDGE(CLK)) THEN
IF (COUNT >= CLK_FREQ/1000) THEN --1second / 1 thousand = 1ms
COUNT := 0;
CLK_1MS <= NOT(CLK_1MS);
ELSE
COUNT := COUNT + 1;
END IF;
END IF;
END PROCESS;


PROCESS(CLK_1MS)
VARIABLE COUNT: INTEGER RANGE 0 TO 3 := 0;
BEGIN

IF RISING_EDGE(CLK_1MS) THEN

IF (COUNT = 3) THEN
COUNT := 0;
SEG <= SEGS(3);
AN <= (3 => '0', others => '1');

ELSIF (COUNT = 2) THEN
COUNT := COUNT +1;
SEG <= SEGS(2);
AN <= (2 => '0', others => '1');

ELSIF (COUNT = 1) THEN
COUNT := COUNT + 1;
SEG <= SEGS(1);
AN <= (1 => '0', others => '1');

ELSIF (COUNT = 0) THEN
COUNT := COUNT + 1;
SEG <= SEGS(0);
AN <= (0 => '0', others => '1');

END IF;
END IF;

END PROCESS;
END LOGIC;


