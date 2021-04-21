LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------------------------------
entity Datapath is
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
end Datapath;
------------- complete the Datapath Unit Architecture code --------------
architecture arc_sys of Datapath is
subtype vec is std_logic_vector(n-1 downto 0);
constant zerovec: vec := (others => '0');
constant onevec: vec := zerovec + '1';
signal down_counter: vec := zerovec;
signal op_reg: std_logic_vector(2 downto 0) := (others => '0');
signal b_reg: vec := zerovec;
signal c_reg: vec := zerovec;
signal A: vec := zerovec;
signal ALUout: vec := zerovec;
signal ALUFN: std_logic_vector(2 downto 0) := (others => '0');
begin
	ALU0: ALU generic map(n) port map(A, b_reg, ALUFN, ALUout);

	counter_load: process(clk)
	begin
		if(clk'EVENT and clk = '1') then
			down_counter <= down_counter;
			if(Ld = '1') then
				down_counter <= DATAin;
			elsif(down_counter /= zerovec) then
					down_counter <= (down_counter - 1);
			end if;
		end if;
	end process;
	
	opreg: process(clk)
	begin
		if(clk'EVENT and clk = '0') then
			op_reg <= op_reg;
			if(OPCin = '1') then
				op_reg <= DATAin(2 downto 0);
			end if;
		end if;
	end process;

	breg: process(clk)
	begin
		if(clk'EVENT and clk = '0') then
			b_reg <= b_reg;
			if(Bin = '1') then
				b_reg <= ALUout;
			end if;
		end if;
	end process;

	creg: process(clk)
	begin
		if(clk'EVENT and clk = '1') then
			c_reg <= c_reg;
			if(Cout = '1') then
				c_reg <= b_reg;
			end if;
		end if;
	end process;
	
	ALUFN <= op_reg when OPC2 = '1' else zerovec(2 downto 0);
	A <= DATAin when OPC1 = '1' else zerovec;
	Input <= '0' when DATAin = zerovec else '1';
	One <= '1' when down_counter = onevec else '0';
	DATAout <= c_reg;
	
	
	
end arc_sys;







