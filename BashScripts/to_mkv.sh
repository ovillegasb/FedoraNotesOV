#!/bin/bash

###############################################################################
# CONVERT *.video to *.mkv                                                    #
#                                                                             #
# 	to_mkv video target_directory options*                                    #
#                                                                             #
#                                                                             #
#                                                                             #
# Orlando Villegas                                                            #
###############################################################################

# entry arguments
args=("$@")

if [[ $# == 0 ]]
then
	echo "No arguments were introduced"
	exit
fi

# File
file="${args[0]}"

# target directory and options
out=$2
if [[ $out == "" ]] 
then
	out="."
	options=""
elif [ -d "${out}" ]
then
	options="${@:3}"
else
	out="."
	options="${@:2}"
fi

# Some common options:
# -vf scale=480:360

# Print check
echo "File: $file"
echo "target directory: $out"
echo "options: $options"
sleep 5

ffmpeg -i "${file}" -vcodec libx265 -acodec aac $options "${out}/${file%.*}.mkv"
