---------------------------------------------
-- Title       : DDFS_Q_LUT
-- Project     : DDFS
---------------------------------------------
-- File        : DDFS_Q_LUT.vhd
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




entity DDFS_QLUT is
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
end entity DDFS_QLUT;



architecture struct of DDFS_QLUT is

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
		

	component Q_LUT is
		port (
			LUT_line : in  std_logic_vector(11 downto 0);
			LUT_data : out std_logic_vector(5 downto 0) 
		);
	end component;

	component mux2to1 is 
		port (
			i0   : in std_logic;
			i1   : in std_logic;
			s    : in std_logic;
			f    : out std_logic
			) ;
	end component;


	-- SIGNALS DEFINITIONS

	signal pa_out      : std_logic_vector(N-1 downto 0); -- size N
	signal not_pa_out  : std_logic_vector(N-1 downto 0);


	
	signal lut_to_mux2     : std_logic_vector(M-1 downto 0); -- size M
	signal not_lut_to_mux2 : std_logic_vector(M-1 downto 0);

	signal mux1_to_lut        : std_logic_vector(N-3 downto 0); -- size N-2
	-- had to make this like that because the concatenation seemed not to be allowed inside port map
	signal mux1_to_lut_actual : std_logic_vector(N-1 downto 0);



	begin

		-- initialization of signals defined before the begin
		not_pa_out         <= not pa_out;
		not_lut_to_mux2    <= not lut_to_mux2;
		mux1_to_lut_actual <= "00" & mux1_to_lut;


		-- instantiation components
		i_PA: PhaseAccumulator
			generic map (N=>N)
			port map(clk, reset, fw, pa_out);

		i_LUT: Q_LUT
			port map(  mux1_to_lut_actual, lut_to_mux2);


		mux_gen_before_lut: for i in 0 to N-3 generate
			i_mux1: mux2to1
			port map(pa_out(i), 
				     not_pa_out(i), 
				     pa_out(N-2), 
				     mux1_to_lut(i)
			);
		end generate;


		mux_gen_after_lut: for i in 0 to M-1 generate
			i_mux2: mux2to1
			port map(lut_to_mux2(i), 
				     not_lut_to_mux2(i), 
				     pa_out(N-1), 
				     yq(i)
			);
		end generate;




end architecture struct;




