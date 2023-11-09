library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture arch of testbench is

	signal	mem_A		: std_logic_vector(7 downto 0);
	signal	mem_B		: std_logic_vector(7 downto 0);
	signal	clk		: std_logic := '0';
	signal	rst 		: std_logic := '0';
	signal	iniciar	: std_logic := '0';
			
	signal	pronto 	: std_logic := '0';
	signal	soma		: std_logic_vector(13 downto 0);
	signal	end1 		: std_logic_vector(5 downto 0);
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
	
	
	process
	begin
			iniciar <= '0';
			wait for period;
			
			rst <= '1';
			wait for period;
			
			rst <= '0';
			wait for period;
			
			iniciar <= '1';

			Mem_A <= "00000101";
			Mem_B <= "00000001";
			
			wait for period;
			
			iniciar <= '0';
			
			wait for 33 * period;
			
			Mem_A <= "11111111";
			Mem_B <= "00001101";
			
			wait for 12 * period;
			
			Mem_A <= "00000111";
			Mem_B <= "11111111";
			
			wait for 21 * period;
			
			finished <= '1';
			
			wait for period;
			assert(soma="01111001000100")
			report "Fail" severity error;
			
			wait for period;
			assert false report "Test done." severity note;
			wait;
		end process;
	
end arch;