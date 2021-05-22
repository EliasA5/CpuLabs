LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;

entity top is
	generic ( n : positive := 8 ); 
	port( clk : in std_logic;
		  SW : in std_logic_vector(9 downto 0);
          key0,key1: in std_logic;
          upperBound: out std_logic_vector(n-1 downto 0) := (others => '0');
          countOut: out std_logic_vector(n-1 downto 0) := (others => '0')
          );
end top;

architecture rtl of top is
    signal div: std_logic_vector(1 downto 0) := (others => '0');
    signal rst: std_logic := '1';
    signal enable: std_logic := '0';
    signal pllclk, divclk: std_logic;
    signal upperB: std_logic_vector(n-1 downto 0) := (others => '0');

begin
    m0: modc generic map(n) port map(rst, enable, divclk, upperB, countOut);

    upperBound <= upperB;
    enable <= SW(8);
    rst <= SW(9);
    upperbound_reg: process(SW, key0, clk)
    begin
        if(key0 = '1') then
            if(clk'event and clk = '1') then
                upperB <= SW(7 downto 0);
            end if;
        end if;
    end process upperbound_reg;

    clkDiv_reg: process(SW, key1, clk)
    begin
        if(key1 = '1') then
            if(clk'event and clk = '1') then
                div <= SW(1 downto 0);
            end if;
        end if;
    end process clkDiv_reg;
    
    
    
end rtl;