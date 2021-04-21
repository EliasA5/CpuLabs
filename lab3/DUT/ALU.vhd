LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
--------------------------------------------------------
ENTITY ALU IS
generic (n : positive := 8 );
	PORT (A, B: IN std_logic_vector (n-1 downto 0);
            ALUFN : IN std_logic_vector(2 downto 0);
			  ALUout: OUT std_logic_vector(n-1 downto 0));
END ALU;
--------------------------------------------------------
ARCHITECTURE dataflow OF ALU IS
BEGIN

    ALUout <=   A when ALUFN = "000" else
                A + B when ALUFN = "001" else
                A - B when ALUFN = "010" else
                A or B when ALUFN = "011" else
                A and B when ALUFN = "100" else
                A xor B when ALUFN = "101" else
                A;


END dataflow;
