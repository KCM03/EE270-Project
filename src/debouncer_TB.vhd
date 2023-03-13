----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2023 11:04:58
-- Design Name: 
-- Module Name: debouncer_TB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer_TB is
--  Port ( );
end debouncer_TB;


architecture Behavioral of debouncer_TB is
signal DIN,CLK,DOUT : STD_LOGIC := '0';

component DEBOUNCER 
port(
DIN,CLK :  IN STD_LOGIC;
 DOUT    : OUT STD_LOGIC:= '0');
end component;
for D1: DEBOUNCER use entity work.DEBOUNCER(LOGIC);
begin

D1 : DEBOUNCER PORT MAP(DIN=>DIN,CLK=>CLK,DOUT=>DOUT);

PROCESS
BEGIN

DIN <= '1' AFTER 5e6 ns;

WAIT;
END PROCESS;

PROCESS
BEGIN
WHILE (NOW <= 20e6 NS ) LOOP
CLK <= '1'; WAIT FOR 10NS;
CLK <= '0'; WAIT FOR 10NS;
END LOOP;
WAIT;
END PROCESS;
end Behavioral;
