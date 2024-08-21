#!/bin/bash


# 1: VIDEO
# 2: SUBTITLE
# 3: OUT

video=$1
subtitle=$2
out=$3

#ffmpeg -i $1 -i $2 -vcodec libx256 -crf 23 -c copy -c:s mov_text ${1%.*}.mkv
# Parameters
# f: entry format
# map: map 0:0/0:v select video streams from first entry
#      map 0:1/0:a select audio streams from first entry
#      map 1:0/1:s select subtitle streams from second entry


#ffmpeg -i "${video}" -f srt -i "${subtitle}" -map 0:v -map 0:a -map 1:0 -c:v copy -c:a copy -c:s srt "$out/$(echo $video | sed 's/out\///g')"
# 'UTF-8'
# 'LATIN1'
# 'ISO-8859-1'
# ffmpeg -i "${video}" -i "${subtitle}" -map 0.0 -map 0.1 -map 1.0 "$out/$(echo $video | sed 's/out\///g')"

title=$(echo ${video%.*} | sed 's/channel\///g')

# -metadata year="${year}" \
# -metadata:s:s:0 handler="Spanish" \


ffmpeg -i "${video}" \
	-sub_charenc 'LATIN1' \
	-f srt -i "${subtitle}" \
	-map 0:v -map 0:a -map 1:0 \
	-c:v copy -c:a copy -c:s srt \
	-disposition:s:0 default \
	-metadata title="${title}" \
	"$out/$title.mkv"
