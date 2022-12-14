import strutils, sequtils, math, strscans

const data = readfile("data.txt").strip.splitLines

const outputFile = "output.txt"

var 
    cycles: int
    xregister: int = 1
    lineText: string

let f = open(outputFile, fmWrite)


proc registerSignal (cycle, spritePosition: int) =

    if ((cycle mod 40) - 1) in spritePosition-1..spritePosition+1:
        lineText.add("#")
    else:
        lineText.add(".")

    if cycle mod 40 == 0:
        lineText.add("\n")
        

for signal in data:
    var 
        instruction: string
        xincrement: int

    discard signal.scanf("$w $i", instruction, xincrement)
    
    if instruction == "noop":
        inc cycles
        registerSignal(cycles, xregister)
    elif instruction == "addx":
        inc cycles
        registerSignal(cycles, xregister)
        inc cycles
        registerSignal(cycles, xregister)

        xregister += xincrement



f.writeLine(lineText)

close(f)