-- Mateusz Gabryel 181329 EiT 3
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use STD.STANDARD.ALL;

ENTITY top_divider IS
    PORT ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           clk_divider : out STD_LOGIC
          );
END top_divider;

ARCHITECTURE Behavioral OF top_divider IS

constant N : INTEGER := 50000;

signal a : INTEGER := 1; --licznik
signal b : STD_LOGIC := '0'; --zegar po dzieleniu

BEGIN
PROCESS (clk_i, rst_i,a ,b)
BEGIN
    if (rst_i = '1') then
        a <= 1;
        b <= '0';
    elsif (rising_edge(clk_i)) then
        a <= a + 1;
        if (a=N) then
            b <= NOT b;
            a <= 1;
        END if;
    END if;
-- przepisanie wynikow na diode led
clk_divider <= b;

END PROCESS;
END Behavioral;