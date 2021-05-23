LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------------------------------------------------------------
entity modc is
	port( rst,enable,clk : in std_logic;
		  upperBound : in std_logic_vector(7 downto 0);
		  countOut : out std_logic_vector(7 downto 0));
end modc;
------------------------------------------------------------------
architecture arc_sys of modc is
	signal currentBound: std_logic_vector(7 downto 0) := (others => '0');
	signal tempOut: std_logic_vector(7 downto 0) := (others => '0');
	signal state: std_logic := '1';
	constant zerovec: std_logic_vector(7 downto 0) := (others => '0');	
begin
	--------------------------------------------------------------
	proc1 : process(clk, rst, enable)
	begin
		
		if(rst = '1') then
			tempOut <= zerovec;
		elsif(clk'EVENT and clk = '1') then
			if(enable = '1') then

				if(tempOut >= currentBound) then
					tempOut <= zerovec;
				elsif(tempOut >= upperBound) then
					tempOut <= zerovec;
				else
					tempOut <= tempOut + '1';
				end if;
			end if;
		end if;
		
	end process;
	--------------------------------------------------------------
	proc2 : process(clk, rst, enable)
	begin
		
		if(rst ='1') then
			currentBound <= zerovec;
			state <= '1';
		elsif(clk'EVENT and clk = '0') then
			if(enable = '1') then

				currentBound <= currentBound;
				state <= '0';

				if(state = '1') then
					state <= '0';
				elsif(currentBound = upperBound and tempOut = upperBound) then
					currentBound <= zerovec;
					state <= '1';
				elsif(tempOut = zerovec) then
					currentBound <= currentBound + '1';
				elsif(currentBound > upperBound) then
					currentBound <= upperBound;

				end if;
			end if;
		end if;

	end process;
	--------------------------------------
	countOut <= tempOut;

end arc_sys;







