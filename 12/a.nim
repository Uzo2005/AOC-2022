import strutils, sequtils, sugar, math

var 
    dataTupleRep: seq[(string, (string, string), (string, string))]

const 
    data = readfile("newData.txt").strip().splitLines().map(x => x.splitWhitespace())
  

for y, row in data:
    for x, stuff in row:
        let 
            right = (if x == row.len-1: "nothing" else: row[x+1])
            left = (if x == 0: "nothing" else: row[x-1] )
            up = (if y == 0: "nothing" else: data[y-1][x])
            down = (if y == data.len-1: "nothing" else: data[y+1][x])

        # if right == "nothing" or left == "nothing" or up=="nothing" or  down == "nothing":
        #     discard
        # else:
        #     if up <= stuff + 1 :     
        #         discard
        #     elif down <= stuff + 1:
        #         discard
        #     elif left <= stuff + 1:
        #         discard
        #     elif right <= stuff + 1:
        #         discard
        dataTupleRep.add((stuff, (up, down), (left, right)))