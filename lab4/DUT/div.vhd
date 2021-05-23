LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
------------------------------------------------------------------
entity div is
	port( clkin : in std_logic;
          clkout: out std_logic;
		  divby : in std_logic_vector(1 downto 0)
		  );
end div;

architecture rtl of div is
    signal counter: std_logic_vector(31 downto 0) := (others => '0');
begin
    
    counter_proc: process(clkin)
    begin
        if(clkin'event and clkin = '1') then
            counter <= counter + 1;
        end if;
    end process counter_proc;

    with divby select
        clkout <=   counter(23) when "00",
                    counter(24) when "01",
                    counter(25) when "10",
                    counter(26) when "11",
                    'Z' when others;

    
end rtl;