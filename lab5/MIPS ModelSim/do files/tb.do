onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips_tb/U_1/clock
add wave -noupdate /mips_tb/U_1/reset
add wave -noupdate -radix hexadecimal /mips_tb/U_1/PC
add wave -noupdate -radix hexadecimal /mips_tb/U_1/Instruction_out
add wave -noupdate -radix hexadecimal /mips_tb/U_1/read_data_1_out
add wave -noupdate -radix hexadecimal /mips_tb/U_1/read_data_2_out
add wave -noupdate -radix hexadecimal /mips_tb/U_1/write_data_out
add wave -noupdate /mips_tb/U_1/Memwrite_out
add wave -noupdate /mips_tb/U_1/Regwrite_out
add wave -noupdate -radix hexadecimal /mips_tb/U_1/ALU_result_out
add wave -noupdate /mips_tb/U_1/Zero_out
add wave -noupdate /mips_tb/U_1/Branch_out
add wave -noupdate -radix hexadecimal /mips_tb/CS1_OUT_SIG
add wave -noupdate -radix hexadecimal /mips_tb/CS2_OUT_SIG
add wave -noupdate -radix hexadecimal /mips_tb/CS3_OUT_SIG
add wave -noupdate -radix hexadecimal /mips_tb/CS4_OUT_SIG
add wave -noupdate -radix hexadecimal /mips_tb/CS5_OUT_SIG
add wave -noupdate -radix hexadecimal /mips_tb/CS6_OUT_SIG
add wave -noupdate -radix hexadecimal /mips_tb/CS7_IN_SIG
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {81370 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 251
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2424832 ps}
