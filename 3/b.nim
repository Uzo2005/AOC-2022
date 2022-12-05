import strutils, sequtils, math
# import sequtils

var 
    collectAnswer: seq[char]
    answer: seq[int]
    upperCaseSeq = toSeq({'A'..'Z'})
    lowerCaseSeq = toSeq({'a'..'z'})

const filename = "data.txt"

const data = readFile(filename).strip().split()

const it = data.len div 3

const currentData = data.distribute(it)

for input in currentData:
    let firstHalf = input[0]
    let secondHalf = input[1]
    let thirdHalf  = input[2]

    let difference = thirdHalf.filterIt(it in firstHalf.filterIt(it in secondHalf).join).join

    collectAnswer.add(difference[0])

for letter in collectAnswer:
    if letter.isUpperAscii():
        answer.add(upperCaseSeq.find(letter) + 27)
    else:
        answer.add(lowerCaseSeq.find(letter) + 1)

echo "answer is: ", sum(answer)

