--  Execute module (implements the data ALU and Branch Address Adder  
--  for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY  Execute IS
	PORT(	Read_data_1 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Read_data_2 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Sign_extend 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Addr			: IN 	STD_LOGIC_VECTOR( 25 DOWNTO 0 );
			Shamt			: IN 	STD_LOGIC_VECTOR( 4 DOWNTO 0);
			ALUOp 			: IN 	STD_LOGIC_VECTOR( 3 DOWNTO 0 );
			ALUSrc 			: IN 	STD_LOGIC;
			Zero 			: OUT	STD_LOGIC;
			ALU_Result 		: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Add_Result 		: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
			Jump_Result		: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
			PC_plus_4 		: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
			clock, reset	: IN 	STD_LOGIC );
END Execute;

ARCHITECTURE behavior OF Execute IS

COMPONENT Shifter is
	GENERIC (n: INTEGER := 32;
			k: INTEGER := 5);
	PORT   (    Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
				X: IN STD_LOGIC_VECTOR (k-1 DOWNTO 0);
				right: IN STD_LOGIC;
				res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
				carry: OUT STD_LOGIC);
end COMPONENT;

SIGNAL Ainput, Binput 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL ALU_output_mux		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
SIGNAL Branch_Add 			: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
SIGNAL ShiftLeft_Result		: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL ShiftRight_Result	: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL mult_result			: STD_LOGIC_VECTOR(63 DOWNTO 0);
BEGIN
						-- Calculate shifts
	shifterLeft: Shifter GENERIC MAP(32, 5) PORT MAP(Y => Ainput, X => Shamt, right => '0', res => ShiftLeft_Result);
	shifterRight: Shifter GENERIC MAP(32, 5) PORT MAP(Y => Ainput, X => Shamt, right => '1', res => ShiftRight_Result);

	Ainput <= Read_data_1;
						-- ALU input mux
	Binput <= Read_data_2 WHEN ( ALUSrc = '0' ) 
  			  ELSE  Sign_extend( 31 DOWNTO 0 );

						-- Generate Zero Flag
	Zero <= '1' WHEN ( ALU_output_mux( 31 DOWNTO 0 ) = X"00000000"  )
			ELSE '0';    
						-- Select ALU output        
	ALU_result <= X"0000000" & B"000"  & ALU_output_mux( 31 ) WHEN  ALUOp = "1111" 
				ELSE  	ALU_output_mux( 31 DOWNTO 0 );
						-- Adder to compute Branch Address
	Branch_Add	<= PC_plus_4( 9 DOWNTO 2 ) +  Sign_extend( 7 DOWNTO 0 ) ;
	Add_result 	<= Branch_Add( 7 DOWNTO 0 );
	Jump_Result <= ALU_output_mux(9 downto 2) when ALU_output_mux = "1000" ELSE
				   Addr( 7 DOWNTO 0 );
	mult_result <= Ainput * Binput;  

	PROCESS ( ALUOp, Ainput, Binput )
		BEGIN
						-- Select ALU operation
		CASE ALUOp IS
							-- ALU performs AND
			WHEN "0000" 	=>	ALU_output_mux 	<= Ainput and Binput; 
							-- ALU performs OR
			WHEN "0001" 	=>	ALU_output_mux 	<= Ainput or Binput;
							-- ALU performs XOR
			WHEN "0010" 	=>	ALU_output_mux 	<= Ainput xor Binput;
							-- ALU performs ADD
			WHEN "0011" 	=>	ALU_output_mux  <= Ainput + Binput;
							-- ALU performs SUB
			WHEN "0100" 	=>	ALU_output_mux 	<= Ainput - Binput;
							-- ALU performs MULTIPLY
			WHEN "0101" 	=>	ALU_output_mux 	<= mult_result( 31 DOWNTO 0 );
							-- ALU performs SHIFT LEFT BY SHAMT
			WHEN "0110" 	=>	ALU_output_mux 	<= ShiftLeft_Result;
							-- ALU performs SHIFT RIGHT BY SHAMT
			WHEN "0111" 	=>	ALU_output_mux 	<= ShiftRight_Result;
							-- ALU performs Pass A
			WHEN "1000" 	=>	ALU_output_mux 	<= Ainput;
							-- ALU performs SHIFT LEFT 16 TIMES
			WHEN "1001" 	=>	ALU_output_mux 	<= AInput(15 DOWNTO 0) & X"0000";
							-- ALU performs PASS PC+4
			WHEN "1010" 	=>	ALU_output_mux 	<= X"00000" & B"00" & PC_plus_4;
							-- ALU performs ?
			WHEN "1011" 	=>	ALU_output_mux 	<= X"00000000";
							-- ALU performs ?
			WHEN "1100" 	=>	ALU_output_mux 	<= X"00000000";
							-- ALU performs ?
			WHEN "1101" 	=>	ALU_output_mux 	<= X"00000000";
							-- ALU performs ?
			WHEN "1110" 	=>	ALU_output_mux 	<= X"00000000";
							-- ALU performs SLT
			WHEN "1111" 	=>	ALU_output_mux 	<= Ainput - Binput;

			WHEN OTHERS	=>	ALU_output_mux 	<= X"00000000" ;

		END CASE;

	END PROCESS;

END behavior;

