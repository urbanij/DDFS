---------------------------------------------
-- Title       : rca
-- Project     : DDFS
---------------------------------------------
-- File        : rca.vhd
-- Language    : VHDL
-- Author(s)   : francescourbani
-- Company     : 
-- Created     : Sat May  5 18:52:03 CEST 2018
---------------------------------------------
-- Description :
---------------------------------------------
-- Update      :
---------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
-- use ieee.std_logic_unsigned.all;
 use ieee.numeric_std.all;


entity rca is
	generic (
		N : positive := 12
	);

	port (
		x   : in  std_logic_vector(N -1 downto 0);
		y   : in  std_logic_vector(N -1 downto 0);
		c0  : in  std_logic;

		s   : out std_logic_vector(N -1 downto 0);
		cn  : out std_logic
	) ;
end entity ; -- rca



architecture struct of rca is
	
	-- declare component full adder (from fa.vhd)
	component fa
		port(
		x    : in std_logic;
		y    : in std_logic;
		cin  : in std_logic;

		s    : out std_logic;
		cout : out std_logic
	);
	end component;


	-- define an intermediate signal called c, of size N

	-- question: can i define a signal c sized 1 instead of Nbin? 
	-- after all i don't need all the values to be stored...
	signal c : std_logic_vector(N  downto 0); -- total size is N+1


begin
	
	-- initializing first an last element of signal c
	c(0) <= c0;     
	

	-- ripple carry adder generator
	GEN_RCA: for i in 0 to N-1 generate
		i_fa : fa
			port map( x(i), y(i), c(i), s(i), c(i+1) );
	end generate;

	cn <= c(N);


end architecture ; -- struct





