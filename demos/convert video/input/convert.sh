#!/bin/bash
mkdir -p output
FILELIST1=$(ls ./*.gif)
for F in $FILELIST1; do
    echo "file: $F"
    SIZECHECK=0
    ITERATOR=23
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
            echo "iterator: $ITERATOR"
        fi
    done
done

# -vf scale=320:240