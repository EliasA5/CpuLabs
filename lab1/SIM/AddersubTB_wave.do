onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /addsubtb/subctl
add wave -noupdate /addsubtb/cout
add wave -noupdate /addsubtb/x
add wave -noupdate /addsubtb/y
add wave -noupdate /addsubtb/res
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7918 ps} 0}
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
WaveRestoreZoom {0 ps} {27712 ps}
