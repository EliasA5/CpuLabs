LIBRARY ieee;
USE ieee.std_logic_1164.all;


package aux_package is
-----------------------------------------------------------------
  component top is
	generic (
		n : positive := 8 
	);
	port(
		rst,clk : in std_logic;
		DATAin  : in std_logic_vector(n-1 downto 0);
		---------------------------------------------
		DATAout : out std_logic_vector(n-1 downto 0)
	);
  end component;
-----------------------------------------------------------------
  component Control is
	port(
		rst,clk : in std_logic;
		Input,One : in std_logic;
		---------------------------------------------
		OPCin,OPC2,OPC1,Ld,Bin,Cout : out std_logic
	);
  end component;
-----------------------------------------------------------------	
  component Datapath is
	generic (
		n : positive := 8 
	);
	port(
		clk : in std_logic;
		OPCin,OPC2,OPC1,Ld,Bin,Cout : in std_logic;
		DATAin  : in std_logic_vector(n-1 downto 0);
		---------------------------------------------
		Input,One : out std_logic;
		DATAout : out std_logic_vector(n-1 downto 0)
	);
  end component;
-----------------------------------------------------------------




  
  
  
  
end aux_package;

