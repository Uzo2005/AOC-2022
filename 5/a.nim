# Good lord, this day's solution will only work for my input!!

import strutils, sequtils, sugar, math, strscans, algorithm



var
    firstSet, secondSet, thirdSet, fourthSet, fifthSet, sixthSet, seventhSet,
        eightSet, ninthSet: seq[seq[char]]
    instructionSeq: seq[seq[int]] #in each sequence, the arrangement is like this : @[numberOfStuffToBeMoved, originalPositionOfStuffs, newPositionOfStuffAfterMovement]

const
    instructions = readfile("instructions.txt").strip().splitLines()
    cratesArrangement = readfile("crates.txt").splitLines()

echo "DONE READING INPUT FILES"


echo "STARTING TO PARSE INSTRUCTIONS"

for instruction in instructions:

    var stuffToBeMoved, originalPosition, endingPosition: int
    if instruction.scanf("move $i from $i to $i", stuffToBeMoved,
            originalPosition, endingPosition):
        instructionSeq.add(@[stuffToBeMoved, originalPosition, endingPosition])

echo "DONE PARSING INSTRUCTIONS INTO THE INSTRUCTIONS SEQUENCE"


echo "STARTING TO PARSE CRATES ARRANGEMENT INTO A SUITABLE STRUCTURE"


for crates in cratesArrangement:
    var
        splitCrates = toSeq(crates).distribute(9)
        wtf: seq[seq[char]]

    for i in splitCrates:
        var i = i
        i.keepIf(proc(x: char): bool = x != '[' and x != ']' and x != ' ')
        wtf.add(i)

    firstSet.add(wtf[0])
    secondSet.add(wtf[1])
    thirdSet.add(wtf[2])
    fourthSet.add(wtf[3])
    fifthSet.add(wtf[4])
    sixthSet.add(wtf[5])
    seventhSet.add(wtf[6])
    eightSet.add(wtf[7])
    ninthSet.add(wtf[8])

echo "REVERSING THE SEQUENCES TO MAKE MY WORK EASIER"

firstSet.reverse()
secondSet.reverse()
thirdSet.reverse()
fourthSet.reverse()
fifthSet.reverse()
sixthSet.reverse()
seventhSet.reverse()
eightSet.reverse()
ninthSet.reverse()

firstSet.keepIf(proc(x: seq[char]): bool = x != @[])
secondSet.keepIf(proc(x: seq[char]): bool = x != @[])
thirdSet.keepIf(proc(x: seq[char]): bool = x != @[])
fourthSet.keepIf(proc(x: seq[char]): bool = x != @[])
fifthSet.keepIf(proc(x: seq[char]): bool = x != @[])
sixthSet.keepIf(proc(x: seq[char]): bool = x != @[])
seventhSet.keepIf(proc(x: seq[char]): bool = x != @[])
eightSet.keepIf(proc(x: seq[char]): bool = x != @[])
ninthSet.keepIf(proc(x: seq[char]): bool = x != @[])


echo "DONE PARSING CRATES INTO A SUITABLE FORMAT"

echo "STARTING TO EXECUTE THE INSTRUCTIONS ON EACH CRATE"




# proc popNumberOfTimes [T](seqOfStuffs: var seq[seq[T]], numberOfTimes: int, poppedStuffs: var seq[seq[T]]) =
#     if seqOfStuffs.len == 0:
#         poppedStuffs = @[]
#     else:
#         for num in 1..numberOfTimes:
#             var poppedOut = seqOfStuffs.pop()
#             poppedStuffs.add(poppedOut)

    


# proc pushPoppedStuffs [T](seqOfStuffs: var seq[seq[T]], poppedStuffs: var seq[seq[T]]) =
#     for i in poppedStuffs:
#         seqOfStuffs.add(i)


# proc replace [T](exampleSeq: var seq[T], newValue: T, index: int) =
#     exampleSeq.insert(newValue, index)
#     exampleSeq.delete(index)

for index, instructionSet in instructionSeq:

    var
        numberOfThingsToPop = instructionSet[0]
        initialPlace = instructionSet[1]
        endingPlace = instructionSet[2]
        poppedStuffs: seq[seq[char]]

    var startSetOfCrates, endSetOfCrates: seq[seq[char]]

    case initialPlace:
        of 1:
            startSetOfCrates = firstSet
        of 2:
            startSetOfCrates = secondSet
        of 3:
            startSetOfCrates = thirdSet
        of 4:
            startSetOfCrates = fourthSet
        of 5:
            startSetOfCrates = fifthSet
        of 6:
            startSetOfCrates = sixthSet
        of 7:
            startSetOfCrates = seventhSet
        of 8:
            startSetOfCrates = eightSet
        of 9:
            startSetOfCrates = ninthSet
        else:
            discard

    case endingPlace:
        of 1:
            endSetOfCrates = firstSet
        of 2:
            endSetOfCrates = secondSet
        of 3:
            endSetOfCrates = thirdSet
        of 4:
            endSetOfCrates = fourthSet
        of 5:
            endSetOfCrates = fifthSet
        of 6:
            endSetOfCrates = sixthSet
        of 7:
            endSetOfCrates = seventhSet
        of 8:
            endSetOfCrates = eightSet
        of 9:
            endSetOfCrates = ninthSet
        else:
            discard

    for i in 1..numberOfThingsToPop:
 
        var b = startSetOfCrates.pop()
        endSetOfCrates.add(b)

    case initialPlace:
        of 1:
            firstSet = startSetOfCrates 
        of 2:
            secondSet = startSetOfCrates
        of 3:
            thirdSet = startSetOfCrates
        of 4:
            fourthSet = startSetOfCrates
        of 5:
            fifthSet = startSetOfCrates
        of 6:
            sixthSet = startSetOfCrates
        of 7:
            seventhSet = startSetOfCrates
        of 8:
            eightSet = startSetOfCrates
        of 9:
            ninthSet = startSetOfCrates
        else:
            discard

    case endingPlace:
    of 1:
        firstSet = endSetOfCrates 
    of 2:
        secondSet = endSetOfCrates
    of 3:
        thirdSet = endSetOfCrates
    of 4:
        fourthSet = endSetOfCrates
    of 5:
        fifthSet = endSetOfCrates
    of 6:
        sixthSet = endSetOfCrates
    of 7:
        seventhSet = endSetOfCrates
    of 8:
        eightSet = endSetOfCrates
    of 9:
        ninthSet = endSetOfCrates
    else:
        discard


# echo instructionSeq

echo "answer is: ", firstSet[^1][0], secondSet[^1][0], thirdSet[^1][0], fourthSet[^1][0], fifthSet[^1][0], sixthSet[^1][0], seventhSet[^1][0], eightSet[^1][0], ninthSet[^1][0]
