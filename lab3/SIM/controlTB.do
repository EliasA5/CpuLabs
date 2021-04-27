onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /controltb/rst
add wave -noupdate /controltb/clk
add wave -noupdate /controltb/Input
add wave -noupdate /controltb/One
add wave -noupdate -divider state
add wave -noupdate /controltb/L0/pr_state
add wave -noupdate /controltb/L0/nx_state
add wave -noupdate -divider {IO signals}
add wave -noupdate /controltb/OPCin
add wave -noupdate /controltb/OPC2
add wave -noupdate /controltb/OPC1
add wave -noupdate /controltb/Ld
add wave -noupdate /controltb/Bin
add wave -noupdate /controltb/Cout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2180553 ps} 0}
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
WaveRestoreZoom {244067 ps} {1268067 ps}
