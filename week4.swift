import Foundation
// =============================================================
//  Station ALMA-7, Part II: The Teleporter Incident
//  iOS Mobile Development · Module 4 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Part2_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER DATA section.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • Default to struct. Use class only where the task says so.
// =============================================================


// MARK: - =================== STARTER DATA ===================
// MARK: - Do not modify anything in this section

/// Splits a line into fields.
/// fields("crate:101:120")            -> ["crate", "101", "120"]
/// fields("livestock:lab mice:12:2")  -> ["livestock", "lab mice", "12", "2"]
/// fields("junk")                     -> ["junk"]
func fields(_ line: String, separatedBy separator: Character = ":") -> [String] {
    var result: [String] = []
    var current = ""
    for character in line {
        if character == separator {
            result.append(current)
            current = ""
        } else {
            current.append(character)
        }
    }
    result.append(current)
    return result
}

/// Cargo manifest as recovered from the damaged recorder.
let rawManifest = [
    "crate:101:120",
    "container:KZ-ALM-7:340",
    "livestock:lab mice:12:2",
    "???-corrupted-line",
    "crate:102:75",
    "container:KZ-ALM-9:410",
    "livestock:ficus:3:5",
    "crate:103:260",
    "crate:104:abc",
    ""
]

/// Oxygen readings. One of these deck names is not a real deck.
let deckReadings: [(deck: String, oxygen: Int)] = [
    (deck: "bridge",     oxygen: 78),
    (deck: "lab",        oxygen: 64),
    (deck: "greenhouse", oxygen: 55),
    (deck: "cargo",      oxygen: 12),
    (deck: "medbay",     oxygen: 90),
    (deck: "engine",     oxygen: 41)
]

/// Crew records, straight from the personnel file.
let crewData: [(name: String, deck: String, oxygen: Int)] = [
    (name: "Timur",   deck: "engine", oxygen: 62),
    (name: "Dana",    deck: "lab",    oxygen: 48),
    (name: "Aigerim", deck: "bridge", oxygen: 91),
    (name: "Nurlan",  deck: "cargo",  oxygen: 17)
]

print("ALMA-7 recorder online: \(rawManifest.count) manifest lines, \(deckReadings.count) readings, \(crewData.count) crew records.")

// MARK: - ================= END OF STARTER DATA =================


// MARK: - =================== YOUR SOLUTION ===================
// Uncomment each declaration when you start working on it.


// MARK: Level 1 · The Deck Register

// 1.1
enum Deck: String, CaseIterable {
    case bridge
    case lab
    case cargo
    case medbay
    case engine
    
    var evacuationPriority: Int {
        switch self {
        case .bridge: return 1
        case .lab: return 3
        case .cargo: return 5
        case .medbay: return 2
        case .engine: return 4
        }
    }
}
for deck in Deck.allCases {
    print("\(deck.rawValue): \(deck.evacuationPriority)")
}
// 1.2
enum AlarmLevel: Int {
    case green = 0
    case yellow
    case orange
    case red
    static func level(forTotalMass mass: Int) -> AlarmLevel {
        let step = min(max(mass, 0) / 500, 3)
        return AlarmLevel(rawValue: step) ?? .red
    }
}
AlarmLevel.level(forTotalMass: 0)
AlarmLevel.level(forTotalMass: 940)
AlarmLevel.level(forTotalMass: 4000)

// MARK: Level 2 · The Manifest

// 2.1
enum ManifestEntry {
    case crate(id: Int, massKg: Int)
    case container(code: String, massKg: Int)
    case livestock(species: String, count: Int, massPerUnitKg: Int)
    case unknown(raw: String)
}
// 2.2
func parseEntry(_ line: String) -> ManifestEntry {
    let parts = line.split(separator: ":", omittingEmptySubsequences:false
    )
    guard let entry = parts.first else { return .unknown(raw: line) }
    switch entry {
    case "crate":
        guard parts.count == 3,
            let id = Int(parts[1]),
            let massKg = Int(parts[2])
        else {return .unknown(raw: line)}
        return .crate(id: id, massKg: massKg)
    case "container":
        guard parts.count == 3,
            let massKg = Int(parts[2])
        else {return .unknown(raw: line)}
        return .container(code: String(parts[1]), massKg: massKg)
    case "livestock":
        guard parts.count == 4,
            let count = Int(parts[2]),
            let massPerUnitKg = Int(parts[3])
        else {return .unknown(raw: line)}
        return .livestock(species: String(parts[1]), count: count, massPerUnitKg: massPerUnitKg)
    default:
        return .unknown(raw: line)
    }
}
parseEntry("crate:101:120")
parseEntry("container:KZ-ALM-7:340")
parseEntry("livestock:lab mice:12:2")
// 2.3
func mass(of entry: ManifestEntry) -> Int {
    switch entry {
    case let .crate(id, massKg):
        return massKg
    case let .container(code, massKg):
        return massKg
    case let .livestock(species, count, massPerUnitKg):
        return count * massPerUnitKg
    case .unknown:
        return 0
    }
}

var A = 0
var unknownCount = 0
for line in rawManifest {
    let entry = parseEntry(line)
    if case .unknown = entry { unknownCount += 1 }
    A += mass(of: entry)
}
print("Manifest total mass: \(A)")
print("Unknown lines: \(unknownCount)")

// MARK: Level 3 · Crew Snapshots

// 3.1
struct CrewSnapshot {
    let name: String
    var deck: Deck
    var oxygen: Int
    
    mutating func breathe(_ amount: Int) {
        oxygen = max(0, oxygen - amount)
    }
    mutating func move(to deck: Deck) {
        self.deck = deck
    }
    mutating func reviveInMedbay() {
        self = CrewSnapshot(name: name, deck: .medbay, oxygen: 100)
    }
    static func rookie(named name: String) -> CrewSnapshot {
        CrewSnapshot(name: name, deck: .bridge, oxygen: 100)
    }
}

var snap = CrewSnapshot(name:"John", deck: .bridge, oxygen: 100)
snap.breathe(10)
print(snap.oxygen)
// 3.2
var crewRoster: [CrewSnapshot] = []
for data in crewData {
    if Deck(rawValue: data.deck) == nil {
        print("Deck \(data.deck) does not exist.")
        continue
    }
    crewRoster.append(CrewSnapshot(
        name: data.name, deck: Deck(rawValue: data.deck) ?? .bridge, oxygen: data.oxygen)
    )
}
// 3.3 · Value-semantics demonstration (copy / plain parameter / inout)

// 1. Copy
var original = CrewSnapshot.rookie(named: "Ada")
print("Original oxygen:", original.oxygen)
var copy = original
copy.breathe(30)
print("After (copy) breathe copy oxygen:", copy.oxygen)
print("After (copy) breathe original oxygen:", original.oxygen)

// 2. Plain function
func breathePlain(_ snapshot: CrewSnapshot) {
    var local = snapshot
    local.breathe(50)
    print("Inside function local oxygen:", local.oxygen)
}
var crew = CrewSnapshot.rookie(named: "Bo")
print("Before oxygen:", crew.oxygen)
breathePlain(crew)
print("After drainPlain oxygen:", crew.oxygen)

// 3. inout
func breatheInout(_ snapshot: inout CrewSnapshot) {
    snapshot.breathe(50)
}
print("Before inout drainInout oxygen:", crew.oxygen)
breatheInout(&crew)
print("After inout drainInout oxygen:", crew.oxygen)
// MARK: Level 4 · The Teleport Pod

// 4.1
final class TeleportPod {
    let id: String
    var chargeLevel: Int
    var occupant: CrewSnapshot?
    
    init(id: String, chargeLevel: Int) {
        self.id = id
        self.chargeLevel = chargeLevel
        self.occupant = nil
    }
    
    @discardableResult
    func load(_ crew: CrewSnapshot) -> Bool {
        guard occupant == nil, chargeLevel >= 20 else { return false }
        occupant = crew
        return true
    }
    
    @discardableResult
    func fire() -> CrewSnapshot? {
        guard let crew = occupant else { return nil }
        chargeLevel -= 20
        occupant = nil
        return crew
    }
}
// Structs in Swift have automatically generated initializers, unlike classes, because structs cannot inherit. A struct's full set of stored properties is right in its own definition. Nothing is hidden in a parent type, so Swift can safely generate init(name:deck:oxygen:)

// 4.2 · Charge ledger: load+fire three times, then fire an empty pod
let pod1 = TeleportPod(id: "P-1", chargeLevel: 100)

pod1.load(CrewSnapshot.rookie(named: "Timur"))
_ = pod1.fire()
print("Step 1: \(pod1.chargeLevel)")

pod1.load(CrewSnapshot.rookie(named: "Dana"))
_ = pod1.fire()
print("Step 2: \(pod1.chargeLevel)")

pod1.load(CrewSnapshot.rookie(named: "Nurlan"))
_ = pod1.fire()
print("Step 3: \(pod1.chargeLevel)")
_ = pod1.fire()
print("Step 4: \(pod1.chargeLevel)")
let C = pod1.chargeLevel
// 4.3 · Reference-semantics demonstration
let pod2 = pod1
pod2.chargeLevel = 50

print("pod1: \(pod1.chargeLevel)")
print("pod2: \(pod2.chargeLevel)")
print(pod1 === pod2)

// CrewSnapshot experiment
// assigning a class instance copies the reference (both names share one object),
// assigning a struct copies the value (two independent instances).
var crewA = CrewSnapshot.rookie(named: "Timur")
var crewB = crewA
crewB.breathe(30)

print("crewA: \(crewA.oxygen)")
print("crewB: \(crewB.oxygen)")

// MARK: Level 5 · Station Systems
// 5.1
final class Station {
    let callSign: String
    var hullIntegrity: Int {
            willSet {
                print("Hull changes from \(hullIntegrity) to \(newValue)")
            }
            didSet {
                if hullIntegrity > 100 { hullIntegrity = 100 }
                if hullIntegrity < 0 { hullIntegrity = 0 }
            }
        }
    lazy var fullDiagnostics: String = {
        print("Running full scan...")
        return "\(callSign): hull \(hullIntegrity), total O2 \(totalOxygen)"
    }()
    var oxygenByDeck: [Deck: Int]
    var totalOxygen: Int {
            var sum = 0
            for value in oxygenByDeck.values {
                sum += value
            }
            return sum
    }
    var averageOxygen: Int {
            get {
                guard oxygenByDeck.count > 0 else { return 0 }
                return totalOxygen / oxygenByDeck.count
            }
            set {
                for deck in oxygenByDeck.keys {
                    oxygenByDeck[deck] = newValue
                }
            }
        }
    
    init(callSign: String, hullIntegrity: Int, readings: [(deck: String, oxygen: Int)]) {
        self.callSign = callSign
        self.hullIntegrity = hullIntegrity
        var result: [Deck: Int] = [:]
        for (name, value) in readings {
            if let deck = Deck(rawValue: name) {
                result[deck] = value
            }
        }
        self.oxygenByDeck = result
    }
}
let station = Station(callSign: "ALM-1", hullIntegrity: 100, readings: deckReadings)
let B = station.averageOxygen
print(B)
print(station.fullDiagnostics)
print(station.fullDiagnostics)
let untouched = Station(callSign: "ALM-2", hullIntegrity: 80, readings: deckReadings)
print("No scan will be printed for the untouched station: \(untouched.callSign)")
// 5.2 · The clamp trap: 130, then -40, then 55
station.hullIntegrity = 130
print("hull: \(station.hullIntegrity)")
station.hullIntegrity = -40
print("hull: \(station.hullIntegrity)")
station.hullIntegrity = 55
print("hull: \(station.hullIntegrity)")
// Assigning to a property inside its own didSet writes the value directly
// and does not trigger willSet/didSet again, so the clamp can't loop.

// MARK: Level 6 · Incident Reports
// Three of these compile and are wrong. One does not compile.
// For each: expectation, actual behaviour, the language rule, the fix.

// Initial Report 1
//var roster = crewRoster
//for var member in roster {
//    member.oxygen -= 10
//}
//print(roster[0].oxygen)   // author expected the crew to have lost oxygen

// Fix
// for var member in roster creates a local copy of the element on each iteration,
// and the copy changes, not the array element itself.
var roster = crewRoster
for i in roster.indices {
    roster[i].breathe(10)
}
print(roster[0].oxygen)   // author expected the crew to have lost oxygen

// Initial Report 2
//let podA = TeleportPod(id: "A", chargeLevel: 100)
//let podB = podA
//podB.chargeLevel = 0
//print(podA.chargeLevel)   // author expected 100

// Fix
// TeleportPod is a class, which is a reference type.
// let podB = podA copies the reference,
// so both constants point to the same instance.
let podA = TeleportPod(id: "A", chargeLevel: 100)
let podB = TeleportPod(id: "A", chargeLevel: podA.chargeLevel)
podB.chargeLevel = 0
print(podA.chargeLevel)   // author expected 100

// Initial Report 3
//struct Logbook {
//    var entries: [String] = []
//    func add(_ entry: String) {
//        entries.append(entry)
//    }
//}

// Fix
// The error 'cannot use mutating member on immutable value:
// 'self' is immutable' does not let the code compile.
struct Logbook {
    var entries: [String] = []
    mutating func add(_ entry: String) {
        entries.append(entry)
    }
}

// Initial Report 4
//let snapshot = CrewSnapshot.rookie(named: "Dana")
//snapshot.oxygen = 40
//
//let pod = TeleportPod(id: "B", chargeLevel: 50)
//pod.chargeLevel = 10

// Fix
// For a value type (struct), the variable is the data itself.
// Modifying any property means modifying the value, and `let` forbids this.
// That is why an error occurs, even though `oxygen` is declared as `var`.
// For a class, let freezes only the reference: pod can't point to another object,
// but the object's var properties (chargeLevel) can still change, so line 2 compiles.
var snapshot = CrewSnapshot.rookie(named: "Dana")
snapshot.oxygen = 40

let pod = TeleportPod(id: "B", chargeLevel: 50)
pod.chargeLevel = 10


// MARK: Level 7 · Sealing the Black Box

// The leaky original:

//class FlightRecorder {
//    var entries: [String] = []
//    var isSealed = false
//}

// final class FlightRecorder { }

class FlightRecorder {
    // private blocks any array read and write from the outside
    private var entries: [String] = []
    // private(set) blocks write from the outside, it is impossible to revert isSealed back to false
    private(set) var isSealed = false
    // internal blocks access from outside this module
    internal var count: Int {
        entries.count
    }
    // gives access to read the array's transcript
    internal var transcript: String {
        var result = ""
        var index = 1
        for entry in entries {
            result += "\(index). \(entry)\n"
            index += 1
        }
        return result
    }
    // this is the only way to add an entry, checks isSealed first
    internal func add(_ entry: String) -> Bool {
        guard !isSealed else { return false }
        entries.append(entry)
        return true
    }

    // gives an opportunity to seal a record, unseal is impossible, there is no reverse method
    internal func seal() {
        isSealed = true
    }

    // fileprivate blocks access from other files
    fileprivate func lastEntry() -> String? {
        entries.last
    }
}

// A free function elsewhere in the file that uses your fileprivate helper:
func auditTranscript(of recorder: FlightRecorder) -> String {
    return "Latest entry: \(recorder.lastEntry() ?? "none")"
}

let recorder = FlightRecorder()
recorder.add("Some record")
recorder.add("Some other record")
recorder.seal()

let accepted = recorder.add("One more record")
print("Accepted after seal: \(accepted)")
print("Count: \(recorder.count)")
print(recorder.transcript)
print(auditTranscript(of: recorder))

//recorder.entries = []
// error: 'entries' is inaccessible due to 'private' protection level
//recorder.entries.removeAll()
// error: 'entries' is inaccessible due to 'private' protection level
//recorder.isSealed = false
// error: cannot assign to property: 'isSealed' setter is inaccessible

// MARK: Finale · Integrity Code

let D = AlarmLevel.level(forTotalMass: A).rawValue
let integrityCode = "\(A)-\(B)-\(C)-\(D)"
print("INTEGRITY CODE: \(integrityCode)")


// MARK: Bonus

// deinit in TeleportPod, a do-block lifetime experiment, and === identity


// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. Why did CrewSnapshot get an initializer for free and TeleportPod did not?
    Structs don't support inheritance, and all its stored properties are listed just once,
    so the compiler can safely generate init for it automatically.
    A class can have a superclass and subclasses. Its init has to go through the whole
    inheritance chain, and the compiler can't decide for us
    which super.init to call or which parent properties to include.
 2. What does `mutating` do to self, and why do classes never need it?
    In a struct method, self is a read-only copy. mutating turns self into an inout parameter,
    so the method can change properties, and the change is written back into the variable the method was called on.
    In a class, self is a reference. Changing a property changes the object in memory,
    not the reference. mutating isn't needed.
 3. In Report 4 both values are `let`. What exactly does `let` freeze for a
    struct, and what does it freeze for a class?
    Struct: let freezes the whole value. The variable IS the data, and oxygen lives inside
    snapshot, so changing any property means changing the value.
    Class: let freezes only the reference (which object pod points to).
    The object itself lives elsewhere, and its var properties can be changed.
 4. Why must a lazy property be var? When does lazy change behaviour, not
    just performance?
    A let must have its value by the end of init, and then it can't change.
    A lazy property gets its value later, on first access, so it is written after init.
 5. private vs fileprivate: where in your FlightRecorder would private be
    too strict?
    private is visible only inside the type (and its extensions in the same file).
    The free function printLatest(from:) is outside the class, so with a private
    lastEntry() it wouldn't compile.
    fileprivate opens the helper to the whole file,
    including this free function,
    but still hides it from other files.
 Bonus. On which line does deinit fire, and why can't === be used on
 CrewSnapshot?

*/
