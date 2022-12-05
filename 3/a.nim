import strutils, sequtils, math

var 
    collectAnswer: seq[char]
    answer: seq[int]
    upperCaseSeq = toSeq({'A'..'Z'})
    lowerCaseSeq = toSeq({'a'..'z'})

const filename = "data.txt"

const data = readFile(filename).strip().split()



for input in data:
    let firstHalf = input[0..<input.len div 2]
    let secondHalf = input[input.len div 2..^1]
    let difference = firstHalf.filterIt(it in secondHalf).join

    collectAnswer.add(difference[0])



for letter in collectAnswer:
    if letter.isUpperAscii():
        answer.add(upperCaseSeq.find(letter) + 27)
    else:
        answer.add(lowerCaseSeq.find(letter) + 1)

echo "answer is: ", sum(answer)