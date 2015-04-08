# ListTools.tcl
**Problem:**
Something I was doing (maybe lmap) was returning a list with a bunch of 'blanks' in it, like this:
```
a b c {} d e  {} {} f g h {} {} {}
```
I wanted a single command to blast these out of my lists: `lremove`

**Example:**
```
package require list_tools
set my_list {a b c {} d e  {} {} f g h {} {} {}}
puts $my_list; # -> a b c {} d e  {} {} f g h {} {} {}
lremove my_list {}
puts $my_list; # -> a b c d e f g h
```

**Problem:**
I was sniffing for a hardware device on a serial port, but was not sure which serial port it was on. I wanted to take the list of ports and just rotate it each time I wanted to inspect the next port: `lrotate`

**Example:**
```
package require list_tools
set port_list {com1 com2 com3 com4 com8 com14}
puts $port_list; # -> com1 com2 com3 com4 com8 com14
lrotate port_list
puts $port_list; # -> com2 com3 com4 com8 com14 com1
lrotate port_list
puts $port_list; # -> com3 com4 com8 com14 com1 com2
```

**Problem:**
Looking back on it, I'm not sure why I made this thing. I'll have to dig through my apps to see where I'm actually using it. Maybe I hadn't looked at one of the million queues available from tcllib. Anyway...: `lpop`

**Example:**
```
package require list_tools
set command_list {reset enable poll start stop disable shutdown}
puts $command_list;  # -> reset enable poll start stop disable shutdown
lpop command_list;   # -> reset
puts $command_list;  # -> enable poll start stop disable shutdown
lpop command_list 2; # -> enable poll
puts $command_list;  # -> start stop disable shutdown
```

**Problem:**
I wanted a lindex that I could pass in multiple indices to in order to selectively pull bits and pieces from a list: `lindices`

Later, I found this ticket and weighed in on it: [lselect proposal](https://core.tcl.tk/tcl/tktview?name=a95309bf70) - *I sort of had correspondence with dkf, I'll never wash this monitor again.*

I prefer mine because I feel like it acts more like out-of-the-box lindex.

**Example:**
```
lindices {a b c}; # returns the original list as lindex does
lindices {a b c} 0;
lindices {a b c} 1;
lindices {a b c} 3; # returns nothing as lindex does
lindices {a b c} 0 1 3;
lindices {a b c} {0 1 3}; # args list can be a list
lindices {a b c} -1; # returns nothing as lindex does
lindices {a b c} x; # bad index "x": must be integer?[+-]integer? or end?[+-]integer?
lindices {a b c} {0 1 end 0 3 end-1};
```

## How to make it available for use:

1. Take the Tcl module file and drop it into `<TclInstallRoot>\lib\tcl8\8.6\`
2. Rename it to list_tools-0.0.3.tm
3. `package require list_tools`
