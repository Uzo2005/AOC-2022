import strutils, sequtils, algorithm, tables, deques

proc hcf(a, b: int): int =
    if a == 0:
        return b
    if b == 0: 
        return a
    var
        bigger = max(a, b)
        smaller = min(a, b)
    
        rem = bigger mod smaller

    hcf(smaller, rem)

proc lcm(a, b: int): int = a*b div hcf(a, b)

proc lcm(nums: seq[int]): int =
    nums.foldl(lcm(a, b))

const 
    data = readfile("data.txt").strip.splitLines
    numberOfMonkeysInstructions = (data.len + 1) div 7
    instructions = data.distribute(numberOfMonkeysInstructions)
    numberOfMonkeys = instructions.len
    rounds = 10000

var 
    monkeyActivityCount = newSeq[int](numberOfMonkeys)
    monkeyItems = initTable[string, Deque[int]]()
    testDivisors: seq[int]
    testDivisorsLcm: int

for monkeyNumber, instruction in instructions:
    let 
        monkeyName = instruction[0].replace(" ").replace(":")
        startingItems = instruction[1].split(":")[1].strip.split(", ").map(parseint)
        testCondition = instruction[3].split(" by ")[1].parseint


    #initialise the starting items
    monkeyItems[monkeyName] = startingItems.toDeque

    #collect all the test conditions so I can find the lcm
    testDivisors.add(testCondition)

testDivisorsLcm = lcm(testDivisors)

for _ in 0..<rounds:
    for monkeyNumber, instruction in instructions:
        let 
            monkeyName = instruction[0].replace(" ").replace(":")
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

            #reduce the number to avoid integer overflows while still passing divisibility tests

            while newValue > testDivisorsLcm:
                newValue -= testDivisorsLcm

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
    
echo monkeyActivityCount

monkeyActivityCount.sort()

var answer = monkeyActivityCount[^1] * monkeyActivityCount[^2] #the two top values

echo "answer is ", answer
