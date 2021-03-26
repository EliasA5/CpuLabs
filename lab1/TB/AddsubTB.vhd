library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity AddsubTB is
	constant n: INTEGER := 8; 
end AddsubTB;
---------------------------------------------------------


architecture rtb of AddsubTB is
	SIGNAL subctl,cout : STD_LOGIC;
	SIGNAL x,y,res : STD_LOGIC_VECTOR (n-1 DOWNTO 0);
begin
	L0 : AdderSub generic map (n) port map(y,x,subctl,res,cout);
    
	--------- start of stimulus section ------------------	
        tb : process
        begin
			subctl <= '0';
			x <= (others => '0');
			y <= (others => '0');
			---- 8 ns res = x
			test_bits0: for i in 0 to (n-1) loop
				wait for 1 ns;
				x <= (i => '1', others => '0');
			end loop;

			---- 8-16 ns res = -x
			subctl <= '1';
			test_bits1: for i in 0 to (n-1) loop
				wait for 1 ns;
				x <= (i => '1', others => '0');
			end loop;
			
			---- 16-24 ns res = x+y = 2x = 2y
			subctl <= '0';
			test_bitwiseadd: for i in 0 to (n-1) loop
				wait for 1 ns;
				x <= (i => '1', others => '0');
				y <= (i => '1', others => '0');
			end loop;

			---- 24-32 ns res = 0
			subctl <= '1';
			test_bitwisesub: for i in 0 to (n-1) loop
				wait for 1 ns;
				x <= (i => '1', others => '0');
				y <= (i => '1', others => '0');
			end loop;

			---- 32-34 ns test carry
			subctl <= '0';
			wait for 1 ns;
			x <= (n-1 => '1', others => '0');
			y <= (n-1 => '1', others => '0');
			wait for 1 ns;
			x <= (others => '0');
			y <= (others => '0');
			wait for 1 ns;

        end process tb;

  
end architecture rtb;
