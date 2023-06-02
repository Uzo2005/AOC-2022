import strutils, sequtils, algorithm

const data = readfile("data.txt").strip.splitLines.mapIt(it.strip.splitWhitespace)

var 
    hPosX, hPosY: int
    tPosX, tPosY: int
    tailposlogger: seq[(int, int)]

proc updateTail(hposX, hPosY: int; tPosX, tPosY: var int) =
    if not(hposX != tposX and hposY != tposY) or not(abs(hPosX - tPosX) == 1 and hPosY == tPosY) or not(abs(hPosY - tPosY) == 1 and hPosX == tPosX):
        #they are not touching and not too far from each other
        
        if hposX - tposX == 2 and hposY == tposY:
            #head is 2 step to the right
            echo "  -- head is 2 step to the right"
            inc tposX

        elif tposX - hposX == 2 and hposY == tposY:
            #head is 2 step to the left
            echo "  -- head is 2 step to the left"
            dec tposX

        elif hposY - tposY == 2 and hposX == tposX:
            #head is 2 step above
            echo "  -- head is 2 step above"
            inc tposY

        elif tposY - hposY == 2 and hposX == tposX:
            #head is 2 step below
            echo "  -- head is 2 step below"
            dec tposY
        
        else:
            echo "       -->no simple case is matched"


        if hposx - tposx == 1 and hposY - tposY == 2: 
            #head just moved 2 above and to the right
            echo "  -- head just moved 2 above and to the right"
            inc tposX
            inc tposY

        elif tposx - hposx == 1 and hposY - tposY == 2: 
            #head just moved 2 above and to the left
            echo "  -- head just moved 2 above and to the left"
            dec tposX
            inc tposY

        elif hposX - tposX == 2 and hposY - tposY == 1:
            #head is above and just moved 2 steps right
            echo "  -- head is above and just moved 2 steps right"
            inc tposX
            inc tposY

        elif tposX - hposX == 2 and hposY - tposY == 1:
            #head is above and just moved 2 steps left
            echo "  -- head is above and just moved 2 steps left"
            dec tposX
            inc tposY

        elif hPosX - tPosX == 1 and tPosY - hPosY == 2:
            #head just moved 2 below and to the right
            echo "  -- head just moved 2 below and to the right"
            inc tposX
            dec tposY

        elif tPosX - hPosX == 1 and tPosY - hPosY == 2:
            #head just moved 2 below and to the left
            echo "  -- head just moved 2 below and to the left"
            dec tposX
            dec tposY

        elif hposX - tposX == 2 and tposy - hposy == 1:
            #head is below and just moved 2 steps right
            echo "  -- head is below and just moved 2 steps right"
            inc tposX
            dec tposY

        elif tposX - hposX == 2 and tposy - hposy == 1:
            #head is below and just moved 2 steps left
            echo "  -- head is below and just moved 2 steps left"
            dec tposY
            dec tposX

        else:
            echo "       -->no diagonal case is matched"

        
    
    else:
        echo "---------=============----------"
        echo "met a condition not covered!"
        echo "Head X: ", hposX
        echo "Head Y: ", hposY
        echo "Tail X: ", tposX
        echo "Tail Y: ", tposY
        echo "---------=============----------"

    tailposlogger.add((tposX, tposY))



proc goRight(stepSize: int) =
    for step in 1..stepSize:
        echo "head went right"
        inc hposX
        updateTail(hPosX, hPosY, tPosX, tPosY)

proc goLeft(stepSize: int) =
    for step in 1..stepSize:
        echo "head went left"
        dec hposX
        updateTail(hPosX, hPosY, tPosX, tPosY)

proc goUp(stepSize: int) =
    for step in 1..stepSize:
        echo "head went up"
        inc hposY
        updateTail(hPosX, hPosY, tPosX, tPosY)


proc goDown(stepSize: int) =
    for step in 1..stepSize:
        echo "head went down"
        dec hposY
        updateTail(hPosX, hPosY, tPosX, tPosY)


for instruction in data:
    let 
        direction = instruction[0]
        stepSize = instruction[1]
    case direction:
        of "R": #go right
            goRight(parseint stepSize)
        of "L":#go left
            goLeft(parseint stepSize)
        of "U":#go up
            goUp(parseint stepSize)
        of "D":#go down
            goDown(parseint stepSize)


echo "=================================="
echo "final positions are: "
echo "  Head X: ", hposx
echo "  Head Y: ", hposy
echo "  Tail X: ", tposx
echo "  Tail Y: ", tposy
echo "=================================="

echo "answer is ", tailposlogger.deduplicate.len