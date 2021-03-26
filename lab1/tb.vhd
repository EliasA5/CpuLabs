library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity tb is
	constant n : integer := 8;
	constant k : integer := 3;   -- k=log2(n)
	constant m : integer := 4;   -- m=2^(k-1)
end tb;
---------------------------------------------------------
architecture rtb of tb is

	SIGNAL Y,X:  STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	SIGNAL ALUFN :  STD_LOGIC_VECTOR (2 DOWNTO 0);
	SIGNAL ALUout:  STD_LOGIC_VECTOR(n-1 downto 0); -- ALUout[n-1:0]&Cflag
	SIGNAL Nflag,Cflag,Zflag:  STD_LOGIC; -- Zflag,Cflag,Nflag

begin
	L0 : top generic map (n,k,m) port map(Y,X,ALUFN,ALUout,Nflag,Cflag,Zflag);
    
	--------- start of stimulus section -----------------------------------		
        tb_x_y : process
        begin
		  x <= (others => '0');
		  y <= (others => '1');
		  for i in 0 to 32 loop
			wait for 50 ns;
			x <= x+2;
			y <= y-1;
		  end loop;
		  wait;
        end process;
		 
		
		tb_ALUFN : process
        begin
		  ALUFN <= (others => '0');
		  for i in 0 to 8 loop
			wait for 100 ns;
			ALUFN <= ALUFN+1;
		  end loop;
		  wait;
        end process;
  
end architecture rtb;
