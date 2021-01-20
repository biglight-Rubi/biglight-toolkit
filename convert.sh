#!/bin/bash
mkdir -p output
# Beautiful command, mkdir. If the directory doesn't exist it will create it and if it exist it will just acceses it.
FILELIST1=$(ls ./*.gif)
# List all files with .gif extensions... this is why we can have other files in the directory free from this script. They just won't be listed, so they won't be touched.
for F in $FILELIST1; do
    echo "file: $F"
    SIZECHECK=0
# SIZECHECK   it's just a marker use to continue the loop till the file size ot the output video is below 100KB
    ITERATOR=23
# ITERATOR    after shadowing Arun I decided to start the count a little below the default crf used
    F2=${F%".gif"}
    echo "file without ext: $F2"
    while [[ $SIZECHECK -eq 0 ]]; do
        ffmpeg -i "$F" -b:v 0 -crf $ITERATOR -f mp4 -vcodec libx264 -pix_fmt yuv420p output/"$F2.mp4" -y
        FILESIZE=$(stat -f %z "output/$F2.mp4")
        echo "filesize: $FILESIZE"
        if [[ $FILESIZE -lt 100000 ]]; then
            SIZECHECK=1
        else
            ITERATOR=$((ITERATOR+1))
# You can see here that the iterator used to mark the that it will continue to increase untill it reaches the desired file size
            echo "iterator: $ITERATOR"
        fi
    done
done
