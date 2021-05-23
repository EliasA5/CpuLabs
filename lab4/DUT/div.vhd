LIBRARY ieee;
USE ieee.std_logic_1164.all;
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
            counter <= counter + '1';
        end if;
    end process counter_proc;
    
    case divby is:
        when "00" => 
            clkout <= counter(23);
        when "01" =>
            clkout <= counter(24);
        when "10" =>
            clkout <= counter(25);
        when "11" =>
            clkout <= counter(26);
    end case;

    
end architecture rtl;