library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtrator is
	generic (n: integer := 8);
	port (
	add1, add2: in unsigned(n-1 downto 0);
	sum : out unsigned(n downto 0)
	);

end subtrator;

architecture arch of subtrator is
begin
	sum <= unsigned(abs(signed(resize(add1, n+1)) - signed(resize(add2, n+1))));

end architecture;