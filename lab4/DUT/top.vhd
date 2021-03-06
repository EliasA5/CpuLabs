LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;

entity top is
	port( clk : in std_logic;
		  SW : in std_logic_vector(9 downto 0);
          key0,key1: in std_logic;
          upperBound: out std_logic_vector(7 downto 0) := (others => '0');
          countOut: out std_logic_vector(7 downto 0) := (others => '0');
          hexOutUpperB: out std_logic_vector(13 downto 0) := (others => '0');
          hexOutCountOut: out std_logic_vector(13 downto 0) := (others => '0')
          );
end top;

architecture rtl of top is
    signal divby: std_logic_vector(1 downto 0) := (others => '0');
    signal rst: std_logic := '1';
    signal enable: std_logic := '0';
    signal pllclk, divclk: std_logic;
    signal upperB: std_logic_vector(7 downto 0) := (others => '0');
    signal cOut: std_logic_vector(7 downto 0) := (others => '0'); 

begin
    --connect all relevant inner signal and ports to thier correct location according to figure 3 in assignment4
    m0: modc port map(rst, enable, divclk, upperB, cOut);
    pll0: pll port map(inclk0 => clk, c0 => pllclk);
    div0: div port map(pllclk, divclk, divby);
    ToHex0: bin8ToHex port map(upperB, hexOutUpperB);
    ToHex1: bin8ToHex port map(cOut, hexOutCountOut);

    upperBound <= upperB;
    enable <= SW(8);
    rst <= SW(9);
    countOut <= cOut;

    --the register that holds value for upperBound, treat key0 as a falling edge trigger
    upperbound_reg: process(SW, key0, clk)
    begin
        if(key0'event and key0 = '0') then
            upperB <= SW(7 downto 0);
        end if;
    end process upperbound_reg;

    --the register that holds value for clock div, treat key1 as a falling edge trigger
    clkDiv_reg: process(SW, key1, clk)
    begin
        if(key1'event and key1 = '0') then
            divby <= SW(1 downto 0);
        end if;
    end process clkDiv_reg;
    
    
    
end rtl;