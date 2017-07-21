//: Protocol Oriented Programming (POP)

import UIKit

protocol Vehicle: CustomStringConvertible {
    var isRunning: Bool { get set }
    var make: String { get set }
    var model: String { get set }
    
    mutating func start()
    mutating func turnOff()
}

extension Vehicle {
    var makeModel: String {
        return "\(make) \(model)"
    }
    
    mutating func start() {
        if isRunning {
            print("Already started")
        } else {
            isRunning = true
            print("\(self.description) fired up!")
        }
    }
    
    mutating func turnOff() {
        if isRunning {
            isRunning = false
            print("\(self.description) shut down!")
        } else {
            print("Already dead!")
        }
    }
}

struct SportsCar: Vehicle {
    var isRunning: Bool = false
    var make: String
    var model: String
    
    var description: String {
        return self.makeModel
    }
    
//    mutating func start() {
//        if isRunning {
//            print("Already started!")
//        } else {
//            isRunning = true
//            print("Vrooom")
//        }
//    }
//    
//    mutating func turnOff() {
//        if isRunning {
//            isRunning = false
//            print("Crickets")
//        } else {
//            print("Already dead!")
//        }
//    }
}

class SemiTruck: Vehicle {
    var isRunning: Bool = false
    var make: String
    var model: String
    
    init(isRunning: Bool, make: String, model: String) {
        self.isRunning = isRunning
        self.make = make
        self.model = model
    }
    
    var description: String {
        return self.makeModel
    }
    
//    func start() {
//        if isRunning {
//            print("Already started")
//        } else {
//            isRunning = true
//            print("Rumble")
//        }
//    }
//    
//    func turnOff() {
//        if isRunning {
//            isRunning = false
//            print("put...put...silence")
//        } else {
//            print("Already shut down")
//        }
//    }
    
    func blowAirHorn() {
        print("TOOOOOT :)")
    }
}

var car1 = SportsCar(isRunning: false, make: "Porshe", model: "911")
var truck1 = SemiTruck(isRunning: false, make: "Peterbilt", model: "Verago")

car1.start()
truck1.start()
truck1.blowAirHorn()

truck1.turnOff()

var vehicleArray: Array<Vehicle> = [car1, truck1]
for vehicle in vehicleArray {
    print("\(vehicle.makeModel)")
}

extension Double {
    var dollarString: String {
        return String(format: "$%.02f", self)
    }
}

var pct = 32.15 * 0.15
print("\(pct.dollarString)")
