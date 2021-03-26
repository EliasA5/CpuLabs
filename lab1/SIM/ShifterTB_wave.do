onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix symbolic /shiftertb/y
add wave -noupdate -radix unsigned -childformat {{/shiftertb/x(7) -radix unsigned} {/shiftertb/x(6) -radix unsigned} {/shiftertb/x(5) -radix unsigned} {/shiftertb/x(4) -radix unsigned} {/shiftertb/x(3) -radix unsigned} {/shiftertb/x(2) -radix unsigned} {/shiftertb/x(1) -radix unsigned} {/shiftertb/x(0) -radix unsigned}} -subitemconfig {/shiftertb/x(7) {-radix unsigned} /shiftertb/x(6) {-radix unsigned} /shiftertb/x(5) {-radix unsigned} /shiftertb/x(4) {-radix unsigned} /shiftertb/x(3) {-radix unsigned} /shiftertb/x(2) {-radix unsigned} /shiftertb/x(1) {-radix unsigned} /shiftertb/x(0) {-radix unsigned}} /shiftertb/x
add wave -noupdate /shiftertb/right
add wave -noupdate -radix binary -childformat {{/shiftertb/res(7) -radix unsigned} {/shiftertb/res(6) -radix unsigned} {/shiftertb/res(5) -radix unsigned} {/shiftertb/res(4) -radix unsigned} {/shiftertb/res(3) -radix unsigned} {/shiftertb/res(2) -radix unsigned} {/shiftertb/res(1) -radix unsigned} {/shiftertb/res(0) -radix unsigned}} -subitemconfig {/shiftertb/res(7) {-radix unsigned} /shiftertb/res(6) {-radix unsigned} /shiftertb/res(5) {-radix unsigned} /shiftertb/res(4) {-radix unsigned} /shiftertb/res(3) {-radix unsigned} /shiftertb/res(2) {-radix unsigned} /shiftertb/res(1) {-radix unsigned} /shiftertb/res(0) {-radix unsigned}} /shiftertb/res
add wave -noupdate /shiftertb/Cflag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19061 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 104
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
WaveRestoreZoom {0 ps} {854 ps}
