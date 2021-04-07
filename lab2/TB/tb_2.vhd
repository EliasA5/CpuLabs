library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;

ENTITY tb_2 is
    constant n : integer := 8;
end tb_2;

architecture rtb of tb_2 is
    signal rst,clk : std_logic;
	signal upperBound : std_logic_vector(n-1 downto 0);
	signal countOut : std_logic_vector(n-1 downto 0);
begin
    L0 : top generic map (n) port map(rst,clk,upperBound,countOut);

    gen_clk : process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= not clk;
        wait for 50 ns;
    end process;

    tester_1: process
    begin
        rst <= '0';
        upperBound <= (others =>'0');
        wait for 200 ns;
        upperBound <= upperBound + 3;
        wait for 400 ns;
        upperBound <= upperBound - 1;
        wait for 300 ns;
        upperBound <= upperBound + 5;
        wait for 1850 ns;
        upperBound <= upperBound - 2;
        wait for 400 ns;
        rst <= '1', '0' after 300 ns;
        upperBound <= upperBound + 6;
        wait for 1000 ns;
        upperBound <= upperBound - 9;
        wait;
    end process;

end architecture rtb;