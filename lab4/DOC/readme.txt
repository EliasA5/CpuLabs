aux_package.vhd: contains components used in our project.

modc.vhd: the dynamic growth modulo counter; setting an upperBound will make the module count from 0 to upperBound then reset to 0,
and each times it reaches a new maximum on its way it resets the counter, for example upperBound = 2:
0 01 012 0 01 012
upperBound is allowed to change during operation with no impact.
rst will hard reset the counter to 0 (forgets the maximum reached).
clk updates the state of the machine (once on rising edge, and once on falling edge).
countOut is the ouput of the counter.

pll.vhd: a clock upsampling by 3/2, use the FPGA 50MHZ as input, outputs 75MHZ clock.
rest of pll files are for use in quartus II software.

bin8ToHex.vhd: takes an 8 bit input and outputs the number representation in hex format to be able to be display in the following manner:
                    ---0---
                    |     |
                    5	  1
                    |	  |
                    ---6---
                    |	  |
                    4	  2
                    |	  |
                    ---3---
                    Figure 1
2 is represented as 0100100.

div: accepts a clock and a divby number, outputs a clock which is slowed down by a factor of:
     2^23 when divby = 00
     2^24 when divby = 01
     2^25 when divby = 10
     2^26 when divby = 11


top.vhd: the top module in the package, connects all the different modules to make a dynamic growth modulo counter
         on an altera FPGA, with switches to control speed and upper bound value.
         displays output on red leds and 7-segment hex displays.
         displays upper bound on green leds.
