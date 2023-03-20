
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
library work;
use work.SEGMENTS.all;

entity DOOR is
GENERIC(                           --abcdefg.
S : std_logic_vector(7 DOWNTO 0):=  "01001011"; --constants
H : std_logic_vector(7 DOWNTO 0):=  "11010001";
U : std_logic_vector(7 DOWNTO 0):=  "11000111"; -- inverted;LED 
T : std_logic_vector(7 DOWNTO 0):=  "11100001"; -- Goes high at '0'.

O : std_logic_vector(7 DOWNTO 0):=  "00000011"; --last bit is 
P : std_logic_vector(7 DOWNTO 0):=  "00110001"; --decimal pt.
E : std_logic_vector(7 DOWNTO 0):=  "01100001"; 
N : std_logic_vector(7 DOWNTO 0):=  "11010101";

PASSWORD : STD_LOGIC_VECTOR(5 DOWNTO 0):= "111111";
CLK_FREQ : INTEGER := 100_000_000);
PORT(
SWITCH   :  IN std_logic_vector(5 downto 0); --constraint done
TRY,CLK  :  IN STD_LOGIC; 
LEDs     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); 
SEG     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);--notdone
AN       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --notdone
UNLCK    : OUT STD_LOGIC); -- FOR _TB, REMOVE LATER.

end DOOR;

architecture Behavioral of DOOR is
TYPE STATE IS (LOCKED, UNLOCKED,WARNING);
SIGNAL SWITCH_DEB : STD_LOGIC_VECTOR(5 DOWNTO 0); --debounced switch
SIGNAL TRY_DEB    : STD_LOGIC; --debounced button
SIGNAL POSITION   : STATE := LOCKED; -- tracks state
SIGNAL LED_SIGNAL : STD_LOGIC_VECTOR(15 DOWNTO 0); -- buffered led output
SIGNAL TRY_EDGE   : STD_LOGIC_VECTOR(1 DOWNTO 0); -- button edge detection
SIGNAL SEGS       : SEVEN_SEGMENT(3 DOWNTO 0);
begin

DEB_GEN: FOR I IN 5 DOWNTO 0 GENERATE

DEB_ELEM : ENTITY WORK.DEBOUNCER  -- attach debouncers to switches
PORT MAP(DIN => SWITCH(I),DOUT => SWITCH_DEB(I),CLK=>CLK);
END GENERATE;

TRY_DEBOUNCE : ENTITY WORK.DEBOUNCER --attach debouncer to button
PORT MAP(DIN => TRY, DOUT => TRY_DEB, CLK => CLK);


DISP : ENTITY WORK.DISPLAY --attach debouncer to button
PORT MAP(SEGS => SEGS, SEG=> SEG, AN=>AN, CLK => CLK);



LEDs <= LED_SIGNAL; --pass led buffer to leds



PROCESS(CLK,TRY_DEB)
VARIABLE COUNT : INTEGER RANGE 0 TO CLK_FREQ*10:= 0; --state counter
VARIABLE BLINK : INTEGER RANGE 0 TO CLK_FREQ:= 0; --led blink counter
BEGIN

IF RISING_EDGE(CLK) THEN --global clock
TRY_EDGE <= TRY_EDGE(0) & TRY_DEB; -- shift register/ button edge detect
------------------------------------------------
CASE (POSITION) IS --door state machine
------------------------------------------------
WHEN LOCKED =>
LED_SIGNAL <= (OTHERS => '0'); --LIGHTS OFF
UNLCK  <= '0';      -- DOOR LOCKED              
SEGS(0) <= S;   -- prints SHUT
SEGS(1) <= h;  
SEGS(2) <= u;  
SEGS(3) <= t; 
 
IF(TRY_EDGE = "01") THEN  -- if button rising edge
IF (SWITCH_DEB = PASSWORD) THEN -- if password match
COUNT := 0;
POSITION <= UNLOCKED; --goto unlocked
ELSE
COUNT := 0;
POSITION <= WARNING; --goto warning
END IF;
END IF;
------------------------------------------------
WHEN UNLOCKED =>
LED_SIGNAL <= (OTHERS => '0'); -- lights off
UNLCK  <= '1';     
SEGS(0) <= O;   --print open
SEGS(1) <= p; 
SEGS(2) <= e; 
SEGS(3) <= n; 

--IF (RISING_EDGE(CLK)) THEN
IF (COUNT >= CLK_FREQ*10/1000) THEN -- if the counter is at 10s
COUNT := 0; --reset count
POSITION <= LOCKED; --goto locked
ELSE 
COUNT := COUNT + 1; --else increment count
END IF;
--END IF;

IF COUNT <= CLK_FREQ*1/1000 THEN --- LED COUNTDOWN
LED_SIGNAL <= "1111111111000000";
ELSIF COUNT <= CLK_FREQ*2/1000 THEN
LED_SIGNAL <= "1111111110000000";
ELSIF COUNT <= CLK_FREQ*3/1000 THEN
LED_SIGNAL <= "1111111100000000";
ELSIF COUNT <= CLK_FREQ*4/1000 THEN
LED_SIGNAL <= "1111111000000000";
ELSIF COUNT <= CLK_FREQ*3/1000 THEN
LED_SIGNAL <= "1111110000000000";
ELSIF COUNT <= CLK_FREQ*5/1000 THEN
LED_SIGNAL <= "1111100000000000";
ELSIF COUNT <= CLK_FREQ*6/1000 THEN
LED_SIGNAL <= "1111000000000000";
ELSIF COUNT <= CLK_FREQ*7/1000 THEN
LED_SIGNAL <= "1110000000000000";
ELSIF COUNT <= CLK_FREQ*8/1000 THEN
LED_SIGNAL <= "1100000000000000";
ELSIF COUNT <= CLK_FREQ*9/1000 THEN
LED_SIGNAL <= "1000000000000000";
ELSE
LED_SIGNAL <= (OTHERS => '0');
END IF;
------------------------------------------------
WHEN WARNING =>
UNLCK  <= '0';     
SEGS(0) <= S;  
SEGS(1) <= h;  
SEGS(2) <= u;  
SEGS(3) <= t;

--IF (RISING_EDGE(CLK)) THEN
IF (BLINK>= CLK_FREQ/1000) THEN -- blink counter is at 1s
LED_SIGNAL <= NOT(LED_SIGNAL); --flips leds on/off
BLINK := 0; -- reset count
ELSE
BLINK := BLINK + 1; -- else increment counter
END IF;


IF (COUNT >= CLK_FREQ*5/1000) THEN  -- if state counter is at 5s (COUNT >= CLK_FREQ*5)
COUNT := 0; -- reset count;
POSITION <= LOCKED; --goto locked
ELSE 
COUNT := COUNT + 1; -- else increment count
END IF;
--END IF;

END CASE;
END IF;
END PROCESS;
end Behavioral;
