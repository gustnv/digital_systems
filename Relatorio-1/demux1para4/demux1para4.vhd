library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity demux1para4 is 
	port (
	f : in std_logic;
	sel: in std_logic_vector(1 downto 0);
	a,b,c,d : out std_logic
	);
end demux1para4;

architecture arch of demux1para4 is
begin

a <= f when sel = "00" else '0';
b <= f when sel = "01" else '0';
c <= f when sel = "10" else '0';
d <= f when sel = "11" else '0';

end arch;