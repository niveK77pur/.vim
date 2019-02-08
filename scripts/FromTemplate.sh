#!/bin/bash

# $1 : the file where the templates are stored
# $2 : the tag to look for in the file
# $3 : the character used for comments (i.e. # for python)

#echo 1: "$1" 2: "$2" 3: "$3"

# the line containing the instructions based on the tag
instruction=$(fgrep -n "$3\$$2" "$1")

[[ $? -eq 1 ]] && { echo ""; exit 1; }

begin=$(( ${instruction%:*} + 1 ))
end=$(( $begin + ${instruction#*+} ))

sed -n "$begin,${end}p" "$1"
