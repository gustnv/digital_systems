library ieee;
use ieee.std_logic_1164.all;

entity registrador is
	generic (n: integer:=8);
	port (
			clk, rst, enable: in std_logic;
			w: in std_logic_vector(n-1 downto 0);
			q: out std_logic_vector(n-1 downto 0)
			);
end registrador;

architecture arch of registrador is
begin
	process(rst, clk)
	begin
		if rst = '1' then 
			q <= (others => '0');
		elsif (rising_edge(clk)) then
			if enable = '1' then
				q <= w;
			end if;
		end if;
	end process;
	
end arch;
	
		