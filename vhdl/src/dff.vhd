---------------------------------------------
-- Title       : dff
-- Project     : DDFS
---------------------------------------------
-- File        : dff.vhd
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

entity dff is
    port (
        clk_dff     : in  std_logic;
        rst_dff     : in  std_logic; -- reset is active high, not low as usual, otherwise its trickier to be tested onto the ZYBO
        d_dff       : in  std_logic;
        q_dff       : out std_logic
    );

end dff;



architecture beh of dff is
begin

    dff_p: process(clk_dff, rst_dff) -- the process triggers whenever one of these
                                     -- 2 signals in the sensitivity list triggers

        begin
            if rst_dff='1' then 
                q_dff <= '0';
            elsif (clk_dff='1' and clk_dff'event) then
                q_dff <= d_dff;
            end if;
        end process dff_p;

end beh;
