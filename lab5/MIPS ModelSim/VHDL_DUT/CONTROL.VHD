		-- control module (implements MIPS control unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY control IS
   PORT( 	
	Opcode 		: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	Function_opcode : IN STD_LOGIC_VECTOR( 5 DOWNTO 0);
	RegDst 		: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0);
	ALUSrc 		: OUT 	STD_LOGIC;
	MemtoReg 	: OUT 	STD_LOGIC;
	RegWrite 	: OUT 	STD_LOGIC;
	MemRead 	: OUT 	STD_LOGIC;
	MemWrite 	: OUT 	STD_LOGIC;
	Branch 		: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0);
	Jump		: OUT	STD_LOGIC;
	ALUop 		: OUT 	STD_LOGIC_VECTOR( 3 DOWNTO 0 );
	clock, reset	: IN 	STD_LOGIC );

END control;

ARCHITECTURE behavior OF control IS

	SIGNAL  R_format, Lw, Sw, Beq, Bne, Imm_write, Jal, J 	: STD_LOGIC;
	SIGNAL	ALUop_temp 			: STD_LOGIC_VECTOR( 3 DOWNTO 0 );
	SIGNAL	Ext_Function_opcode : STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	SIGNAL	Ext_Opcode 			: STD_LOGIC_VECTOR( 7 DOWNTO 0 );

BEGIN           
				-- Code to generate control signals using opcode bits
	R_format 	<=  '1'  WHEN  Opcode = "000000"  ELSE '0';
	Lw          <=  '1'  WHEN  Opcode = "100011"  ELSE '0';
 	Sw          <=  '1'  WHEN  Opcode = "101011"  ELSE '0';
   	Beq         <=  '1'  WHEN  Opcode = "000100"  ELSE '0';
	Bne			<=  '1'  WHEN  Opcode = "000101"  ELSE '0';
	J			<= 	'1'	 WHEN  Opcode = "000010"  Else '0';
	Jal			<=	'1'	 WHEN  Opcode = "000011"  ELSE '0';
	Imm_write	<=	'0'  WHEN  (Sw = '1' OR Beq = '1' OR Bne = '1' OR J = '1') ELSE '1'; 
	
	Jump		<=	'1'  WHEN  (J = '1' or Jal = '1' or (R_format = '1' and Function_opcode = "001000")) else '0';
	RegDst(1)	<=	Jal;
  	RegDst(0)   <=  R_format;
 	ALUSrc  	<=  not(R_format or Beq or Bne);
	MemtoReg 	<=  Lw;
  	RegWrite 	<=  R_format OR Imm_write;
  	MemRead 	<=  Lw;
   	MemWrite 	<=  Sw;
	Branch(1)	<=	Bne; 
 	Branch(0)   <=  Beq;
						-- decode alu operation
	Ext_Function_opcode <= "00" & Function_opcode;
	Ext_Opcode <= "00" & Opcode;
	ALUop_temp	<=	"0000" WHEN (Ext_Function_opcode = X"24") ELSE -- and
					"0001" WHEN (Ext_Function_opcode = X"25") ELSE -- or
					"0010" WHEN (Ext_Function_opcode = X"26") ELSE -- xor
					"0011" WHEN (Ext_Function_opcode = X"20" OR Ext_Function_opcode = X"21") ELSE -- add
					"0100" WHEN (Ext_Function_opcode = X"22") ELSE -- sub
					"0101" WHEN (Ext_Function_opcode = X"18") ELSE -- multiply
					"0110" WHEN (Ext_Function_opcode = X"00") ELSE -- shift left
					"0111" WHEN (Ext_Function_opcode = X"02") ELSE -- shift right
					"1000" WHEN (Ext_Function_opcode = X"08") ELSE -- pass A JR
					"1111" WHEN (Ext_Function_opcode = X"2A") ELSE -- slt
					"ZZZZ";
					
	ALUop		<= 	ALUop_temp WHEN R_format = '1' ELSE
					"0000" WHEN Ext_Opcode = X"0C" ELSE -- and
					"0001" WHEN Ext_Opcode = X"0D" ELSE -- or
					"0010" WHEN Ext_Opcode = X"0E" ELSE -- xor
					"0011" WHEN Ext_Opcode = X"08" OR Ext_Opcode = X"23" OR Ext_Opcode = X"2B" ELSE -- add
					"1001" WHEN Ext_Opcode = X"0F" ELSE --shift left 16 times
					"1010" WHEN Ext_Opcode = X"03" ELSE -- PC+4
					"1111" WHEN Ext_Opcode = X"0A" OR Ext_Opcode = X"04" OR Ext_Opcode = X"05" ELSE -- slt
					"ZZZZ";

   END behavior;


