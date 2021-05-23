LIBRARY ieee;
USE ieee.std_logic_1164.all;


package aux_package is

	component modc is
		generic ( n : positive := 8 ); 
		port( rst,enable,clk : in std_logic;
		  upperBound : in std_logic_vector(n-1 downto 0);
		  countOut : out std_logic_vector(n-1 downto 0));
	end component;

----------------------------------------------------------------

	component top is
		generic ( n : positive := 8 ); 
		port( clk : in std_logic;
		  SW : in std_logic_vector(9 downto 0);
          key0,key1: in std_logic);

	end component;

----------------------------------------------------------------

	component div is
		port( clkin : in std_logic;
			clkout: out std_logic;
			divby : in std_logic_vector(1 downto 0)
			);
	end component;
----------------------------------------------------------------


  
  
end aux_package;