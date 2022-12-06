import sequtils, strutils

const data = readfile("signal_packets.txt").strip()


for num in 0..<data.len:
    if data[num..<num+4].deduplicate() == data[num..<num+4]:
        echo "The first marker is: ", data[num..<num+4]
        echo "The first time a marker appears is after the ", data.find(data[num..<num+4]) + 4, " th character arrives"
        break


        
