library IEEE;
use ieee.std_logic_1164.all;
USE work.aux_package.all;

ENTITY LogicalTB is
    constant n: INTEGER := 8;
    constant k: INTEGER := 3;
    constant m: INTEGER := 4;
end LogicalTB;

architecture LTB of LogicalTB is
    SIGNAL x,y,ALUout: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAl ALUFN: STD_LOGIC_VECTOR(2 DOWNTO 0);
begin
    ---- no need for cflag, zflag, nflag for logical operations
    ALU1: top generic map(n,k,m) port map(y, x, ALUFN, ALUout, OPEN);

    --- "100" or, "101" and, "110" xor, "111" nor
    tb_logical: process
    begin
        ---- test 1's with 0's
        x <= (others => '0');
        y <= (others => '1');
        wait for 1 ns;
        ALUFN <= "100";
        wait for 1 ns;
        ALUFN <= "101";
        wait for 1 ns;
        ALUFN <= "110";
        wait for 1 ns;
        ALUFN <= "111";
        ----- test 1's with 1's
        wait for 1 ns;
        x <= (others => '1');
        y <= (others => '1');
        ALUFN <= "100";
        wait for 1 ns;
        ALUFN <= "101";
        wait for 1 ns;
        ALUFN <= "110";
        wait for 1 ns;
        ALUFN <= "111";
        ---- test 0's with 0's
        wait for 1 ns;
        x <= (others => '0');
        y <= (others => '0');
        ALUFN <= "100";
        wait for 1 ns;
        ALUFN <= "101";
        wait for 1 ns;
        ALUFN <= "110";
        wait for 1 ns;
        ALUFN <= "111";
        wait for 1 ns;

    end process;
    
    
end architecture LTB;