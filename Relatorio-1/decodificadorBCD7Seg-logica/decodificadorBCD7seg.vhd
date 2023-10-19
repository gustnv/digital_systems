library ieee;
use ieee.std_logic_1164.all;

entity decodificadorBCD7Seg is 
	port (
	bcd : in std_logic_vector(3 downto 0);
	abcdefg: out std_logic_vector(6 downto 0)
	);
end decodificadorBCD7Seg;

architecture arch of decodificadorBCD7Seg is
begin
abcdefg(0) <= (not(bcd(3)) and not(bcd(2)) and not(bcd(1)) and bcd(0)) or (bcd(2) and (not(bcd(1))) and not(bcd(0))) or (bcd(3) and bcd(1)) or(bcd(3) and bcd(2));

abcdefg(1) <= (bcd(2) and not(bcd(1)) and bcd(0)) or (bcd(2) and bcd(1) and not(bcd(0))) or (bcd(3) and bcd(1)) or (bcd(3) and bcd(2));

abcdefg(2) <= (not(bcd(2)) and bcd(1) and not(bcd(0))) or (bcd(3) and bcd(1)) or (bcd(3) and bcd(2));

abcdefg(3) <= (not(bcd(3)) and not(bcd(2)) and not(bcd(1)) and bcd(0)) or (bcd(2) and not(bcd(1)) and not(bcd(0))) or (bcd(2) and bcd(1) and bcd(0)) or (bcd(3) and bcd(1)) or (bcd(3) and bcd(2));

abcdefg(4) <= (bcd(2) and not(bcd(1))) or (bcd(3) and bcd(1)) or (bcd(0));

abcdefg(5) <= (not(bcd(3)) and not(bcd(2)) and bcd(0)) or (not(bcd(2)) and bcd(1)) or (bcd(1) and bcd(0)) or (bcd(3) and bcd(2));

abcdefg(6) <= (not(bcd(3)) and not(bcd(2)) and not(bcd(1))) or (bcd(2) and bcd(1) and bcd(0)) or (bcd(3) and bcd(1)) or (bcd(3) and bcd(2));

end arch;