Input:  PORT_SW[7-0] 
Output: PORT_LEDG[7-0], PORT_LEDR[7-0], PORT_HEX0, PORT_HEX1, PORT_HEX2, PORT_HEX3
RESET:  Pushbutton KEY0
---------------------------------------------------------------------------------------
The program execution:
1) if SW=0x01 (other SW1-SW7 don't matter): sll by 1 of [ind_7 <- ind_1] in serial once, shown separately onto output devices
   if SW=0x02 (other SW2-SW7 don't matter): srl by 1 of [ind_6 -> ind_0] in serial once, shown separately onto output devices
   else, doing nothing (output state saved)
2) On RESET: clear all outputs.