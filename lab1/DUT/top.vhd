LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY top IS
  GENERIC (n : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	); -- m=2^(k-1)
  PORT (  Y,X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		  ALUout: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag,Cflag,Zflag: OUT STD_LOGIC ); -- Zflag,Cflag,Nflag
END top;
------------- complete the top Architecture code --------------
ARCHITECTURE struct OF top IS 
	subtype vec is STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	type matrix is array (3 DOWNTO 0) of vec;
	signal rows: matrix;
	constant zerovec: vec := (others => '0');
	signal tempans: vec;
	signal cflags: STD_LOGIC_VECTOR(2 DOWNTO 0);
	
BEGIN
	---- cflag for logical operations is always 0
	cflags(2) <= '0';
	---- connect signal to addersub and shifter modules and save computations in rows and cflags for returning
	AddSub: AdderSub generic map (n) port map (Y, X, ALUFN(0), rows(0), Cflags(0));
	Shift: Shifter generic map (n, k) port map (Y, X(k-1 DOWNTO 0), ALUFN(0), rows(1), Cflags(1));

	---- compute the logical operations based on ALUFN first 2 bits and save them
	with ALUFN(1 DOWNTO 0) select
		rows(2) <=  Y OR X when "00",
					Y AND X when "01",
					Y when OTHERS;
	with ALUFN(1 DOWNTO 0) select
		rows(3) <=  Y XOR X WHEN "10",
					Y NOR X WHEN "11",
					Y WHEN OTHERS;
	---- first 2 bits decide or/and xor/nor operations and saves them in relevant place
	
	---- bit 3 and 2 decide which row to output from ALU
	---- save temporary answer to set the carries to the correct output
	with ALUFN(2 DOWNTO 1) select
	    tempans <=  rows(0) when "00",
					rows(1) when "01",
					rows(2) when "10",
					rows(3) when "11",
					rows(3) when others;

	---- zflag set when answer is zero
	Zflag <= '1' when tempans = zerovec else '0';
	---- Nflag set when msb is set
	Nflag <= tempans(n-1);
	---- fetch cflag depending on operation
	---- "00" from AdderSub, "01" from shifter
	---- is 0 for logical operations
	with ALUFN(2 DOWNTO 1) select
 		Cflag <= Cflags(0) when "00",
				 Cflags(1) when "01",
				 Cflags(2) when OTHERS;
	
	---- set output
	ALUout <= tempans;
	
END struct;

