import strutils, sequtils, math

const 
    data = readfile("data.txt").strip()
    allAlphabets = {'a'..'z'}.toSeq

var f = open("newData.txt", fmWrite)
for stuff in data:
    if stuff == '\n':
        f.write(stuff)
    elif stuff == 'S' or stuff == 'E' :
        f.write(stuff)
        f.write(' ')
    else:
        f.write(allAlphabets.find(stuff))
        f.write(' ')
f.close