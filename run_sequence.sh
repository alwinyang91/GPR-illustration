#!/bin/bash

filename="FeLi"

for i in $(seq 0 1 20); do
	let idx=$i
	echo $idx
	lualatex "\def\idx{$idx} \input{FeLi}";
	pdftoppm FeLi.pdf FeLi -png -f 1 -r 1200
	mv FeLi-1.png $filename"_"$i.png
done
#-q:v 1
ffmpeg -framerate 2 -i $filename"_"%d.png -c:v libx264 -crf 0 $filename"_2".mov

for i in $(seq 0 1 20); do
	rm $filename"_"$i.png
done
