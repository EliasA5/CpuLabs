library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


ENTITY Shifter IS
    GENERIC (n: INTEGER := 8;
             k: INTEGER := 3);
    PORT   (    Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
                X: IN STD_LOGIC_VECTOR (k-1 DOWNTO 0);
                right: IN STD_LOGIC;
                res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
                carry: OUT STD_LOGIC);
END Shifter;


architecture shifty of Shifter is

SUBTYPE vec IS STD_LOGIC_VECTOR (n-1 DOWNTO 0);
TYPE matrix IS ARRAY (k-1 DOWNTO 0) of vec;
signal row: matrix;
signal carries: STD_LOGIC_VECTOR(k-1 downto 0);
constant zerovec: vec := (others => '0');

BEGIN
    
    ---- generate first shift and carry if needed

    row(0) <= Y when x(0) = '0' else ('0' & Y(n-1 DOWNTO 1)) when right = '1' else (Y(n-2 DOWNTO 0) & '0');
    carries(0) <= '0' when x(0) = '0' else Y(0) when right = '1' else Y(n-1);

    ---- for each i shift by 2^i if x(i) = 1 else dont shift
    g1: FOR i in 1 to (k-1) GENERATE

        --generate shifts
        row(i) <= row(i-1) when x(i) = '0' 
                  else (zerovec((2**i - 1) DOWNTO 0) & row(i-1)(n-1 DOWNTO 2**i)) when right = '1'
                  else (row(i-1)((n - 1 - 2**i) DOWNTO 0) & zerovec((2**i - 1) DOWNTO 0));
        carries(i) <= carries(i-1) when x(i) = '0'
                      else row(i-1)(2**i - 1) when right = '1'
                      else row(i-1)(n - 2**i);
    end GENERATE;

    ---- result is ready at last row, pick depending on "right" bit
    res <= row(k-1);
    carry <= carries(k-1);


END shifty;