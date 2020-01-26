#!/usr/bin/env bash

# script renaming all .png or .jpg files in a given directory 
# USEAGE: script_name <dir_path/> <basic_file_name>

E_NUMARG=40
E_BADARG=50

# Checking the correctness of the arguments
if [ $# != 2 ]; then
	echo "Please provide two arguments"
	echo "USEAGE $0 <dir_path/> <basic_file_name> \
eg. path/rename_images.sh ~/images/ holiday"
	exit $E_NUMARG
elif [ ! -d $1 ]; then
	echo "That's not a valid directory"
	echo "USEAGE $0 <dir_path/> <basic_file_name> \
eg. path/rename_images.sh ~/images/ holiday"
	exit $E_BADARG
fi

echo "TEST"

count_png=0
count_jpg=0
list=(`ls $1`)
echo $list
pushd .
cd $1
for file in "${list[@]}"; do
	echo "$file"
	case "$file" in
		*.png ) mv $file "${2}_${count_png}.png" && ((count_png++));;
		*.jpg ) mv $file "${2}_${count_jpg}.jpg" && ((count_jpg++));;
		* ) : ;;	
	esac
done
popd
