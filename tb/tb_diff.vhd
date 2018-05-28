---------------------------------------------
-- Title       : tb_diff
-- Project     : DDFS
---------------------------------------------
-- File        : tb_diff.vhd
-- Language    : VHDL
-- Author(s)   : francescourbani
-- Company     : 
-- Created     : Thu May 17 00:19:32 CEST 2018
---------------------------------------------
-- Description :
---------------------------------------------
-- Update      :
---------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_diff is
end entity ;


architecture arch of tb_diff is
	component DDFS is
			generic (
				N : positive := 12;
				M : positive := 6
			);
			port(
				clk   : in  std_logic;                      -- clk @ 125 MHz
				reset : in  std_logic;                      -- async reset
				fw    : in  std_logic_vector(N-1 downto 0); -- frequency word
				yq    : out std_logic_vector(M-1 downto 0)  -- sin quantized. M is the size
			);

	end component;


	component DDFS_QLUT is
			generic (
				N : positive := 12;
				M : positive := 6
			);
			port(
				clk   : in  std_logic;                      -- clk @ 125 MHz
				reset : in  std_logic;                      -- async reset
				fw    : in  std_logic_vector(N-1 downto 0); -- frequency word
				yq    : out std_logic_vector(M-1 downto 0)  -- sin quantized. M is the size
			);

	end component;

	constant N       : positive := 12;
	constant M       : positive := 6;
	constant clk_per :  TIME     := 1 ns;  -- clk period

	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	signal fw_ext : std_logic_vector(N-1 downto 0);
	signal yq1 : std_logic_vector(M-1 downto 0); 
	signal yq2 : std_logic_vector(M-1 downto 0);
	signal diff: std_logic;
	signal Testing :boolean := True;

begin

	clk <= NOT clk AFTER clk_per/2 WHEN Testing;-- ELSE '0';


	i_dut1 : DDFS
	port map(clk, rst, fw_ext, yq1);

	i_dut2 : DDFS_QLUT
	port map(clk, rst, fw_ext, yq2);

	
	-- SET DIFF TO 1 WHEN yq1 and yq2 are different
	diff <= '1' when yq1/=yq2 else '0';
	
	drive_p: process
	  	begin
	  		wait for 80 ns;
	  		rst <='0';
	  		fw_ext <= "000000001000"; 
	  		wait for 440 ns;
	  		Testing <= False;
	  		wait;
	  	end process;	


end architecture ; -- arch