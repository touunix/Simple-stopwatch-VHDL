----------------------------------------------------------------------------------
--
-- Modelowanie drga� zestyk�w (do symulacji)
-- Wersja: 0.1
--
-- in_i - wej�ciowy "czysty" sygna�
-- out_o - sygna� z dodanymi drganiami zestyk�w
-- 
-- min_time - minimalny czas pomi�dzy drganiami zestyk�w
-- max_time - maksymalny czas pomi�dzy drganiami zestyk�w
-- max_cnt - maksymalna liczba drga� zestyk�w (minimalna wynosi zawsze 0)
-- seed - ziarno dla generatora liczb pseudolosowych
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.MATH_REAL.ALL;

entity bounce is
    Generic ( min_time : TIME := 100 us;
              max_time : TIME := 1 ms;
              max_cnt : INTEGER := 2;
              seed : INTEGER := 777);
    Port ( in_i : in STD_LOGIC;
           out_o : out STD_LOGIC);
end bounce;

architecture Behavioral of bounce is

begin

process
variable seed1, seed2 : integer := seed;
variable rnd, rnd_scaled, min_real, max_real : real;
variable rnd_cnt : integer;
begin
  min_real := real(min_time / 1 ns);
  max_real := real(max_time / 1 ns);
  out_o <= in_i;
  loop
    wait on in_i;
    uniform(seed1, seed2, rnd);
    rnd_cnt := integer(floor(rnd * real(max_cnt + 1)));
    for i in 0 to rnd_cnt * 2 loop
      uniform(seed1, seed2, rnd);
      rnd_scaled := rnd * (max_real - min_real) + min_real;
      wait for rnd_scaled * 1 ns;
      if i mod 2 = 0 then
        out_o <= in_i;
      else
        out_o <= not in_i;
      end if;
    end loop;
  end loop;
end process;

end Behavioral;