LIBRARY ieee;
USE ieee.std_logic_1164.all;


package aux_package is

	component modc is
		port( rst,enable,clk : in std_logic;
		  upperBound : in std_logic_vector(7 downto 0);
		  countOut : out std_logic_vector(7 downto 0));
	end component;

----------------------------------------------------------------

	component top is
		port(   clk : in std_logic;
				SW : in std_logic_vector(9 downto 0);
				key0,key1: in std_logic;
				upperBound: out std_logic_vector(7 downto 0) := (others => '0');
				countOut: out std_logic_vector(7 downto 0) := (others => '0');
				hexOutUpperB: out std_logic_vector(13 downto 0) := (others => '0');
				hexOutCountOut: out std_logic_vector(13 downto 0) := (others => '0')
          );

	end component;

----------------------------------------------------------------

	component div is
		port( clkin : in std_logic;
			clkout: out std_logic;
			divby : in std_logic_vector(1 downto 0)
			);
	end component;
----------------------------------------------------------------

	component PLL is
		port( areset: in std_logic  := '0';
			  inclk0: in std_logic  := '0';
			  c0: out std_logic ;
			  locked: out std_logic 
			);
	end component;

----------------------------------------------------------------

	component bin8ToHex is
		port( binin : in std_logic_vector(7 downto 0);
          	  hexout: out std_logic_vector(13 downto 0)
		  );
	end component;

----------------------------------------------------------------

  
  
end aux_package;