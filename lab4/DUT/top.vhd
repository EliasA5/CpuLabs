LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;

entity top is
	generic ( n : positive := 8 ); 
	port( clk : in std_logic;
		  SW : in std_logic_vector(9 downto 0);
          key0,key1: in std_logic;
          upperBound: std_logic_vector(n-1 downto 0) := (others => '0');
          countOut: std_logic_vector(n-1 downto 0) := (others => '0')
          );
end top;

architecture rtl of top is
    signal div: std_logic_vector(1 downto 0) := (others => '0');
    signal rst: std_logic := '1';
    signal enable: std_logic := '0';
    signal pllclk, divclk: std_logic;

begin
    m0: modc generic map(n) port map(rst, enable, divclk, upperBound, countOut);

    upperbound_reg: process(SW, key0)
    begin
        if(rising_edge(key0)) then
            upperBound <= SW(7 downto 0);
        end if;
    end process upperbound_reg;

    clkDiv_reg: process(SW, key0)
    begin
        if(key1 = '0') then
            div <= (others => '0');
        else
            div <= SW(1 downto 0);
        end if;
    end process clkDiv_reg;
    
    
    
end rtl;