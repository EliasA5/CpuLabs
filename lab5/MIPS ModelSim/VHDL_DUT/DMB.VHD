LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;


ENTITY DMB IS
	PORT(	IO_READ_DATA 		: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        	address 			: IN 	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
        	write_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	   		MemRead, Memwrite 	: IN 	STD_LOGIC;
            CS1_OUT_SIG         : OUT    STD_LOGIC_VECTOR( 7 DOWNTO 0 );
            CS2_OUT_SIG         : OUT    STD_LOGIC_VECTOR( 7 DOWNTO 0 );
            CS3_OUT_SIG         : OUT    STD_LOGIC_VECTOR( 6 DOWNTO 0 );
            CS4_OUT_SIG         : OUT    STD_LOGIC_VECTOR( 6 DOWNTO 0 );
            CS5_OUT_SIG         : OUT    STD_LOGIC_VECTOR( 6 DOWNTO 0 );
            CS6_OUT_SIG         : OUT    STD_LOGIC_VECTOR( 6 DOWNTO 0 );
            CS7_IN_SIG          : IN     STD_LOGIC_VECTOR( 7 DOWNTO 0 );
            clock,reset			: IN 	STD_LOGIC );
            
END DMB;

architecture behavior of DMB is
    COMPONENT bin4ToHex 
        PORT( binin : in std_logic_vector(3 downto 0);
            hexout: out std_logic_vector(6 downto 0)
            );
    END COMPONENT;

    
    SIGNAL IO : STD_LOGIC;
    SIGNAL CS1, CS2, CS3, CS4, CS5, CS6, CS7: STD_LOGIC;
    SIGNAL CS1_SIG, CS2_SIG, CS3_SIG, CS4_SIG, CS5_SIG, CS6_SIG: STD_LOGIC_VECTOR( 7 DOWNTO 0);
    SIGNAL to_write : STD_LOGIC_VECTOR( 7 DOWNTO 0);
begin
    IO <= '1' WHEN (CS1 = '1' OR CS2 = '1' OR CS3 = '1' OR CS4 = '1' OR CS5 = '1' OR CS6 = '1' OR CS7 = '1')
		  ELSE '0';
    CS1 <= '1' when address = X"800" else '0';
    CS2 <= '1' when address = X"804" else '0';
    CS3 <= '1' when address = X"808" else '0';
    CS4 <= '1' when address = X"80C" else '0';
    CS5 <= '1' when address = X"810" else '0';
    CS6 <= '1' when address = X"814" else '0';
    CS7 <= '1' when address = X"818" else '0';
        
    output_sel: process(clock, reset, Memwrite)
    begin 
        if (clock'event and clock = '1') then
            if(Memwrite = '1' AND IO = '1') then
                IO_READ_DATA <= X"000000" & to_write;
            end if;
        end if;
    end process output_sel;

    to_write <= CS1_SIG WHEN CS1 = '1' ELSE
                CS2_SIG WHEN CS2 = '1' ELSE
                CS3_SIG WHEN CS3 = '1' ELSE
                CS4_SIG WHEN CS4 = '1' ELSE
                CS5_SIG WHEN CS5 = '1' ELSE
                CS6_SIG WHEN CS6 = '1' ELSE
                CS7_IN_SIG WHEN CS7 = '1' ELSE
                (others => 'Z');
    
    PORT_LEDG: PROCESS(clock, reset, CS1, MemWrite)
    BEGIN
        if(reset = '1') then
            CS1_SIG <= (others => '0');
        elsif(CS1 = '1' AND Memwrite = '1' AND clock'event AND clock = '1') then
            CS1_SIG <= write_data( 7 DOWNTO 0);
        end if;
    END PROCESS;
    CS1_OUT_SIG <= CS1_SIG;

    PORT_LEDR: PROCESS(clock, reset, CS2, MemWrite)
    BEGIN
        if(reset = '1') then
            CS2_SIG <= (others => '0');
        elsif(CS2 = '1' AND Memwrite = '1' AND clock'event AND clock = '1') then
            CS2_SIG <= write_data( 7 DOWNTO 0);
        end if;
    END PROCESS;
    CS2_OUT_SIG <= CS2_SIG;

    PORT_HEX0: PROCESS(clock, reset, CS3, MemWrite)
    BEGIN
        if(reset = '1') then
            CS3_SIG <= (others => '0');
        elsif(CS3 = '1' AND Memwrite = '1' AND clock'event AND clock = '1') then
            CS3_SIG <= write_data( 7 DOWNTO 0);
        end if;
    END PROCESS;
    ToHex0: bin4ToHex port map(CS3_SIG(3 DOWNTO 0), CS3_OUT_SIG);

    PORT_HEX1: PROCESS(clock, reset, CS4, MemWrite)
    BEGIN
        if(reset = '1') then
            CS4_SIG <= (others => '0');
        elsif(CS4 = '1' AND Memwrite = '1' AND clock'event AND clock = '1') then
            CS4_SIG <= write_data( 7 DOWNTO 0);
        end if;
    END PROCESS;
    ToHex1: bin4ToHex port map(CS4_SIG(3 DOWNTO 0), CS4_OUT_SIG);

    PORT_HEX2: PROCESS(clock, reset, CS5, MemWrite)
    BEGIN
        if(reset = '1') then
            CS5_SIG <= (others => '0');
        elsif(CS5 = '1' AND Memwrite = '1' AND clock'event AND clock = '1') then
            CS5_SIG <= write_data( 7 DOWNTO 0);
        end if;
    END PROCESS;
    ToHex2: bin4ToHex port map(CS5_SIG(3 DOWNTO 0), CS5_OUT_SIG);

    PORT_HEX3: PROCESS(clock, reset, CS6, MemWrite)
    BEGIN
        if(reset = '1') then
            CS6_SIG <= (others => '0');
        elsif(CS6 = '1' AND Memwrite = '1' AND clock'event AND clock = '1') then
            CS6_SIG <= write_data( 7 DOWNTO 0);
        end if;
    END PROCESS;
    ToHex3: bin4ToHex port map(CS6_SIG(3 DOWNTO 0), CS6_OUT_SIG);


end architecture behavior;