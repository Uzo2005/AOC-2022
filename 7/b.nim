import strutils, sequtils, tables, algorithm


const data = readfile("data.txt").strip.splitlines
const totalDiskSpace = 70000000
const unUsedSpaceNeeded = 30000000

var 
    ourDataTotalSize: int
    curdirlogger: seq[string]
    dirtracker: seq[(seq[string], string)]
    filetracker: seq[(seq[string], (string, string))]
    sizetracker = initTable[seq[string], int]()

curdirlogger.add("")

for cmd in data:
    let entry = cmd.strip.splitWhiteSpace
    case entry.len:
        of 3:
            #this is a cd cmd
            let curDir = entry[2]
            if curDir == "..":
                discard curdirlogger.pop()
            else:
                curdirlogger.add(curDir)
        of 2:
            case entry[0]:
                of "$":
                    #this is an ls cmd
                    discard
                else:
                    if entry[0] == "dir":
                        #dir details
                        let dirname = entry[1]
                        dirtracker.add((curdirlogger, dirname))
                        # echo dirname
                    else:
                        #file details
                        let filesize = entry[0]
                        let filename = entry[1]

                        filetracker.add((curdirlogger, (filesize, filename)))
                        # echo filename
        else:
            assert false, "I dont know what this is !"
    

for (_, details) in filetracker.deduplicate:#to skip repetitions
    inc ourDataTotalSize, parseint(details[0]) #this totalsize looks suspicious

proc isChildDirOf(a, b: seq[string]): bool =
    if a.len < b.len:
        return false
    result = a[0 .. (b.len - 1)] == b

for (pwd, foldername) in dirtracker:
    var temp = pwd
    temp.add(foldername)
    let fullpath = temp
    
    for (cwd, details) in filetracker:
        let (size, _) = details
        if cwd == fullpath or cwd.isChildDirOf(fullpath):
            if sizetracker.haskey(fullpath):
                sizetracker[fullpath] += parseint(size)
            else:
                sizetracker[fullpath] = parseint(size)

let 
    availableSpace = totalDiskSpace - ourDataTotalSize
    extraSpaceNeeded = unUsedSpaceNeeded - availableSpace

var smallestDirToBeDeleted = ourDataTotalSize

for (directory, directorySize) in sizetracker.pairs:
    if directorySize >= extraSpaceNeeded:
        smallestDirToBeDeleted = min(smallestDirToBeDeleted, directorySize)

echo smallestDirToBeDeleted

