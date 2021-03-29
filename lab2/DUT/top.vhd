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
	signal tempOut: std_logic_vector(n-1 downto 0) := (others => '0');
	signal state: std_logic := '1';
	constant zerovec: std_logic_vector(n-1 downto 0) := (others => '0');	
begin
	--------------------------------------------------------------
	proc1 : process(clk,rst)
	begin
		if(rst ='1') then
			tempOut <= zerovec;
		elsif(clk'EVENT and clk = '1') then

			if(tempOut = currentBound) then
				tempOut <= zerovec;
			elsif(tempOut = upperBound) then
				tempOut <= zerovec;
			else
				tempOut <= tempOut + '1';
			end if;
			
		end if;
	end process;
	--------------------------------------------------------------
	proc2 : process(clk,rst)
	begin
		if(rst ='1') then
			currentBound <= zerovec;
			state <= '1';
		elsif(clk'EVENT and clk = '0') then

			currentBound <= currentBound;
			state <= '0';

			if(state = '1') then
				state <= '0';
			elsif(currentBound = upperBound and tempOut = upperBound) then
				currentBound <= zerovec;
				state <= '1';
			elsif(tempOut = zerovec) then
				currentBound <= currentBound + '1';
			end if;

		end if;
	end process;
	--------------------------------------
	countOut <= tempOut;

end arc_sys;







