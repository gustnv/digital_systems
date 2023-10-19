library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decodificadorBCD7Seg is 
	port (
	bcd : in std_logic_vector(3 downto 0);
	abcdefg: out std_logic_vector(6 downto 0)
	);
end decodificadorBCD7Seg;

architecture arch of decodificadorBCD7Seg is
begin
process(bcd) is
begin
	case bcd is
		when "0000" =>
			abcdefg <= "0000001";
		when "0001" => 
			abcdefg <= "1001111";
		when "0010" =>
			abcdefg <= "0010010";
		when "0011" => 
			abcdefg <= "0000110";
		when "0100" =>
			abcdefg <= "1001100";
		when "0101" =>
			abcdefg <= "0100100";
		when "0110" => 
			abcdefg <= "0100000";
		when "0111" =>
			abcdefg <= "0001111";
		when "1000" =>
			abcdefg <= "0000000";
		when "1001" => 
			abcdefg <= "0000100";
		when others =>
			abcdefg <= "1111111";
		end case;
	end process;
end arch;