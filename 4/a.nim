import strutils, sequtils, algorithm


var answer: int

proc isSubsetOf [T](firstSeq: seq[T], secondSeq: seq[T]) :bool =
    let unionOfBoth =  concat(firstSeq, secondSeq)
    var intersectionOfBoth = deduplicate(unionOfBoth)
    
    intersectionOfBoth.sort(cmp)


    if firstSeq == intersectionOfBoth or secondSeq == intersectionOfBoth:
        return true
    else:
        return false

const data = readfile("data.txt").strip().splitLines()


# echo data[0].split(",")[0].split("-")[0]
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

    if seqOfFirstElf.isSubsetOf(seqOfSecondElf):
        inc answer
    else:
        discard

echo "answer is: ", answer
