//
//  Boxes.swift
//  CarWash
//
//  Created by alena on 19.01.2020.
//  Copyright © 2020 alena. All rights reserved.
//

import UIKit

class Box {
    var numberBox: Int
    var car = [Car]()
    
    init(numberBox: Int, car: Array<Car>) {
        self.numberBox = numberBox
        self.car = car
        
    }
}

class Time {
    let hour: Int
    let min: Int
    var timeText: String {
        return "\(hour) ч.  \(min) мин. "
    }
    
    init(hour: Int, min: Int) {
        self.hour = hour
        self.min = min
    }
}

class Car {
    let car: String
    let timeWash: Time
    
    init(car: String, timeWash: Time) {
        self.car = car
        self.timeWash = timeWash
    }
}