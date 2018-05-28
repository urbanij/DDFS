---------------------------------------------
-- Title       : tb_phaseaccumulator
-- Project     : DDFS
---------------------------------------------
-- File        : tb_phaseaccumulator.vhd
-- Language    : VHDL
-- Author(s)   : francescourbani
-- Company     : 
-- Created     : Mon May 14 11:18:18 CEST 2018
---------------------------------------------
-- Description :
---------------------------------------------
-- Updates     : Mon May 14 11:18:31 CEST 2018: 
--               - passing

---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_phaseaccumulator is
end tb_phaseaccumulator;


architecture rtl of tb_phaseaccumulator is
	

	constant N       : positive := 12;

	component PhaseAccumulator is
		generic (N : positive := 12);
		
		port(
			clk    : in  std_logic;
			rst    : in  std_logic;
			pa_in  : in  std_logic_vector(N-1 downto 0);
			pa_out : out std_logic_vector(N-1 downto 0)
		);
	end component;


	signal clk_ext   : std_logic                      := '0';
	signal rst_ext   : std_logic                      := '1';
	signal pa_in_ext : std_logic_vector(N-1 downto 0) := "000000010001";
	
	signal Testing   : Boolean                         := True;
	constant clk_per :  TIME                           := 1 ns;  -- clk period



	begin 
		clk_ext <= NOT clk_ext AFTER clk_per/2 WHEN Testing;-- ELSE '0';


		dut : PhaseAccumulator
		port map(clk_ext, rst_ext, pa_in_ext, open);


		drive_p: process
	  	begin

	  		wait for 50 ns;

	  		pa_in_ext <= "000000000000";
	  		wait for 50 ns;

	  		pa_in_ext <= "000000000001";
	  		wait for 70 ns;

	  		rst_ext   <= '0';
	  		wait for 10 ns;

	  		pa_in_ext <= "000000000011"; -- 3
	  		wait for 50 ns;
	  		
	  		rst_ext <= '1';
	  		wait for 110 ns;
	  		rst_ext <= '0';

	  		wait for 1500 ns;

	  		pa_in_ext <= "000000001011"; --11
	  		wait for 32 ns;
	  		rst_ext <= '1';
	  		wait for 90 ns;
	  		rst_ext <= '0';

	  		wait for 800 ns;

	  		pa_in_ext <= "000000100000"; --32
	  		wait for 800 ns;

	  		Testing <= False;
	  		wait;
	  	end process;

end rtl;

