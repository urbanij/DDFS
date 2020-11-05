---------------------------------------------
-- Title       : DDFS
-- Project     : DDFS
---------------------------------------------
-- File        : DDFS.vhd
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
use ieee.numeric_std.all;




entity DDFS is
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
end entity DDFS;



architecture struct of DDFS is

	component PhaseAccumulator is
		generic (
			N : positive --:= 12
		);	
		port(
			clk    : in  std_logic;
			rst    : in  std_logic;
			pa_in  : in  std_logic_vector(N-1 downto 0);
			pa_out : out std_logic_vector(N-1 downto 0)
		);
	end component;
		

	component LUT_DDFS is
		port (
			LUT_line : in  std_logic_vector(11 downto 0);
			LUT_data : out std_logic_vector(5 downto 0) 
		);
	end component;

	signal pa_to_LUT : std_logic_vector(N-1 downto 0); -- intermediate wire between PA and LUT


	begin

		i_PA: PhaseAccumulator
			generic map (N=>N)
			port map(clk, reset, fw, pa_to_LUT);

		i_LUT: LUT_DDFS
			port map(pa_to_LUT, yq);

end architecture struct;

