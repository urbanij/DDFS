---------------------------------------------
-- Title       : tb_DDFS_QLUT
-- Project     : DDFS
---------------------------------------------
-- File        : tb_DDFS_QLUT.vhd
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
-- use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;




entity tb_DDFS_wrapper is
end entity tb_DDFS_wrapper;



architecture struct of tb_DDFS_wrapper is

	constant clk_per :  TIME     := 1 ns;  -- clk period

	component DDFS_WRAPPER is
		port (
			clk     : in  std_logic;                     -- L16
			reset   : in  std_logic;                     -- R18
			fw      : in  std_logic_vector( 3 downto 0); -- W13 P15 G15
			led     : out std_logic_vector( 3 downto 0); -- M14 M15 G14
			yq      : out std_logic_vector( 5 downto 0)  -- F20 H20 J19 L19 N20 H18
		);
	end component;


		
	signal clk_ext   : std_logic := '0';
	signal reset_ext : std_logic := '1';
	signal fw_ext    : std_logic_vector(3 downto 0);
	SIGNAL Testing   : Boolean := True;


	signal led   : std_logic_vector(3 downto 0);
	signal yq_s   : std_logic_vector( 5 downto 0);
  

	begin

		clk_ext <= NOT clk_ext AFTER clk_per/2 WHEN Testing;-- ELSE '0';

		i_dut1: DDFS_WRAPPER
			port map(clk_ext, reset_ext, fw_ext, led, yq_s );



		drive_p: process
	  	begin
	  		wait for 80 ns;
	  		reset_ext <= '0';

	  		fw_ext <= x"0";
	  		wait for 810 ns;
	  		
	  		fw_ext <= x"7";
	  		wait for 40 ns;

	  		fw_ext <= x"f";
	  		wait for 280 ns;
	  		reset_ext <= '1';
	  		wait for 190 ns;
	  		reset_ext <= '0';
	  		wait for 710 ns;

	  		fw_ext <= x"9"; 
	  		wait for 140 ns;

	  		Testing <= False;
	  		wait;
	  	end process;

end architecture struct;


