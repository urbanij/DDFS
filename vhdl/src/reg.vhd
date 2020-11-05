--------------------------------------------------------------------------------
-- Title       : Nbits register
-- Project     : DDFS
--------------------------------------------------------------------------------
-- File        : reg.vhd
-- Language    : VHDL
-- Author      : Luca Pilato (luca.pilato@for.unipi.it)
-- Company     : UNIPI-DII
-- Created     : Wed Mar 29 11:22:38 CEST 2017
--------------------------------------------------------------------------------
-- Update      :
--------------------------------------------------------------------------------
-- Description : Parallel IN / Parallel OUT register
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity reg is
	generic (N : positive := 12);
	port (
		clk     : in  std_logic;
		rst     : in  std_logic;
		d       : in  std_logic_vector(N-1 downto 0);
		q       : out std_logic_vector(N-1 downto 0)
	);
end reg;


architecture rtl of reg is

  component dff
	port (
		clk_dff     : in  std_logic;
		rst_dff     : in  std_logic;
		d_dff       : in  std_logic;
		q_dff       : out std_logic
	);
	end component dff;

	begin

	reg_gen: for i in 0 to N-1 generate
		i_dff : dff
		  port map (clk, rst, d(i), q(i));
	end generate reg_gen;
  
end rtl;


