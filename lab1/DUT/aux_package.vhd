library IEEE;
use ieee.std_logic_1164.all;

package aux_package is
--------------------------------------------------------
	component top is
	GENERIC (n : INTEGER := 8;
			 k : integer := 3;     -- k=log2(n)
		     m : integer := 4	); -- m=2^(k-1)
	PORT (  Y,X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		  ALUout: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag,Cflag,Zflag: OUT STD_LOGIC ); -- Zflag,Cflag,Nflag
	end component;
---------------------------------------------------------  
	component FA is
		PORT (xi, yi, cin: IN std_logic;
			      s, cout: OUT std_logic);
	end component;
---------------------------------------------------------	
	component AdderSub is
		GENERIC (n: INTEGER := 8);
		PORT (  y,x: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
				subctl: IN STD_LOGIC;
				res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
				cout: OUT STD_LOGIC);
	end component;
---------------------------------------------------------	
	component Shifter is
		GENERIC (n: INTEGER := 8;
				k: INTEGER := 3);
		PORT   (    Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
					X: IN STD_LOGIC_VECTOR (k-1 DOWNTO 0);
					right: IN STD_LOGIC;
					res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
					carry: OUT STD_LOGIC);
	end component;
	---------------------------------------------------------

	
	
	
	
	
	
	
	
	
	
	
	
	
	
end aux_package;

