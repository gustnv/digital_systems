library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux2x1 is
	generic(n: integer:= 8);
	port (sel: in std_logic;
			e0,e1:  in std_logic_vector(n-1 downto 0);
			saida:  out std_logic_vector(n-1 downto 0) );
	end mux2x1;

architecture mux of mux2x1 is
begin 
  with sel select saida <= e0 when '0',
	                       e1 when others;
end mux;
