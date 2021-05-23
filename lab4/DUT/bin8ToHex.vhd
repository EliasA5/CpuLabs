LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------------------------------------------------------------
entity bin8ToHex is
	port( binin : in std_logic_vector(7 downto 0);
          hexout: out std_logic_vector(13 downto 0)
		  );
end bin8ToHex;

architecture rtl of bin8ToHex is
    
begin
    
    with binin(3 downto 0) select 
        hexout(6 downto 0) <= "1000000" when x"0",	
                    "1111001" when x"1",	
                    "0100100" when x"2", 	--  
                    "0110000" when x"3", 	--  ---0---
                    "0011001" when x"4", 	--  |     |
                    "0010010" when x"5", 	--  5	  1
                    "0000010" when x"6", 	--  |	  |
                    "1111000" when x"7", 	--  ---6---
                    "0000000" when x"8", 	--  |	  |
                    "0011000" when x"9", 	--  4	  2
                    "0001000" when x"a",    --  |	  |
                    "0000011" when x"b",    --  ---3---
                    "1000110" when x"c",    --
                    "0100001" when x"d",
                    "0000110" when x"e",
                    "0001110" when x"f",
                    "1111111" when others;

    with binin(7 downto 4) select 
        hexout(13 downto 7) <= "1000000" when x"0",	
                    "1111001" when x"1",	
                    "0100100" when x"2", 	--  
                    "0110000" when x"3", 	--  ---0---
                    "0011001" when x"4", 	--  |     |
                    "0010010" when x"5", 	--  5	  1
                    "0000010" when x"6", 	--  |	  |
                    "1111000" when x"7", 	--  ---6---
                    "0000000" when x"8", 	--  |	  |
                    "0011000" when x"9", 	--  4	  2
                    "0001000" when x"a",    --  |	  |
                    "0000011" when x"b",    --  ---3---
                    "1000110" when x"c",    --
                    "0100001" when x"d",
                    "0000110" when x"e",
                    "0001110" when x"f",
                    "1111111" when others;
		
                               
    
    
end architecture rtl;