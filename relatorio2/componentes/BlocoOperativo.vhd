library ieee;
use iee.std_logic_1164.all;

entity blocoOperativo is
	generic(
			x: integer(8));
	port (
		r_soma,r_csad,r_ci, r_cpA, r_cpB: in std_logic;
		m_soma, m_zi: in std_logic;
		mem_A, mem_B: in std_logic_vector(7 downto 0);
		
		end1: out std_logic_vector(5 downto 0);
		soma: out std_logic_vector(13 downto 0);
		menor: out std_logic
	);
end blocoOperativo;

architecture arch of blocoOperativo is

	signal sABS: std_logic_vector(7 downto 0);
	signal sABS2, sSoma_v, sSoma2_v, sSaD_reg:  std_logic_vector(13 downto 0);
	signal si: std_logic_vector(6 downto 0);
	signal si2: std_logic_vector(5 downto 0);
	signal sSoma_i: std_logic_vector(6 downto 0);

begin

end architecture;