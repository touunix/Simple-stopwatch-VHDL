-- Mateusz Gabryel 181329 EiT 3
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use STD.STANDARD.ALL;

ENTITY top_display IS
  PORT ( led7_seg_o: out STD_LOGIC_VECTOR(7 downto 0):= "00000000";
		 led7_an_o: out STD_LOGIC_VECTOR(3 downto 0):= "0000";
		 digit_i: in STD_LOGIC_VECTOR(31 downto 0);
	     display_clk: in STD_LOGIC; 
	     rst_i: in STD_LOGIC
		);
END top_display;

ARCHITECTURE Behavioral OF top_display IS
signal counter_display : INTEGER := 0; --licznik do rejestru
BEGIN
WITH counter_display SELECT --realizacja przypisania selektywnego do realizacji rejestru przesuwnego
    led7_an_o <= "0111" WHEN 1, -- AN3
                 "1011" WHEN 2, -- AN2
                 "1101" WHEN 3, -- AN1
                 "1110" WHEN 4, -- AN0
                 "0000" WHEN OTHERS;
    WITH counter_display SELECT
    led7_seg_o <= digit_i(31 downto 24) WHEN 1, -- AN3
                  digit_i(23 downto 16) WHEN 2, -- AN2
                  digit_i(15 downto 8) WHEN 3,  -- AN1
                  digit_i(7 downto 0) WHEN 4,   -- AN0
                  "00000000" WHEN OTHERS;

PROCESS (display_clk, rst_i)

BEGIN
    if(rst_i = '1') then -- reset
        counter_display <= 0;
    elsif(rising_edge(display_clk)) then
            if(counter_display=4) then  -- zmiana z AN0 na AN3 (symulacja)
                counter_display <= 1;   -- AN3
            else
                counter_display <= counter_display+1; -- dalsze kroki rejestru przesuwnego
            END if;
        END if;
END PROCESS;     
END Behavioral;