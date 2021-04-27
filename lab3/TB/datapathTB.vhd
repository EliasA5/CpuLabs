library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
USE work.aux_package.all;
use std.textio.all;

ENTITY datapathTB is
    constant n : integer := 8;
end datapathTB;

architecture rtb of datapathTB is
	signal clk: std_logic;
	signal OPCin,OPC2,OPC1,Ld,Bin,Cout : std_logic;
    signal Input,One : std_logic;
	signal DATAin: std_logic_vector(n-1 downto 0) := (others => '0');
	signal DATAout: std_logic_vector(n-1 downto 0);
    constant ton: time := 50 ns;

begin
    L0 : Datapath generic map (n) port map (clk, OPCin, OPC2, OPC1, Ld, Bin, Cout, DATAin, Input, One, DATAout);

    clk_gen: process
    begin
        clk <= '0';
        wait for ton;
        clk <= not clk;
        wait for ton;
    end process;

    data_gen: process
    begin
        wait for ton+ton/4;

        --check when OPin and Ld = 1 if opcode register and counter are updated
        DATAin <= (0 => '1', others => '0');
        OPCin <= '1', '0' after 2*ton;
        Ld <= '1', '0' after 2*ton;
        report "[time="& time'image(now)& "]" &
               "check OPC_REG and downcounter"
        severity note;
        wait for 2*ton;
        --pass DATAin to B register
        OPC1 <= '1', '0' after 2*ton;
        Bin <= '1', '0' after 2*ton;
        report "[time="& time'image(now)& "]" &
               "check B_REG and A=DATAin"
        severity note;
        wait for 2*ton;
        -- compute DATAin+B_reg and store in B_reg
        OPC2 <= '1', '0' after 2*ton;
        OPC1 <= '1', '0' after 2*ton;
        Bin <= '1', '0' after 2*ton;
        report "[time="& time'image(now)& "]" &
               "check B_REG = B_REG + DATAIN"
        severity note;
        wait for 2*ton;
        -- pass B_reg value to C_reg
        Cout <= '1', '0' after 2*ton;
        report "[time="& time'image(now)& "]" &
               "C_REG = B_REG"
        severity note;

        wait;
    end process;

end architecture rtb;