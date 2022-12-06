import sequtils, strutils

const data = readfile("signal_packets.txt").strip()


for num in 0..<data.len:
    if data[num..<num+14].deduplicate() == data[num..<num+14]:
        echo "The first start-of-message is: ", data[num..<num+14]
        echo "The first time a start-of-message appears is after ", data.find(data[num..<num+14]) + 14
        break



        
