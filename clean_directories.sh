#!/usr/bin/env bash

# script deleting empty files and directories from a given directory
# USEAGE: script_name <dir_path/>

E_NUMARG=40
E_BADARG=50

# Checking the correctness of the argument
if [ $# != 1 ]; then
	echo "Please provide only one argument"
	echo "USEAGE $0 <dir_path/>"
	exit $E_NUMARG
elif [ ! -d $1 ]; then
	echo "That's not a valid directory"
	echo "USEAGE $0 <dir_path/>"
	exit $E_BADARG
else
	:
fi

# Setting a counter of deleted files/directories
count=0

# Recursive cleaning function
dir_recursive () {
temp_list=`ls $1`
if [[ ${#temp_list} -eq 0 ]]; then
	echo "Empty directory $1 was deleted"
	rm -rf "$1"
	((count++))
else
    for element in $temp_list; do
        if [[ -f "${1}${element}" ]] && [[ ! -s "${1}${element}" ]]
        then
            echo "Empty file ${1}${element} was deleted"
			rm "${1}${element}"
			((count++))
        elif [[ -d "${1}${element}" ]]; then
        	dir_recursive "${1}${element}/"
        fi
    done
fi
}

# Calling a recursive function
dir_recursive $1

# Showing short summary statement
echo
if [[ "$count" -ne 1 ]]; then
	echo "$count files/directories were deleted"
else
	echo "$count file/directory was deleted"
fi


