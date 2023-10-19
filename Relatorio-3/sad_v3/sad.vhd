library ieee;
use ieee.std_logic_1164.all;

entity sad is
	generic(
				x: integer := 8;
				y: integer := 5;
				z: integer := 14
				);
	port(
		mem_A		: in std_logic_vector(31 downto 0);
		mem_B		: in std_logic_vector(31 downto 0);
		clk		: in std_logic;
		rst 		: in std_logic;
		iniciar	: in std_logic;
		
		pronto 	: out std_logic;
		soma		: out std_logic_vector(z-1 downto 0);
		end1 		: out std_logic_vector(3 downto 0);
		read1 	: out std_logic
		
		);

end sad;

architecture arch of sad is

	signal menor, r_soma, r_csad, r_ci : std_logic;
	signal r_cpA, r_cpB, m_soma, m_zi  : std_logic;
	signal sSoma : std_logic_vector(z-1 downto 0);
	signal sRead, sPronto: std_logic;
	signal sEnd: std_logic_vector(3 downto 0);
	
	component BlocoControle is
		port(
			clk, rst 		: in std_logic;
			iniciar			: in std_logic;
			
			menor				: in std_logic;
			
			r_soma, r_csad	: out std_logic;
			r_ci				: out std_logic;
			r_cpA, r_cpB	: out std_logic;
			m_soma, m_zi	: out std_logic;
			
			read1, pronto 	: out std_logic
			);
	end component;
	
	---
	component blocoOperativo is
		generic(
				x: integer := 8;
				y: integer := 7;
				z: integer := 14
				);
				
		port (
			clk, rst 		: in std_logic;
			r_soma, r_csad	: in std_logic;
			r_ci				: in std_logic;
			r_cpA, r_cpB	: in std_logic;
			m_soma, m_zi	: in std_logic;
			mem_A, mem_B	: in std_logic_vector(31 downto 0);
			
			end1				: out std_logic_vector(3 downto 0);
			soma				: out std_logic_vector(13 downto 0);
			menor				: out std_logic
		);
	end component;
	
begin

operativo: blocoOperativo
	generic map (
				x => x,
				y => y,
				z => z
				)
	port map(clk 		=> clk,
				rst 		=> rst,
				r_soma	=> r_soma,
				r_csad	=> r_csad,
				r_ci		=> r_ci,
				r_cpA		=> r_cpA,
				r_cpB		=> r_cpB,
				m_soma	=> m_soma,
				m_zi		=> m_zi,
				mem_A		=> mem_A,
				mem_B		=> mem_B,
				end1		=> sEnd,
				soma		=> sSoma,
				menor 	=> menor
				);
---

controle: blocoControle
	port map(clk 		=> clk,
				rst 		=> rst,
				iniciar 	=> iniciar,
				menor 	=> menor,
				r_soma	=> r_soma,
				r_csad	=> r_csad,
				r_ci		=> r_ci,
				r_cpA		=> r_cpA,
				r_cpB		=> r_cpB,
				m_soma	=> m_soma,
				m_zi		=> m_zi,
				read1		=> sRead,
				pronto	=> sPronto
				);

	
soma <= sSoma;
read1 <= sRead;
pronto <= sPronto;
end1 <= sEnd;

end arch;