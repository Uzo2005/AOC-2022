import strutils, sequtils, sugar, algorithm

const mapData = readfile("data.txt").strip().split().map(x => toSeq(x).map(y => parseInt($y)))



# const visibleOnEdge = mapData[0].len * 2 + (mapData.len - 2)*2

# echo visibleOnEdge




# proc isVisibleFromLeft (num: int, indexOfNum: int,  mapDataRow: seq[int]): bool =
#     let leftSide = mapDataRow[0..<indexOfNum]
#     if num > max(leftSide):
#         result = true

# proc isVisibleFromRight (num: int, indexOfNum: int,  mapDataRow: seq[int]): bool =
#     let rightSide = mapDataRow[indexOfNum+1..^1]
#     if num > max(rightSide):
#         result = true

proc treeViewsFromRight (num, indexOfNum: int, mapDataRow: seq[int], down :bool) :int=
    var rightSide = mapDataRow[indexOfNum+1..^1]

    # if down:
    #     rightSide.reverse()
    #     for indexOfTree, tree in rightSide:
    #         if tree >= num:
    #             # [1, 2, 3, 4]
    #             # [4, 3, 2, 1]
    #             # 0 -> 3
    #             # 1 -> 2
    #             # 2 -> 1
    #             # 3 -> 0
    #             result = abs(((rightSide.len - 1) - indexOfTree) - indexOfNum)
    #             break
    #         else:
    #             continue
    # else:

    for indexOfTree, tree in rightSide:
        if tree >= num:
            # result = abs(indexOfTree - indexOfNum)
            result = indexOfTree + 1
            # if down:  
            #     echo "" 
            #     echo "index Of Tree is: ", indexOfTree, " and index of num is: ", indexOfNum
            break
        else:
            continue

    if result == 0:
        result = rightSide.len

    # if down:
    # echo "num is ", num, " and the ", if down: "down" else: "right"  ," side is ", rightSide, " viewing distance is ", result
    #     echo ""
    #     echo "_____________________________________________________________________________________________"
    

proc treeViewsFromLeft (num, indexOfNum: int, mapDataRow: seq[int], up: bool) :int =
    var leftSide = mapDataRow[0..<indexOfNum]
    leftSide.reverse()
    for indexOfTree, tree in leftSide:
        if tree >= num:
            # [1, 2, 3, 4]
            # [4, 3, 2, 1]
            # 0 -> 3
            # 1 -> 2
            # 2 -> 1
            # 3 -> 0
            result = abs(((leftSide.len - 1) - indexOfTree) - indexOfNum)
            break
        else:
            continue

    if result == 0:
        result = leftSide.len
    # echo "num is ", num, " and the ", if up: "up" else: "left"  ," side is ", leftSide, " viewing distance is ", result
    



proc transposeData [T](data: seq[seq[T]]) : seq[seq[T]] = 
    result.setLen(data.len)
    for row in data:
        for index, num in row:
            result[index].add(num)
    

let transposedMapData = transposeData(mapData)



# If position in original Sequence is data[rowIndex][heightIndex] then position in transposition is transData[heightIndex][rowIndex]





proc scenicScore [T](mapTree, transposedMapTree : seq[seq[T]]) :T =
    for rowIndex, row in mapTree:
        for heightIndex, height in row:
            var distanceRLUD = newSeq[int](4)

            if rowIndex == 0 or rowIndex == mapData.len-1 or heightIndex == 0 or heightIndex == row.len-1:
                distanceRLUD = @[0, 0, 0, 0]
            else:
                distanceRLUD[0] = height.treeViewsFromRight(heightIndex, row, false)
                distanceRLUD[1] = height.treeViewsFromLeft(heightIndex, row, false)
                distanceRLUD[2] =  height.treeViewsFromLeft(rowIndex, transposedMapTree[heightIndex], true)
                distanceRLUD[3] = height.treeViewsFromRight(rowIndex, transposedMapTree[heightIndex], true)
                
            # echo distanceRLUD, " for ", height, " index ", heightIndex+1, " on row ", rowIndex+1

            # echo distanceRLUD[0]*distanceRLUD[1]*distanceRLUD[2]*distanceRLUD[3]
            if result < distanceRLUD[0]*distanceRLUD[1]*distanceRLUD[2]*distanceRLUD[3]:
                result = distanceRLUD[0]*distanceRLUD[1]*distanceRLUD[2]*distanceRLUD[3]

echo "answer is: ", scenicScore(mapData, transposedMapData)

