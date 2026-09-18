import Foundation

let fruits = ["Apple", "Banana", "Cherry", "Date", "Elderberry"]
print("1) Third fruit is", fruits[2])

var luckyNumbers: Set<Int> = [7, 14, 15, 1]
luckyNumbers.insert(9)
print("2) Updated set:", luckyNumbers)

let releaseYears = ["Swift": 2014, "Python": 1991, "C": 1972]
print("3) Swift was released in", releaseYears["Swift"]!)

var colors = ["Red", "Green", "Blue", "Yellow"]
colors[1] = "Purple"
print("4) Colors:", colors)

let setA: Set<Int> = [1, 2, 3, 4]
let setB: Set<Int> = [3, 4, 5, 6]
let intersection = setA.intersection(setB)
print("5) Sets intersection:", intersection)

var scores = ["Alice": 85, "Bob": 90, "Charlie": 78]
scores.updateValue(95, forKey: "Bob")
print("6) Updated scores", scores)

let fruitsA = ["apple", "banana"]
let fruitsB = ["cherry", "date"]
let mergedFruits = fruitsA + fruitsB
print("7) Merged fruits:", mergedFruits)

var populations = ["Kazakhstan": 19_600_000, "France": 67_000_000, "Japan": 125_000_000]
populations["Germany"] = 83_000_000
print("8) Updated populations:", populations)

let animalsA: Set<String> = ["cat", "dog"]
let animalsB: Set<String> = ["dog", "mouse"]
let unionResult = animalsA.union(animalsB)
let finalSet = unionResult.subtracting(animalsB)
print("9) Final animals set:", finalSet)

let grades = [
    "Anna": [88, 92, 79],
    "Bob": [70, 85, 95]
]
print("10) Anna's 2nd grade is", grades["Anna"]![1])