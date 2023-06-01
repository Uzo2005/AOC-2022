import strutils, sequtils, math, sugar, algorithm, os

const data = readfile("data.txt").strip().splitLines()
var 
    realHeadPosition: (int, int)
    realTailPosition: (int, int)
    tailMovements: seq[(int, int)]

proc direction (data: string) : char =
    result = data[0]

proc distanceToMove(data: string) : int =
    result = parseInt(data[2..^1])

proc isTwoHorizontalStepsAheadOf (headPosition, tailPosition: (int, int)) :bool =
    let 
        (headXDirection, headYDirection) = headPosition
        (tailXDirection, tailYDirection) = tailPosition

    if (abs(headXDirection - tailXdirection) > 1 and headYDirection == tailYDirection) or (abs(headYDirection - tailYDirection) > 1 and headXDirection == tailXDirection):
        result = true

proc isDiagonallyAdjacentTo (headPosition, tailPosition: (int, int)) :bool =
    let 
        (headXDirection, headYDirection) = headPosition
        (tailXDirection, tailYDirection) = tailPosition

    if ((abs(headYDirection - tailYDirection) > 1) and (abs(headXDirection - tailXDirection) > 0)) or ((abs(headXDirection - tailXdirection) > 1) and (abs(headYDirection - tailYDirection) > 0)):
        result = true


for movement in data:
    case movement.direction():
    of 'R':
        for eachStep in 1..movement.distanceToMove():
            inc realHeadPosition[0]
            if realHeadPosition.isDiagonallyAdjacentTo(realTailPosition):
                # echo "diagonal Right"
                if (realHeadPosition[1] - realTailPosition[1] ) >= 1:
                    realTailPosition[1] += 1
                else:
                    realTailPosition[1] -= 1
                inc realTailPosition[0]
            elif realHeadPosition.isTwoHorizontalStepsAheadOf(realTailPosition):
                # echo "Horizontal Right"
                realTailPosition = (realHeadPosition[0]-1, realTailPosition[1])
            else:
                # echo "none of them"
                discard
            tailMovements.add(realTailPosition)
        # echo "moved Right and distance moved is: ", movement.distanceToMove(), " and head position is ", realHeadPosition, " while tail position is: ", realTailPosition
    of 'L':
        for eachStep in 1..movement.distanceToMove():
            realHeadPosition[0] -= 1
            if realHeadPosition.isDiagonallyAdjacentTo(realTailPosition):
                # echo "diagonal Left"
                if (realHeadPosition[1] - realTailPosition[1]) >= 1:
                    realTailPosition[1] += 1
                else:
                    # echo "puff"
                    realTailPosition[1] -= 1
                realTailPosition[0] -= 1
            elif realHeadPosition.isTwoHorizontalStepsAheadOf(realTailPosition):
                # echo "Horizontal Left"
                realTailPosition = (realHeadPosition[0]+1, realTailPosition[1])
            else:
                # echo "none of them"
                discard
            tailMovements.add(realTailPosition)
        # echo "moved Left and distance moved is: ", movement.distanceToMove(), " and head position is ", realHeadPosition, " while tail position is: ", realTailPosition
    of 'U':
        for eachStep in 1..movement.distanceToMove():
            inc realHeadPosition[1]
            if realHeadPosition.isDiagonallyAdjacentTo(realTailPosition):
                # echo "diagonal Up"
                realTailPosition = (realTailPosition[0]+1, realTailPosition[1]+1)

            elif realHeadPosition.isTwoHorizontalStepsAheadOf(realTailPosition):
                # echo "Horizontal Up"
                realTailPosition = (realTailPosition[0], realHeadPosition[1]-1)
            else:
                # echo "none of them"
                discard
            tailMovements.add(realTailPosition)
        # echo "moved Up and distance moved is: ", movement.distanceToMove(), " and head is ", realHeadPosition, " while tail position is: ", realTailPosition
    of 'D':
        for eachStep in 1..movement.distanceToMove():
            realHeadPosition[1] -= 1
            if realHeadPosition.isDiagonallyAdjacentTo(realTailPosition):
                # echo "diagonal Down"
                realTailPosition = (realTailPosition[0]+1, realTailPosition[1]-1)

            elif realHeadPosition.isTwoHorizontalStepsAheadOf(realTailPosition):
                # echo "Horizontal Down"
                realTailPosition = (realHeadPosition[0], realHeadPosition[1]+1)
            else:
                # echo "none of them"
                discard
            tailMovements.add(realTailPosition)
        # echo "moved down and distance moved is: ", movement.distanceToMove(), " and head is ", realHeadPosition, " while tail position is: ", realTailPosition
    else:
        echo "The direction ", movement.direction(), " is not recognised"
    
    

echo tailMovements.deduplicate.len
