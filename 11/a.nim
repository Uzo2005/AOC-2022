import strutils, sequtils, algorithm, tables, deques

const 
    data = readfile("data.txt").strip.splitLines
    numberOfMonkeysInstructions = (data.len + 1) div 7
    instructions = data.distribute(numberOfMonkeysInstructions)
    numberOfMonkeys = instructions.len
    rounds = 20


var 
    monkeyActivityCount = newSeq[int](numberOfMonkeys)
    monkeyItems = initTable[string, Deque[int]]()

for monkeyNumber, instruction in instructions:
    let 
        monkeyName = instruction[0].replace(" ").replace(":")
        startingItems = instruction[1].split(":")[1].strip.split(", ").map(parseint)

    #initialise the starting items
    monkeyItems[monkeyName] = startingItems.toDeque

for _ in 0..<rounds:
    for monkeyNumber, instruction in instructions:
        let 
            monkeyName = instruction[0].replace(" ").replace(":")
            # startingItems = instruction[1].split(":")[1].strip.split(", ").map(parseint)
            operation = instruction[2].split(" = ")[1].splitWhiteSpace[1..2]
            testCondition = instruction[3].split(" by ")[1].parseint
            actionOnTestPass = instruction[4].splitWhiteSpace[^1].parseint
            actionOnTestFail = instruction[5].splitWhiteSpace[^1].parseint
        
        for _ in monkeyItems[monkeyName].pairs:
            inc monkeyActivityCount[monkeyNumber]
            var newValue = monkeyItems[monkeyName].popFirst

            #apply the operation
            case operation[0]:
                of "*":
                    #multiply
                    case operation[1]:
                        of "old":
                            #use the old value
                            newValue *= newValue
                        else:
                            #it is a number
                            let num = parseint(operation[1])
                            newValue *= num
                of "+":
                    #add 
                    case operation[1]:
                        of "old":
                            #use the old value
                            newValue += newValue
                        else:
                            #it is a number
                            let num = parseint(operation[1])
                            newValue += num
                else:
                    echo " This operand is kinda wierd: ", operation[0]

            #div worry level by three 
            newValue = newValue div 3

            #execute the test
            if newValue mod testCondition == 0:
                monkeyItems["Monkey" & $actionOnTestPass].addLast(newValue)
                # echo monkeyName, "  threw ", newValue, " to ", "Monkey" & $actionOnTestPass

            else:
                monkeyItems["Monkey" & $actionOnTestFail].addLast(newValue)
                # echo monkeyName, "  threw ", newValue, " to ", "Monkey" & $actionOnTestFail

            

    # echo monkeyName
    # echo startingItems
    # echo operation
    # echo testCondition
    # echo actionOnTestPass
    # echo actionOnTestFail
    
echo monkeyItems

var answer: int

monkeyActivityCount.sort()

answer = monkeyActivityCount[^1] * monkeyActivityCount[^2] #the two top values

echo "answer is ", answer
