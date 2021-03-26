LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------------------------------------------------------------
entity top is
	generic ( n : positive := 8 ); 
	port( rst,clk : in std_logic;
		  upperBound : in std_logic_vector(n-1 downto 0);
		  countOut : out std_logic_vector(n-1 downto 0));
end top;
------------------------------------------------------------------
architecture arc_sys of top is
	
	
begin
	--------------------------------------------------------------
	proc1 : process(clk,rst)
	begin
		
		
		
		
		
		
		
		
		
		
		
		
		
	end process;
	--------------------------------------------------------------
	proc2 : process(clk,rst)
	begin
		
		
		
		
		
		
		
		
		
		
		
	end process;
	--------------------------------------------------------------
	
	
	
	
	
end arc_sys;







