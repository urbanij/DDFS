---------------------------------------------
-- Title       : tb_fa
-- Project     : RippleCarryAdder
---------------------------------------------
-- File        : tb_fa.vhd
-- Language    : VHDL
-- Author(s)   : francescourbani
-- Company     : 
-- Created     : Tue May 15 20:57:19 CEST 2018
---------------------------------------------
-- Description :
---------------------------------------------
-- Update      :
---------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
-- use ieee.std_logic_unsigned.all;
 use ieee.numeric_std.all;


entity tb_fa is
end entity tb_fa;



architecture rtl of tb_fa is
	

	constant step :  TIME     := 20 ns; 

	component fa is 
		port(
			x    : in std_logic;
			y    : in std_logic;
			cin  : in std_logic;

			s    : out std_logic;
			cout : out std_logic
		);
	end component;
	

	signal a : std_logic;
	signal b : std_logic;
	signal c : std_logic; -- external signals


begin
	dut: fa
	port map (a, b, c, open, open);

	proc: process
	begin
		a <= '0';
		b <= '0';
		c <= '0';
		wait for step;

		a <= '0';
		b <= '1';
		c <= '0';
		wait for step;

		a <= '1';
		b <= '0';
		c <= '0';
		wait for step;

		a <= '0';
		b <= '0';
		c <= '1';
		wait for step;

		a <= '1';
		b <= '1';
		c <= '0';
		wait for step;

		a <= '0';
		b <= '1';
		c <= '1';
		wait for step;
		
		a <= '1';
		b <= '1';
		c <= '1';
		wait for step;

		a <= '1';
		b <= '0';
		c <= '0';
		wait for step;

		a <= '0';
		b <= '0';
		c <= '1';
		wait for step;

		wait ;
	end process;



end architecture ; -- rtl

