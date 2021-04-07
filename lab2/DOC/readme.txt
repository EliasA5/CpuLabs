aux_package.vhd: contains components used in our project.

top.vhd: the dynamic growth modulo counter; setting an upperBound will make the module count from 0 to upperBound then reset to 0,
and each times it reaches a new maximum on its way it resets the counter, for example upperBound = 2:
0 01 012 0 01 012
upperBound is allowed to change during operation with no impact.
rst will hard reset the counter to 0 (forgets the maximum reached).
clk updates the state of the machine (once on rising edge, and once on falling edge).
countOut is the ouput of the counter.