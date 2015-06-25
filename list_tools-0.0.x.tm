package provide list_tools 0.0.4

proc lremove {the_list args} {
	upvar 1 $the_list local_list
	foreach what_to_remove $args {
		set local_list [lsearch -inline -all -not -exact $local_list $what_to_remove]
	}
}

proc lrotate {the_list} {
	upvar 1 $the_list local_list
	set local_list [join [list [lrange $local_list 1 end] [lindex $local_list 0]]]
}

proc lpop {the_list {number_to_pop 1}} {
	upvar 1 $the_list local_list
	set pop_list [lrange $local_list 0 $number_to_pop-1]
	set local_list [lrange $local_list $number_to_pop end]
	return $pop_list
}

proc lindices {the_list args} {
	if {[llength $args]} {
	set result {}
		foreach index [join $args] {
			if {[string is integer $index]} {
				if {$index >= 0 && $index < [llength $the_list]} {
					lappend result [lindex $the_list $index]
				}
			} else {
				lappend result [lindex $the_list $index]
			}
		}
		return $result
	}
	return $the_list
}

proc lshuffle {the_list} {
	foreach number $the_list {
		lappend keyed_list [list [expr {rand()}] $number]
	}
	set sorted_keyed_list [lsort -increasing -real -index 0 $keyed_list]
	return [lsearch -glob -all -inline -index 1 -subindices $sorted_keyed_list *]
}

proc range {start end} {
	set output {}
	for {set i $start} {$i <= $end} {incr i} {
		lappend output $i
	}
	return $output
}
