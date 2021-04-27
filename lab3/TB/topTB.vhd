library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
USE work.aux_package.all;
use std.textio.all;

ENTITY topTB is
    constant n : integer := 8;
end topTB;

architecture rtb of topTB is
    signal rst,clk : std_logic;
	signal  DATAin: std_logic_vector(n-1 downto 0) := (others => '0');
	signal  DATAout: std_logic_vector(n-1 downto 0);
    constant ton: time := 50 ns;
    signal done: boolean := false;

begin
    L0 : top generic map (n) port map(rst, clk, DATAin, DATAout);

    clk_gen: process
    begin
        clk <= '0';
        wait for ton;
        clk <= not clk;
        wait for ton;
    end process;


  data_gen: process
    variable l_1: line;
    file f: text open read_mode is "inputFile.txt";
    variable i: integer;
    variable good: boolean;
  begin
    rst <= '1', '0' after 2*ton;
    wait for ton+ton/4;
    readline(f, l_1); 
    loop
      read(l_1, i, good);
      exit when not good;
      DATAin <= conv_std_logic_vector(i, n);
      wait for 2*ton;
    end loop;
    done <= true;
    file_close(f);
    wait;
  end process;

  data_out: process
    file outf: text open write_mode is "outputFile.txt";
    variable l: line;
    constant space: string(1 downto 1) := " ";
    begin
        wait until (DATAout'event or done'event);
        if(DATAout'event) then
            write(l, conv_integer(DATAout), left, 0);
            write(l, space, left, 1);
        elsif(done) then
            writeline(outf, l);
            file_close(outf);
            wait;
        end if;
    end process;


end architecture rtb;