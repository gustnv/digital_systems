library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4para1 is 
	generic (n: positive:= 1);
	port (
	a,b,c,d : in std_logic_vector(n-1 downto 0);
	sel: in std_logic_vector(1 downto 0);
	y : out std_logic_vector(n-1 downto 0)
	);
end mux4para1;

architecture arch of mux4para1 is
begin
	with sel select y <= a when "00",
								b when "01",
								c when "10",
								d when others;
	
end arch;