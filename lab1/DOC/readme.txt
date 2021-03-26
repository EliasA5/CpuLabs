top.vhd:
is the ALU module, recieves x and y and ALUFN signals and outputs ALUout which is the result of the logical operation between x and y that is defined by ALUFN
ALUFN: "000" +, "001" -, "010" shift left, "011" shift right, "100" or, "101" and, "110" xor, "111" nor.
it also outputs 3 flags:
    Cflag - a carry resulted from the operation
    Nflag - the result is a negative number (in 2s complement)
    Zflag - the result is 0

AdderSub.vhd:
is the Adding/Subtracting module, recieves x and y vectors and "subctl" bit
outputs x+y if "subctl" = 0, x-y if "subctl" = 1
        Cflag when a carry is resulted from the operation.

Shifter.vhd:
is the shifter module, recieves x and y vectors and "right" bit.
shifts y by the decimal value of x to the left/right based on the "right" bit input.
also outputs a Cflag when a carry is resulted from the operation.

FA.vhd:
is a Full Adder module on 2 bits, x, y and cin
outputs s as the result, cout as the carry

aux_package.vhd:
the package used to describe all the neccecarry subcomponents signals (I/O) used in the project.