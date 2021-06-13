						--  Dmemory module (implements the data
						--  memory for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY dmemory IS
	PORT(	read_data 			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			IO_READ_DATA 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0);
        	address 			: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        	write_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	   		MemRead, Memwrite 	: IN 	STD_LOGIC;
            clock,reset			: IN 	STD_LOGIC );
END dmemory;

ARCHITECTURE behavior OF dmemory IS
SIGNAL write_clock : STD_LOGIC;
SIGNAL MEMORY_READ_DATA : STD_LOGIC_VECTOR( 31 DOWNTO 0);
SIGNAL IO_READ : STD_LOGIC;
BEGIN
	data_memory : altsyncram
	GENERIC MAP  (
		operation_mode => "SINGLE_PORT",
		width_a => 32,
		widthad_a => 10,
		lpm_type => "altsyncram",
		outdata_reg_a => "UNREGISTERED",
		init_file => "dmemory.hex",
		intended_device_family => "Cyclone"
	)
	PORT MAP (
		wren_a => memwrite,
		clock0 => write_clock,
		address_a => address,
		data_a => write_data,
		q_a => MEMORY_READ_DATA	);


	read_data <= IO_READ_DATA when IO_READ = '1' ELSE MEMORY_READ_DATA;
	IO_READ <= '1' WHEN (address = X"800" OR address = X"804" OR address = X"808" OR address = X"80C" OR address = X"810" OR address = X"814" OR address = X"818")
				ELSE '0';
-- Load memory address register with write clock
		write_clock <= NOT clock;
END behavior;

