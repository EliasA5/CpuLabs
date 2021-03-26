library IEEE;
use ieee.std_logic_1164.all;
USE work.aux_package.all;

ENTITY TopTB is
    constant n: INTEGER := 8;
    constant k: INTEGER := 3;
    constant m: INTEGER := 4;
End TopTB;


architecture TBALU of TopTB is
    signal y, x, ALUout: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    signal Cflag, Zflag, Nflag: STD_LOGIC;
    signal ALUFN: STD_LOGIC_VECTOR(2 DOWNTO 0);
begin
    ALUmod: top generic map(n, k, m) port map(y, x, ALUFN, ALUOUT, Nflag, Cflag, Zflag);
    ---- "000" +, "001" -, "010" shift left, "011" shift right, "100" or, "101" and, "110" xor, "111" nor
    toptb: process
    begin
        
        ---- Nflag test
        wait for 1 ns;
        x <= (others => '0');
        y <= ((n-1) => '1', others => '0');
        ALUFN <= "000";
        wait for 1 ns;
        ALUFN <= "001";
        wait for 1 ns;
        y <= ((n-2) => '1', others => '0');
        x <= (0 => '1', others => '0');
        ALUFN <= "010";
        ---- shift right Nflag = 0
        wait for 1 ns;
        y <= ((n-1) => '1', others => '0');
        ALUFN <= "011";
        wait for 1 ns;
        ALUFN <= "100";
        wait for 1 ns;
        x <= ((n-1) => '1', others => '0');
        ALUFN <= "101";
        wait for 1 ns;
        x <= (others => '0');
        ALUFN <= "110";
        wait for 1 ns;
        y <= (others => '0');
        ALUFN <= "111";
        wait for 1 ns;

        ---- Cflag Test
        x <= ((n-1) => '1', others => '0');
        y <= ((n-1) => '1', others => '0');
        ALUFN <= "000";
        wait for 1 ns;
        ALUFN <= "001";
        wait for 1 ns;
        y <= ((n-1) => '1', 0 => '1', others => '0');
        x <= (0 => '1', others => '0');
        ALUFN <= "010";
        wait for 1 ns;
        ALUFN <= "011";
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
        wait for 1 ns;

        ---- Zflag test
        x <= (others => '0');
        y <= (others => '0');
        ALUFN <= "000";
        wait for 1 ns;
        ALUFN <= "001";
        wait for 1 ns;
        y <= (others => '1');
        x <= ((k-1) downto 0 => '1', others => '0');
        ALUFN <= "010";
        wait for 1 ns;
        ALUFN <= "011";
        wait for 1 ns;
        x <= (others => '0');
        y <= (others => '0');
        ALUFN <= "100";
        wait for 1 ns;
        ALUFN <= "101";
        wait for 1 ns;
        ALUFN <= "110";
        wait for 1 ns;
        x <= (others => '1');
        ALUFN <= "111";
        wait for 1 ns;

    end process;
    
end architecture TBALU;