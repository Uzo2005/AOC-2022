import strutils, sequtils, math, sugar


var collectScores: seq[int]
const filename = "data.txt"

const input = readFile(filename).strip().splitLines()

# echo input[0][2]=='Y'

# const drawArr = [('A', 4), ('B', 5), ('C', 6)]
# const winArr  = [('A', 8), ('B', 9), ('C', 7)]
# const loseArr = [('A', 3), ('B', 1), ('C', 2)]


for round in input:
    case round[2]:
        of 'X':
            if round[0]=='A':
                collectScores.add(3)
            elif round[0]=='B':
                collectScores.add(1)
            elif round[0]=='C':
                collectScores.add(2)
        of 'Y':
            if round[0]=='A':
                collectScores.add(4)
            elif round[0]=='B':
                collectScores.add(5)
            elif round[0]=='C':
                collectScores.add(6)
          
        of 'Z':
            if round[0]=='A':
                collectScores.add(8)
            elif round[0]=='B':
                collectScores.add(9)
            elif round[0]=='C':
                collectScores.add(7)
        
        else:
            discard

echo "answer is: ", sum(collectScores)

# x- lose
# y- draw
# z- win


# const possiblePermutations: array[9, (string, int)] = [("A X", 4), ("A Y", 8), ("A Z", 3), ("B X", 1), ("B Y", 5), ("B Z", 9), ("C X", 7), ("C Y", 2), ("C Z", 6)]

