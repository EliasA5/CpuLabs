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
	ALUop 		: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
	clock, reset	: IN 	STD_LOGIC );

END control;

ARCHITECTURE behavior OF control IS

	SIGNAL  R_format, Lw, Sw, Beq, Bne, Imm_write, Jal, J 	: STD_LOGIC;

BEGIN           
				-- Code to generate control signals using opcode bits
	R_format 	<=  '1'  WHEN  Opcode = "000000"  ELSE '0';
	Lw          <=  '1'  WHEN  Opcode = "100011"  ELSE '0';
 	Sw          <=  '1'  WHEN  Opcode = "101011"  ELSE '0';
   	Beq         <=  '1'  WHEN  Opcode = "000100"  ELSE '0';
	Bne			<=  '1'  WHEN  Opcode = "000101"  ELSE '0';
	J			<= 	'1'	 WHEN  Opcode = "000010"  Else '0';
	Jal			<=	'1'	 WHEN  Opcode = "000011"  ELSE '0';
	Imm_write	<=	'0'  WHEN  Lw OR Beq OR Bne OR J ELSE '1'; 
	
	Jump		<=	'1'  WHEN  J or Jal  or (R_format and Function_opcode = "001000") else '0';
	RegDst(1)	<=	Jal;
  	RegDst(0)   <=  R_format;
 	ALUSrc  	<=  not(R_format or Beq or Bne);
	MemtoReg 	<=  Lw;
  	RegWrite 	<=  R_format OR Imm_write;
  	MemRead 	<=  Lw;
   	MemWrite 	<=  Sw;
	Branch(1)	<=	Bne; 
 	Branch(0)   <=  Beq;
	ALUOp( 1 ) 	<=  R_format;
	ALUOp( 0 ) 	<=  Beq OR Bne; 

   END behavior;


