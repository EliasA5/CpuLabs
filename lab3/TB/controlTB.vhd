library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
USE work.aux_package.all;
use std.textio.all;

ENTITY controlTB is
    constant n : integer := 8;
end controlTB;

architecture rtb of controlTB is
    signal rst,clk : std_logic;
    signal Input,One : std_logic;
	signal OPCin,OPC2,OPC1,Ld,Bin,Cout : std_logic;
    constant ton: time := 50 ns;
    type arr is array(0 to 6) of std_logic;
                            -- 0, 0, 2, 1, 3, 4, 0
    constant inputs_1: arr := ('0', '0', '1', '1', '1', '1', '0');
    constant ones_1: arr :=   ('0', '0', '0', '0', '0', '1', '0');
                            -- 0, 0, 1, 1, 3, 0, 0
    constant inputs_2: arr := ('0', '0', '1', '1', '1', '0', '0');
    constant ones_2: arr :=   ('0', '0', '0', '0', '1', '0', '0');


begin

    L0: Control port map(rst, clk, Input, One, OPCin, OPC2, OPC1, Ld, Bin, Cout);
    

    clk_gen: process
    begin
        clk <= '0';
        wait for ton;
        clk <= not clk;
        wait for ton;
    end process;

    data_gen: process
    begin
        rst <= '1', '0' after 2*ton;
        wait for ton+ton/4;
        --test regular run on 2 inputs
        for i in 0 to 6 loop
            Input <= inputs_1(i);
            One <= ones_1(i);
            wait for 2*ton;
        end loop;
        --test run on 1 input
        wait for 4*ton;
        for i in 0 to 6 loop
            Input <= inputs_2(i);
            One <= ones_2(i);
            wait for 2*ton;
        end loop;
        --test run on rst while at some state
        for i in 0 to 4 loop
            Input <= inputs_1(i);
            One <= ones_1(i);
            wait for 2*ton;
        end loop;
        rst <= '1';
        wait;
    end process;

end architecture rtb;