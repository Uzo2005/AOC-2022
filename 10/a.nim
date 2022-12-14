import strutils, sequtils, math, strscans

const data = readfile("data.txt").strip.splitLines

var 
    cycles: int
    xregister: seq[(int, int)] = @[(0, 1)]
    cycle20, cycle60, cycle100, cycle140, cycle180, cycle220: seq[(int, int)]

for signal in data:
    var 
        instruction: string
        xincrement: int

    discard signal.scanf("$w $i", instruction, xincrement)
    
    if instruction == "noop":
        inc cycles
        continue
    elif instruction == "addx":
        cycles += 2
        xregister.add((cycles, xregister[^1][1] + xincrement))

for input in xregister:
    if input[0] in 15..<20:
        cycle20.add(input)
    elif input[0] in 55..<60:
        cycle60.add(input)
    elif input[0] in 95..<100:
        cycle100.add(input)
    elif input[0] in 135..<140:
        cycle140.add(input)
    elif input[0] in 175..<180:
        cycle180.add(input)
    elif input[0] in 215..<220:
        cycle220.add(input)

let
    signalStrength = (20*cycle20[^1][1]) + (60*cycle60[^1][1]) + (100*cycle100[^1][1]) + (140*cycle140[^1][1]) + (180*cycle180[^1][1]) + (220*cycle220[^1][1])

echo "answer is ", signalStrength
 
