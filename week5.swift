// =============================================================
//  Station ALMA-7, Part III: The Repair Fleet
//  iOS Mobile Development · Module 5 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Part3_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER DATA section. LegacyBeacon in
//     particular must be reached with an extension, not edited.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • The Health Rule must exist in exactly ONE place in this file.
// =============================================================


// MARK: - =================== STARTER DATA ===================
// MARK: - Do not modify anything in this section

/// Drone records recovered from the fleet registry.
/// One `kind` does not correspond to any drone type you will build.
let fleetData: [(kind: String, id: String, charge: Int)] = [
    (kind: "welder",  id: "W-1", charge: 80),
    (kind: "scanner", id: "S-1", charge: 45),
    (kind: "cargo",   id: "C-1", charge: 100),
    (kind: "welder",  id: "W-2", charge: 15),
    (kind: "scanner", id: "S-2", charge: 60),
    (kind: "tug",     id: "T-1", charge: 50)
]

/// Hull sensors. These are NOT drones — they never move and never work a shift.
let sensorData: [(id: String, charge: Int)] = [
    (id: "hull-cam", charge: 12),
    (id: "thermal",  charge: 77)
]

/// Hardware from the original station. You may not add anything to this
/// declaration — no methods, no protocols, no properties.
struct LegacyBeacon {
    let name: String
    let signalStrength: Int
}

let beacon = LegacyBeacon(name: "ALMA-BEACON", signalStrength: 8)

print("Fleet registry online: \(fleetData.count) drone records, \(sensorData.count) sensors, beacon \(beacon.name).")

// MARK: - ================= END OF STARTER DATA =================


// MARK: - =================== YOUR SOLUTION ===================
// Uncomment each declaration when you start working on it.


// MARK: Level 1 · The Power Cell

// Why a class and not a struct here?  ->
final class PowerCell {
    private var charge: Int
    init(charge: Int) {
        if charge < 0 {
            self.charge = 0
        } else if charge > 100 {
            self.charge = 100
        } else {
            self.charge = charge
        }
    }
    func level() -> Int {
        return charge
    }
    func spend(amount: Int) -> Bool {
        if amount < 0 || charge - amount < 0 {
            return false
        } else {
            charge -= amount
            return true
        }
    }
    func recharge(by amount: Int) {
        guard amount > 0 else {
            return
        }
        charge = min(charge + amount, 100)
    }
}

let cell = PowerCell(charge: 50)
print(cell.level())
print(cell.spend(amount: -10))
print(cell.spend(amount: 100))
print(cell.spend(amount: 10))
print(cell.level())
cell.recharge(by: 60)
print(cell.level())
// Encapsulation proof (leave this commented, with the compiler error):
// cell.charge = 100
// error: 'charge' is inaccessible due to 'private' protection level


// MARK: Level 2 · The Fleet

// 2.1  What does `final` on runOnce() buy you?  ->
// final does not let child classes to override the ritual,
// it's the same for all Drones.
class Drone {
    let id: String
    let cell: PowerCell

    init(id: String, cell: PowerCell) {
        self.id = id
        self.cell = cell
    }
    var powerCost: Int {
        return 10
    }
    var statusLine: String {
        return "\(id): \(cell.level())%"
    }
    func performTask() -> Int { 0 }

    final func runOnce() -> Int {
        let result: Bool = cell.spend(amount: powerCost)
        if !result {
            return 0
        }
        return performTask()
    }
}

// 2.2
final class WelderDrone: Drone {
    override var powerCost: Int {
        return 25
    }
    override func performTask() -> Int {
        return 40
    }
    func weldSeam() -> String {
        return ""
    }
}

class ScannerDrone: Drone {
    override var powerCost: Int {
        return 10
    }
    override func performTask() -> Int {
        return 15
    }
    override var statusLine: String {
        return super.statusLine + " [scanner]"
    }
}
final class CargoDrone: Drone {
    override var powerCost: Int {
        return 20
    }
    override func performTask() -> Int {
        return 25
    }
}

// 2.3
func makeDrone(kind: String, id: String, charge: Int) -> Drone? {
    switch kind {
    case "welder":
        return WelderDrone(id: id, cell: PowerCell(charge: charge))
    case "scanner":
        return ScannerDrone(id: id, cell: PowerCell(charge: charge))
    case "cargo":
        return CargoDrone(id: id, cell: PowerCell(charge: charge))
    default:
        return nil
    }
}
var fleet: [Drone] = []
for fdata in fleetData {
    if let newDrone = makeDrone(kind: fdata.kind, id: fdata.id, charge: fdata.charge) {
        fleet.append(newDrone)
    } else {
        print("The record with id '\(fdata.0)' was skipped.")
    }
}
// MARK: Level 3 · The Shift

func runShift(_ fleet: [Drone], rounds: Int) -> Int {
    var totalWork: Int = 0
    for drone in fleet {
        for i in 0..<rounds {
            totalWork += drone.runOnce()
        }
    }
    return totalWork
}

let A: Int = runShift(fleet, rounds: 3)
var B: Int = 0
var C: Int = 0
for drone in fleet {
    B += drone.cell.level()
    if drone.runOnce() != 0 {
        C += 1
    }
}
print(A)
print(B)
print(C)

// MARK: Level 4 · Diagnostics
// 4.1
protocol Diagnosable {
    var componentID: String { get }
    var statusCode: Int { get }
    func diagnose() -> String
}

// 4.2
protocol Rechargeable {
    mutating func recharge(by amount: Int)
}
// Why does Drone implement recharge(by:) without `mutating`?  ->
// Class is a reference type. Inside the class method `self` is a
// reference, so changing a property changes the shared object,
// not the reference itself.
extension Drone: Diagnosable, Rechargeable {
    var componentID: String {
        return "Drone-\(id)"
    }
    var statusCode: Int { healthCode(for: cell.level()) }
    
    func diagnose() -> String {
        return "Drone diagnosis for \(componentID): status-\(statusLine), charge-\(cell.level())"
    }
    
    func recharge(by amount: Int) {
        cell.recharge(by: amount)
    }
}
struct SensorModule: Diagnosable, Rechargeable {
    var componentID: String
    var chargeLevel: Int
    var statusCode: Int { healthCode(for: chargeLevel) }

    func diagnose() -> String {
        return "SensorModule diagnosis for \(componentID): code-\(statusCode), charge-\(chargeLevel)"
    }
    mutating func recharge(by amount: Int) {
        guard amount > 0 else {
            print("You can recharge SensorModule only with positive amount.")
            return
        }
        chargeLevel += amount
    }
}
var sensors: [SensorModule] = []
for sdata in sensorData {
    var newSensor: SensorModule = SensorModule(componentID: sdata.id, chargeLevel: sdata.charge)
    sensors.append(newSensor)
}

// 4.3
// Why could [Drone] never have held the sensors?  ->
// A struct cannot inherit from a class, one is a value type, other is a reference type.
func diagnosticsReport(_ components: [Diagnosable]) -> String {
    var report: String = ""
    for component in components {
        report += component.diagnose() + "\n"
    }
    return report
}
var components: [Diagnosable] = fleet + sensors
print(diagnosticsReport(components))

// MARK: Level 5 · Shared Behaviour

// 5.1 · default diagnose() + the single home of the Health Rule
extension Diagnosable {
    func diagnose() -> String {
        "\(componentID): code \(statusCode)"
    }
    func healthCode(for level: Int) -> Int {
        switch level {
        case ..<20:
            return 2
        case 20..<50:
            return 1
        default:
            return 0
        }
    }
}

// 5.2 · the beacon you cannot edit
// Extension adds conformance without touching LegacyBeacon's declaration
extension LegacyBeacon: Diagnosable {
    var componentID: String { name }
    var statusCode: Int { healthCode(for: signalStrength) }

    func diagnose() -> String {
        "Legacy Beacon \(name); signal - \(signalStrength), code - \(statusCode)."
    }
}
components.append(beacon)
print(diagnosticsReport(components))
var D = 0
for component in components {
    D += component.statusCode
}
print("Mission fragment D = \(D)")

// 5.3
extension Int {
    var powerBar: String {
        let filled = Swift.min(Swift.max(self / 10, 0), 10)
        var bar = ""
        for i in 0..<10 {
            if i < filled {
                bar += "#"
            } else {
                bar += "."
            }
        }
        return bar
    }
}


// MARK: Level 6 · Incident Reports
 // Two of these do not compile. Two compile and lie.
 // For each: expectation, actual behaviour, the language rule, the fix.


// Report 1
// The author wanted to overrride exisiting method,
// but forgot to use 'override' keyword.
//class PatchDrone: Drone {
//    func performTask() -> Int {
//        return 30
//    }
//}

// Fix:
class PatchDrone: Drone {
    override func performTask() -> Int {
        return 30
    }
}

// Report 2
// The author tries to inherit from a final class and override a final method
//final class HeavyWelder: WelderDrone {
//    override func runOnce() -> Int {
//        return 999
//    }
//}

// Fix
final class HeavyWelder: Drone {
    override var powerCost: Int { 40 }
    override func performTask() -> Int { 80 }
}

// Report 3
// The author expects to call weldSeam() method for the object, which is declared as a Drone type (Drone does not have the method). The compiler only knows the declared type, so it can not reach WelderDrone's methods,
//   so only Drone's members are visible, even though the object is a WelderDrone.
//let reportFleet: [Drone] = [WelderDrone(id: "W-9", cell: PowerCell(charge: 100))]
//let first = reportFleet[0]
//print(first.weldSeam())

let reportFleet: [WelderDrone] = [WelderDrone(id: "W-9", cell: PowerCell(charge: 100))]
let first = reportFleet[0]
print(first.weldSeam())

// Report 4
// The author expects to receive "thruster" output, but "generic component" is printed instead.
// label() is not a protocol requirement. It exists only in the extension.
// The version of the method is chosen by the declared type,
// not by the real object, so the extension takes over.
//protocol Labelled {
//    var componentID: String { get }
//}
//
//extension Labelled {
//    func label() -> String { "generic component" }
//}
//
//struct Thruster: Labelled {
//    let componentID: String
//    func label() -> String { "thruster \(componentID)" }
//}
//
//let parts: [Labelled] = [Thruster(componentID: "T-1")]
//print(parts[0].label())
// Fix
protocol Labelled {
    var componentID: String { get }
    func label() -> String
}

extension Labelled {
    func label() -> String { "generic component" }
}

struct Thruster: Labelled {
    let componentID: String
    func label() -> String { "thruster \(componentID)" }
}

let parts: [Labelled] = [Thruster(componentID: "T-1")]
print(parts[0].label())


// MARK: Finale · Mission Code

 let missionCode = "\(A)-\(B)-\(C)-\(D)"
 print("MISSION CODE: \(missionCode)")


// MARK: Bonus

// Two ways to forbid using Drone directly; a protocol-based redesign;
// two or three sentences comparing them.


// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. Why does a class satisfy a `mutating` protocol requirement without the
    keyword, while a struct must write it?
    
    mutating is used just for for value types: in a struct method `self` is the value itself, so changing a property means changing the whole value, and the method must be allowed to write `self` back (it becomes inout). In a class `self` is a reference; changing a property changes the object in memory, not the reference, so mutatin is not needed.

 2. One thing inheritance does that protocols cannot, and one thing
    protocols do that inheritance cannot:
    
     Inherited subclasses get stored properties and real implementation from the
     parent; protocols serve like blueprints.
 
    Protocols can unite unrelated types like classes, structs (like Drones and SensorModule in this lab).
 

 3. What does `final` prevent, and what did it protect in runOnce()?
    `final` on a method forbids overriding it; `final` on a class forbids creating subclasses. Making runOnce() final guarantees that every drone will follow the same ritual.
 
 4. In Report 4, why did the protocol extension's method win?
    label() is not a requirement of `Labelled`, it exists only in the extension.
    For such methods Swift uses static dispatch: it picks the implementation by the
    variable's declared type, not by the real object. parts[0] is declared as
    `Labelled`, so the extension's "generic component" is called, and Thruster's
    own label() is ignored.
*/

