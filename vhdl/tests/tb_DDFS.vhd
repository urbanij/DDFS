---------------------------------------------
-- Title       : tb_DDFS
-- Project     : DDFS
---------------------------------------------
-- File        : tb_DDFS.vhd
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




entity tb_DDFS is
end entity tb_DDFS;



architecture struct of tb_DDFS is

	constant N       : positive := 12;
	constant M       : positive := 6;

	constant clk_per :  TIME     := 1 ns;  -- clk period

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
		
	signal clk_ext   : std_logic := '0';
	signal reset_ext : std_logic := '1';
	signal fw_ext    : std_logic_vector(N-1 downto 0);
	SIGNAL Testing   : Boolean := True;


	begin

		clk_ext <= NOT clk_ext AFTER clk_per/2 WHEN Testing;-- ELSE '0';

		i_dut1: DDFS
			generic map (N, M)
			port map(clk_ext, reset_ext, fw_ext, open);



		drive_p: process
	  	begin
	  		wait for 80 ns;
	  		reset_ext <= '0';

	  		fw_ext <= "000000000001"; 
	  		--fw_ext <= (others => '0');
	  		wait for 3 us;

	  		fw_ext <= "000000001100";
	  		wait for 810 ns;
	  		
	  		fw_ext <= "000000010000";
	  		wait for 40 ns;

	  		fw_ext <= "000000100000";
	  		wait for 280 ns;
	  		reset_ext <= '1';
	  		wait for 190 ns;
	  		reset_ext <= '0';
	  		wait for 710 ns;

	  		fw_ext <= "000010000000"; 
	  		wait for 140 ns;

	  		Testing <= False;
	  		wait;
	  	end process;

end architecture struct;


