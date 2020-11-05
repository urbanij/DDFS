---------------------------------------------
-- Title       : tb_rca
-- Project     : DDFS
---------------------------------------------
-- File        : tb_rca.vhd
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


entity tb_rca is
end entity ; -- tb_rca


architecture struct of tb_rca is
	
	-- declare component full adder (from fa.vhd)
	component rca is
		generic (
		N : positive := 12
		);

		port (
			x   : in  std_logic_vector(N-1 downto 0);
			y   : in  std_logic_vector(N-1 downto 0);
			c0  : in  std_logic;

			s   : out std_logic_vector(N-1 downto 0);
			cn  : out std_logic
		) ;
	end component;

	constant N       : positive := 12;
	signal c : std_logic := '0';
	signal x_ext : std_logic_vector(N-1 downto 0) := "000001110010";
	signal y_ext : std_logic_vector(N-1 downto 0) := "111000011111";


begin
	
	dut: rca 
	generic map (N)
	port map (x_ext, y_ext, c, open ,open);



		drive_p: process
	  	begin
	  		x_ext <= "000000000111";
	  		y_ext <= "011110000111";
	  		wait for 50 ns;

	  		c <= '1';

	  		wait for 23 ns;

	  		x_ext <= "000000010001";
	  		wait for 19 ns;

	  		x_ext <= "000011010111";
	  		wait for 100 ns;

	  		wait for 12 ns;
	  		c <= '0';

	  		y_ext <= "000110011011";
	  		wait for 4 ns;

	  		x_ext <= "000000000111";
	  		wait for 40 ns;

	  		x_ext <= "111111110111";
	  		y_ext <= "110111111111";
	  		wait for 90 ns;

	  		c <= '1';
	  		wait for 89 ns ;
	  		y_ext <= "010110011000";
	  		x_ext <= "000110000111";
	  		wait for 33 ns;
	  		wait;

	  	end process;


	  	-- COVERAGE:
		-- figura di merito per determinare quanto il test bench copre tutte le casistiche
		-- si usa in progetti grandi
		-- coverage 100% significa che tutti i casi sono stati coperti dal test bench.


end architecture ; -- struct





