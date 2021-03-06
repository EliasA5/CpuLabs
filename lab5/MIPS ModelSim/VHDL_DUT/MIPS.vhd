				-- Top Level Structural Model for MIPS Processor Core
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY MIPS IS

	PORT( reset, clock					: IN 	STD_LOGIC; 
		-- Output important signals to pins for easy display in Simulator
		PC								: OUT  STD_LOGIC_VECTOR( 9 DOWNTO 0 );
		ALU_result_out, read_data_1_out, read_data_2_out, write_data_out,	
     	Instruction_out					: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
		Branch_out, Zero_out, Memwrite_out, 
		Regwrite_out					: OUT 	STD_LOGIC ;
		CS1_OUT_SIG         			: OUT    STD_LOGIC_VECTOR( 7 DOWNTO 0 );
		CS2_OUT_SIG         			: OUT    STD_LOGIC_VECTOR( 7 DOWNTO 0 );
		CS3_OUT_SIG         			: OUT    STD_LOGIC_VECTOR( 6 DOWNTO 0 );
		CS4_OUT_SIG         			: OUT    STD_LOGIC_VECTOR( 6 DOWNTO 0 );
		CS5_OUT_SIG         			: OUT    STD_LOGIC_VECTOR( 6 DOWNTO 0 );
		CS6_OUT_SIG         			: OUT    STD_LOGIC_VECTOR( 6 DOWNTO 0 );
		CS7_IN_SIG          			: IN     STD_LOGIC_VECTOR( 7 DOWNTO 0 )
		);
END 	MIPS;

ARCHITECTURE structure OF MIPS IS

	COMPONENT Ifetch
   	     PORT(	Instruction			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		PC_plus_4_out 		: OUT  	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        		Add_result 			: IN 	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
				Jump_Result			: IN	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
        		Branch 				: IN 	STD_LOGIC_VECTOR( 1 DOWNTO 0);
				Jump				: IN 	STD_LOGIC;
        		Zero 				: IN 	STD_LOGIC;
        		PC_out 				: OUT 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        		clock,reset 		: IN 	STD_LOGIC );
	END COMPONENT; 

	COMPONENT Idecode
 	     PORT(	read_data_1 		: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		read_data_2 		: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		Instruction 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		read_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		ALU_result 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		RegWrite, MemtoReg 	: IN 	STD_LOGIC;
        		RegDst 				: IN 	STD_LOGIC_VECTOR ( 1 DOWNTO 0);
        		Sign_extend 		: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				Addr				: OUT 	STD_LOGIC_VECTOR( 25 DOWNTO 0 );
        		clock, reset		: IN 	STD_LOGIC );
	END COMPONENT;

	COMPONENT control
	     PORT( 	Opcode 				: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
		 		Function_opcode		: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
             	RegDst 				: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0);
             	ALUSrc 				: OUT 	STD_LOGIC;
             	MemtoReg 			: OUT 	STD_LOGIC;
             	RegWrite 			: OUT 	STD_LOGIC;
             	MemRead 			: OUT 	STD_LOGIC;
             	MemWrite 			: OUT 	STD_LOGIC;
             	Branch 				: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0);
				Jump				: OUT	STD_LOGIC;
             	ALUop 				: OUT 	STD_LOGIC_VECTOR( 3 DOWNTO 0 );
             	clock, reset		: IN 	STD_LOGIC );
	END COMPONENT;

	COMPONENT  Execute
   	     PORT(	Read_data_1 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                Read_data_2 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
               	Sign_Extend 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				Addr				: IN 	STD_LOGIC_VECTOR( 25 DOWNTO 0 );
				Shamt				: IN 	STD_LOGIC_VECTOR( 4 DOWNTO 0);
               	ALUOp 				: IN 	STD_LOGIC_VECTOR( 3 DOWNTO 0 );
               	ALUSrc 				: IN 	STD_LOGIC;
               	Zero 				: OUT	STD_LOGIC;
               	ALU_Result 			: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
               	Add_Result 			: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
				Jump_Result			: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
               	PC_plus_4 			: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
               	clock, reset		: IN 	STD_LOGIC );
	END COMPONENT;


	COMPONENT dmemory
	     PORT(	read_data 			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		address 			: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
				IO_READ_DATA 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0);
				IO					: IN 	STD_LOGIC;
        		write_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		MemRead, Memwrite 	: IN 	STD_LOGIC;
        		Clock,reset			: IN 	STD_LOGIC );
	END COMPONENT;

	COMPONENT DMB IS
		PORT(	IO_READ_DATA 		: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				address 			: IN 	STD_LOGIC_VECTOR( 11 DOWNTO 0 );
				write_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				MemRead, Memwrite 	: IN 	STD_LOGIC;
				IO                  : OUT   STD_LOGIC;
				CS1_OUT_SIG         : OUT    STD_LOGIC_VECTOR( 7 DOWNTO 0 );
				CS2_OUT_SIG         : OUT    STD_LOGIC_VECTOR( 7 DOWNTO 0 );
				CS3_OUT_SIG         : OUT    STD_LOGIC_VECTOR( 6 DOWNTO 0 );
				CS4_OUT_SIG         : OUT    STD_LOGIC_VECTOR( 6 DOWNTO 0 );
				CS5_OUT_SIG         : OUT    STD_LOGIC_VECTOR( 6 DOWNTO 0 );
				CS6_OUT_SIG         : OUT    STD_LOGIC_VECTOR( 6 DOWNTO 0 );
				CS7_IN_SIG          : IN     STD_LOGIC_VECTOR( 7 DOWNTO 0 );
				clock,reset			: IN 	STD_LOGIC );
	END COMPONENT;

					-- declare signals used to connect VHDL components
	SIGNAL PC_plus_4 		: STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	SIGNAL read_data_1 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data_2 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Sign_Extend 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Addr				: STD_LOGIC_VECTOR( 25 DOWNTO 0 );
	SIGNAL Add_result 		: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	SIGNAL Jump_Result		: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	SIGNAL ALU_result 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL IO_READ_DATA		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL ALUSrc 			: STD_LOGIC;
	SIGNAL Branch 			: STD_LOGIC_VECTOR( 1 DOWNTO 0);
	SIGNAL Jump				: STD_LOGIC;
	SIGNAL RegDst 			: STD_LOGIC_VECTOR( 1 DOWNTO 0);
	SIGNAL Regwrite 		: STD_LOGIC;
	SIGNAL Zero 			: STD_LOGIC;
	SIGNAL MemWrite 		: STD_LOGIC;
	SIGNAL MemtoReg 		: STD_LOGIC;
	SIGNAL MemRead 			: STD_LOGIC;
	SIGNAL ALUop 			: STD_LOGIC_VECTOR(  3 DOWNTO 0 );
	SIGNAL Instruction		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Address			: STD_LOGIC_VECTOR( 11 DOWNTO 0 );
	SIGNAL IO				: STD_LOGIC;
	SIGNAL reset_internal	: STD_LOGIC;

BEGIN
					-- copy important signals to output pins for easy 
					-- display in Simulator
   Instruction_out 	<= Instruction;
   ALU_result_out 	<= ALU_result;
   read_data_1_out 	<= read_data_1;
   read_data_2_out 	<= read_data_2;
   write_data_out  	<= read_data WHEN MemtoReg = '1' ELSE ALU_result;
   Branch_out 		<= Branch(1) OR Branch(0);
   Zero_out 		<= Zero;
   RegWrite_out 	<= RegWrite;
   MemWrite_out 	<= MemWrite;
   Address			<= ALU_Result (11 DOWNTO 2) & "00";
   reset_internal	<= not reset;
					-- connect the 5 MIPS components   
  IFE : Ifetch
	PORT MAP (	Instruction 	=> Instruction,
    	    	PC_plus_4_out 	=> PC_plus_4,
				Add_result 		=> Add_result,
				Jump_Result		=> Jump_Result,
				Branch 			=> Branch,
				Jump			=> Jump,
				Zero 			=> Zero,
				PC_out 			=> PC,        		
				clock 			=> clock,  
				reset 			=> reset_internal );

   ID : Idecode
   	PORT MAP (	read_data_1 	=> read_data_1,
        		read_data_2 	=> read_data_2,
        		Instruction 	=> Instruction,
        		read_data 		=> read_data,
				ALU_result 		=> ALU_result,
				RegWrite 		=> RegWrite,
				MemtoReg 		=> MemtoReg,
				RegDst 			=> RegDst,
				Sign_extend 	=> Sign_extend,
				Addr			=> Addr,
        		clock 			=> clock,  
				reset 			=> reset_internal );


   CTL:   control
	PORT MAP ( 	Opcode 			=> Instruction( 31 DOWNTO 26 ),
				Function_opcode => Instruction( 5 DOWNTO 0 ),
				RegDst 			=> RegDst,
				ALUSrc 			=> ALUSrc,
				MemtoReg 		=> MemtoReg,
				RegWrite 		=> RegWrite,
				MemRead 		=> MemRead,
				MemWrite 		=> MemWrite,
				Branch 			=> Branch,
				Jump			=> Jump,
				ALUop 			=> ALUop,
                clock 			=> clock,
				reset 			=> reset_internal );

   EXE:  Execute
   	PORT MAP (	Read_data_1 	=> read_data_1,
             	Read_data_2 	=> read_data_2,
				Sign_extend 	=> Sign_extend,
				Addr			=> Addr,
				Shamt			=> Instruction( 10 DOWNTO 6 ),
				ALUOp 			=> ALUop,
				ALUSrc 			=> ALUSrc,
				Zero 			=> Zero,
                ALU_Result		=> ALU_Result,
				Add_Result 		=> Add_Result,
				Jump_Result		=> Jump_Result,
				PC_plus_4		=> PC_plus_4,
                Clock			=> clock,
				Reset			=> reset_internal );

   MEM:  dmemory
	PORT MAP (	read_data 		=> read_data,
				address 		=> Address(9 downto 0),--jump memory address by 4
				IO_READ_DATA	=> IO_READ_DATA,
				IO				=> IO,
				write_data 		=> read_data_2,
				MemRead 		=> MemRead, 
				Memwrite 		=> MemWrite, 
                clock 			=> clock,  
				reset 			=> reset_internal );

	IO_DMB: DMB
	port map(	IO_READ_DATA 	=> IO_READ_DATA,
				address 		=> Address,
				write_data 		=> read_data_2,
				MemRead 		=> MemRead, 
				Memwrite 		=> MemWrite,
				IO				=> IO,
				CS1_OUT_SIG     => CS1_OUT_SIG,
				CS2_OUT_SIG     => CS2_OUT_SIG,
				CS3_OUT_SIG     => CS3_OUT_SIG,
				CS4_OUT_SIG     => CS4_OUT_SIG,  
				CS5_OUT_SIG     => CS5_OUT_SIG, 
				CS6_OUT_SIG     => CS6_OUT_SIG,
				CS7_IN_SIG      => CS7_IN_SIG,
                clock 			=> clock,  
				reset 			=> reset_internal );

END structure;

