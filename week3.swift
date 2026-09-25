// =============================================================
//  Station ALMA-7: Rescue Protocol
//  iOS Mobile Development · Module 3 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER CODE section.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • Use the exact function names from the assignment PDF.
// =============================================================


// MARK: - =================== STARTER CODE ===================
// MARK: - Do not modify anything in this section

typealias Reading = (sensor: String, value: Int)

/// Splits a string at the first occurrence of the separator.
/// splitOnce("O2:87", by: ":") -> ("O2", "87")
/// splitOnce("hello", by: ":") -> nil
func splitOnce(_ line: String, by separator: Character) -> (String, String)? {
    guard let index = line.firstIndex(of: separator) else { return nil }
    let left = String(line[..<index])
    let right = String(line[line.index(after: index)...])
    return (left, right)
}

let rawLog = [
    "O2:87", "TEMP:-12", "O2:9x", "PRESS:101", "TEMP:abc", "O2:",
    "RAD:3", "O2:64", ":55", "TEMP:31", "PRESS:98", "O2:71",
    "RAD:-1", "TEMP:4", "PRESS:1o2", "O2:90"
]

class Tank {
    var level: Int
    init(level: Int) { self.level = level }
}

class Module {
    let name: String
    var oxygenTank: Tank?
    init(name: String, oxygenTank: Tank?) {
        self.name = name
        self.oxygenTank = oxygenTank
    }
}

class CrewMember {
    let name: String
    let role: String
    let priority: Int      // 1 = evacuated first
    var module: Module?    // nil = in open space
    init(name: String, role: String, priority: Int, module: Module?) {
        self.name = name
        self.role = role
        self.priority = priority
        self.module = module
    }
}

let lab  = Module(name: "Lab",  oxygenTank: Tank(level: 40))
let hab  = Module(name: "Hab",  oxygenTank: Tank(level: 12))
let dock = Module(name: "Dock", oxygenTank: nil)

let crew = [
    CrewMember(name: "Timur",   role: "Engineer",  priority: 3, module: lab),
    CrewMember(name: "Dana",    role: "Scientist", priority: 4, module: dock),
    CrewMember(name: "Aigerim", role: "Commander", priority: 1, module: hab),
    CrewMember(name: "Nurlan",  role: "Pilot",     priority: 2, module: nil)
]

var roster: [String: CrewMember] = [:]
for member in crew { roster[member.name] = member }

print("ALMA-7 systems online: \(rawLog.count) log lines, \(crew.count) crew members.")

// MARK: - ================= END OF STARTER CODE =================


// MARK: - =================== YOUR SOLUTION ===================
// Uncomment each signature when you start working on it.


// MARK: Level 1 · Decoding Telemetry

// 1.1
 func parseReading(_ raw: String) -> Reading? {
     guard let colon = raw.firstIndex(of: ":"),
               raw[..<colon].isEmpty == false,
               let value = Int(raw[raw.index(after: colon)...]),
               value >= 0 || raw[..<colon] == "TEMP"
         else {
             return nil
         }
         
         let sensor = String(raw[..<colon])
         return (sensor: sensor, value: value)
 }
print(parseReading("O2:87"))
print(parseReading("RAD:-1"))
// 1.2
func parseLog(_ lines: [String]) -> (valid: [Reading], invalidCount: Int) {
    var valid: [Reading] = []
    var invalidCount: Int = 0
    for line in lines {
        if let reading = parseReading(line) {
            valid.append(reading)
        } else {
            invalidCount += 1
        }
    }
    return (valid, invalidCount)
}

let A = parseLog(rawLog).invalidCount
let validReadings = parseLog(rawLog).valid

// MARK: Level 2 · Analysis

// 2.1
func select(_ readings: [Reading], where isIncluded: (Reading) -> Bool) -> [Reading] {
    var filteredReadings: [Reading] = []
    for reading in readings {
        if isIncluded(reading) {
            filteredReadings.append(reading)
        }
    }
    return filteredReadings
}
func values(of readings: [Reading]) -> [Int] {
    var values: [Int] = []
    for reading in readings {
        values.append(reading.value)
    }
    return values
}
let retrievedReadings = select(validReadings) { $0.sensor == "O2" }

print(retrievedReadings)
let o2_values: [Int] = values(of: retrievedReadings)
print()
// 2.2
func stats(of values: [Int]) -> (min: Int, max: Int, average: Double)? {
    if values.count == 0 {
        return nil
    }
    var currentMin = values[0]
    var currentMax = values[0]
    var total: Double = 0.0
    for value in values {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
        total += Double(value)
    }
    return (currentMin, currentMax, total / Double(values.count))
}

func stats(_ values: Int...) -> (min: Int, max: Int, average: Double)? {
    stats(of: values)
}
print(stats(3, 8, 1))
print(stats())
let B = stats(of: o2_values)
print(B)
// 2.3 · The Closure Ladder (5 sorts, then compare results in code)
let descendingReadings = validReadings.sorted(by:{(r1: Reading, r2: Reading) -> Bool in
    return r1.value > r2.value
})
let descendingReadings2 = validReadings.sorted(by:{r1, r2 in return r1.value > r2.value})
let descendingReadings3 = validReadings.sorted(by:{r1, r2 in r1.value > r2.value})
let descendingReadings4 = validReadings.sorted(by:{$0.value > $1.value})
let sorted5 = validReadings.sorted { $0.value > $1.value }
// MARK: Level 3 · Temperature Stabilization

// 3.1
func heatUp(_ t: Int) -> Int {
    return t + 5
}
func coolDown(_ t: Int) -> Int {
    return t - 3
}
 func hold(_ t: Int) -> Int {
     return t
 }
func chooseProtocol(for temp: Int) -> (Int) -> Int {
    if temp < 18 {
        return heatUp(_:)
    } else if temp > 24 {
        return coolDown(_:)
    } else {
        return hold(_:)
    }
}
// 3.2
func runUntilStable(from start: Int, maxSteps: Int = 10) -> (finalTemp: Int, steps: Int, isStable: Bool) {
    var temp = start
    var steps = 0
    
    while (temp < 18 || temp > 24) && steps < maxSteps {
        let apply = chooseProtocol(for: temp)
        temp = apply(temp)
        steps += 1
    }
    let isStable = temp >= 18 && temp <= 24
    return (finalTemp: temp, steps: steps, isStable: isStable)
}
let tempLogs = select(validReadings) { $0.sensor == "TEMP" }
let tempValues: [Int] = values(of: tempLogs)
let minTemp: Int? = stats(of: tempValues)?.min
let C = runUntilStable(from: minTemp ?? 0)

// MARK: Level 4 · The Crew

// 4.1
func oxygenLevel(of member: CrewMember) -> Int? { return member.module?.oxygenTank?.level }
print(oxygenLevel(of: crew[0]))
print(oxygenLevel(of: crew[2]))
// 4.2
func status(of member: CrewMember) -> String {
    guard let lvl = member.module?.oxygenTank?.level else {
        let location = member.module?.name ?? "open space"
        return "\(member.name): no data (\(location))"
    }
    if lvl < 20 {
        return "\(member.name): \(lvl)% CRITICAL"
    } else {
        return "\(member.name): \(lvl)% OK"
    }
}
for member in crew {
    print(status(of: member))
}
// 4.3
@discardableResult
func transferOxygen(from source: inout Int, to target: inout Int, amount: Int) -> Int {
    guard amount > 0 else {
            return 0
        }
    let spaceInTarget = 100 - target
    let realTransfer = min(amount, source, spaceInTarget)
    source -= realTransfer
    target += realTransfer
    return realTransfer
}
guard let labTank = lab.oxygenTank, let habTank = hab.oxygenTank else {
    print("Один из баков отсутствует")
    fatalError("Cannot proceed without both tanks")
}

let transferred = transferOxygen(from: &labTank.level, to: &habTank.level, amount: 30)

print("Transferred: \(transferred) units")
print("Lab level now: \(labTank.level)")
print("Hab level now: \(habTank.level)")
let D = hab.oxygenTank

// 4.4
func evacuationOrder(_ names: String..., roster: [String: CrewMember]) -> [String] {
    var found: [CrewMember] = []
    for name in names {
        guard let member = roster[name] else {
            print("Unknown crew member: \(name)")
            continue
        }
        found.append(member)
    }
    let sorted = found.sorted { $0.priority < $1.priority }
        
    var result: [String] = []
    for member in sorted {
        result.append(member.name)
    }
    return result
}
evacuationOrder("Dana", "Ghost","Timur","Aigerim", roster: roster)
evacuationOrder("Nurlan", "Dana","Timur","Guest", roster: roster)
// MARK: Level 5 · The Saboteur's Logbook
// The saboteur's code is below, commented out (it needs your
// oxygenLevel(of:) to compile). Comment on every problem, then
// write fixed versions and a test that proves the logic bug is gone.


func reportOxygen(for member: CrewMember) -> String {
    // member.module! breaks if member.module == nil
    // .oxygenTank! breaks if module exists but has no tank
    guard let tank = member.module?.oxygenTank else {
        return "\(member.name): no data"
    }
    return "\(member.name): \(tank.level)%"
}

func firstCritical(in crew: [CrewMember]) -> String? {
    for member in crew {
        if let level = oxygenLevel(of: member), level < 20 {
            // Result is overwritten on every match,not just the first.
            // This will returns the last critical member, not the first.
            return member.name
        }
    }
    return nil
}



// MARK: Finale · Launch Code

let launchCode = "\(A)-\(B)-\(C)-\(D)"
print("LAUNCH CODE: \(launchCode)")


// MARK: Bonus

// func makeAlarm(threshold: Int) -> (Int) -> Bool { }


// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. guard let vs if let beyond syntax:
 guard let is exits the current scope if the check fails, 
 so any values you unwrap using it will stay around after the check. 
 if let only unwraps the variable inside its own block. Outside of it, the variable doesn't exist.

func someFunction() -> Int? {
    1
}

guard let number = someFunction() else {
    return
}
print(number)

if let number = someFunction() {
    print(number)
}

 2. Why can't you pass [Int] to stats(_ values: Int...)?
 The parameter Int... means the function expects separate Int values, not an array.
 Swift does not automatically converts an array into variadic arguments.

 3. Why doesn't transferOxygen(from: &x, to: &x, amount: 5) compile?
 It is impossible to pass the same variable as two different inout parameters, 
 because both parameters would get exclusive write access to the same memory location at the same time.
 4. Why doesn't oxygenLevel(of: dana) ?? "no data" compile?
 oxygenLevel(of:) returns Int?, while "no data" is a String. Those are incompatible types.
 5. Full type of chooseProtocol and how to read it:
chooseProtocol is a function that takes one Int (the temperature)
and returns ANOTHER function
that returned function itself takes an Int and returns an Int
 Bonus. Where does the alarm counter live after makeAlarm returns?

*/
