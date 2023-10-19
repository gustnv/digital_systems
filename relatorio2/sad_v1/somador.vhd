library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador is
	generic (n: integer := 8);
	port (
	add1, add2: in unsigned(n-1 downto 0);
	sum : out unsigned(n downto 0)
	);

end somador;

architecture arch of somador is
begin
	sum <= resize(add1, n+1) + resize(add2, n+1);

end architecture;