--------------------------------------------------------------------------------
-- Title       : Nbits register
-- Project     : DDFS
--------------------------------------------------------------------------------
-- File        : tb_reg.vhd
-- Language    : VHDL
-- Author      : francescourbani
-- Company     : UNIPI-DII
-- Created     : Tue May 15 16:15:05 CEST 2018
--------------------------------------------------------------------------------
-- Update      :
--------------------------------------------------------------------------------
-- Description :
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
-- use ieee.std_logic_unsigned.all;
-- use ieee.numeric_std.all;




entity tb_reg is
end tb_reg;


architecture rtl of tb_reg is

	constant N       : positive := 12;

	component reg is
		generic (N : positive := 12);
		port (
			clk     : in  std_logic;
			rst     : in  std_logic;
			d       : in  std_logic_vector(N-1 downto 0);
			q       : out std_logic_vector(N-1 downto 0)
		);
	end component;


	signal clk_ext : std_logic := '0';
	signal reset : std_logic := '0';
	signal d_in : std_logic_vector(N-1 downto 0);
	

	SIGNAL Testing: Boolean := True;
	constant clk_per :  TIME     := 20 ns;  -- clk period


	begin 
		clk_ext <= NOT clk_ext AFTER clk_per/2 WHEN Testing;-- ELSE '0';


		i_dut: reg 
			generic map (N)
			port map(clk_ext, reset, d_in, open);




		drive_p: process
	  	begin
	  		d_in <= "000000000111";
	  		wait for 50 ns;

	  		d_in <= "000000000001";
	  		wait for 2 ns;

	  		reset   <= '1';
	  		wait for 19 ns;

	  		reset <= '0';
	  		wait for 22 ns;

	  		d_in <= "000000000111";
	  		wait for 100 ns;

	  		d_in <= "000000000111";
	  		wait for 40 ns;

	  		d_in <= "000110000111";
	  		wait for 33 ns;

	  		Testing <= False;
	  		wait;
	  	end process;

	  	-- it works! Tue May 15 16:12:51 CEST 2018



end rtl;


