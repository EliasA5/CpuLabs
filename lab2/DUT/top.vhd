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
	signal currentBound: std_logic_vector(n-1 downto 0) := (others => '0');
	signal tempcountOut: std_logic_vector(n-1 downto 0) := (others => '0');
	constant zerovec: std_logic_vector(n-1 downto 0) := (others => '0');	
begin
	--------------------------------------------------------------
	proc1 : process(clk,rst)
	begin
		
		if(rst ='1') then
			tempcountOut <= zerovec;
		elsif(clk'EVENT and clk = '1') then
			if(currentBound = zerovec) then
				tempcountOut <= zerovec;
			elsif(currentBound = tempcountOut) then
				tempcountOut <= zerovec;
			else
				tempcountOut <= tempcountOut + '1';
			end if;

		end if;
	end process;
	--------------------------------------------------------------
	proc2 : process(clk,rst)
	begin
		if(rst ='1') then
			currentBound <= zerovec;
		elsif(clk'EVENT and clk = '0') then
			if(tempcountOut = upperBound) then
				currentBound <= zerovec;
			elsif(tempcountOut = zerovec) then
				currentBound <= currentBound + '1';
			end if;
		end if;
	end process;
	--------------------------------------
	countOut <= tempcountOut;
	
	


end arc_sys;







