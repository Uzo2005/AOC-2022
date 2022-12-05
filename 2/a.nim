import strutils,sequtils, math
# import tables

var collectScores: seq[int]
const filename = "data.txt"

const input = readFile(filename).strip().splitLines()

# echo input

const possiblePermutations: array[9, (string, int)] = [("A X", 4), ("A Y", 8), ("A Z", 3), ("B X", 1), ("B Y", 5), ("B Z", 9), ("C X", 7), ("C Y", 2), ("C Z", 6)]

# echo possiblePermutations.type()

for i in input:
    for p in possiblePermutations:
        if p[0] == i:
            collectScores.add(p[1])


echo "answer is: ", sum(collectScores)
