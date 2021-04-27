aux_package.vhd: contains components used in our project.

top.vhd: out controller based system, operates on a serial stream of numbers in the following manner:
        * the first time a non-zero numbers enters the datapath save the first 3 bits as the opcode for the operation
        001 - add, 010 - minus, 011 - or, 100 - and, 101 - xor.
        the 2nd number is the number of operands for example k.
        a stream of k numbers.
        back to *
        whenever rst_bit = 1, force the machine into *.
        this module connects the control unit to the datapath unit.

ALU.vhd: basic ALU module that has the following operations, assuming A,B operands of length n and ALUfn is bit vector of length 3: 
        000 - A, 001 - A+B, 010 - A-B, 011 - A or B, 100 - A and B, 101 - A xor B.
        doesn't support overflows.

Control.vhd: the control module based on a direct moore machine (except for 1 output).
             supports 4 states as described in pre3.pdf.
             accepts 2 inputs, Input when a non-zero input enters the datapath.
                               One when one operand is left for the operation.
             outputs 6 bits: 
             OPCin - accept input as opcode for the ALU.
             OPC2 - pass the opcode to the ALU if 1, else pass 0
             OPC1 - pass the data as operand to the ALU if 1, else pass 0
             Ld - pass the data to the counter
             Bin - pass the ALU output into register B
             Cout - pass register B value into register C

Datapath.vhd: the compute module, updates specific registers based on input from the Control module.
              outputs 2 bits, Input whenever a non-zero input enters.
                              One whenever the built in counter reaches 1.
              accepts 6 inputs:
              OPCin - REG_OPC accepts value.
              OPC2 - mux between REG_OPC and a zero vector.
              OPC1 - mux between DATAin and zero vec.
              Ld - down_counter accepts value.
              Bin - REG_B accepts value.
              Cout - REG_C accepts value.