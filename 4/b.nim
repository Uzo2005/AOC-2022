import strutils, sequtils, algorithm


var answer: int

proc overlapsWith [T](firstSeq: seq[T], secondSeq: seq[T]) :bool =
    let unionOfBoth =  concat(firstSeq, secondSeq)
    
    for element in unionOfBoth:
        if unionOfBoth.count(element) > 1:
            result = true


const data = readfile("data.txt").strip().splitLines()


for pair in data:
    let 
        twoSection = pair.split(",")
        firstElfSection = twoSection[0]
        secondElfSection = twoSection[1]
        firstElfSplit    = firstElfSection.split("-")
        secondElfSplit    = secondElfSection.split("-")

        fES =  parseInt($(firstElfSplit[0])) #first elf start
        fEE   =  parseInt($(firstElfSplit[1])) #first elf end
        sES = parseInt($(secondElfSplit[0]))  #second elf start
        sEE  = parseInt($(secondElfSplit[1])) #second elf end
        seqOfFirstElf = toSeq({fES..fEE})
        seqOfSecondElf = toSeq({sES..sEE})

    if seqOfFirstElf.overlapsWith(seqOfSecondElf):
        inc answer
    else:
        discard

echo "answer is: ", answer
