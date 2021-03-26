library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity shifterTB is
	constant n: INTEGER := 8;
	constant k: INTEGER := 3;
end shifterTB;
---------------------------------------------------------

architecture tbb of shifterTB is
	SIGNAL y,x:  STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	SIGNAL right: STD_LOGIC := '0';
	SIGNAL res: STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	SIGNAL Cflag:  STD_LOGIC; -- Zflag,Cflag,Nflag

	begin
		shifter1: Shifter generic map(n, k) port map(y, x(k-1 DOWNTO 0), right, res, Cflag);

		tb_shifter: process
		begin
			----tb left shifting 8 ns
			right <= '0';
			y <= (OTHERS => '1');
			x <= (OTHERS => '0');
			tb_left: for i in 0 to (n-1) loop
				wait for 1 ns;
				x <= x + '1';
			end loop;
			
			--tb right shifting 8-16 ns;
			right <= '1';	
			y <= (OTHERS => '1');
			x <= (OTHERS => '0');
			tb_right: for i in 0 to (n-1) loop
				wait for 1 ns;
				x <= x + '1';
			end loop;
			
			--tb carry 16-18 ns
			wait for 1 ns;
			right <= '0';
			x <= (0 => '1', others => '0');
			y <= (n-1 => '0', others => '1');
			wait for 1 ns;
			right <= '1';
			x <= (0 => '1', others => '0');
			y <= (0 => '0', others => '1');
			wait for 1 ns;

		end process;



END architecture tbb;