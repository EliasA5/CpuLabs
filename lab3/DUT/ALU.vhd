LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------------
ENTITY ALU IS
generic (n : positive := 8 );
	PORT (A, B: IN std_logic_vector (n-1 downto 0);
            ALUFN : std_logic_vector(2 downto 0)
			  ALUout: OUT std_logic_vector(n-1 downto 0));
END ALU;
--------------------------------------------------------
ARCHITECTURE dataflow OF ALU IS
BEGIN

	if(ALUFN = "000") then then
        ALUout <= A;
    elsif(ALUFN = "001") then
        ALUout <= A + B;  
    elsif(ALUFN = "010") then
        ALUout <= A - B;
    elsif(ALUFN = "011") then
        ALUout <= A or B;
    elsif(ALUFN = "100") then
        ALUout <= A and B;
    elsif(ALUFN = "101") then
        ALUout <=  A xor B;
    else
        ALUout <= A;
    end if;
    
END dataflow;
