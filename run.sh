#!/bin/sh
echo please enter the directory [number]?
read DIR
echo please enter the file to be run [a/b]?
read FILE
cd $DIR
while inotifywait -e modify .
    do 
        nim c -r $FILE.nim
done
cd ..
