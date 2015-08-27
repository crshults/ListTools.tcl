package provide list_tools 0.0.9

proc lremove_in_place {the_list args} {
	upvar 1 $the_list local_list
	foreach what_to_remove $args {
		set local_list [lsearch -inline -all -not -exact $local_list $what_to_remove]
	}
}

proc lremove {the_list args} {
	foreach what_to_remove $args {
		set the_list [lsearch -inline -all -not -exact $the_list $what_to_remove]
	}
	return $the_list
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

proc lmax {the_list} {
	return [lindex [lsort -integer $the_list] end]
}

proc lfind {the_list the_items} {
	set result {}
	foreach item $the_items {
		set index [lsearch $the_list $item]
		if {$index ne -1} {
			lappend result $index
		}
	}
	return $result
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

proc lintersection {args} {
	if {[llength $args] == 1} {
		return [join $args]
	}

	if {[llength $args] == 2} {
		set intersection {}
		foreach item [lindex $args 0] {
			set match [lsearch -exact -inline [lindex $args 1] $item]
			if {$match ne ""} {
				lappend intersection $match
			}
		}
		return $intersection
	}

	lintersection [lintersection [lindex $args 0]] [lintersection {*}[lrange $args 1 end]]
}

proc ltoggle {the_list the_item} {
	upvar 1 $the_list local_list
	if {[lsearch $local_list $the_item] != -1} {
		lremove local_list $the_item
		return removed
	} else {
		lappend local_list $the_item
		return added
	}
}

proc lcontains {the_list the_item} {
	switch [lsearch $the_list $the_item] {
		-1      {return no}
		default {return yes}
	}
}

proc ltake {the_list number_to_take} {
	lrange $the_list 0 $number_to_take-1
}
