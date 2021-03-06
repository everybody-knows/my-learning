//
//  main.swift
//  Homework
//
//  Created by Aleksandr Saltykov on 23.12.2020.
//

import Foundation

//  Task 3
enum EngineState: String {
    case on, off
}
enum WindowsState: String {
    case open = "opened"
    case close = "closed"
}
enum Cargo {
    case load(volume: Double)
    case unload(volume: Double)
}

//  Task 1, 2, 4
struct SportCar {
    let brand: String
    let model: String
    let year: Int
    let trunkVolume: Double
    var engineState: EngineState
    var windowsState: WindowsState
    mutating func changeEngineState(state: EngineState) {
        self.engineState = state
        print("The engine is \(state.rawValue) at \(brand) \(model)\n")
    }
    mutating func changeWindowsState(state: WindowsState) {
        self.windowsState = state
        print("The windows is \(state.rawValue) at \(brand) \(model)\n")
    }
    func printProperties() {
        print("    brand: " + brand)
        print("    model: " + model)
        print("    year: \(year)")
        print("    truncVolume: \(trunkVolume)")
        print("    engineState: \(engineState)")
        print("    windowsState: \(windowsState)\n")
    }
}
struct TrunkCar {
    let brand: String
    let model: String
    let year: Int
    let trunkVolume: Double
    var filledTrunkVolume: Double
    mutating func changeFilledTrunkVolume (cargo: Cargo) {
        switch cargo {
        case let .load(volume):
            if filledTrunkVolume + volume > trunkVolume {     // Check volume value
                    print("ERROR in changeFilledTrunkVolume: The load does not fit (\(volume) liters), max load: \(trunkVolume - filledTrunkVolume) liters\n")
            } else {
                self.filledTrunkVolume = filledTrunkVolume + volume
                print("\(volume) liters loaded in the trunk of \(brand) \(model), space left: \(trunkVolume - filledTrunkVolume) liters\n")
            }
        case let .unload(volume):
            if filledTrunkVolume - volume < 0 {   // Check volume value
                print("ERROR in changeFilledTrunkVolume: Can not unload \(volume) liters, max unload: \(filledTrunkVolume) liters\n")
            } else {
                self.filledTrunkVolume = filledTrunkVolume - volume
                print("\(volume) liters unloaded from the trunk of \(brand) \(model), space left: \(trunkVolume - filledTrunkVolume) liters\n")
            }
        }
    }
    func printProperties() {
        print("    brand: " + brand)
        print("    model: " + model)
        print("    year: \(year)")
        print("    truncVolume: \(trunkVolume)")
        print("    filledTruncVolume: \(filledTrunkVolume)\n")
    }
}

//  Task 5
var maserati: SportCar = SportCar(brand: "Maserati", model: "MC20", year: 2020, trunkVolume: 100, engineState: .off, windowsState: .close)
maserati.changeEngineState(state: .on)

var lamborghini: SportCar = SportCar(brand: "Lamborghini", model: "AVENTADOR", year: 2012, trunkVolume: 150, engineState: .off, windowsState: .close)
lamborghini.changeWindowsState(state: .open)

var man: TrunkCar = TrunkCar(brand: "MAN", model: "TGM", year: 2011, trunkVolume: 64000, filledTrunkVolume: 60000)
man.changeFilledTrunkVolume(cargo: .load(volume: 10000))
man.changeFilledTrunkVolume(cargo: .unload(volume: 6000))
man.changeFilledTrunkVolume(cargo: .load(volume: 10000))

// Task 6
print("\(maserati.brand) \(maserati.model) properties:")
maserati.printProperties()

print("\(lamborghini.brand) \(lamborghini.model) properties:")
lamborghini.printProperties()

print("\(man.brand) \(man.model) properties:")
man.printProperties()
