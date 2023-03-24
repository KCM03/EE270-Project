----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2023 11:14:32
-- Design Name: 
-- Module Name: Display_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.SEGMENTS.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Display_TB is
--  Port ( );
end Display_TB;

architecture Behavioral of Display_TB is
signal SEGS :  SEVEN_SEGMENT(3 DOWNTO 0):= (OTHERS => (OTHERS => '0'));
SIGNAL CLK  :  STD_LOGIC:='0';
SIGNAL SEG  :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL AN   :  STD_LOGIC_VECTOR(3 DOWNTO 0);

begin

DOOR_ELEM: ENTITY WORK.Display 
PORT MAP(SEGS => SEGS,CLK=>CLK,SEG=>SEG,AN=>AN);

PROCESS
BEGIN
SEGS(0) <= (OTHERS => '0');
SEGS(1) <= (OTHERS => '1');
SEGS(2) <= (OTHERS => '0');
SEGS(3) <= (OTHERS => '1');

WAIT;
END PROCESS;


PROCESS
BEGIN
WHILE (NOW < 40e6 NS) LOOP

CLK <= '1'; WAIT FOR 5NS;
CLK <= '0'; WAIT FOR 5NS;
END LOOP;
wait;
END PROCESS;








end Behavioral;
