import strutils, sequtils, tables

const data = readfile("data.txt").strip.splitlines

var 
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
    


proc isChildDirOf(a, b: seq[string]): bool =
    if a.len < b.len: # a/b/c/d and a/b
        return false
    result = a[0 .. (b.len - 1)] == b

assert @["", "/", "a", "e"].isChildDirOf(@["", "/"]), "subdir check impl is wrong"

for (pwd, foldername) in dirtracker.deduplicate:
    var temp = pwd
    temp.add(foldername)
    let fullpath = temp
    
    for (cwd, details) in filetracker:
        let (size, name) = details
        if cwd == fullpath or cwd.isChildDirOf(fullpath):
            if sizetracker.haskey(fullpath):
                sizetracker[fullpath] += parseint(size)
            else:
                sizetracker[fullpath] = parseint(size)

#if fullpath is a/b/c and cwd is a/b it would match 2 and a/b/c count would increase but would a/b's count increase?

echo sizetracker

var answer: int

for (path, size) in sizetracker.pairs:
    if size < 100000:
        # echo path, " ", size
        inc answer, size
            

echo answer
