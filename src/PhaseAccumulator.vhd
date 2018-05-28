---------------------------------------------
-- Title       : PhaseAccumulator
-- Project     : DDFS
---------------------------------------------
-- File        : PhaseAccumulator.vhd
-- Language    : VHDL
-- Author(s)   : francescourbani
-- Company     : 
-- Created     : Thu May  3 15:50:48 2018
---------------------------------------------
-- Description :
---------------------------------------------
-- Update      :
---------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;




entity PhaseAccumulator is

	generic (
		N : positive := 12
	);
	
	port(
		clk    : in  std_logic;
		rst    : in  std_logic;
		pa_in  : in  std_logic_vector(N-1 downto 0);
		pa_out : out std_logic_vector(N-1 downto 0)
	);

end entity PhaseAccumulator;


architecture struct of PhaseAccumulator is
	
	-- calling the two components needed, i.e. the register and N-bits ripple carry adder

	component reg is
		generic (
			N : positive
		);
		port (
			clk     : in  std_logic;
			rst     : in  std_logic;
			d       : in  std_logic_vector(N-1 downto 0);
			q       : out std_logic_vector(N-1 downto 0)
		);
	end component reg;



	component rca is
		generic (
			N : positive
		);

		port (
			x   : in  std_logic_vector(N -1 downto 0);
			y   : in  std_logic_vector(N -1 downto 0);
			c0  : in  std_logic;

			s   : out std_logic_vector(N -1 downto 0);
			cn  : out std_logic
		) ;
	end component rca;


	-- defining two auxiliary signals
	signal kfw_s       : std_logic_vector(N-1 downto 0); -- wire on the "feedback loop" between the register and the RCA input
	signal kfw_next    : std_logic_vector(N-1 downto 0); -- wire between RCA and reg



	begin
	
	i_adder: rca
	    generic map (N)
	    port map (pa_in, kfw_s, '0', kfw_next, open);
	
	
	i_reg: reg 
		generic map(N)
		port map(clk, rst, kfw_next, kfw_s);

	pa_out <= kfw_s;

end architecture struct;




