#!/bin/bash

# $1 : the file where the templates are stored
# $2 : the tag to look for in the file

# the line containing the instructions based on the tag
instr=$(fgrep -n "%\$$2" "$1")
begin=$(( ${instr%:*} + 1 ))
end=$(( $begin + ${instr#*+} ))
sed -n "$begin,${end}p" "$1"
