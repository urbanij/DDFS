---------------------------------------------
-- Title       : tb_LUT_DDFS
-- Project     : DDFS
---------------------------------------------
-- File        : tb_LUT_DDFS.vhd
-- Language    : VHDL
-- Author(s)   : francescourbani
-- Company     : 
-- Created     : 
---------------------------------------------
-- Description :
---------------------------------------------
-- Update      :
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_LUT_DDFS is
end tb_LUT_DDFS;


architecture rtl of tb_LUT_DDFS is

	component LUT_DDFS is
		port (
		    LUT_line : in  std_logic_vector(11 downto 0);
		    LUT_data : out std_logic_vector(5 downto 0) 
		);
	end component;


	signal LUT_in : std_logic_vector(11 downto 0);


	begin 

		dut : LUT_DDFS
			port map(LUT_in, open);

		drive_p: process
	  	begin
	  		LUT_in <= "000000000000";
	  		wait for 10 ns;
	  		
	  		LUT_in <= "000100010011";
	  		wait for 20 ns;

	  		LUT_in <= "000101010011";
	  		wait for 20 ns;

	  		LUT_in <= "000101011011";
	  		wait for 20 ns;
	  		
	  		LUT_in <= "000100011111";
	  		wait for 130 ns;
	  		wait;
	  	end process;

end rtl;