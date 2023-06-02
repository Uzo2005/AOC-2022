import strutils, sequtils, algorithm

const data = readfile("data.txt").strip.splitLines.mapIt(
        it.strip.splitWhitespace)

const 
    startX = 0
    startY = 0

var
    hPosX = startX
    hPosY = startY
    knot1X, knot2X, knot3X, knot4X, knot5X, knot6X, knot7X, knot8X = startX
    knot1Y, knot2Y, knot3Y, knot4Y, knot5Y, knot6Y, knot7Y, knot8Y = startY
    tPosX = startX
    tPosY = startY
    tailposlogger: seq[(int, int)]

proc updateTail(hposX, hPosY: int; nextX, nextY: var int) =

    if not(hposX != nextX and hposY != nextY) or not(abs(hPosX - nextX) == 1 and
            hPosY == nextY) or not(abs(hPosY - nextY) == 1 and hPosX == nextX):
        #they are not touching and not too far from each other

        if hposX - nextX == 2 and hposY == nextY:
            #head is 2 step to the right
            echo "  -- head is 2 step to the right"
            inc nextX

        elif nextX - hposX == 2 and hposY == nextY:
            #head is 2 step to the left
            echo "  -- head is 2 step to the left"
            dec nextX

        elif hposY - nextY == 2 and hposX == nextX:
            #head is 2 step above
            echo "  -- head is 2 step above"
            inc nextY

        elif nextY - hposY == 2 and hposX == nextX:
            #head is 2 step below
            echo "  -- head is 2 step below"
            dec nextY

        else:
            echo "       -->no simple case is matched"


        if hposx - nextX >= 1 and hposY - nextY == 2: #changed here
            #head just moved 2 above and to the right
            echo "  -- head just moved 2 above and to the right"
            inc nextX
            inc nextY

        elif nextX - hposx >= 1 and hposY - nextY == 2:
            #head just moved 2 above and to the left
            echo "  -- head just moved 2 above and to the left"
            dec nextX
            inc nextY

        elif hposX - nextX == 2 and hposY - nextY >= 1:
            #head is above and just moved 2 steps right
            echo "  -- head is above and just moved 2 steps right"
            inc nextX
            inc nextY

        elif nextX - hposX == 2 and hposY - nextY >= 1:
            #head is above and just moved 2 steps left
            echo "  -- head is above and just moved 2 steps left"
            dec nextX
            inc nextY

        elif hPosX - nextX >= 1 and nextY - hPosY == 2:
            #head just moved 2 below and to the right
            echo "  -- head just moved 2 below and to the right"
            inc nextX
            dec nextY

        elif nextX - hPosX >= 1 and nextY - hPosY == 2:
            #head just moved 2 below and to the left
            echo "  -- head just moved 2 below and to the left"
            dec nextX
            dec nextY

        elif hposX - nextX == 2 and nexty - hposy >= 1:
            #head is below and just moved 2 steps right
            echo "  -- head is below and just moved 2 steps right"
            inc nextX
            dec nextY

        elif nextX - hposX == 2 and nexty - hposy >= 1:
            #head is below and just moved 2 steps left
            echo "  -- head is below and just moved 2 steps left"
            dec nextY
            dec nextX

        else:
            echo "       -->no diagonal case is matched"

    else:
        echo "---------=============----------"
        echo "met a condition not covered!"
        echo "Head X: ", hposX
        echo "Head Y: ", hposY
        echo "Tail X: ", nextX
        echo "Tail Y: ", nextY
        echo "---------=============----------"

    tailposlogger.add((tPosX, tPosY))
    
proc goRight(stepSize: int) =
    for step in 1..stepSize:
        echo "head went right"
        inc hposX
        updateTail(hPosX, hPosY, knot1X, knot1Y)
        updateTail(knot1X, knot1Y, knot2X, knot2Y)
        updateTail(knot2X, knot2Y, knot3X, knot3Y)
        updateTail(knot3X, knot3Y, knot4X, knot4Y)
        updateTail(knot4X, knot4Y, knot5X, knot5Y)
        updateTail(knot5X, knot5Y, knot6X, knot6Y)
        updateTail(knot6X, knot6Y, knot7X, knot7Y)
        updateTail(knot7X, knot7Y, knot8X, knot8Y)
        updateTail(knot8X, knot8Y, tPosX, tPosY)

proc goLeft(stepSize: int) =
    for step in 1..stepSize:
        echo "head went left"
        dec hposX
        updateTail(hPosX, hPosY, knot1X, knot1Y)
        updateTail(knot1X, knot1Y, knot2X, knot2Y)
        updateTail(knot2X, knot2Y, knot3X, knot3Y)
        updateTail(knot3X, knot3Y, knot4X, knot4Y)
        updateTail(knot4X, knot4Y, knot5X, knot5Y)
        updateTail(knot5X, knot5Y, knot6X, knot6Y)
        updateTail(knot6X, knot6Y, knot7X, knot7Y)
        updateTail(knot7X, knot7Y, knot8X, knot8Y)
        updateTail(knot8X, knot8Y, tPosX, tPosY)

proc goUp(stepSize: int) =
    for step in 1..stepSize:
        echo "head went up"
        inc hposY
        updateTail(hPosX, hPosY, knot1X, knot1Y)
        updateTail(knot1X, knot1Y, knot2X, knot2Y)
        updateTail(knot2X, knot2Y, knot3X, knot3Y)
        updateTail(knot3X, knot3Y, knot4X, knot4Y)
        updateTail(knot4X, knot4Y, knot5X, knot5Y)
        updateTail(knot5X, knot5Y, knot6X, knot6Y)
        updateTail(knot6X, knot6Y, knot7X, knot7Y)
        updateTail(knot7X, knot7Y, knot8X, knot8Y)
        updateTail(knot8X, knot8Y, tPosX, tPosY)

proc goDown(stepSize: int) =
    for step in 1..stepSize:
        echo "head went down"
        dec hposY
        updateTail(hPosX, hPosY, knot1X, knot1Y)
        updateTail(knot1X, knot1Y, knot2X, knot2Y)
        updateTail(knot2X, knot2Y, knot3X, knot3Y)
        updateTail(knot3X, knot3Y, knot4X, knot4Y)
        updateTail(knot4X, knot4Y, knot5X, knot5Y)
        updateTail(knot5X, knot5Y, knot6X, knot6Y)
        updateTail(knot6X, knot6Y, knot7X, knot7Y)
        updateTail(knot7X, knot7Y, knot8X, knot8Y)
        updateTail(knot8X, knot8Y, tPosX, tPosY)

for instruction in data:
    let
        direction = instruction[0]
        stepSize = instruction[1]
    case direction:
        of "R": #go right
            goRight(parseint stepSize)
        of "L": #go left
            goLeft(parseint stepSize)
        of "U": #go up
            goUp(parseint stepSize)
        of "D": #go down
            goDown(parseint stepSize)

echo "=================================="
echo "final positions are: "
echo "  Head X: ", hposx
echo "  Head Y: ", hposy
echo "  Tail X: ", tposx
echo "  Tail Y: ", tposy
echo "=================================="

echo "answer is ", tailposlogger.deduplicate.len
