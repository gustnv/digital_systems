library ieee;
use ieee.std_logic_1164.all;

entity BlocoControle is
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

end blocoControle;

architecture arch of blocoControle is
	
	type states is (S0, S1, S2, S3, S4, S5);
	signal atual, prox: states;

begin
REG: process(clk, rst)
    begin

        if rst = '1' then
            atual <= S0;
        
        elsif (rising_edge(clk)) then
            atual <= prox;
        
        end if;
end process;
	 
COMB: process(atual, iniciar, menor)
	begin   

        case (atual) is

            when s0 =>  if iniciar = '1' then
									prox <= s1;
								else
									prox <= s0;
								end if;
				
					  r_soma <= '0';
					  r_csad <= '0';
					  r_ci	<= '0';
					  r_cpA	<= '0';
					  r_cpB 	<= '0';
					  m_soma <= '0';
					  m_zi 	<= '0';
					  read1	<= '0';
					  pronto <= '1';
				
				---
				when s1 => prox <= s2;
				
					  r_soma <= '1';
					  r_csad <= '0';
					  r_ci	<= '1';
					  r_cpA	<= '0';
					  r_cpB 	<= '0';
					  m_soma <= '1';
					  m_zi 	<= '1';
					  read1	<= '0';
					  pronto <= '0';
				
				---
				when s2 =>  if menor = '1' then
									prox <= s3;
								else
									prox <= s5;
								end if;
				
					  r_soma <= '0';
					  r_csad <= '0';
					  r_ci	<= '0';
					  r_cpA	<= '0';
					  r_cpB 	<= '0';
					  m_soma <= '0';
					  m_zi 	<= '0';
					  read1	<= '0';
					  pronto <= '0';
					  
				---
				when s3 => prox <= s4;
				
					  r_soma <= '0';
					  r_csad <= '0';
					  r_ci	<= '0';
					  r_cpA	<= '1';
					  r_cpB 	<= '1';
					  m_soma <= '0';
					  m_zi 	<= '0';
					  read1	<= '1';
					  pronto <= '0';
					  
				---
				when s4 => prox <= s2;
				
					  r_soma <= '1';
					  r_csad <= '0';
					  r_ci	<= '1';
					  r_cpA	<= '0';
					  r_cpB 	<= '0';
					  m_soma <= '0';
					  m_zi 	<= '0';
					  read1	<= '0';
					  pronto <= '0';
				
				---
				when s5 => prox <= s0;
				
					  r_soma <= '0';
					  r_csad <= '1';
					  r_ci	<= '0';
					  r_cpA	<= '0';
					  r_cpB 	<= '0';
					  m_soma <= '0';
					  m_zi 	<= '0';
					  read1	<= '0';
					  pronto <= '0';
			end case;            
		end process;
					
end arch;