library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity blocoOperativo is
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
		mem_A, mem_B	: in std_logic_vector(7 downto 0);
		
		end1				: out std_logic_vector(5 downto 0);
		soma				: out std_logic_vector(13 downto 0);
		menor				: out std_logic
	);
end blocoOperativo;

architecture arch of blocoOperativo is

	signal sAP1, sAP2	: std_logic_vector(x-1 downto 0);
	signal Sub1 		: unsigned(x downto 0);
	signal sSoma1_in 	: unsigned(z-1 downto 0);
	signal sSoma1_Out	: unsigned(z downto 0);
	signal sMux1_out 	: std_logic_vector(z-1 downto 0);
	signal sSoma_r_out: std_logic_vector(z-1 downto 0);
	signal sSaD_out	: std_logic_vector(z-1 downto 0);
	
	----------
	----------
	
	signal sMux2_out	: std_logic_vector(y-1 downto 0);
	signal sR_I_out	: std_logic_vector(y-1 downto 0);
	signal sSomaI_out	: unsigned(y downto 0);
	
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

	pA: registrador
		generic map (n => x)
		port map (
					clk		=> clk,
					rst 		=> rst,
					enable	=> r_cpA,
					w 			=> Mem_A,
					q 			=> sAp1
					);
					
	pB: registrador
		generic map (n => x)
		port map (
					clk 		=> clk,
					rst 		=> rst,
					enable	=> r_cpB,
					w 			=> Mem_B,
					q 			=> sAp2
					);
	
	Subtrator1 : subtrator
		generic map (n => x)
			port map (
						add1 => unsigned(sAp1),
						add2 => unsigned(sAp2),
						sum  => sub1
						);
						
	Som1 : somador
			generic map (n => z)
			port map (
						add1 => resize(unsigned(sub1), 14),
						add2 => unsigned(ssoma_r_out),
						sum  => sSoma1_Out
						);
						
	mux1 : mux2x1
			generic map (n => z)
			port map (
				sel	=> m_soma,
				e0		=> (std_logic_vector(sSoma1_Out)(13 downto 0)),
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
				e0		=> std_logic_vector(sSomaI_out)(y-1 downto 0),
				e1		=> "0000000",
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
			generic map (n => y)
			port map (
						add1 => "0000001",
						add2 => unsigned(sR_I_out),
						sum  => sSomaI_out
						);



end1 <= sr_I_out(y-2 downto 0);
menor <= not(sr_I_out(y-1));
soma <= sSaD_out;


end architecture;