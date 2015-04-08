# ListTools.tcl
list_tools usage examples:
package require list_tools
set my_list {a b c {} d e  {} {} f g h {} {} {}}
puts $my_list; # -> a b c {} d e  {} {} f g h {} {} {}
lremove my_list {}
puts $my_list; # -> a b c d e f g h

package require list_tools
set port_list {com1 com2 com3 com4 com8 com 14}
puts $port_list; # -> com1 com2 com3 com4 com8 com 14
lrotate port_list
puts $port_list; # -> com2 com3 com4 com8 com 14 com1
lrotate port_list
puts $port_list; # -> com3 com4 com8 com 14 com1 com2

package require list_tools
set command_list {reset enable poll start stop disable shutdown}
puts $command_list;  # -> reset enable poll start stop disable shutdown
lpop command_list;   # -> reset
puts $command_list;  # -> enable poll start stop disable shutdown
lpop command_list 2; # -> enable poll
puts $command_list;  # -> start stop disable shutdown

lindices -> see https://core.tcl.tk/tcl/tktview?name=a95309bf70
