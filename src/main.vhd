----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2023 10:10:50
-- Design Name: 
-- Module Name: main - Behavioral
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
package display is
  type SEGMENT is array (natural range <>) of std_logic_vector(6 downto 0);
end package;
package body display is
end package body;
--------------------------------------------- Output type declarations
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.display.all;

entity main is
PORT(
SWITCH   : IN std_logic_vector(5 downto 0);
TRY,CLK  :  IN STD_LOGIC_VECTOR;
LEDs     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
SEGS     : OUT SEGMENT(0 TO 3));

end main;

architecture Behavioral of main is
TYPE STATE IS (LOCKED, UNLOCKED,WARNING);
begin


end Behavioral;
