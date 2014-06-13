//
//  SwiftClasses.swift
//  SwiftExample1
//
//  Created by Brian Sterner on 6/5/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

import Foundation

class Vehicle {
    var numberOfWheels: Int
    var maxPassengers: Int
    func description() -> String {
        return "\(numberOfWheels) wheels; up to \(maxPassengers) passengers"
    }
    
    init() {
        numberOfWheels = 0
        maxPassengers = 1
    }
}

class Bicycle: Vehicle {
    init() {
        super.init()
        numberOfWheels = 2
    }
}

class Car: Vehicle {
    var speed: Double = 0.0
    init() {
        super.init()
        maxPassengers = 5
        numberOfWheels = 4
    }
    override func description() -> String {
        return super.description() + "; "
            + "traveling at \(speed) mph"
    }
}