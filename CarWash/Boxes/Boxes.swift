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

class Car {
    var carName: String 
    var timeWash: String
    
    init(carName: String, timeWash: String) {
        self.carName = carName
        self.timeWash = timeWash
        
    }
}
