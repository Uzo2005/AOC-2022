import strutils,sequtils, sugar, math, algorithm, os, strscans

var
    headX, headY, tailX, tailY:  int
    tailPositionLogger: seq[(int, int)]
    

const data = readfile("data.txt").strip().splitLines()


proc updateTailPositionUporDown (headX, headY, tailX, tailY : var int) =
    if abs(headY-tailY) > 1 and headX == tailX:
        if headY-1 > tailY:
            tailY = headY-1
        elif headY+1 < tailY:
            tailY = headY+1
 
        # echo "matched horizontal"
        
    elif abs(headY - tailY) > 1 and abs(headX - tailX) == 1:
        if headY-1 > tailY:
            tailY = headY-1
        elif headY+1 < tailY:
            tailY = headX+1
        tailX = headX

        # echo "matched diagonal"
        

    else:
        discard
        # echo "No Tail Movement"



proc updateTailPositionRightOrLeft (headX, headY, tailX, tailY : var int) =
    if abs(headX - tailX) > 1 and headY == tailY:
        if headX-1 > tailX:
            tailX = headX-1
        elif headX+1 < tailX:
            tailX = headX+1
        # echo "matched horizontal"
    elif abs(headY - tailY) == 1 and abs(headX - tailX) > 1:
        if headX-1 > tailX:
            tailX = headX-1
        elif headX+1 < tailX:
            tailX = headX+1
        tailY = headY
        # echo "matched diagonal"
        
    else:
        discard
        # echo "No Tail Movement"

    

for line in data:
    var 
        direction, magnitudeChar: char
        
    
    discard scanf(line, "$c $c", direction, magnitudeChar)

    var magnitude = parseInt($magnitudeChar)

    for movement in 1..magnitude:
        # echo "__________________________________________________________________________________"
        # echo ""
        if direction == 'U':
            inc headY
            updateTailPositionUporDown(headX, headY, tailX, tailY)
        elif direction == 'D':
            dec headY
            updateTailPositionUporDown(headX, headY, tailX, tailY)
        elif direction == 'R':
            inc headX 
            updateTailPositionRightOrLeft(headX, headY, tailX, tailY)

        elif direction == 'L':
            dec headX 
            updateTailPositionRightOrLeft(headX, headY, tailX, tailY)
        
        # echo "The direction is ", direction, " and head is at: (",  headX, ", ", headY, ") while tail is at: (",  tailX, ", ", tailY, ")"
        # echo ""
        # echo ""
        
        
        tailPositionLogger.add((tailX, tailY))

   
var 
    realHeadPosition = (headX, headY)
    realTailPosition = (tailX, tailY)

echo realTailPosition
echo realHeadPosition
echo tailPositionLogger
echo tailPositionLogger.len
echo tailPositionLogger.deduplicate.len