library IEEE;
use IEEE.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity testbench is
end testbench;

architecture arch of testbench is

	signal	mem_A		: std_logic_vector(31 downto 0);
	signal	mem_B		: std_logic_vector(31 downto 0);
	signal	clk		: std_logic := '0';
	signal	rst 		: std_logic := '0';
	signal	iniciar	: std_logic := '0';
			
	signal	pronto 	: std_logic := '0';
	signal	soma		: std_logic_vector(13 downto 0);
	signal	end1 		: std_logic_vector(3 downto 0);
	signal	read1 	: std_logic := '0';
	signal 	finished	: std_Logic := '0';

	constant period: time := 20 ns;

begin

	dut: 	entity work.sad
		port map(mem_A 	=> mem_A,
					mem_B 	=> mem_B,
					clk 		=> clk,
					rst 		=> rst,
					iniciar 	=> iniciar,
					pronto 	=> pronto,
					soma 		=> soma,
					end1 		=> end1,
					read1 	=> read1);
			
	clk <= not clk after period/2 when finished /= '1' else '0';


	stim: process is
	file arquivo_de_estimulos : text open read_mode is "..\..\estimulos.dat";
	variable linha_de_estimulos: line; 
	variable espaco : character;
	variable valor_de_entrada_A, valor_de_entrada_B : bit_vector(31 downto 0);
	variable valor_de_saida: bit_vector(13 downto 0);

	begin
		rst <= '1';
		iniciar <= '0';
		wait for period;
		rst <= '0';
		wait for period;
		iniciar <= '1';


	
	while not endfile(arquivo_de_estimulos) loop
		readline(arquivo_de_estimulos, linha_de_estimulos);
				
		for i in 0 to 15 loop 
	
			wait for 3 * period;
			
			read(linha_de_estimulos, valor_de_entrada_A);
			Mem_A <= to_stdlogicvector(valor_de_entrada_A);
			read(linha_de_estimulos, espaco);
			read(linha_de_estimulos, valor_de_entrada_B);
			Mem_B <= to_stdlogicvector(valor_de_entrada_B);
		
		end loop;
	
		read(linha_de_estimulos, espaco);
		read(linha_de_estimulos, valor_de_saida);
		
	wait for 4 * period;
			assert(soma = to_stdlogicvector(valor_de_saida))
			report
				"Falha na simulacao."
			severity error;
		end loop;
				
		wait for period;

		assert false report "Test done." severity note;
		finished <= '1';
		wait;
	end process;
end arch;
		
	
	
	
	
	
	