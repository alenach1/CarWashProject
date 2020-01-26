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
// вывести время свойство типа Date в любом красивом формате с помощью DateForMatter

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
    let carName: String //carName
    let timeWash: Time
    
    init(carName: String, timeWash: Time) {
        self.carName = carName
        self.timeWash = timeWash
    }
}
