#!/bin/sh
echo please enter the directory [number]?
read DIR
echo please enter the file to be run [a/b]?
read FILE
cd $DIR
while inotifywait -e modify . *.txt
    sleep 5
    do 
        nim c -r -f $FILE.nim

done
# cd ..
