---------------------------------------------
-- Title       : fa
-- Project     : DDFS
---------------------------------------------
-- File        : fa.vhd
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
 use ieee.numeric_std.all;


entity fa is
	port(
		x, y , cin    : in  std_logic;
		s, cout       : out std_logic
	);
end entity fa;

architecture rtl of fa is
begin
	s    <= x xor y xor cin;
	cout <= ( x and y ) or ( x and cin ) or ( cin and y );
end architecture ;
