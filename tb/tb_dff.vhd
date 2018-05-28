--------------------------------------------------------------------------------
-- Title       : TestBench of D-FlipFlop
-- Project     : DDFS
--------------------------------------------------------------------------------
-- File        : tb_dff.vhd
-- Language    : VHDL
-- Author      : Luca Pilato (luca.pilato@for.unipi.it)
-- Company     : UNIPI-DII
-- Created     : Wed Mar 29 11:22:38 CEST 2017
--------------------------------------------------------------------------------
-- Update      :
--------------------------------------------------------------------------------
-- Description :
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_dff is
end tb_dff;

architecture beh of tb_dff is

  component dff
    port (
        clk_dff     : in  std_logic;
        rst_dff     : in  std_logic; -- reset is active high, not low as usual, otherwise its trickier to be tested onto the ZYBO
        d_dff       : in  std_logic;
        q_dff       : out std_logic
    );
  end component dff;
  
  signal clk    : std_logic := '0';
  signal rst    : std_logic;
  signal d      : std_logic;

  constant clk_T  : time := 100 ns;  
  signal   clk_go : std_logic;
  
  
begin
  
  clk <= not clk after clk_T/2 when clk_go='1' else '0';

  i_dut: dff
  port map (
    clk_dff => clk    ,
    rst_dff => rst    ,
    d_dff   => d      ,
    q_dff   => open
  );
    

  drive_p: process
  begin
    rst     <= '1';
    d       <= '0';
    clk_go  <= '1';
    wait for 123 ns;    
    rst     <= '0';
    wait until rising_edge(clk);
    d       <= '1';
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    d       <= '0';
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    d       <= '1';
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait for 123 ns;
    rst     <= '1';
    wait until rising_edge(clk);
    d <= '0';
    wait for 123 ns;
    clk_go  <= '0';
    wait;
  end process drive_p;
    
end beh;