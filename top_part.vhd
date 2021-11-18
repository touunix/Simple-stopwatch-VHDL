-- Mateusz Gabryel 181329 EiT 3
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use STD.STANDARD.ALL;

ENTITY top_part IS
    PORT ( part : in STD_LOGIC_VECTOR (3 downto 0);
           digit_i : out STD_LOGIC_VECTOR (7 downto 1):="1111111");
END top_part;

ARCHITECTURE Behavioral OF top_part IS

BEGIN

WITH part SELECT
	digit_i <= "0000001" WHEN "0000",  -- 0
               "1001111" WHEN "0001",  -- 1
               "0010010" WHEN "0010",  -- 2
               "0000110" WHEN "0011",  -- 3
               "1001100" WHEN "0100",  -- 4
               "0100100" WHEN "0101",  -- 5
               "0100000" WHEN "0110",  -- 6
               "0001111" WHEN "0111",  -- 7
               "0000000" WHEN "1000",  -- 8
               "0000100" WHEN "1001",  -- 9
		       "1111110" WHEN OTHERS;  -- znak przepelnienia
END Behavioral;