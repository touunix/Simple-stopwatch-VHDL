-- Mateusz Gabryel 181329 EiT 3
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.STANDARD.ALL;

ENTITY top_stoper IS
    PORT ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           start_stop_button_i : in STD_LOGIC;
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
          );
END top_stoper;

ARCHITECTURE Behavioral OF top_stoper IS

COMPONENT top_divider is
    PORT ( clk_i: in STD_LOGIC;
           rst_i: in STD_LOGIC;
           clk_divider: out STD_LOGIC
          );
END COMPONENT;
 
COMPONENT top_display IS
	PORT ( led7_seg_o: out STD_LOGIC_VECTOR(7 downto 0);
		   led7_an_o: out STD_LOGIC_VECTOR(3 downto 0);
		   digit_i: in STD_LOGIC_VECTOR(31 downto 0);
	       display_clk: in STD_LOGIC;
	       rst_i: in STD_LOGIC
		  );
END COMPONENT;
    
COMPONENT top_part IS
	PORT ( part: in STD_LOGIC_VECTOR(3 downto 0);
		   digit_i: out STD_LOGIC_VECTOR(6 downto 0)
		  );
END COMPONENT;
    
signal digit_i: STD_LOGIC_VECTOR (31 downto 0):= "11000000110000001100000011000000";
signal clk_o: STD_LOGIC;
type stan_lista IS (START, STOP, RESET);
signal stan, n_stan: stan_lista := RESET;
signal ms_AN0: STD_LOGIC_VECTOR (3 downto 0):= "0000"; -- jednosci ms
signal ms_AN1: STD_LOGIC_VECTOR (3 downto 0):= "0000"; -- dziesiatki ms
signal s_AN2: STD_LOGIC_VECTOR (3 downto 0):= "0000";  -- jednosci s
signal s_AN3: STD_LOGIC_VECTOR (3 downto 0):= "0000";  -- dziesiatki s
signal counter: INTEGER := 0; -- licznik
signal rst_o: STD_LOGIC := '1';
signal rst_n: STD_LOGIC :='0';
signal s_sync, s_sync_old: STD_LOGIC := '0';
signal s_stable: STD_LOGIC := '0';

BEGIN

divider: top_divider
    PORT MAP ( clk_i => clk_i,
               rst_i => '0',
               clk_divider => clk_o
              );

display: top_display
    PORT MAP ( led7_seg_o => led7_seg_o,
               led7_an_o => led7_an_o,
               digit_i => digit_i,
               display_clk => clk_o,
               rst_i => rst_i
              );

AN0: top_part
    PORT MAP ( part =>ms_AN0,
               digit_i => digit_i(7 downto 1)
              );

AN1: top_part
    PORT MAP ( part => ms_AN1,
               digit_i => digit_i(15 downto 9)
              );

AN2: top_part
    PORT MAP ( part =>s_AN2,
               digit_i =>digit_i(23 downto 17)
              );

AN3: top_part
    PORT MAP ( part =>s_AN3,
               digit_i =>digit_i(31 downto 25)
              );

PROCESS(clk_i)
variable opoznienie: INTEGER;
BEGIN

    if(rising_edge(clk_i)) then
        stan <= n_stan;
        s_sync <= start_stop_button_i;
        s_sync_old <= s_stable;  

        if (s_sync = s_stable) then
            opoznienie :=0;
        else
            opoznienie := opoznienie + 1;
        END if;
        if (opoznienie = 1000000) then
            s_stable <= s_sync;
            opoznienie := 0;
        END if;

        if(stan = START) then
            if(s_AN3 = "1111" and s_AN2 = "1111" and ms_AN1 = "1111" and ms_AN0 = "1111") then -- start/reset po przepelnieniu
                counter <=0;
            else
                counter <= counter +1;
            END if;
            
            if(counter = 1000000) then
                counter <=0;
                ms_AN0 <= ms_AN0 + 1;
            END if;
            
            if(ms_AN0 = "1010") then -- 9 na AN0 - czyli na jednosci ms
                ms_AN0 <= "0000";
                ms_AN1 <= ms_AN1 + 1;
            END if;
            
            if(ms_AN1 = "1010") then -- 9 na AN1 - czyli na dziesiatki ms
                ms_AN1 <= "0000";
                s_AN2 <= s_AN2 + 1;
            END if;
            
            if(s_AN2 = "1010") then -- 9 na AN@ - czyli na jednosci s
                s_AN2 <= "0000";
                s_AN3 <= s_AN3 + 1;
            elsif(s_AN3 = "0101" and s_AN2 = "1001" and ms_AN1 = "1001" and ms_AN0 = "1001") then -- przepelnienie
                s_AN3 <= "1111";
                s_AN2 <= "1111";
                ms_AN1 <= "1111";
                ms_AN0 <= "1111";
                counter <= 0;
            END if;
            
        elsif(stan = STOP) then -- STOP, zatrzymanie
            counter <=0;
        elsif(stan = RESET) then -- RESET, wyzerowanie
            counter <=0;
            ms_AN0 <= "0000";
            ms_AN1 <= "0000";
            s_AN2 <= "0000";
            s_AN3 <= "0000";
        END if;
    END if;
END PROCESS;

PROCESS(rst_i, stan, s_stable, s_sync_old, rst_o, rst_n) -- dzialanie przcysiku po nacisnieciu
BEGIN
    if (rst_i = '1') then
        rst_o <= '0';
        rst_n <= '1';
    elsif (rst_i = '0') then
        rst_o <= '1';
        rst_n <= '0';
    END if;
    
    if (s_stable = '1' and s_sync_old = '0') then
        CASE stan IS
            WHEN START => n_stan <= STOP;
            WHEN STOP => n_stan <= RESET;
            WHEN RESET => n_stan <= START;
        END CASE;
    elsif (rst_o = '0' and rst_n = '1') then
        n_stan <= RESET;
    else
        n_stan <= stan;
    END if;
END PROCESS;

digit_i(0) <= '1';  -- wylaczenie kropki dla AN0
digit_i(8) <= '1';  -- wylaczenie kropki dla AN1
digit_i(16) <= '0'; -- wlaczenie kropki dla AN2
digit_i(24) <= '1'; -- wylaczenie kropki dla AN3

END Behavioral;