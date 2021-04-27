LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
-----------------------------------------------------------------------
entity Control is
	port(
		rst,clk : in std_logic;
		Input,One : in std_logic;
		---------------------------------------------
		OPCin,OPC2,OPC1,Ld,Bin,Cout : out std_logic
	);
end Control;
------------- complete the Control Unit Architecture code --------------
architecture arc_sys of Control is
type state is (state_0, state_1, state_2, state_3);
signal pr_state, nx_state: state := state_0;
begin

	update_state: process (rst, clk)
	begin
		if(rst = '1') then
			pr_state <= state_0;
		elsif(clk'EVENT and clk = '1') then
			pr_state <= nx_state;
		end if;
	end process;
				
	update_nxtstate_outputs: process(Input, One, pr_state)
		begin
			-- default signal assignments
			-- output is a function of present state only (except for Cout)
			-- next state is a function of present state and input
			-- direct moore machine
			OPCin <= '0';
			OPC2 <= '0';
			OPC1 <= '0';
			Ld <= '0';
			Bin <= '0';
			Cout <= '0';
			-- update states based on inputs Input,One and present state
			-- table of states in ../DOC/pre3.pdf
			case pr_state is
				when state_0 =>
					OPCin <= '1';
					if (Input = '0') then
						nx_state <= state_0;
					else
						nx_state <= state_1;
					end if;
				when state_1 =>
					Ld <= '1';
					nx_state <= state_2;
				when state_2 =>
					OPC1 <= '1';
					Bin <= '1';
					if(One = '0') then
						nx_state <= state_3;
					else
						Cout <= '1';
						nx_state <= state_0;
					end if;
				when state_3 =>
					OPC2 <= '1';
					OPC1 <= '1';
					Bin <= '1';
					if(One = '0') then
						nx_state <= state_3;
					else
						Cout <= '1';
						nx_state <= state_0;
					end if;
			end case;
	end process;
	
	
	
	
end arc_sys;







