library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity blocoOperativo is
	generic(
			x: integer := 8;
			y: integer := 5;
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
end blocoOperativo;

architecture arch of blocoOperativo is

	signal sPA0, sPB0 : std_logic_vector(x-1 downto 0);
	signal sPA1, sPB1 : std_logic_vector(x-1 downto 0);
	signal sPA2, sPB2 : std_logic_vector(x-1 downto 0);
	signal sPA3, sPB3 : std_logic_vector(x-1 downto 0);
	
	signal Sub0, Sub1 : unsigned(x downto 0);
	signal Sub2, Sub3 : unsigned(x downto 0);
	
	signal sSoma0_Out	: unsigned(8 downto 0);
	signal sSoma1_Out	: unsigned(8 downto 0);
	signal sSoma2_Out	: unsigned(9 downto 0);
	signal sSoma3_in  : unsigned(z-1 downto 0);
	signal sSoma3_out : unsigned(z downto 0);
	
	signal sMux1_out 	: std_logic_vector(z-1 downto 0);
	signal sSoma_r_out: std_logic_vector(z-1 downto 0);
	signal sSaD_out	: std_logic_vector(z-1 downto 0);
	
	----------
	----------
	
	signal sMux2_out	: std_logic_vector(y-1 downto 0);
	signal sR_I_out	: std_logic_vector(y-1 downto 0);
	signal sSomaI_out	: unsigned(y-1 downto 0);
	
	----------
	----------
	
	component somador is
		generic (n: integer := 8);
		port (
			add1, add2: in unsigned(n-1 downto 0);
			sum : out unsigned(n downto 0)
			);
	end component;
		
		
	component registrador is
		generic (n: integer:=8);
		port (
				clk, rst, enable: in std_logic;
				w: in std_logic_vector(n-1 downto 0);
				q: out std_logic_vector(n-1 downto 0)
				);
	end component;

	
	component subtrator is
		generic (n: integer := 8);
		port (
			add1, add2: in unsigned(n-1 downto 0);
			sum : out unsigned(n downto 0)
			);
	end component;

	component mux2x1 is
		generic(n: integer:= 8);
		port (
				sel: in std_logic;
				e0,e1:  in std_logic_vector(n-1 downto 0);
				saida:  out std_logic_vector(n-1 downto 0) );
	end component;
	
	----------
	----------
	
begin

	pA0: registrador
		generic map (n => x)
		port map (
					clk		=> clk,
					rst 		=> rst,
					enable	=> r_cpA,
					w 			=> Mem_A(7 downto 0),
					q 			=> sPA0
					);
					
	pB0: registrador
		generic map (n => x)
		port map (
					clk 		=> clk,
					rst 		=> rst,
					enable	=> r_cpB,
					w 			=> Mem_B(7 downto 0),
					q 			=> SPB0
					);
					
	pA1: registrador
		generic map (n => x)
		port map (
					clk		=> clk,
					rst 		=> rst,
					enable	=> r_cpA,
					w 			=> Mem_A(15 downto 8),
					q 			=> sPA1
					);
					
	pB1: registrador
		generic map (n => x)
		port map (
					clk 		=> clk,
					rst 		=> rst,
					enable	=> r_cpB,
					w 			=> Mem_B(15 downto 8),
					q 			=> SPB1
					);
					
	pA2: registrador
		generic map (n => x)
		port map (
					clk		=> clk,
					rst 		=> rst,
					enable	=> r_cpA,
					w 			=> Mem_A(23 downto 16),
					q 			=> sPA2
					);
					
					
	pB2: registrador
		generic map (n => x)
		port map (
					clk 		=> clk,
					rst 		=> rst,
					enable	=> r_cpB,
					w 			=> Mem_B(23 downto 16),
					q 			=> SPB2
					);
					
	pA3: registrador
		generic map (n => x)
		port map (
					clk		=> clk,
					rst 		=> rst,
					enable	=> r_cpA,
					w 			=> Mem_A(31 downto 24),
					q 			=> sPA3
					);
					
	pB3: registrador
		generic map (n => x)
		port map (
					clk 		=> clk,
					rst 		=> rst,
					enable	=> r_cpB,
					w 			=> Mem_B(31 downto 24),
					q 			=> SPB3
					);
	---
	---
	
	Subtrator0 : subtrator
		generic map (n => x)
			port map (
						add1 => unsigned(SPA0),
						add2 => unsigned(SPB0),
						sum  => sub0
						);
						
	Subtrator1 : subtrator
		generic map (n => x)
			port map (
						add1 => unsigned(SPA1),
						add2 => unsigned(SPB1),
						sum  => sub1
						);
						
	Subtrator2 : subtrator
		generic map (n => x)
			port map (
						add1 => unsigned(SPA2),
						add2 => unsigned(SPB2),
						sum  => sub2
						);
						
	Subtrator3 : subtrator
		generic map (n => x)
			port map (
						add1 => unsigned(SPA3),
						add2 => unsigned(SPB3),
						sum  => sub3
						);
	
						
	Som0 : somador
			generic map (n => x)
			port map (
						add1 => unsigned(sub0(x-1 downto 0)),
						add2 => unsigned(sub1(x-1 downto 0)),
						sum  => sSoma0_Out
						);
						
	Som1 : somador
			generic map (n => x)
			port map (
						add1 => unsigned(sub2(x-1 downto 0)),
						add2 => unsigned(sub3(x-1 downto 0)),
						sum  => sSoma1_Out
						);
	Som2 : somador
				generic map (n => x+1)
				port map (
							add1 => unsigned(sSoma0_Out),
							add2 => unsigned(sSoma1_Out),
							sum  => sSoma2_Out
							);
	
	Som3 : somador
				generic map (n => z)
				port map (
							add1 => resize(unsigned(sSoma2_Out), 14),
							add2 => unsigned(ssoma_r_out),
							sum  => sSoma3_out
							);
							
	mux1 : mux2x1
			generic map (n => z)
			port map (
				sel	=> m_soma,
				e0		=> (std_logic_vector(sSoma3_out)(13 downto 0)),
				e1		=> "00000000000000",
				saida	=> sMux1_out
						);

	reg_soma : registrador
			generic map (n => z)
			port map (
						clk		=> clk,
						rst 		=> rst,
						enable	=> r_soma,
						w 			=> smux1_out,
						q 			=> ssoma_r_out
						);
						
	SAD_reg : registrador
			generic map (n => z)
			port map (
						clk		=> clk,
						rst 		=> rst,
						enable	=> r_csad,
						w 			=> ssoma_r_out,
						q 			=> sSaD_out
						);
						
						
		----------------------
		----------------------
		
		
	mux2 : mux2x1
			generic map (n => y)
			port map (
				sel	=> m_zi,
				e0		=> std_logic_vector(sSomaI_out),
				e1		=> "00000",
				saida	=> sMux2_out
						);
						
	reg_I : registrador
			generic map (n => y)
			port map (
						clk		=> clk,
						rst 		=> rst,
						enable	=> r_ci,
						w 			=> smux2_out,
						q 			=> sR_I_out
						);
						
	sum2 : somador
			generic map (n => y-1)
			port map (
						add1 => "0001",
						add2 => unsigned(sR_I_out(y-2 downto 0)),
						sum  => sSomaI_out
						);



end1 <= sr_I_out(y-2 downto 0);
menor <= not(sr_I_out(y-1));
soma <= sSaD_out;


end architecture;