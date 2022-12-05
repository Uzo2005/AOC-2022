import strutils, sequtils, math, sugar
# import sequtils

var caloriesArranged: seq[seq[string]]
var total: seq[int]


const calories = readFile("test.txt").strip().split()

echo calories

# proc groupBySpace(stuffs: seq[string]) : seq[seq[string]] =
#     var temp: seq[string]

#     for stuff in stuffs:
#         if stuff != "":
#             temp.add(stuff)
#         else:
#             caloriesArranged.add(temp)
#             temp.setLen(0)
#     result = caloriesArranged


# proc groupBySpace(stuffs: seq[string]) : seq[seq[string]] =
    


#     result = caloriesArranged


# let calorieRecord = groupBySpace(calories)

# echo calorieRecord

# for calorie in calorieRecord:
#    total.add(sum(calorie.map(parseInt)))

# var first = max(total)

# total.delete(total.find(max(total)))

# var second = max(total)

# total.delete(total.find(max(total)))

# var third = max(total)

# # echo first
# # echo second
# # echo third

# echo "answer is: ", first + second + third


# Heads up this solution is horrible and will break your mind!!