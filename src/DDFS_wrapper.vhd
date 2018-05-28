---------------------------------------------
-- Title       : DDFS_wrapper
-- Project     : DDFS
---------------------------------------------
-- File        : DDFS_wrapper.vhd
-- Language    : VHDL
-- Author(s)   : francescourbani
-- Company     : 
-- Created     : Wed May 16 19:46:56 CEST 2018
---------------------------------------------
-- Description :
---------------------------------------------
-- Update      :
---------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity DDFS_WRAPPER is
	port (
		clk     : in  std_logic;                     -- L16
		reset   : in  std_logic;                     -- R18
		fw      : in  std_logic_vector( 3 downto 0); -- W13 P15 G15
		led     : out std_logic_vector( 3 downto 0); -- M14 M15 G14
		yq      : out std_logic_vector( 5 downto 0)  -- F20 H20 J19 L19 N20 H18
	);
end DDFS_WRAPPER;



architecture rtl of DDFS_WRAPPER is
	component DDFS_QLUT
		port (
			clk     : in  std_logic;                     -- suppose @125MHz
			reset   : in  std_logic ;                    -- asynch, active high
			fw      : in  std_logic_vector(11 downto 0); -- frequency word
			yq      : out std_logic_vector( 5 downto 0)  -- sin quantized
		);
	end component;
	
	signal fw_ext : std_logic_vector(11 downto 0);
	signal yq_s   : std_logic_vector( 5 downto 0);
  
  
begin

	fw_ext <= "00000000" & fw;

	i_DDFS : DDFS_QLUT
	port map (
		clk       => clk,
		reset     => reset,
		fw        => fw_ext,
		yq        => yq_s
	);

	led <= fw;	
	yq  <= (not yq_s(5)) & yq_s(4 downto 0);

end rtl;



