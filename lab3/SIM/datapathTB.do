onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapathtb/clk
add wave -noupdate -divider OPC_REG
add wave -noupdate /datapathtb/OPCin
add wave -noupdate /datapathtb/L0/op_reg
add wave -noupdate -divider downcounter
add wave -noupdate /datapathtb/L0/Ld
add wave -noupdate -radix decimal /datapathtb/L0/down_counter
add wave -noupdate -divider B_REG
add wave -noupdate /datapathtb/L0/Bin
add wave -noupdate -radix decimal /datapathtb/L0/b_reg
add wave -noupdate -divider C_REG
add wave -noupdate /datapathtb/L0/Cout
add wave -noupdate -radix decimal /datapathtb/L0/c_reg
add wave -noupdate -radix decimal /datapathtb/DATAout
add wave -noupdate -divider ALUfn
add wave -noupdate /datapathtb/L0/OPC2
add wave -noupdate /datapathtb/L0/ALUFN
add wave -noupdate -divider A_input
add wave -noupdate /datapathtb/L0/OPC1
add wave -noupdate -radix decimal /datapathtb/L0/A
add wave -noupdate -radix decimal /datapathtb/DATAin
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {76977 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 172
configure wave -valuecolwidth 112
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {985088 ps}
