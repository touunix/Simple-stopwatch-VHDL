-- Mateusz Gabryel 181329 EiT 3
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY tb IS
END tb;

ARCHITECTURE Behavioral OF tb IS

COMPONENT top_stoper IS
    PORT ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           start_stop_button_i : in STD_LOGIC;
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
          );
END COMPONENT top_stoper;

COMPONENT bounce IS
   GENERIC ( min_time : TIME := 100 us;
              max_time : TIME := 1 ms;
              max_cnt : INTEGER := 2;
              seed : INTEGER := 777);
    PORT ( in_i : in STD_LOGIC;
           out_o : out STD_LOGIC);
END COMPONENT bounce;

signal clk_i: STD_LOGIC := '0';
signal btn_o: STD_LOGIC:= '0';
signal btn_o_bounce: STD_LOGIC:= '0';
signal rst_i: STD_LOGIC := '0';
signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0);
signal led7_an_o : STD_LOGIC_VECTOR (3 downto 0);
constant PERIOD : TIME := 10 ns; -- 100 MHz

BEGIN

uut: top_stoper 
    PORT MAP ( clk_i => clk_i,
               rst_i =>  rst_i,
              start_stop_button_i => btn_o_bounce,
              led7_seg_o => led7_seg_o,
              led7_an_o => led7_an_o
             );

uut_2: bounce
    PORT MAP ( in_i => btn_o,
               out_o => btn_o_bounce
              );
 
clk_i <= NOT clk_i AFTER PERIOD/2; -- realizacja prostego zegara

tb:PROCESS
   BEGIN
        WAIT FOR 10 ms;
            btn_o <= '1'; -- start
        WAIT FOR 30 ms;
            btn_o <= '0'; 
        WAIT FOR  1290 ms; -- wcisniecie startu po 1,29 s - czyli zatrzymanie
            btn_o <= '1';
        WAIT FOR 50 ms;
            btn_o <= '0';
        WAIT FOR 150 ms;
            btn_o <= '1'; -- start
        WAIT FOR 30 ms;
            btn_o <= '0';
        WAIT FOR 50 ms;
            btn_o <= '1'; -- zatrzymanie  
        WAIT FOR 30 ms;
            btn_o <= '0';
        WAIT FOR 50 ms;
            rst_i <= '1'; -- reset asynchroniczny
        WAIT FOR 5 ms;
            rst_i <= '0';
        WAIT FOR 15 ms;
     WAIT;
END PROCESS;
END Behavioral;