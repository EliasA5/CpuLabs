onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_1/rst
add wave -noupdate /tb_1/clk
add wave -noupdate -radix decimal /tb_1/upperBound
add wave -noupdate -radix decimal /tb_1/countOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {116135 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {158192 ps} {4254192 ps}
