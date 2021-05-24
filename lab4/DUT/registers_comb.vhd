LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;

entity registers_comb is
    generic(inp_len: integer := 8;
            output_len: integer := 14);
	port( clk: in std_logic := '0';
          input: in std_logic_vector(inp_len-1 downto 0) := (others => '0');
          output: out std_logic_vector(output_len-1 downto 0) := (others => '0')
          );
end registers_comb;

architecture rtl of registers_comb is
    signal inp: std_logic_vector(inp_len-1 downto 0) := (others => '0');
    signal outp: std_logic_vector(output_len-1 downto 0) := (others => '0');
begin
    toTest: bin8ToHex port map(inp, outp);
    
    change_input: process(clk)
    begin
        if(clk'event and clk ='1') then
            inp <= input;
        end if;
    end process change_input;

    change_output: process(clk)
    begin
        if(clk'event and clk ='1') then
            output <= outp;
        end if;
    end process change_output;
    
end architecture rtl;