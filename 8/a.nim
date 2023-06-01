import strutils, sequtils, math, sugar, algorithm

const mapData = readfile("data.txt").strip().split().map(x => toSeq(x).map(y => parseInt($y)))



# const visibleOnEdge = mapData[0].len * 2 + (mapData.len - 2)*2

# echo visibleOnEdge

var 
    answer: int


proc isVisibleFromLeft (num: int, indexOfNum: int,  mapDataRow: seq[int]): bool =
    let leftSide = mapDataRow[0..<indexOfNum]
    if num > max(leftSide):
        result = true

proc isVisibleFromRight (num: int, indexOfNum: int,  mapDataRow: seq[int]): bool =
    let rightSide = mapDataRow[indexOfNum+1..^1]
    if num > max(rightSide):
        result = true



proc transposeData [T](data: seq[seq[T]]) : seq[seq[T]] = 
    result.setLen(data.len)
    for row in data:
        for index, num in row:
            result[index].add(num)
    

let transposedMapData = transposeData(mapData)

# writeFile("output.txt", $mapData & "\n\n\n\n" & $transposedMapData)

# echo mapData
# echo transposedMapData


# If position in original Sequence is data[rowIndex][heightIndex] then position in transposition is transData[heightIndex][rowIndex]

for rowIndex, row in mapData:
    for heightIndex, height in row:
        if rowIndex == 0 or rowIndex == mapData.len-1 or heightIndex == 0 or heightIndex == row.len-1:
            inc answer
        elif height.isVisibleFromRight(heightIndex, row) or height.isVisibleFromLeft(heightIndex, row) or height.isVisibleFromRight(rowIndex, transposedMapData[heightIndex]) or height.isVisibleFromLeft(rowIndex, transposedMapData[heightIndex]) :
            inc answer


echo "answer is: ", answer

