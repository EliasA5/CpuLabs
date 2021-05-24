library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;

ENTITY tb is
    constant n : integer := 8;
end tb;

architecture rtb of tb is
    signal rst,clk : std_logic;
	signal upperBound : std_logic_vector(n-1 downto 0);
	signal countOut : std_logic_vector(n-1 downto 0);
    signal enable : std_logic := '1';
begin
    L0 : modc port map(rst,enable,clk,upperBound,countOut);
    -- added enable bit
    gen_clk : process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= not clk;
        wait for 50 ns;
    end process;

    tester_1: process
    begin
        upperBound <= (others =>'0');
        wait for 200 ns;
        upperBound <= upperBound + 1;
        wait for 250 ns;
        upperBound <= upperBound + 1;
        wait for 1000 ns;
        upperBound <= upperBound + 2;
        wait for 2000 ns;
        upperBound <= upperBound + 4;
        wait for 6000 ns;

    end process;

    gen_rst: process
    begin
        rst <= '1', '0' after 100 ns;
        wait;
    end process;



end architecture rtb;